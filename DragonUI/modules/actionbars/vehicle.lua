local addon = select(2,...);
local config = addon.config;
local class = addon._class;
local unpack = unpack;
local ipairs = ipairs;
local RegisterStateDriver = RegisterStateDriver;
local UnregisterStateDriver = UnregisterStateDriver;
local UnitVehicleSkin = UnitVehicleSkin;
local UIParent = UIParent;
local InCombatLockdown = InCombatLockdown;
local _G = getfenv(0);

-- ============================================================================
-- VEHICLE MODULE FOR DRAGONUI
-- ============================================================================
-- Approach: RetailUI pattern — do NOT kill VehicleMenuBar, let Blizzard
-- handle vehicle transitions natively. We reskin in-place and overlay
-- our custom art when artstyle=true.
-- ============================================================================

-- Module state tracking
local VehicleModule = {
    initialized = false,
    applied = false,
    pendingApply = false,
    stateDrivers = {},
    events = {},
    hooks = {},
    frames = {}
}

-- Register with ModuleRegistry (if available)
if addon.RegisterModule then
    addon:RegisterModule("vehicle", VehicleModule, "Vehicle", "Vehicle interface enhancements")
end

-- Frame variables
local pUiMainBar = nil
local vehicleBarBackground = nil
local vehiclebar = nil
local vehicleExitButton = nil

-- ============================================================================
-- CONFIGURATION
-- ============================================================================

local function GetModuleConfig()
    return addon.db and addon.db.profile and addon.db.profile.modules and addon.db.profile.modules.vehicle
end

local function IsModuleEnabled()
    local cfg = GetModuleConfig()
    return cfg and cfg.enabled
end

local function IsMainbarsModuleEnabled()
    local cfg = addon.db and addon.db.profile and addon.db.profile.modules and addon.db.profile.modules.mainbars
    return cfg and cfg.enabled
end

local function CheckDependencies()
    if not IsMainbarsModuleEnabled() then
        return false
    end
    local mainBar = addon.pUiMainBar or _G.pUiMainBar
    if not mainBar then
        return false
    end
    return true
end

-- ============================================================================
-- STANCE/BONUS BAR PAGE HANDLING
-- ============================================================================

local stance = {
    ['DRUID'] = '[bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 7; [bonusbar:2] 8; [bonusbar:3] 9; [bonusbar:4] 10;',
    ['WARRIOR'] = '[bonusbar:1] 7; [bonusbar:2] 8; [bonusbar:3] 9;',
    ['PRIEST'] = '[bonusbar:1] 7;',
    ['ROGUE'] = '[bonusbar:1] 7; [form:3] 7;',
    ['DEFAULT'] = '[bonusbar:5] 11; [bar:2] 2; [bar:3] 3; [bar:4] 4; [bar:5] 5; [bar:6] 6;',
}

local function getbarpage()
    local condition = stance['DEFAULT']
    local page = stance[class]
    if page then
        condition = condition..' '..page
    end
    condition = condition..' 1'
    return condition
end

-- ============================================================================
-- VEHICLE EXIT BUTTON (always created — standalone leave vehicle button)
-- ============================================================================

local function CreateVehicleExitButton()
    if vehicleExitButton then return end

    vehicleExitButton = CreateFrame(
        'CheckButton',
        'DragonUI_VehicleExitButton',
        UIParent,
        'SecureHandlerClickTemplate,SecureHandlerStateTemplate'
    )

    local btnsize = config.additional.size or 30
    vehicleExitButton:SetSize(btnsize, btnsize)

    -- Position: relative to stance bar if exists, else main bar
    local parent = addon.pUiStanceBar or _G.pUiStanceBar or pUiMainBar
    if parent then
        vehicleExitButton:SetParent(parent)
    end

    local x_pos = config.additional.vehicle and config.additional.vehicle.x_position or -40
    vehicleExitButton:SetPoint('TOPLEFT', x_pos, -5)

    -- Textures
    vehicleExitButton:SetNormalTexture('Interface\\Vehicles\\UI-Vehicles-Button-Exit-Up')
    vehicleExitButton:GetNormalTexture():SetTexCoord(0.140625, 0.859375, 0.140625, 0.859375)
    vehicleExitButton:SetPushedTexture('Interface\\Vehicles\\UI-Vehicles-Button-Exit-Down')
    vehicleExitButton:GetPushedTexture():SetTexCoord(0.140625, 0.859375, 0.140625, 0.859375)
    vehicleExitButton:SetHighlightTexture('Interface\\Vehicles\\UI-Vehicles-Button-Highlight')
    vehicleExitButton:GetHighlightTexture():SetTexCoord(0.130625, 0.879375, 0.130625, 0.879375)
    vehicleExitButton:GetHighlightTexture():SetBlendMode('ADD')

    -- Scripts
    vehicleExitButton:RegisterForClicks('AnyUp')
    vehicleExitButton:SetScript('OnEnter', function(self)
        GameTooltip_AddNewbieTip(self, LEAVE_VEHICLE, 1.0, 1.0, 1.0, nil)
    end)
    vehicleExitButton:SetScript('OnLeave', GameTooltip_Hide)
    vehicleExitButton:SetScript('OnClick', function(self)
        VehicleExit()
        self:SetChecked(true)
    end)
    vehicleExitButton:SetScript('OnShow', function(self)
        self:SetChecked(false)
    end)

    vehicleExitButton:Hide()

    -- Direct state driver: show only during vehicle UI
    VehicleModule.stateDrivers.vehicleExitVisibility = {frame = vehicleExitButton, state = 'visibility'}
    RegisterStateDriver(vehicleExitButton, 'visibility', '[vehicleui] show; hide')

    VehicleModule.frames.vehicleExitButton = vehicleExitButton
end

-- ============================================================================
-- CUSTOM VEHICLE ART (artstyle=true only)
-- ============================================================================

local function CreateVehicleArtFrames()
    if vehicleBarBackground then return end

    vehicleBarBackground = CreateFrame(
        'Frame',
        'DragonUI_VehicleBarBackground',
        UIParent,
        'VehicleBarUiTemplate'
    )
    vehicleBarBackground:SetScale(config.mainbars.scale_vehicle or 1)
    vehicleBarBackground:Hide()

    -- vehiclebar: content container (buttons, health, power go here)
    -- Inherits visibility from parent — do NOT explicitly Hide() it
    vehiclebar = CreateFrame(
        'Frame',
        'DragonUI_VehicleBar',
        vehicleBarBackground,
        'SecureHandlerStateTemplate'
    )
    vehiclebar:SetAllPoints(vehicleBarBackground)
    -- NOTE: vehiclebar is NOT hidden — it inherits visibility from vehicleBarBackground

    VehicleModule.frames.vehicleBarBackground = vehicleBarBackground
    VehicleModule.frames.vehiclebar = vehiclebar
end

local function vehiclebar_power_setup()
    if not vehiclebar then return end

    VehicleMenuBarLeaveButton:SetParent(vehiclebar)
    VehicleMenuBarLeaveButton:SetSize(47, 50)
    VehicleMenuBarLeaveButton:SetClearPoint('BOTTOMRIGHT', -178, 14)
    VehicleMenuBarLeaveButton:SetHighlightTexture('Interface\\Vehicles\\UI-Vehicles-Button-Highlight')
    VehicleMenuBarLeaveButton:GetHighlightTexture():SetTexCoord(0.130625, 0.879375, 0.130625, 0.879375)
    VehicleMenuBarLeaveButton:GetHighlightTexture():SetBlendMode('ADD')

    if not VehicleMenuBarLeaveButton.DragonUIClickHooked then
        VehicleMenuBarLeaveButton:HookScript('OnClick', VehicleExit)
        VehicleMenuBarLeaveButton.DragonUIClickHooked = true
    end

    VehicleMenuBarHealthBar:SetParent(vehiclebar)
    VehicleMenuBarHealthBarOverlay:SetParent(VehicleMenuBarHealthBar)
    VehicleMenuBarHealthBarOverlay:SetSize(46, 105)
    VehicleMenuBarHealthBarOverlay:SetClearPoint('BOTTOMLEFT', -5, -9)
    VehicleMenuBarHealthBarBackground:SetParent(VehicleMenuBarHealthBar)
    VehicleMenuBarHealthBarBackground:SetTexture([[Interface\Tooltips\UI-Tooltip-Background]])
    VehicleMenuBarHealthBarBackground:SetTexCoord(0.0, 1.0, 0.0, 1.0)
    VehicleMenuBarHealthBarBackground:SetVertexColor(
        TOOLTIP_DEFAULT_BACKGROUND_COLOR.r,
        TOOLTIP_DEFAULT_BACKGROUND_COLOR.g,
        TOOLTIP_DEFAULT_BACKGROUND_COLOR.b
    )

    VehicleMenuBarPowerBar:SetParent(vehiclebar)
    VehicleMenuBarPowerBarOverlay:SetParent(VehicleMenuBarPowerBar)
    VehicleMenuBarPowerBarOverlay:SetSize(46, 105)
    VehicleMenuBarPowerBarOverlay:SetClearPoint('BOTTOMLEFT', -5, -9)
    VehicleMenuBarPowerBarBackground:SetParent(VehicleMenuBarPowerBar)
    VehicleMenuBarPowerBarBackground:SetTexture([[Interface\Tooltips\UI-Tooltip-Background]])
    VehicleMenuBarPowerBarBackground:SetTexCoord(0.5390625, 0.953125, 0.0, 1.0)
    VehicleMenuBarPowerBarBackground:SetVertexColor(
        TOOLTIP_DEFAULT_BACKGROUND_COLOR.r,
        TOOLTIP_DEFAULT_BACKGROUND_COLOR.g,
        TOOLTIP_DEFAULT_BACKGROUND_COLOR.b
    )
end

local function vehiclebar_mechanical_setup()
    if not vehicleBarBackground then return end

    vehicleBarBackground.OrganicUi:Hide()
    vehicleBarBackground.MechanicUi:Show()

    VehicleMenuBarLeaveButton:SetNormalTexture(addon._dir..'mechanical2')
    VehicleMenuBarLeaveButton:GetNormalTexture():SetTexCoord(45/512, 84/512, 185/512, 224/512)
    VehicleMenuBarLeaveButton:SetPushedTexture(addon._dir..'mechanical2')
    VehicleMenuBarLeaveButton:GetPushedTexture():SetTexCoord(2/512, 40/512, 185/512, 223/512)

    VehicleMenuBarHealthBar:SetSize(38, 84)
    VehicleMenuBarPowerBar:SetSize(38, 84)
    VehicleMenuBarPowerBar:SetClearPoint('BOTTOMRIGHT', -94, 6)
    VehicleMenuBarHealthBar:SetClearPoint('BOTTOMLEFT', 74, 6)
    VehicleMenuBarHealthBarBackground:SetSize(40, 92)
    VehicleMenuBarPowerBarBackground:SetSize(40, 92)
    VehicleMenuBarHealthBarBackground:SetClearPoint('BOTTOMLEFT', -2, -6)
    VehicleMenuBarPowerBarBackground:SetClearPoint('BOTTOMLEFT', -2, -6)
    VehicleMenuBarHealthBarOverlay:SetTexture(addon._dir..'mechanical2')
    VehicleMenuBarHealthBarOverlay:SetTexCoord(4/512, 44/512, 263/512, 354/512)
    VehicleMenuBarPowerBarOverlay:SetTexture(addon._dir..'mechanical2')
    VehicleMenuBarPowerBarOverlay:SetTexCoord(4/512, 44/512, 263/512, 354/512)

    VehicleMenuBarPitchUpButton:SetParent(vehicleBarBackground.MechanicUi)
    VehicleMenuBarPitchUpButton:SetSize(32, 31)
    VehicleMenuBarPitchUpButton:SetClearPoint('BOTTOMLEFT', 156, 46)
    VehicleMenuBarPitchUpButton:SetNormalTexture(addon._dir..'mechanical2')
    VehicleMenuBarPitchUpButton:SetPushedTexture(addon._dir..'mechanical2')
    VehicleMenuBarPitchUpButton:GetNormalTexture():SetTexCoord(1/512, 34/512, 227/512, 259/512)
    VehicleMenuBarPitchUpButton:GetPushedTexture():SetTexCoord(36/512, 69/512, 227/512, 259/512)

    VehicleMenuBarPitchDownButton:SetParent(vehicleBarBackground.MechanicUi)
    VehicleMenuBarPitchDownButton:SetSize(32, 31)
    VehicleMenuBarPitchDownButton:SetClearPoint('BOTTOMLEFT', 156, 8)
    VehicleMenuBarPitchDownButton:SetNormalTexture(addon._dir..'mechanical2')
    VehicleMenuBarPitchDownButton:SetPushedTexture(addon._dir..'mechanical2')
    VehicleMenuBarPitchDownButton:GetNormalTexture():SetTexCoord(148/512, 180/512, 289/512, 320/512)
    VehicleMenuBarPitchDownButton:GetPushedTexture():SetTexCoord(148/512, 180/512, 323/512, 354/512)

    VehicleMenuBarPitchSlider:SetParent(vehicleBarBackground.MechanicUi)
    VehicleMenuBarPitchSlider:SetSize(20, 82)
    VehicleMenuBarPitchSlider:SetClearPoint('BOTTOMLEFT', 124, 2)

    local bg1 = _G['DragonUI_VehicleBarBackgroundBACKGROUND1']
    if bg1 then
        bg1:SetDrawLayer('BACKGROUND', -1)
    end

    VehicleMenuBarPitchSliderBG:SetTexture([[Interface\Vehicles\UI-Vehicles-Endcap]])
    VehicleMenuBarPitchSliderBG:SetTexCoord(0.46875, 0.50390625, 0.31640625, 0.62109375)
    VehicleMenuBarPitchSliderBG:SetVertexColor(0, 0.85, 0.99)

    VehicleMenuBarPitchSliderMarker:SetWidth(20)
    VehicleMenuBarPitchSliderMarker:SetTexture([[Interface\Vehicles\UI-Vehicles-Endcap]])
    VehicleMenuBarPitchSliderMarker:SetTexCoord(0.46875, 0.50390625, 0.45, 0.55)
    VehicleMenuBarPitchSliderMarker:SetVertexColor(1, 0, 0)

    VehicleMenuBarPitchSliderOverlayThing:SetPoint('TOPLEFT', -5, 2)
    VehicleMenuBarPitchSliderOverlayThing:SetPoint('BOTTOMRIGHT', 3, -4)
end

local function vehiclebar_organic_setup()
    if not vehicleBarBackground then return end

    vehicleBarBackground.OrganicUi:Show()
    vehicleBarBackground.MechanicUi:Hide()
    VehicleMenuBarHealthBar:SetSize(38, 74)
    VehicleMenuBarPowerBar:SetSize(38, 74)
    VehicleMenuBarPowerBar:SetClearPoint('BOTTOMRIGHT', -119, 3)
    VehicleMenuBarHealthBar:SetClearPoint('BOTTOMLEFT', 119, 3)
    VehicleMenuBarHealthBarBackground:SetSize(40, 83)
    VehicleMenuBarPowerBarBackground:SetSize(40, 83)
    VehicleMenuBarHealthBarBackground:SetClearPoint('BOTTOMLEFT', -2, -9)
    VehicleMenuBarPowerBarBackground:SetClearPoint('BOTTOMLEFT', -2, -9)
    VehicleMenuBarLeaveButton:SetNormalTexture('Interface\\Vehicles\\UI-Vehicles-Button-Exit-Up')
    VehicleMenuBarLeaveButton:GetNormalTexture():SetTexCoord(0.140625, 0.859375, 0.140625, 0.859375)
    VehicleMenuBarLeaveButton:SetPushedTexture('Interface\\Vehicles\\UI-Vehicles-Button-Exit-Down')
    VehicleMenuBarLeaveButton:GetPushedTexture():SetTexCoord(0.140625, 0.859375, 0.140625, 0.859375)
    VehicleMenuBarHealthBarOverlay:SetTexture([[Interface\Vehicles\UI-Vehicles-Endcap-Organic-bottle]])
    VehicleMenuBarHealthBarOverlay:SetTexCoord(0.46484375, 0.66015625, 0.0390625, 0.9375)
    VehicleMenuBarPowerBarOverlay:SetTexture([[Interface\Vehicles\UI-Vehicles-Endcap-Organic-bottle]])
    VehicleMenuBarPowerBarOverlay:SetTexCoord(0.46484375, 0.66015625, 0.0390625, 0.9375)
end

local function vehiclebar_layout_setup()
    if IsVehicleAimAngleAdjustable() then
        vehiclebar_mechanical_setup()
    else
        vehiclebar_organic_setup()
    end
end

local function vehiclebutton_position()
    if not vehiclebar then return end
    if InCombatLockdown() then return end

    for index = 1, VEHICLE_MAX_ACTIONBUTTONS do
        local button = _G['VehicleMenuBarActionButton'..index]
        if button then
            button:ClearAllPoints()
            button:SetParent(vehiclebar)
            button:SetSize(52, 52)
            button:Show()
            if index == 1 then
                button:SetPoint('BOTTOMLEFT', vehiclebar, 'BOTTOMRIGHT', -594, 21)
            else
                local previous = _G['VehicleMenuBarActionButton'..(index-1)]
                if previous then
                    button:SetPoint('LEFT', previous, 'RIGHT', 6, 0)
                end
            end
        end
    end
end

-- ============================================================================
-- ARTSTYLE EVENT HANDLING
-- ============================================================================

local function OnVehicleEvent(self, event, ...)
    if event == 'UNIT_ENTERED_VEHICLE' then
        vehiclebar_layout_setup()
        vehiclebutton_position()
        if addon.vehiclebuttons_template then
            addon.vehiclebuttons_template()
        end
        UnitFrameHealthBar_Update(VehicleMenuBarHealthBar, 'vehicle')
        UnitFrameManaBar_Update(VehicleMenuBarPowerBar, 'vehicle')
    elseif event == 'UNIT_DISPLAYPOWER' then
        UnitFrameManaBar_Update(VehicleMenuBarPowerBar, 'vehicle')
    end
end

-- ============================================================================
-- ARTSTYLE VISIBILITY STATE DRIVERS
-- ============================================================================
-- vehiclebar inherits visibility from vehicleBarBackground (SetAllPoints,
-- NOT explicitly hidden) so buttons parented to it become visible when
-- vehicleBarBackground is shown.

local function SetupArtStyleStateDrivers()
    if not vehicleBarBackground or not pUiMainBar then return end

    -- Direct state driver on vehicleBarBackground: show/hide based on [vehicleui]
    VehicleModule.stateDrivers.vehicleArtVisibility = {frame = vehicleBarBackground, state = 'visibility'}
    RegisterStateDriver(vehicleBarBackground, 'visibility', '[vehicleui] show; hide')

    -- Hide main bar during vehicle UI
    VehicleModule.stateDrivers.mainBarVehicle = {frame = pUiMainBar, state = 'vehicleupdate'}
    pUiMainBar:SetAttribute('_onstate-vehicleupdate', [[
        if newstate == '1' then
            self:Hide()
        else
            self:Show()
        end
    ]])
    RegisterStateDriver(pUiMainBar, 'vehicleupdate', '[vehicleui] 1; 2')
end

-- ============================================================================
-- BOTTOM BARS VISIBILITY DURING VEHICLE
-- ============================================================================
-- Since noop.lua removed bars from UIPARENT_MANAGED_FRAME_POSITIONS,
-- Blizzard's native system can't hide them during vehicle. We handle it.

local function SetupBottomBarVehicleVisibility()
    local hider = VehicleModule.frames.bottomBarHider
    if not hider then
        hider = CreateFrame('Frame')
        hider:RegisterEvent('UNIT_ENTERED_VEHICLE')
        hider:RegisterEvent('UNIT_EXITED_VEHICLE')
        hider:RegisterEvent('PLAYER_ENTERING_WORLD')
        VehicleModule.frames.bottomBarHider = hider
    end

    hider:SetScript('OnEvent', function(self, event, unit)
        if InCombatLockdown() then return end

        if event == 'UNIT_ENTERED_VEHICLE' and unit == 'player' then
            if MultiBarBottomLeft and MultiBarBottomLeft:IsShown() then
                VehicleModule.frames.bottomLeftWasShown = true
                MultiBarBottomLeft:Hide()
            end
            if MultiBarBottomRight and MultiBarBottomRight:IsShown() then
                VehicleModule.frames.bottomRightWasShown = true
                MultiBarBottomRight:Hide()
            end
        elseif event == 'UNIT_EXITED_VEHICLE' and unit == 'player' then
            if VehicleModule.frames.bottomLeftWasShown and MultiBarBottomLeft then
                MultiBarBottomLeft:Show()
                VehicleModule.frames.bottomLeftWasShown = nil
            end
            if VehicleModule.frames.bottomRightWasShown and MultiBarBottomRight then
                MultiBarBottomRight:Show()
                VehicleModule.frames.bottomRightWasShown = nil
            end
        elseif event == 'PLAYER_ENTERING_WORLD' then
            if UnitInVehicle('player') then
                if MultiBarBottomLeft and MultiBarBottomLeft:IsShown() then
                    VehicleModule.frames.bottomLeftWasShown = true
                    MultiBarBottomLeft:Hide()
                end
                if MultiBarBottomRight and MultiBarBottomRight:IsShown() then
                    VehicleModule.frames.bottomRightWasShown = true
                    MultiBarBottomRight:Hide()
                end
            end
        end
    end)
end

-- ============================================================================
-- BONUS BAR PAGE SWITCHING
-- ============================================================================

local function SetupBonusBarVehicle()
    if not pUiMainBar then return end

    for i = 1, 12 do
        local actionButton = _G['ActionButton'..i]
        if actionButton then
            pUiMainBar:SetFrameRef('ActionButton'..i, actionButton)
        end
    end

    pUiMainBar:Execute([[
        buttons = newtable()
        for i = 1, 12 do
            local button = self:GetFrameRef('ActionButton'..i)
            if button then
                table.insert(buttons, button)
            end
        end
    ]])

    pUiMainBar:SetAttribute('_onstate-page', [[
        for i, button in ipairs(buttons) do
            button:SetAttribute('actionpage', tonumber(newstate))
        end
    ]])

    VehicleModule.stateDrivers.bonusBarPage = {frame = pUiMainBar, state = 'page'}
    RegisterStateDriver(pUiMainBar, 'page', getbarpage())
end

-- ============================================================================
-- APPLY / RESTORE
-- ============================================================================

local function CleanupVehicleFrames()
    local globalFrames = {
        'mixin2template',
        'pUiVehicleBar',
        'vehicleExit',
        'pUiVehicleLeaveButton'
    }
    for _, frameName in ipairs(globalFrames) do
        local frame = _G[frameName]
        if frame and frame.Hide then
            frame:Hide()
            frame:SetParent(nil)
            if frame.UnregisterAllEvents then
                frame:UnregisterAllEvents()
            end
            _G[frameName] = nil
        end
    end
end

local function ApplyVehicleSystem()
    if VehicleModule.applied or not IsModuleEnabled() then return end

    if InCombatLockdown() then
        VehicleModule.pendingApply = true
        if addon.CombatQueue then
            addon.CombatQueue:Add("vehicle_apply", function()
                if IsModuleEnabled() and VehicleModule.pendingApply then
                    ApplyVehicleSystem()
                end
            end)
        end
        return
    end

    if not CheckDependencies() then
        return
    end

    pUiMainBar = addon.pUiMainBar or _G.pUiMainBar
    CleanupVehicleFrames()

    -- 1. Vehicle exit button (direct state driver: [vehicleui] show; hide)
    CreateVehicleExitButton()

    -- 2. Bonus bar page switching (stance-based action page management)
    SetupBonusBarVehicle()

    -- 3. Hide bottom bars during vehicle UI
    SetupBottomBarVehicleVisibility()

    -- 4. Custom vehicle art (organic/mechanical) — only when artstyle=true
    if config.additional.vehicle.artstyle then
        CreateVehicleArtFrames()
        vehiclebar_power_setup()

        -- Register vehicle events for layout and health bar updates
        local artEvents = {
            'UNIT_ENTERED_VEHICLE',
            'UNIT_EXITED_VEHICLE',
            'UNIT_DISPLAYPOWER',
        }
        for _, event in ipairs(artEvents) do
            vehiclebar:RegisterEvent(event)
            VehicleModule.events[event] = vehiclebar
        end
        vehiclebar:SetScript('OnEvent', OnVehicleEvent)

        -- State drivers: show art when [vehicleui], hide main bar
        SetupArtStyleStateDrivers()
    end

    VehicleModule.applied = true
    VehicleModule.pendingApply = false
end

local function RestoreVehicleSystem()
    if not VehicleModule.applied then return end
    if InCombatLockdown() then return end

    -- Unregister events
    for key, frame in pairs(VehicleModule.events) do
        if frame and type(frame) == "table" and frame.UnregisterAllEvents then
            pcall(frame.UnregisterAllEvents, frame)
        end
    end
    VehicleModule.events = {}

    -- Unregister state drivers
    for name, data in pairs(VehicleModule.stateDrivers) do
        if data.frame and UnregisterStateDriver then
            pcall(UnregisterStateDriver, data.frame, data.state)
        end
    end
    VehicleModule.stateDrivers = {}

    -- Hide custom frames
    if vehicleBarBackground then vehicleBarBackground:Hide() end
    if vehicleExitButton then vehicleExitButton:Hide() end

    -- Restore bottom bars
    if VehicleModule.frames.bottomLeftWasShown and MultiBarBottomLeft then
        MultiBarBottomLeft:Show()
    end
    if VehicleModule.frames.bottomRightWasShown and MultiBarBottomRight then
        MultiBarBottomRight:Show()
    end

    -- Unregister bottomBarHider events
    if VehicleModule.frames.bottomBarHider then
        VehicleModule.frames.bottomBarHider:UnregisterAllEvents()
        VehicleModule.frames.bottomBarHider:SetScript('OnEvent', nil)
    end

    CleanupVehicleFrames()
    if VehicleMenuBar then VehicleMenuBar:Show() end

    VehicleModule.frames = {}
    vehicleBarBackground = nil
    vehiclebar = nil
    vehicleExitButton = nil
    pUiMainBar = nil

    VehicleModule.applied = false
    VehicleModule.hooks = {}
end

-- ============================================================================
-- PUBLIC API
-- ============================================================================

function addon.RefreshVehicleSystem()
    if IsModuleEnabled() then
        if not VehicleModule.applied then
            ApplyVehicleSystem()
        else
            if addon.RefreshVehicle then
                addon.RefreshVehicle()
            end
        end
    else
        RestoreVehicleSystem()
    end
end

function addon.RefreshVehicle()
    if not IsModuleEnabled() or not VehicleModule.applied then return end
    if InCombatLockdown() then return end

    local btnsize = config.additional.size
    local x_position = config.additional.vehicle.x_position

    if vehicleExitButton then
        vehicleExitButton:SetSize(btnsize, btnsize)
        vehicleExitButton:ClearAllPoints()
        vehicleExitButton:SetPoint('TOPLEFT', x_position, -5)
    end

    if vehicleBarBackground then
        vehicleBarBackground:SetScale(config.mainbars.scale_vehicle or 1)
    end
end

-- ============================================================================
-- DEBUG COMMAND
-- ============================================================================

function addon.DebugVehicle()
    local p = function(msg) print("|cff00ccff[DragonUI Vehicle]|r " .. msg) end
    p("--- Vehicle Module Debug ---")
    p("Module enabled: " .. tostring(IsModuleEnabled()))
    p("Module applied: " .. tostring(VehicleModule.applied))
    p("artstyle: " .. tostring(config.additional.vehicle.artstyle))
    p("pUiMainBar: " .. tostring(pUiMainBar ~= nil) .. (pUiMainBar and (" shown=" .. tostring(pUiMainBar:IsShown())) or ""))
    p("vehicleBarBackground: " .. tostring(vehicleBarBackground ~= nil) .. (vehicleBarBackground and (" shown=" .. tostring(vehicleBarBackground:IsShown())) or ""))
    p("vehiclebar: " .. tostring(vehiclebar ~= nil) .. (vehiclebar and (" shown=" .. tostring(vehiclebar:IsShown()) .. " visible=" .. tostring(vehiclebar:IsVisible())) or ""))
    p("vehicleExitButton: " .. tostring(vehicleExitButton ~= nil) .. (vehicleExitButton and (" shown=" .. tostring(vehicleExitButton:IsShown()) .. " visible=" .. tostring(vehicleExitButton:IsVisible()) .. " parent=" .. tostring(vehicleExitButton:GetParent() and vehicleExitButton:GetParent():GetName())) or ""))
    p("UnitInVehicle: " .. tostring(UnitInVehicle("player")))
    p("UnitHasVehicleUI: " .. tostring(UnitHasVehicleUI("player")))
    p("GetBonusBarOffset: " .. tostring(GetBonusBarOffset()))
    p("VehicleMenuBar: shown=" .. tostring(VehicleMenuBar and VehicleMenuBar:IsShown()) .. " alpha=" .. tostring(VehicleMenuBar and VehicleMenuBar:GetAlpha()))
    if VehicleMenuBarActionButtonFrame then
        p("VehicleMenuBarActionButtonFrame: shown=" .. tostring(VehicleMenuBarActionButtonFrame:IsShown()))
    else
        p("VehicleMenuBarActionButtonFrame: nil")
    end
    p("MultiBarBottomLeft shown: " .. tostring(MultiBarBottomLeft and MultiBarBottomLeft:IsShown()))
    p("MultiBarBottomRight shown: " .. tostring(MultiBarBottomRight and MultiBarBottomRight:IsShown()))
    p("State drivers:")
    for name, data in pairs(VehicleModule.stateDrivers) do
        p("  " .. name .. " -> " .. tostring(data.frame and data.frame:GetName()) .. " [" .. data.state .. "]")
    end
    p("--- End Debug ---")
end

-- ============================================================================
-- INITIALIZATION
-- ============================================================================

local function WaitForDependencies(callback, attempts)
    attempts = attempts or 0
    if attempts > 20 then return end

    if CheckDependencies() then
        callback()
    else
        addon.core:ScheduleTimer(function()
            WaitForDependencies(callback, attempts + 1)
        end, 0.5)
    end
end

local initFrame = CreateFrame("Frame")
VehicleModule.eventFrame = initFrame

initFrame:RegisterEvent("ADDON_LOADED")
initFrame:RegisterEvent("PLAYER_LOGIN")
initFrame:SetScript("OnEvent", function(self, event, addonName)
    if event == "ADDON_LOADED" and addonName == "DragonUI" then
        VehicleModule.initialized = true
        self:UnregisterEvent("ADDON_LOADED")
    elseif event == "PLAYER_LOGIN" then
        if IsModuleEnabled() then
            WaitForDependencies(function()
                ApplyVehicleSystem()
            end)
        end

        if addon.db then
            addon.db.RegisterCallback(addon, "OnProfileChanged", function()
                addon.core:ScheduleTimer(function()
                    addon.RefreshVehicleSystem()
                end, 0.1)
            end)
            addon.db.RegisterCallback(addon, "OnProfileCopied", function()
                addon.core:ScheduleTimer(function()
                    addon.RefreshVehicleSystem()
                end, 0.1)
            end)
            addon.db.RegisterCallback(addon, "OnProfileReset", function()
                addon.core:ScheduleTimer(function()
                    addon.RefreshVehicleSystem()
                end, 0.1)
            end)
        end

        self:UnregisterEvent("PLAYER_LOGIN")
    elseif event == "PLAYER_REGEN_ENABLED" then
        self:UnregisterEvent("PLAYER_REGEN_ENABLED")
        if VehicleModule.pendingApply and IsModuleEnabled() then
            VehicleModule.pendingApply = false
            WaitForDependencies(function()
                ApplyVehicleSystem()
            end)
        end
    end
end)

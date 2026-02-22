--[[
    Original code by Dmitriy (RetailUI) - Licensed under MIT License
    Adapted for DragonUI with DragonflightUI-inspired positioning control
]]

local addon = select(2, ...);

--  CREATE MODULE USING THE DRAGONUI SYSTEM
local BuffFrameModule = {}
addon.BuffFrameModule = BuffFrameModule

-- Register with ModuleRegistry (if available)
if addon.RegisterModule then
    addon:RegisterModule("buffs", BuffFrameModule, "Buff Frame", "Custom buff frame styling, positioning and toggle button")
end

--  LOCAL VARIABLES
local buffFrame = nil
local toggleButton = nil
local dragonUIBuffFrame = nil  --  OUR CUSTOM FRAME
local buffsHiddenByToggle = false  -- Track if user manually hid buffs via toggle

-- DEFAULT BUFF FRAME POSITION (must match database.lua defaults)
local BUFF_DEFAULT_ANCHOR = "TOPRIGHT"
local BUFF_DEFAULT_POSX = -270
local BUFF_DEFAULT_POSY = -15

-- Y position when a GM ticket or GM chat panel is open
local BUFF_TICKET_POSY = -60

-- Save original BuffFrame methods BEFORE anything modifies them
local original_BuffFrame_SetPoint = BuffFrame.SetPoint
local original_BuffFrame_ClearAllPoints = BuffFrame.ClearAllPoints

-- Flag: when true, our SetPoint/ClearAllPoints overrides are active
local buffFramePositionLocked = false

-- Check if buff frame is at default position (not moved by editor)
-- Uses a saved flag instead of coordinate comparison to avoid stale profile values
local function IsBuffFrameAtDefaultPosition()
    if not addon.db or not addon.db.profile or not addon.db.profile.widgets or not addon.db.profile.widgets.buffs then
    end
    return not addon.db.profile.widgets.buffs.custom_position
end

--  FUNCTION TO REPLACE BUFFFRAME (TOGGLE BUTTON)
local function ReplaceBlizzardFrame(frame)
    frame.toggleButton = frame.toggleButton or CreateFrame('Button', nil, UIParent)
    toggleButton = frame.toggleButton
    toggleButton.toggle = true
    toggleButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 12, -6)
    toggleButton:SetSize(9, 17)
    toggleButton:SetHitRectInsets(0, 0, 0, 0)

    local normalTexture = toggleButton:GetNormalTexture() or toggleButton:CreateTexture(nil, "BORDER")
    normalTexture:SetAllPoints(toggleButton)
    SetAtlasTexture(normalTexture, 'CollapseButton-Right')
    toggleButton:SetNormalTexture(normalTexture)

    local highlightTexture = toggleButton:GetHighlightTexture() or toggleButton:CreateTexture(nil, "HIGHLIGHT")
    highlightTexture:SetAllPoints(toggleButton)
    SetAtlasTexture(highlightTexture, 'CollapseButton-Right')
    toggleButton:SetHighlightTexture(highlightTexture)

    toggleButton:SetScript("OnClick", function(self)
        self.toggle = not self.toggle
        if not self.toggle then
            -- HIDE buffs
            buffsHiddenByToggle = true
            if addon.db and addon.db.profile and addon.db.profile.buffs then
                addon.db.profile.buffs.buffs_hidden = true
            end
            local normalTexture = self:GetNormalTexture()
            SetAtlasTexture(normalTexture, 'CollapseButton-Left')
            local highlightTexture = toggleButton:GetHighlightTexture()
            SetAtlasTexture(highlightTexture, 'CollapseButton-Left')

            for index = 1, BUFF_ACTUAL_DISPLAY do
                local button = _G['BuffButton' .. index]
                if button then
                    button:Hide()
                end
            end
        else
            -- SHOW buffs
            buffsHiddenByToggle = false
            if addon.db and addon.db.profile and addon.db.profile.buffs then
                addon.db.profile.buffs.buffs_hidden = false
            end
            local normalTexture = self:GetNormalTexture()
            SetAtlasTexture(normalTexture, 'CollapseButton-Right')
            local highlightTexture = toggleButton:GetHighlightTexture()
            SetAtlasTexture(highlightTexture, 'CollapseButton-Right')

            for index = 1, BUFF_ACTUAL_DISPLAY do
                local button = _G['BuffButton' .. index]
                if button then
                    button:Show()
                end
            end
        end
    end)

    local consolidatedBuffFrame = ConsolidatedBuffs
    consolidatedBuffFrame:SetMovable(true)
    consolidatedBuffFrame:SetUserPlaced(true)
    consolidatedBuffFrame:ClearAllPoints()
    -- Anchor ConsolidatedBuffs at its natural TOPRIGHT of the buff area so that
    -- the Blizzard anchor chain (ConsolidatedBuffs → TemporaryEnchantFrame →
    -- TempEnchant1/2/3 → BuffButton1) flows correctly.  Previously this was
    -- anchored to the toggle button, pushing TemporaryEnchantFrame far right
    -- and causing weapon-enchant icons (rogue poisons etc.) to overlap the
    -- toggle button.
    consolidatedBuffFrame:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
end

--  FUNCTION TO SHOW/HIDE THE BUTTON BASED ON BUFFS
local function ShowToggleButtonIf(condition)
    if condition then
        dragonUIBuffFrame.toggleButton:Show()
    else
        dragonUIBuffFrame.toggleButton:Hide()
    end
end

--  FUNCTION TO COUNT BUFFS
local function GetUnitBuffCount(unit, range)
    local count = 0
    for index = 1, range do
        local name = UnitBuff(unit, index)
        if name then
            count = count + 1
        end
    end
    return count
end

-- ============================================================================
-- POSITIONING SYSTEM
-- We permanently override BuffFrame.SetPoint and ClearAllPoints so that
-- NO Blizzard code (BuffFrame_Update, UIParent_ManageFramePositions, etc.)
-- can move BuffFrame. Every SetPoint call on BuffFrame gets redirected to
-- anchor it to our dragonUIBuffFrame. We only touch dragonUIBuffFrame position.
-- ============================================================================

--  FUNCTION TO POSITION OUR FRAME (dragonUIBuffFrame moves, BuffFrame follows)
function BuffFrameModule:UpdatePosition()
    if not dragonUIBuffFrame then return end
    if not addon.db or not addon.db.profile or not addon.db.profile.widgets or not addon.db.profile.widgets.buffs then
        return
    end
    
    local widgetOptions = addon.db.profile.widgets.buffs
    
    if IsBuffFrameAtDefaultPosition() then
        -- DEFAULT POSITION: shift down when ticket/GM panel is open
        local ticketOpen = (TicketStatusFrame and TicketStatusFrame:IsShown())
                        or (GMChatStatusFrame and GMChatStatusFrame:IsShown())
        local posY = ticketOpen and BUFF_TICKET_POSY or BUFF_DEFAULT_POSY
        dragonUIBuffFrame:ClearAllPoints()
        dragonUIBuffFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", BUFF_DEFAULT_POSX, posY)
    else
        -- CUSTOM POSITION (editor): use saved coordinates, ignore tickets
        dragonUIBuffFrame:ClearAllPoints()
        dragonUIBuffFrame:SetPoint(widgetOptions.anchor, widgetOptions.posX, widgetOptions.posY)
    end
end

--  FUNCTION TO ENABLE/DISABLE THE MODULE
function BuffFrameModule:Toggle(enabled)
    if not addon.db or not addon.db.profile then return end
    
    addon.db.profile.buffs.enabled = enabled
    
    if enabled then
        self:Enable()
    else
        self:Disable()
    end
end

--  FUNCTION TO ENABLE THE MODULE
function BuffFrameModule:Enable()
    if not addon.db.profile.buffs.enabled then return end
    
    --  CREATE BUFFFRAME USING CreateUIFrame
    dragonUIBuffFrame = addon.CreateUIFrame(BuffFrame:GetWidth(), BuffFrame:GetHeight(), "Auras")
    
    --  REGISTER IN CENTRALIZED SYSTEM
    addon:RegisterEditableFrame({
        name = "buffs",
        frame = dragonUIBuffFrame,
        blizzardFrame = BuffFrame,
        configPath = {"widgets", "buffs"},
        onHide = function()
            -- After editor saves position, check if it matches the default
            local w = addon.db.profile.widgets.buffs
            local isDefault = w.anchor == BUFF_DEFAULT_ANCHOR
                and math.abs(w.posX - BUFF_DEFAULT_POSX) <= 5
                and math.abs(w.posY - BUFF_DEFAULT_POSY) <= 5
            w.custom_position = not isDefault
            self:UpdatePosition()
        end,
        module = self
    })
    
    -- PERMANENTLY OVERRIDE BuffFrame positioning methods.
    -- Every call to BuffFrame:SetPoint() from ANY code path (BuffFrame_Update,
    -- UIParent_ManageFramePositions, etc.) gets redirected to anchor BuffFrame
    -- to our dragonUIBuffFrame. This is the ONLY reliable way to prevent
    -- Blizzard from moving the buff icons.
    buffFramePositionLocked = true
    
    BuffFrame.ClearAllPoints = function(self)
        -- Noop: don't let anyone clear BuffFrame's anchor.
        -- Our SetPoint override handles re-anchoring when needed.
    end
    
    BuffFrame.SetPoint = function(self, ...)
        -- ALWAYS redirect: anchor BuffFrame to our controlled frame
        if not buffFramePositionLocked or not dragonUIBuffFrame then
            -- Module disabled or not ready: use original
            return original_BuffFrame_SetPoint(self, ...)
        end
        -- Redirect to our frame
        original_BuffFrame_ClearAllPoints(self)
        original_BuffFrame_SetPoint(self, "TOPRIGHT", dragonUIBuffFrame, "TOPRIGHT", 0, 0)
        -- DON'T call UpdatePosition() here - it would reset dragonUIBuffFrame
        -- position during editor drag. UpdatePosition is called on events instead.
    end
    
    -- Set initial position: anchor BuffFrame to our frame
    original_BuffFrame_ClearAllPoints(BuffFrame)
    original_BuffFrame_SetPoint(BuffFrame, "TOPRIGHT", dragonUIBuffFrame, "TOPRIGHT", 0, 0)
    BuffFrameModule:UpdatePosition()
    
    -- ========================================================================
    -- HELPER: Find buff layout info (first buff, last-row-start buff, row count)
    -- Used by both buff row-2 fix and debuff anchoring.
    -- ========================================================================
    local function GetBuffLayoutInfo()
        local slack = BuffFrame.numEnchants or 0
        local perRow = BUFFS_PER_ROW or 16
        local firstBuff = nil
        local lastRowStart = nil
        local numVisible = 0
        for i = 1, BUFF_ACTUAL_DISPLAY do
            local btn = _G["BuffButton" .. i]
            if btn and btn:IsShown() and not btn.consolidated then
                numVisible = numVisible + 1
                if numVisible == 1 then
                    firstBuff = btn
                    lastRowStart = btn
                end
                local idx = numVisible + slack
                if idx > 1 and math.fmod(idx, perRow) == 1 then
                    lastRowStart = btn  -- first buff of a new row
                end
            end
        end
        return firstBuff, lastRowStart, numVisible
    end

    -- ========================================================================
    -- HELPER: Re-anchor ConsolidatedBuffs to our toggle button.
    -- Blizzard code (UIParent_ManageFramePositions, etc.) may reposition
    -- ConsolidatedBuffs; this restores our custom placement.
    -- ========================================================================
    local function RestoreConsolidatedBuffsAnchor()
        local cb = _G.ConsolidatedBuffs
        if cb and dragonUIBuffFrame then
            cb:ClearAllPoints()
            cb:SetPoint("TOPRIGHT", dragonUIBuffFrame, "TOPRIGHT", 0, 0)
        end
        -- Also ensure TemporaryEnchantFrame follows ConsolidatedBuffs correctly
        if TemporaryEnchantFrame and cb then
            TemporaryEnchantFrame:ClearAllPoints()
            if cb:IsShown() then
                TemporaryEnchantFrame:SetPoint("TOPRIGHT", cb, "TOPLEFT", -6, 0)
            else
                TemporaryEnchantFrame:SetPoint("TOPRIGHT", cb, "TOPRIGHT", 0, 0)
            end
        end
    end

    -- ========================================================================
    -- HELPER: Fix debuff positioning (first debuff below last buff row)
    -- ========================================================================
    local function FixDebuffPositions()
        if not buffFramePositionLocked then return end
        local firstBuff, lastRowStart, numVisible = GetBuffLayoutInfo()
        local anchor = lastRowStart or firstBuff
        -- First debuff: anchor below the last buff row, right-aligned
        local firstDebuff = _G["DebuffButton1"]
        if firstDebuff then
            firstDebuff:ClearAllPoints()
            if anchor then
                firstDebuff:SetPoint("TOPRIGHT", anchor, "BOTTOMRIGHT", 0, -60)
            elseif dragonUIBuffFrame then
                -- No buffs visible — anchor directly below the buff frame
                firstDebuff:SetPoint("TOPRIGHT", dragonUIBuffFrame, "BOTTOMRIGHT", 0, -60)
            end
        end
    end

    -- ========================================================================
    -- HOOK: BuffFrame_UpdateAllBuffAnchors — ensure the Blizzard anchor chain
    --   ConsolidatedBuffs → TemporaryEnchantFrame → BuffButton1 → …
    -- stays consistent after Blizzard repositions everything.
    -- Also fixes row-2 alignment and respects the buff toggle state.
    -- ========================================================================
    if not BuffFrameModule._hookedBuffAnchors then
        BuffFrameModule._hookedBuffAnchors = true
        hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", function()
            if not buffFramePositionLocked then return end

            -- 1) Re-anchor TemporaryEnchantFrame (weapon enchants: poisons,
            --    sharpening stones, etc.) to follow ConsolidatedBuffs.
            --    Blizzard's ConsolidatedBuffs OnShow/OnHide handlers set this,
            --    but other code paths may move it; force it every update.
            if TemporaryEnchantFrame and ConsolidatedBuffs then
                TemporaryEnchantFrame:ClearAllPoints()
                if ConsolidatedBuffs:IsShown() then
                    TemporaryEnchantFrame:SetPoint("TOPRIGHT", ConsolidatedBuffs, "TOPLEFT", -6, 0)
                else
                    TemporaryEnchantFrame:SetPoint("TOPRIGHT", ConsolidatedBuffs, "TOPRIGHT", 0, 0)
                end
            end

            -- 2) Fix row-2 start: Blizzard anchors it to ConsolidatedBuffs
            --    BOTTOMRIGHT, which may not match our layout.  Re-anchor to
            --    the first visible buff so rows stack correctly.
            local firstBuff, _, numVisible = GetBuffLayoutInfo()
            if firstBuff then
                local slack = BuffFrame.numEnchants or 0
                local perRow = BUFFS_PER_ROW or 16
                local count = 0
                for i = 1, BUFF_ACTUAL_DISPLAY do
                    local btn = _G["BuffButton" .. i]
                    if btn and btn:IsShown() and not btn.consolidated then
                        count = count + 1
                        local idx = count + slack
                        if idx == perRow + 1 then
                            btn:ClearAllPoints()
                            btn:SetPoint("TOPRIGHT", firstBuff, "BOTTOMRIGHT", 0, -15)
                        end
                    end
                end
            end

            -- 3) Respect buff toggle: re-hide buffs if user collapsed them
            if buffsHiddenByToggle then
                for i = 1, BUFF_ACTUAL_DISPLAY do
                    local btn = _G["BuffButton" .. i]
                    if btn then
                        btn:Hide()
                    end
                end
            end
        end)
    end

    -- ========================================================================
    -- HOOK: DebuffButton_UpdateAnchors — fix debuff positioning
    -- Blizzard anchors the first debuff to ConsolidatedBuffs BOTTOMRIGHT.
    -- Since we moved ConsolidatedBuffs, debuffs end up too far right.
    -- This hook re-anchors the first debuff below the last buff row.
    -- ========================================================================
    if not BuffFrameModule._hookedDebuffAnchors then
        BuffFrameModule._hookedDebuffAnchors = true
        hooksecurefunc("DebuffButton_UpdateAnchors", function(buttonName, index)
            if not buffFramePositionLocked then return end
            if index ~= 1 then return end  -- only fix the first debuff; rest chain from it
            FixDebuffPositions()
        end)
    end

    -- ========================================================================
    -- HOOK: UIParent_ManageFramePositions — fires on ticket open/close.
    -- We update our frame position AND re-anchor ConsolidatedBuffs + debuffs
    -- so nothing drifts horizontally.
    -- ========================================================================
    if not BuffFrameModule._hookedManagePositions then
        BuffFrameModule._hookedManagePositions = true
        hooksecurefunc("UIParent_ManageFramePositions", function()
            if not dragonUIBuffFrame then return end
            if not addon.db or not addon.db.profile or not addon.db.profile.buffs
               or not addon.db.profile.buffs.enabled then return end
            BuffFrameModule:UpdatePosition()
            -- Restore ConsolidatedBuffs anchor (Blizzard may have moved it)
            RestoreConsolidatedBuffsAnchor()
            -- Force debuff re-anchor so they track the new buff position
            FixDebuffPositions()
        end)
    end
    
    -- Also hook TicketStatusFrame Show/Hide directly for reliable detection
    if not BuffFrameModule._hookedTicketFrame then
        BuffFrameModule._hookedTicketFrame = true
        if TicketStatusFrame then
            hooksecurefunc(TicketStatusFrame, "Show", function()
                if dragonUIBuffFrame and IsBuffFrameAtDefaultPosition() then
                    BuffFrameModule:UpdatePosition()
                    RestoreConsolidatedBuffsAnchor()
                    FixDebuffPositions()
                end
            end)
            hooksecurefunc(TicketStatusFrame, "Hide", function()
                if dragonUIBuffFrame and IsBuffFrameAtDefaultPosition() then
                    BuffFrameModule:UpdatePosition()
                    RestoreConsolidatedBuffsAnchor()
                    FixDebuffPositions()
                end
            end)
        end
        if GMChatStatusFrame then
            hooksecurefunc(GMChatStatusFrame, "Show", function()
                if dragonUIBuffFrame and IsBuffFrameAtDefaultPosition() then
                    BuffFrameModule:UpdatePosition()
                    RestoreConsolidatedBuffsAnchor()
                    FixDebuffPositions()
                end
            end)
            hooksecurefunc(GMChatStatusFrame, "Hide", function()
                if dragonUIBuffFrame and IsBuffFrameAtDefaultPosition() then
                    BuffFrameModule:UpdatePosition()
                    RestoreConsolidatedBuffsAnchor()
                    FixDebuffPositions()
                end
            end)
        end
    end
    
    --  CONFIGURE EVENTS
    if not buffFrame then
        buffFrame = CreateFrame("Frame")
        buffFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
        buffFrame:RegisterEvent("UNIT_AURA")
        buffFrame:RegisterEvent("UNIT_ENTERED_VEHICLE")
        buffFrame:RegisterEvent("UNIT_EXITED_VEHICLE")
        
        buffFrame:SetScript("OnEvent", function(self, event, unit)
            if event == "PLAYER_ENTERING_WORLD" then
                ReplaceBlizzardFrame(dragonUIBuffFrame)
                ShowToggleButtonIf(GetUnitBuffCount("player", 16) > 0)
                BuffFrameModule:UpdatePosition()
                
                -- Restore buff toggle state from saved profile
                if addon.db and addon.db.profile and addon.db.profile.buffs
                   and addon.db.profile.buffs.buffs_hidden then
                    buffsHiddenByToggle = true
                    toggleButton.toggle = false
                    local normalTex = toggleButton:GetNormalTexture()
                    SetAtlasTexture(normalTex, 'CollapseButton-Left')
                    local highlightTex = toggleButton:GetHighlightTexture()
                    SetAtlasTexture(highlightTex, 'CollapseButton-Left')
                    for index = 1, BUFF_ACTUAL_DISPLAY do
                        local button = _G['BuffButton' .. index]
                        if button then button:Hide() end
                    end
                end
                
                -- Reposition the GM ticket frame so it doesn't overlap the minimap
                if TicketStatusFrame then
                    TicketStatusFrame:ClearAllPoints()
                    TicketStatusFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -270, -5)
                end
            elseif event == "UNIT_AURA" then
                if unit == 'vehicle' then
                    ShowToggleButtonIf(GetUnitBuffCount("vehicle", 16) > 0)
                elseif unit == 'player' then
                    ShowToggleButtonIf(GetUnitBuffCount("player", 16) > 0)
                end
            elseif event == "UNIT_ENTERED_VEHICLE" then
                if unit == 'player' then
                    ShowToggleButtonIf(GetUnitBuffCount("vehicle", 16) > 0)
                end
            elseif event == "UNIT_EXITED_VEHICLE" then
                if unit == 'player' then
                    ShowToggleButtonIf(GetUnitBuffCount("player", 16) > 0)
                end
            end
        end)
    end
end

--  FUNCTION TO DISABLE THE MODULE
function BuffFrameModule:Disable()
    -- Restore original BuffFrame positioning methods
    buffFramePositionLocked = false
    BuffFrame.SetPoint = original_BuffFrame_SetPoint
    BuffFrame.ClearAllPoints = original_BuffFrame_ClearAllPoints
    
    if buffFrame then
        buffFrame:UnregisterAllEvents()
        buffFrame:SetScript("OnEvent", nil)
        buffFrame = nil
    end
    
    if toggleButton then
        toggleButton:Hide()
        toggleButton = nil
    end
    
    if dragonUIBuffFrame then
        dragonUIBuffFrame:Hide()
        dragonUIBuffFrame = nil
    end
end

--  AUTOMATIC INITIALIZATION
local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("ADDON_LOADED")
initFrame:SetScript("OnEvent", function(self, event, addonName)
    if addonName == "DragonUI" then
        if addon.db and addon.db.profile and addon.db.profile.buffs and addon.db.profile.buffs.enabled then
            BuffFrameModule:Enable()
        end
        self:UnregisterEvent("ADDON_LOADED")
    end
end)

--  FUNCTION TO BE CALLED FROM OPTIONS.LUA
function addon:RefreshBuffFrame()
    if BuffFrameModule and addon.db.profile.buffs.enabled then
        BuffFrameModule:UpdatePosition()
    end
end
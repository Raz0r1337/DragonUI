local addon = select(2, ...)

-- ============================================================================
-- DRAGONUI TARGET OF TARGET FRAME MODULE - WoW 3.3.5a
-- Improved private server compatibility by xius
-- ============================================================================

local Module = {
    totFrame = nil,
    textSystem = nil,
    initialized = false,
    configured = false,
    eventsFrame = nil
}

-- ============================================================================
-- CONFIGURATION & CONSTANTS
-- ============================================================================

-- Cache Blizzard frames
local TargetFrameToT = _G.TargetFrameToT

-- Texture paths (ToT específicas)
local TEXTURES = {
    BACKGROUND = "Interface\\AddOns\\DragonUI\\Textures\\UI-HUD-UnitFrame-TargetofTarget-PortraitOn-BACKGROUND",
    BORDER = "Interface\\AddOns\\DragonUI\\Textures\\UI-HUD-UnitFrame-TargetofTarget-PortraitOn-BORDER",
    BAR_PREFIX = "Interface\\AddOns\\DragonUI\\Textures\\Unitframe\\UI-HUD-UnitFrame-TargetofTarget-PortraitOn-Bar-",
    BOSS = "Interface\\AddOns\\DragonUI\\Textures\\uiunitframeboss2x"
}

-- Boss classifications (coordenadas ToT más pequeñas)
local BOSS_COORDS = {
    elite = {0.001953125, 0.314453125, 0.322265625, 0.630859375, 60, 59, 3, 1},
    rare = {0.00390625, 0.31640625, 0.64453125, 0.953125, 60, 59, 3, 1},
    rareelite = {0.001953125, 0.388671875, 0.001953125, 0.31835937, 74, 61, 10, 1}
}

-- Power types
local POWER_MAP = {
    [0] = "Mana",
    [1] = "Rage",
    [2] = "Focus",
    [3] = "Energy",
    [6] = "RunicPower"
}

-- Frame elements storage
local frameElements = {
    background = nil,
    border = nil,
    elite = nil
}

-- Update throttling
local updateCache = {
    lastHealthUpdate = 0,
    lastPowerUpdate = 0
}

-- ============================================================================
-- UTILITY FUNCTIONS
-- ============================================================================

local function GetConfig()
    -- Try multiple ways to get config (improved private server compatibility)
    if addon.GetConfigValue then
        return addon:GetConfigValue("unitframe", "tot") or {}
    elseif addon.db and addon.db.profile and addon.db.profile.unitframe and addon.db.profile.unitframe.tot then
        return addon.db.profile.unitframe.tot
    end
    return {}
end

local function IsEnabled()
    local config = GetConfig()
    -- Default to true if not explicitly set to false
    if config.enabled == nil then
        return true
    end
    return config.enabled
end

-- Helper function to determine what unit the ToT frame should display
local function GetToTUnit()
    if not UnitExists("target") then
        return nil
    end
    
    -- When targeting yourself, targettarget IS your own target
    -- But we need to make sure we're showing it
    if UnitExists("targettarget") then
        return "targettarget"
    end
    
    return nil
end

-- Check if ToT frame should be visible
-- Show when you have a target AND (you have a targettarget OR you're targeting yourself)
local function ShouldShowToT()
    if not UnitExists("target") then
        return false
    end
    
    local hasTargetTarget = UnitExists("targettarget")
    local targetingSelf = UnitIsUnit("target", "player")
    
    -- Always show if targettarget exists
    if hasTargetTarget then
        return true
    end
    
    -- Also show when targeting yourself (even if you have no target)
    if targetingSelf then
        return true
    end
    
    return false
end

-- ============================================================================
-- BAR MANAGEMENT (IGUAL QUE TARGET/FOCUS)
-- ============================================================================

local function SetupBarHooks()
    -- Health bar hooks (igual que tu target.lua)
    if not TargetFrameToTHealthBar.DragonUI_Setup then
        local healthTexture = TargetFrameToTHealthBar:GetStatusBarTexture()
        if healthTexture then
            healthTexture:SetDrawLayer("ARTWORK", 1)
        end

        hooksecurefunc(TargetFrameToTHealthBar, "SetValue", function(self)
    if not UnitExists("targettarget") then
        return
    end

    local now = GetTime()
    if now - updateCache.lastHealthUpdate < 0.05 then
        return
    end
    updateCache.lastHealthUpdate = now

    local texture = self:GetStatusBarTexture()
    if not texture then
        return
    end

    local config = GetConfig()
    local texturePath
    
    -- NUEVO: Decidir qué textura usar basado en classcolor
    if config.classcolor and UnitIsPlayer("targettarget") then
        texturePath = TEXTURES.BAR_PREFIX .. "Health-Status"  -- Versión Status para colores de clase
    else
        texturePath = TEXTURES.BAR_PREFIX .. "Health"         -- Versión normal
    end

    -- Update texture
    if texture:GetTexture() ~= texturePath then
        texture:SetTexture(texturePath)
        texture:SetDrawLayer("ARTWORK", 1)
    end

    -- Update coords
    local min, max = self:GetMinMaxValues()
    local current = self:GetValue()
    if max > 0 and current then
        texture:SetTexCoord(0, current / max, 0, 1)
    end

    -- Update color
    if config.classcolor and UnitIsPlayer("targettarget") then
        local _, class = UnitClass("targettarget")
        local color = RAID_CLASS_COLORS[class]
        if color then
            texture:SetVertexColor(color.r, color.g, color.b)
        else
            texture:SetVertexColor(1, 1, 1)
        end
    else
        texture:SetVertexColor(1, 1, 1)
    end
end)

        TargetFrameToTHealthBar.DragonUI_Setup = true
    end

    -- Power bar hooks (igual que tu target.lua)
    if not TargetFrameToTManaBar.DragonUI_Setup then
        local powerTexture = TargetFrameToTManaBar:GetStatusBarTexture()
        if powerTexture then
            powerTexture:SetDrawLayer("ARTWORK", 1)
        end

        hooksecurefunc(TargetFrameToTManaBar, "SetValue", function(self)
            if not UnitExists("targettarget") then
                return
            end

            local now = GetTime()
            if now - updateCache.lastPowerUpdate < 0.05 then
                return
            end
            updateCache.lastPowerUpdate = now

            local texture = self:GetStatusBarTexture()
            if not texture then
                return
            end

            -- Update texture based on power type
            local powerType = UnitPowerType("targettarget")
            local powerName = POWER_MAP[powerType] or "Mana"
            local texturePath = TEXTURES.BAR_PREFIX .. powerName

            if texture:GetTexture() ~= texturePath then
                texture:SetTexture(texturePath)
                texture:SetDrawLayer("ARTWORK", 1)
            end

            -- Update coords
            local min, max = self:GetMinMaxValues()
            local current = self:GetValue()
            if max > 0 and current then
                texture:SetTexCoord(0, current / max, 0, 1)
            end

            -- Force white color
            texture:SetVertexColor(1, 1, 1)
        end)

        TargetFrameToTManaBar.DragonUI_Setup = true
    end
end

-- ============================================================================
-- CLASSIFICATION SYSTEM 
-- ============================================================================

local function UpdateClassification()
    local totUnit = GetToTUnit()
    if not totUnit or not frameElements.elite then
        if frameElements.elite then
            frameElements.elite:Hide()
        end
        return
    end

    local classification = UnitClassification(totUnit)
    local coords = nil

    -- Check vehicle first
    if UnitVehicleSeatCount and UnitVehicleSeatCount(totUnit) > 0 then
        frameElements.elite:Hide()
        return
    end

    -- Determine classification
    if classification == "worldboss" or classification == "elite" then
        coords = BOSS_COORDS.elite
    elseif classification == "rareelite" then
        coords = BOSS_COORDS.rareelite
    elseif classification == "rare" then
        coords = BOSS_COORDS.rare
    else
        local name = UnitName(totUnit)
        if name and addon.unitframe and addon.unitframe.famous and addon.unitframe.famous[name] then
            coords = BOSS_COORDS.elite
        end
    end

    if coords then
        frameElements.elite:SetTexture(TEXTURES.BOSS)

        -- Apply horizontal flip to all decorations
        local left, right, top, bottom = coords[1], coords[2], coords[3], coords[4]
        frameElements.elite:SetTexCoord(right, left, top, bottom)

        frameElements.elite:SetSize(51, 51)
        frameElements.elite:SetPoint("CENTER", TargetFrameToTPortrait, "CENTER", -4, -2)
        frameElements.elite:SetDrawLayer("OVERLAY", 11)
        frameElements.elite:Show()
        frameElements.elite:SetAlpha(1)
    else
        frameElements.elite:Hide()
    end
end

-- ============================================================================
-- FRAME INITIALIZATION
-- ============================================================================

local function InitializeFrame()
    if Module.configured then
        return
    end
    
    -- Check if ToT is enabled in config
    if not IsEnabled() then
        -- Hide ToT if disabled
        if TargetFrameToT then
            TargetFrameToT:Hide()
        end
        SetCVar("showTargetOfTarget", "0")
        return
    end
    
    -- Force-enable Blizzard's ToT frame
    SetCVar("showTargetOfTarget", "1")

    -- Verify ToT exists
    if not TargetFrameToT then
        return
    end

    -- Get configuration
    local config = GetConfig()

    -- Position Blizzard frame (only once at init to avoid taint)
    if not Module.configured then
        TargetFrameToT:ClearAllPoints()
        TargetFrameToT:SetPoint(config.anchor or "BOTTOMRIGHT", TargetFrame, config.anchorParent or "BOTTOMRIGHT", config.x or 22, config.y or -15)
        TargetFrameToT:SetScale(config.scale or 1.0)
    end

    -- Hide Blizzard elements
    local toHide = {TargetFrameToTTextureFrameTexture, TargetFrameToTBackground}

    for _, element in ipairs(toHide) do
        if element then
            element:SetAlpha(0)
            element:Hide()
        end
    end

    -- Create background texture
    if not frameElements.background then
        frameElements.background = TargetFrameToT:CreateTexture("DragonUI_ToTBG", "BACKGROUND", nil, 0)
        frameElements.background:SetTexture(TEXTURES.BACKGROUND)
        frameElements.background:SetPoint('LEFT', TargetFrameToTPortrait, 'CENTER', -25 + 1, -10)
    end

    -- Create border texture
    if not frameElements.border then
        frameElements.border = TargetFrameToTHealthBar:CreateTexture("DragonUI_ToTBorder", "OVERLAY", nil, 1)
        frameElements.border:SetTexture(TEXTURES.BORDER)
        frameElements.border:SetPoint('LEFT', TargetFrameToTPortrait, 'CENTER', -25 + 1, -10)
        frameElements.border:Show()
        frameElements.border:SetAlpha(1)
    end

    -- Create elite decoration
    if not frameElements.elite then
        local eliteFrame = CreateFrame("Frame", "DragonUI_ToTEliteFrame", TargetFrameToT)
        eliteFrame:SetFrameStrata("MEDIUM")
        eliteFrame:SetAllPoints(TargetFrameToTPortrait)

        frameElements.elite = eliteFrame:CreateTexture("DragonUI_ToTElite", "OVERLAY", nil, 1)
        frameElements.elite:SetTexture(TEXTURES.BOSS)
        frameElements.elite:Hide()
    end
    -- Configure health bar
    TargetFrameToTHealthBar:Hide()
    TargetFrameToTHealthBar:ClearAllPoints()
    TargetFrameToTHealthBar:SetParent(TargetFrameToT)
    TargetFrameToTHealthBar:SetFrameStrata("LOW")
    TargetFrameToTHealthBar:GetStatusBarTexture():SetDrawLayer("ARTWORK", 1)
    TargetFrameToTHealthBar:GetStatusBarTexture():SetTexture(TEXTURES.BAR_PREFIX .. "Health")
    TargetFrameToTHealthBar.SetStatusBarColor = function()
    end -- noop
    TargetFrameToTHealthBar:GetStatusBarTexture():SetVertexColor(1, 1, 1, 1)
    TargetFrameToTHealthBar:SetSize(70.5, 10)
    TargetFrameToTHealthBar:SetPoint('LEFT', TargetFrameToTPortrait, 'RIGHT', 1 + 1, 0)
    TargetFrameToTHealthBar:Show()

    -- Configure power bar
    TargetFrameToTManaBar:Hide()
    TargetFrameToTManaBar:ClearAllPoints()
    TargetFrameToTManaBar:SetParent(TargetFrameToT)
    TargetFrameToTManaBar:SetFrameStrata("LOW")
    TargetFrameToTManaBar:GetStatusBarTexture():SetDrawLayer("ARTWORK", 1)
    TargetFrameToTManaBar:GetStatusBarTexture():SetTexture(TEXTURES.BAR_PREFIX .. "Mana")
    TargetFrameToTManaBar.SetStatusBarColor = function()
    end -- noop
    TargetFrameToTManaBar:GetStatusBarTexture():SetVertexColor(1, 1, 1, 1)
    TargetFrameToTManaBar:SetSize(74, 7.5)
    TargetFrameToTManaBar:SetPoint('LEFT', TargetFrameToTPortrait, 'RIGHT', 1 - 2 - 1.5 + 1, 2 - 10 - 1)
    TargetFrameToTManaBar:Show()

    -- Configure name text
    if TargetFrameToTTextureFrameName then
        TargetFrameToTTextureFrameName:ClearAllPoints()
        TargetFrameToTTextureFrameName:SetPoint('LEFT', TargetFrameToTPortrait, 'RIGHT', 3, 13)
        TargetFrameToTTextureFrameName:SetParent(TargetFrameToT)
        TargetFrameToTTextureFrameName:Show()
        local font, size, flags = TargetFrameToTTextureFrameName:GetFont()
        if font and size then
            TargetFrameToTTextureFrameName:SetFont(font, math.max(size, 10), flags)
        end
        TargetFrameToTTextureFrameName:SetTextColor(1.0, 0.82, 0.0, 1.0)
        TargetFrameToTTextureFrameName:SetDrawLayer("BORDER", 1)

        --  TRUNCADO AUTOMÁTICO COMO RETAILUI
        TargetFrameToTTextureFrameName:SetWidth(65)
        TargetFrameToTTextureFrameName:SetJustifyH("LEFT")
    end

    -- Force debuff positions if needed
    if TargetFrameToTDebuff1 then
        TargetFrameToTDebuff1:ClearAllPoints()
        TargetFrameToTDebuff1:SetPoint("TOPLEFT", TargetFrameToT, "BOTTOMLEFT", 120, 35)
    end

    -- Setup bar hooks
    SetupBarHooks()
    
    -- CRITICAL: Show the main ToT frame
    TargetFrameToT:Show()
    
    Module.configured = true
end

-- ============================================================================
-- EVENT HANDLING
-- ============================================================================

local function OnEvent(self, event, ...)
    if event == "ADDON_LOADED" then
        local name = ...
        if name == "DragonUI" and not Module.initialized then
            Module.totFrame = CreateFrame("Frame", "DragonUI_ToT_Anchor", UIParent)
            Module.totFrame:SetSize(120, 47)
            Module.totFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 370, -80)
            Module.initialized = true
            
            -- Force-enable or disable Blizzard ToT based on config
            if IsEnabled() then
                SetCVar("showTargetOfTarget", "1")
            else
                SetCVar("showTargetOfTarget", "0")
            end
        end

    elseif event == "PLAYER_ENTERING_WORLD" then
        InitializeFrame()
        
        -- If initialization failed (frame doesn't exist yet), schedule a retry
        if not Module.configured and IsEnabled() then
            local retryFrame = CreateFrame("Frame")
            local retryCount = 0
            retryFrame:SetScript("OnUpdate", function(self, elapsed)
                retryCount = retryCount + 1
                if Module.configured or retryCount > 50 then  -- Stop after ~3 seconds
                    self:SetScript("OnUpdate", nil)
                    return
                end
                
                -- Try to initialize every frame for first 3 seconds
                if TargetFrameToT and not Module.configured then
                    InitializeFrame()
                end
            end)
        end
        
        if IsEnabled() and ShouldShowToT() then
            -- Ensure frame is visible
            if TargetFrameToT then
                TargetFrameToT:Show()
            end
            UpdateClassification()
        end

    elseif event == "PLAYER_TARGET_CHANGED" then
        -- Target changed, force update ToT
        if not IsEnabled() then return end
        
        -- Show or hide based on whether we should show ToT
        if TargetFrameToT then
            if ShouldShowToT() then
                TargetFrameToT:Show()
            else
                TargetFrameToT:Hide()
            end
        end
        
        UpdateClassification()
        if Module.textSystem then
            Module.textSystem.update()
        end

    elseif event == "UNIT_TARGET" then
        if not IsEnabled() then return end
        
        local unit = ...
        if unit == "target" or unit == "player" then
            -- Show or hide based on whether we should show ToT
            if TargetFrameToT then
                if ShouldShowToT() then
                    TargetFrameToT:Show()
                else
                    TargetFrameToT:Hide()
                end
            end
            
            UpdateClassification()
            if Module.textSystem then
                Module.textSystem.update()
            end
        end

    elseif event == "UNIT_CLASSIFICATION_CHANGED" then
        if not IsEnabled() then return end
        
        local unit = ...
        if unit == "targettarget" then
            UpdateClassification()
        end

    elseif event == "UNIT_FACTION" then
        if not IsEnabled() then return end
        
        local unit = ...
        if unit == "targettarget" then
            -- Could add name background color change here if needed
        end
    end
end

-- Initialize events
if not Module.eventsFrame then
    Module.eventsFrame = CreateFrame("Frame")
    Module.eventsFrame:RegisterEvent("ADDON_LOADED")
    Module.eventsFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    Module.eventsFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
    Module.eventsFrame:RegisterEvent("UNIT_TARGET") -- Crucial para ToT
    Module.eventsFrame:RegisterEvent("UNIT_CLASSIFICATION_CHANGED")
    Module.eventsFrame:RegisterEvent("UNIT_FACTION")
    Module.eventsFrame:SetScript("OnEvent", OnEvent)
end

-- ============================================================================
-- PUBLIC API
-- ============================================================================

local function RefreshFrame()
    if not IsEnabled() then
        -- Hide ToT if disabled
        if TargetFrameToT then
            TargetFrameToT:Hide()
        end
        SetCVar("showTargetOfTarget", "0")
        return
    end
    
    -- Force-enable if enabled
    SetCVar("showTargetOfTarget", "1")
    
    if not Module.configured then
        InitializeFrame()
    else
        -- Show/hide based on whether we should show ToT
        if TargetFrameToT then
            if ShouldShowToT() then
                TargetFrameToT:Show()
            else
                TargetFrameToT:Hide()
            end
        end
    end

    if ShouldShowToT() then
        UpdateClassification()
        if Module.textSystem then
            Module.textSystem.update()
        end
    end
end

local function ResetFrame()
    -- Reset a valores por defecto de la DB
    addon:SetConfigValue("unitframe", "tot", "x", 22)
    addon:SetConfigValue("unitframe", "tot", "y", -15)
    addon:SetConfigValue("unitframe", "tot", "scale", 1.0)

    -- Aplicar al frame de Blizzard
    TargetFrameToT:ClearAllPoints()
    TargetFrameToT:SetPoint("BOTTOMRIGHT", TargetFrame, "BOTTOMRIGHT", 22, -15)
    TargetFrameToT:SetScale(1.0)
end

-- Export API (igual que target/focus)
addon.TargetOfTarget = {
    Refresh = RefreshFrame,
    RefreshToTFrame = RefreshFrame,
    Reset = ResetFrame,
    anchor = function()
        return Module.totFrame
    end,
    ChangeToTFrame = RefreshFrame
}

-- Legacy compatibility
addon.unitframe = addon.unitframe or {}
addon.unitframe.ChangeToT = RefreshFrame
addon.unitframe.ReApplyToTFrame = RefreshFrame
addon.unitframe.StyleToTFrame = InitializeFrame

function addon:RefreshToTFrame()
    RefreshFrame()
end



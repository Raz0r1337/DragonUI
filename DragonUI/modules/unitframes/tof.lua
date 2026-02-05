local addon = select(2, ...)

-- ============================================================================
-- DRAGONUI FOCUS OF TARGET FRAME MODULE - WoW 3.3.5a
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
local FocusFrameToT = _G.FocusFrameToT

-- Texture paths
local TEXTURES = {
    BACKGROUND = "Interface\\AddOns\\DragonUI\\Textures\\UI-HUD-UnitFrame-TargetofTarget-PortraitOn-BACKGROUND",
    BORDER = "Interface\\AddOns\\DragonUI\\Textures\\UI-HUD-UnitFrame-TargetofTarget-PortraitOn-BORDER",
    BAR_PREFIX = "Interface\\AddOns\\DragonUI\\Textures\\Unitframe\\UI-HUD-UnitFrame-TargetofTarget-PortraitOn-Bar-",
    BOSS = "Interface\\AddOns\\DragonUI\\Textures\\uiunitframeboss2x"
}

-- Boss classifications
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
        return addon:GetConfigValue("unitframe", "fot") or {}
    elseif addon.db and addon.db.profile and addon.db.profile.unitframe and addon.db.profile.unitframe.fot then
        return addon.db.profile.unitframe.fot
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

-- Helper function to determine what unit the FoT frame should display
local function GetFoTUnit()
    if not UnitExists("focus") then
        return nil
    end
    
    if UnitExists("focustarget") then
        return "focustarget"
    end
    
    return nil
end

-- Check if FoT frame should be visible
local function ShouldShowFoT()
    if not UnitExists("focus") then
        return false
    end
    
    local hasFocusTarget = UnitExists("focustarget")
    local focusingSelf = UnitIsUnit("focus", "player")
    
    if hasFocusTarget then
        return true
    end
    
    if focusingSelf then
        return true
    end
    
    return false
end

-- ============================================================================
-- BAR MANAGEMENT (IGUAL QUE TOT PERO PARA FOCUS)
-- ============================================================================

local function SetupBarHooks()
    -- Health bar hooks (IGUAL que ToT pero para "focustarget")
    if not FocusFrameToTHealthBar.DragonUI_Setup then
        local healthTexture = FocusFrameToTHealthBar:GetStatusBarTexture()
        if healthTexture then
            healthTexture:SetDrawLayer("ARTWORK", 1)
        end

        hooksecurefunc(FocusFrameToTHealthBar, "SetValue", function(self)
            if not UnitExists("focustarget") then
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
            if config.classcolor and UnitIsPlayer("focustarget") then
                texturePath = TEXTURES.BAR_PREFIX .. "Health-Status" -- Versión Status para colores de clase
            else
                texturePath = TEXTURES.BAR_PREFIX .. "Health" -- Versión normal
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
            if config.classcolor and UnitIsPlayer("focustarget") then
                local _, class = UnitClass("focustarget")
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

        FocusFrameToTHealthBar.DragonUI_Setup = true
    end

    -- Power bar hooks (IGUAL que ToT pero para "focustarget")
    if not FocusFrameToTManaBar.DragonUI_Setup then
        local powerTexture = FocusFrameToTManaBar:GetStatusBarTexture()
        if powerTexture then
            powerTexture:SetDrawLayer("ARTWORK", 1)
        end

        hooksecurefunc(FocusFrameToTManaBar, "SetValue", function(self)
            if not UnitExists("focustarget") then
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
            local powerType = UnitPowerType("focustarget")
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

        FocusFrameToTManaBar.DragonUI_Setup = true
    end
end

-- ============================================================================
-- CLASSIFICATION SYSTEM
-- ============================================================================

local function UpdateClassification()
    local fotUnit = GetFoTUnit()
    if not fotUnit or not frameElements.elite then
        if frameElements.elite then
            frameElements.elite:Hide()
        end
        return
    end

    local classification = UnitClassification(fotUnit)
    local coords = nil

    -- Check vehicle first
    if UnitVehicleSeatCount and UnitVehicleSeatCount(fotUnit) > 0 then
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
        local name = UnitName(fotUnit)
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
        frameElements.elite:SetPoint("CENTER", FocusFrameToTPortrait, "CENTER", -4, -2)
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
    
    -- Check if FoT is enabled in config
    if not IsEnabled() then
        if FocusFrameToT then
            FocusFrameToT:Hide()
        end
        return
    end

    -- Verify FoT exists
    if not FocusFrameToT then
        return
    end

    -- Get configuration
    local config = GetConfig()

    -- Position and scale (anchored to Focus Frame)
    if not Module.configured then
        FocusFrameToT:ClearAllPoints()
        FocusFrameToT:SetPoint(config.anchor or "BOTTOMRIGHT", FocusFrame, config.anchorParent or "BOTTOMRIGHT",
            config.x or -8, config.y or -30)
        FocusFrameToT:SetScale(config.scale or 1.0)
    end

    -- Hide Blizzard elements
    local toHide = {FocusFrameToTTextureFrameTexture, FocusFrameToTBackground}

    for _, element in ipairs(toHide) do
        if element then
            element:SetAlpha(0)
            element:Hide()
        end
    end

    -- Create background texture
    if not frameElements.background then
        frameElements.background = FocusFrameToT:CreateTexture("DragonUI_FoTBG", "BACKGROUND", nil, 0)
        frameElements.background:SetTexture(TEXTURES.BACKGROUND)
        frameElements.background:SetPoint('LEFT', FocusFrameToTPortrait, 'CENTER', -25 + 1, -10)
    end

    -- Create border texture
    if not frameElements.border then
        frameElements.border = FocusFrameToTHealthBar:CreateTexture("DragonUI_FoTBorder", "OVERLAY", nil, 1)
        frameElements.border:SetTexture(TEXTURES.BORDER)
        frameElements.border:SetPoint('LEFT', FocusFrameToTPortrait, 'CENTER', -25 + 1, -10)
        frameElements.border:Show()
        frameElements.border:SetAlpha(1)
    end

    -- Create elite decoration
    if not frameElements.elite then
        local eliteFrame = CreateFrame("Frame", "DragonUI_FoTEliteFrame", FocusFrameToT)
        eliteFrame:SetFrameStrata("MEDIUM")
        eliteFrame:SetAllPoints(FocusFrameToTPortrait)

        frameElements.elite = eliteFrame:CreateTexture("DragonUI_FoTElite", "OVERLAY", nil, 1)
        frameElements.elite:SetTexture(TEXTURES.BOSS)
        frameElements.elite:Hide()
    end

    -- Configure health bar
    FocusFrameToTHealthBar:Hide()
    FocusFrameToTHealthBar:ClearAllPoints()
    FocusFrameToTHealthBar:SetParent(FocusFrameToT)
    FocusFrameToTHealthBar:SetFrameStrata("LOW")
    FocusFrameToTHealthBar:GetStatusBarTexture():SetDrawLayer("ARTWORK", 1)
    FocusFrameToTHealthBar:GetStatusBarTexture():SetTexture(TEXTURES.BAR_PREFIX .. "Health")
    FocusFrameToTHealthBar.SetStatusBarColor = function()
    end -- noop
    FocusFrameToTHealthBar:GetStatusBarTexture():SetVertexColor(1, 1, 1, 1)
    FocusFrameToTHealthBar:SetSize(70.5, 10)
    FocusFrameToTHealthBar:SetPoint('LEFT', FocusFrameToTPortrait, 'RIGHT', 1 + 1, 0)
    FocusFrameToTHealthBar:Show()

    -- Configure power bar
    FocusFrameToTManaBar:Hide()
    FocusFrameToTManaBar:ClearAllPoints()
    FocusFrameToTManaBar:SetParent(FocusFrameToT)
    FocusFrameToTManaBar:SetFrameStrata("LOW")
    FocusFrameToTManaBar:GetStatusBarTexture():SetDrawLayer("ARTWORK", 1)
    FocusFrameToTManaBar:GetStatusBarTexture():SetTexture(TEXTURES.BAR_PREFIX .. "Mana")
    FocusFrameToTManaBar.SetStatusBarColor = function()
    end -- noop
    FocusFrameToTManaBar:GetStatusBarTexture():SetVertexColor(1, 1, 1, 1)
    FocusFrameToTManaBar:SetSize(74, 7.5)
    FocusFrameToTManaBar:SetPoint('LEFT', FocusFrameToTPortrait, 'RIGHT', 1 - 2 - 1.5 + 1, 2 - 10 - 1)
    FocusFrameToTManaBar:Show()

    -- Configure name text
    if FocusFrameToTTextureFrameName then
        FocusFrameToTTextureFrameName:ClearAllPoints()
        FocusFrameToTTextureFrameName:SetPoint('LEFT', FocusFrameToTPortrait, 'RIGHT', 3, 13)
        FocusFrameToTTextureFrameName:SetParent(FocusFrameToT)
        FocusFrameToTTextureFrameName:Show()
        local font, size, flags = FocusFrameToTTextureFrameName:GetFont()
        if font and size then
            FocusFrameToTTextureFrameName:SetFont(font, math.max(size, 10), flags)
        end
        FocusFrameToTTextureFrameName:SetTextColor(1.0, 0.82, 0.0, 1.0)
        FocusFrameToTTextureFrameName:SetDrawLayer("BORDER", 1)

        -- Auto truncation
        FocusFrameToTTextureFrameName:SetWidth(65)
        FocusFrameToTTextureFrameName:SetJustifyH("LEFT")
    end

    -- Force debuff positions if needed
    if FocusFrameToTDebuff1 then
        FocusFrameToTDebuff1:ClearAllPoints()
        FocusFrameToTDebuff1:SetPoint("TOPLEFT", FocusFrameToT, "BOTTOMLEFT", 120, 35)
    end

    -- Setup bar hooks
    SetupBarHooks()
    
    -- CRITICAL: Show the main FoT frame
    FocusFrameToT:Show()

    Module.configured = true
end

-- ============================================================================
-- EVENT HANDLING
-- ============================================================================

local function OnEvent(self, event, ...)
    if event == "ADDON_LOADED" then
        local name = ...
        if name == "DragonUI" and not Module.initialized then
            Module.totFrame = CreateFrame("Frame", "DragonUI_FoT_Anchor", UIParent)
            Module.totFrame:SetSize(120, 47)
            Module.totFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 370, -80)
            Module.initialized = true
        end

    elseif event == "PLAYER_ENTERING_WORLD" then
        InitializeFrame()
        
        -- If initialization failed (frame doesn't exist yet), schedule a retry
        if not Module.configured and IsEnabled() then
            local retryFrame = CreateFrame("Frame")
            local retryCount = 0
            retryFrame:SetScript("OnUpdate", function(self, elapsed)
                retryCount = retryCount + 1
                if Module.configured or retryCount > 50 then
                    self:SetScript("OnUpdate", nil)
                    return
                end
                
                if FocusFrameToT and not Module.configured then
                    InitializeFrame()
                end
            end)
        end
        
        if IsEnabled() and ShouldShowFoT() then
            if FocusFrameToT then
                FocusFrameToT:Show()
            end
            UpdateClassification()
        end

    elseif event == "PLAYER_FOCUS_CHANGED" then
        if not IsEnabled() then return end
        
        -- Show or hide based on whether we should show FoT
        if FocusFrameToT then
            if ShouldShowFoT() then
                FocusFrameToT:Show()
            else
                FocusFrameToT:Hide()
            end
        end
        
        UpdateClassification()
        if Module.textSystem then
            Module.textSystem.update()
        end

    elseif event == "UNIT_TARGET" then
        if not IsEnabled() then return end
        
        local unit = ...
        if unit == "focus" then
            -- Show or hide based on whether we should show FoT
            if FocusFrameToT then
                if ShouldShowFoT() then
                    FocusFrameToT:Show()
                else
                    FocusFrameToT:Hide()
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
        if unit == "focustarget" then
            UpdateClassification()
        end

    elseif event == "UNIT_FACTION" then
        if not IsEnabled() then return end
        
        local unit = ...
        if unit == "focustarget" then
            -- Could add name background color change here if needed
        end
    end
end

-- Initialize events
if not Module.eventsFrame then
    Module.eventsFrame = CreateFrame("Frame")
    Module.eventsFrame:RegisterEvent("ADDON_LOADED")
    Module.eventsFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    Module.eventsFrame:RegisterEvent("PLAYER_FOCUS_CHANGED")
    Module.eventsFrame:RegisterEvent("UNIT_TARGET") -- Crucial para FoT
    Module.eventsFrame:RegisterEvent("UNIT_CLASSIFICATION_CHANGED")
    Module.eventsFrame:RegisterEvent("UNIT_FACTION")
    Module.eventsFrame:SetScript("OnEvent", OnEvent)
end

-- ============================================================================
-- PUBLIC API
-- ============================================================================

local function RefreshFrame()
    if not IsEnabled() then
        if FocusFrameToT then
            FocusFrameToT:Hide()
        end
        return
    end
    
    if not Module.configured then
        InitializeFrame()
    else
        -- Show/hide based on whether we should show FoT
        if FocusFrameToT then
            if ShouldShowFoT() then
                FocusFrameToT:Show()
            else
                FocusFrameToT:Hide()
            end
        end
    end

    if ShouldShowFoT() then
        UpdateClassification()
        if Module.textSystem then
            Module.textSystem.update()
        end
    end
end

local function ResetFrame()
    -- Reset a valores por defecto de la DB
    addon:SetConfigValue("unitframe", "fot", "x", -8)
    addon:SetConfigValue("unitframe", "fot", "y", -30)
    addon:SetConfigValue("unitframe", "fot", "scale", 1.0)

    -- Aplicar inmediatamente
    local config = GetConfig()
    FocusFrameToT:ClearAllPoints()
    FocusFrameToT:SetPoint(config.anchor or "BOTTOMRIGHT", FocusFrame, config.anchorParent or "BOTTOMRIGHT", config.x,
        config.y)
    FocusFrameToT:SetScale(config.scale)
end

-- Export API (igual que target/focus)
addon.TargetOfFocus = {
    Refresh = RefreshFrame,
    RefreshToFFrame = RefreshFrame,
    Reset = ResetFrame,
    anchor = function()
        return Module.totFrame
    end,
    ChangeToFFrame = RefreshFrame
}

-- Legacy compatibility
addon.unitframe = addon.unitframe or {}
addon.unitframe.ChangeFocusToT = RefreshFrame
addon.unitframe.ReApplyFocusToTFrame = RefreshFrame
addon.unitframe.StyleFocusToTFrame = InitializeFrame

function addon:RefreshToFFrame()
    RefreshFrame()
end


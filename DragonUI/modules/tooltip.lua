local addon = select(2, ...)

-- ============================================================================
-- TOOLTIP MODULE FOR DRAGONUI
-- Enhances GameTooltip with class colors, health bars, target-of-target,
-- and cleaner styling inspired by Dragonflight tooltips.
-- ============================================================================

-- Module state tracking
local TooltipModule = {
    initialized = false,
    applied = false,
    originalStates = {},
    hooks = {},
    frames = {}
}

-- Register with ModuleRegistry (if available)
if addon.RegisterModule then
    addon:RegisterModule("tooltip", TooltipModule, "Tooltip", "Enhanced tooltip styling with class colors and health bars")
end

-- ============================================================================
-- CONFIGURATION FUNCTIONS
-- ============================================================================

local function GetModuleConfig()
    return addon:GetModuleConfig("tooltip")
end

local function IsModuleEnabled()
    return addon:IsModuleEnabled("tooltip")
end

-- ============================================================================
-- CLASS COLOR CACHE
-- ============================================================================

local CLASS_COLORS = {}
for class, color in pairs(RAID_CLASS_COLORS) do
    CLASS_COLORS[class] = { r = color.r, g = color.g, b = color.b }
end

-- Faction colors for hostile/friendly/neutral
local FACTION_COLORS = {
    friendly = { r = 0.2, g = 0.8, b = 0.2 },
    neutral  = { r = 1.0, g = 1.0, b = 0.0 },
    hostile  = { r = 1.0, g = 0.2, b = 0.2 },
    tapped   = { r = 0.6, g = 0.6, b = 0.6 },
}

-- ============================================================================
-- TOOLTIP HEALTH BAR ENHANCEMENT
-- ============================================================================

local HEALTHBAR_HEIGHT = 6
local HEALTHBAR_PADDING = -5  -- space between text and bar
local HEALTHBAR_BOTTOM_PAD = 8  -- space between bar and tooltip bottom edge
local HEALTHBAR_TOTAL = HEALTHBAR_HEIGHT + HEALTHBAR_PADDING + HEALTHBAR_BOTTOM_PAD

-- Restyle the existing Blizzard GameTooltipStatusBar instead of creating a new one.
-- This avoids the double health bar bug.
local function StyleHealthBar()
    if TooltipModule.healthBarStyled then return end

    local bar = GameTooltipStatusBar
    if not bar then return end

    -- Restyle: slimmer, better texture
    bar:SetHeight(HEALTHBAR_HEIGHT)
    bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")

    -- Position bar INSIDE the tooltip bottom area (like DragonflightUI)
    bar:ClearAllPoints()
    bar:SetPoint("BOTTOMLEFT", GameTooltip, "BOTTOMLEFT", 9, HEALTHBAR_BOTTOM_PAD)
    bar:SetPoint("BOTTOMRIGHT", GameTooltip, "BOTTOMRIGHT", -9, HEALTHBAR_BOTTOM_PAD)

    -- Add dark background behind the bar
    if not bar.__DragonUI_bg then
        local bg = bar:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
        bg:SetVertexColor(0.15, 0.15, 0.15, 0.8)
        bar.__DragonUI_bg = bg
    end

    TooltipModule.healthBarStyled = true
end

-- Extend tooltip height to make room for the health bar inside the border.
-- Uses a one-frame OnUpdate delay so the resize applies AFTER Blizzard's
-- internal layout pass (which can override an immediate SetHeight).
local function AdjustTooltipForHealthBar(tooltip)
    if not tooltip or not GameTooltipStatusBar then return end
    if not GameTooltipStatusBar:IsShown() then return end
    if tooltip.__DragonUI_adjustPending then return end

    tooltip.__DragonUI_adjustPending = true
    local orig = tooltip:GetScript("OnUpdate")
    tooltip:SetScript("OnUpdate", function(self, elapsed)
        -- Restore original OnUpdate first
        self:SetScript("OnUpdate", orig)
        self.__DragonUI_adjustPending = false
        -- Now extend height — Blizzard's layout is done at this point
        local h = self:GetHeight()
        self:SetHeight(h + HEALTHBAR_TOTAL)
    end)
end

-- ============================================================================
-- TOOLTIP BORDER COLORING
-- ============================================================================

-- Color the tooltip border based on unit reaction/class
local function ColorTooltipBorder(unit)
    if not unit or not UnitExists(unit) then return end

    local config = GetModuleConfig()
    if not config or not config.class_colored_border then return end

    local r, g, b = 1, 1, 1

    if UnitIsPlayer(unit) then
        local _, class = UnitClass(unit)
        if class and CLASS_COLORS[class] then
            r = CLASS_COLORS[class].r
            g = CLASS_COLORS[class].g
            b = CLASS_COLORS[class].b
        end
    else
        local reaction = UnitReaction(unit, "player")
        if not reaction then
            -- Tapped or unknown
            r, g, b = FACTION_COLORS.tapped.r, FACTION_COLORS.tapped.g, FACTION_COLORS.tapped.b
        elseif reaction >= 5 then
            r, g, b = FACTION_COLORS.friendly.r, FACTION_COLORS.friendly.g, FACTION_COLORS.friendly.b
        elseif reaction == 4 then
            r, g, b = FACTION_COLORS.neutral.r, FACTION_COLORS.neutral.g, FACTION_COLORS.neutral.b
        else
            r, g, b = FACTION_COLORS.hostile.r, FACTION_COLORS.hostile.g, FACTION_COLORS.hostile.b
        end
    end

    GameTooltip:SetBackdropBorderColor(r, g, b)
end

-- ============================================================================
-- TOOLTIP NAME COLORING
-- ============================================================================

-- Color the first line (unit name) by class color for players
local function ColorTooltipName(unit)
    if not unit or not UnitExists(unit) then return end

    local config = GetModuleConfig()
    if not config or not config.class_colored_name then return end

    if UnitIsPlayer(unit) then
        local _, class = UnitClass(unit)
        if class and CLASS_COLORS[class] then
            local c = CLASS_COLORS[class]
            local name = UnitName(unit)
            if name then
                GameTooltipTextLeft1:SetTextColor(c.r, c.g, c.b)
            end
        end
    end
end

-- ============================================================================
-- TARGET-OF-TARGET LINE
-- ============================================================================

-- Add "Targeting: <name>" line to tooltip
local function AddTargetOfTarget(unit)
    if not unit or not UnitExists(unit) then return end

    local config = GetModuleConfig()
    if not config or not config.target_of_target then return end

    local targetUnit = unit .. "target"
    if UnitExists(targetUnit) then
        local targetName = UnitName(targetUnit)
        if targetName then
            local color = "|cFFFFFFFF"
            if UnitIsPlayer(targetUnit) then
                local _, class = UnitClass(targetUnit)
                if class and CLASS_COLORS[class] then
                    local c = CLASS_COLORS[class]
                    color = string.format("|cFF%02x%02x%02x", c.r * 255, c.g * 255, c.b * 255)
                end
            end
            GameTooltip:AddLine("Targeting: " .. color .. targetName .. "|r", 0.7, 0.7, 0.7)
        end
    end
end

-- ============================================================================
-- HEALTH BAR UPDATE
-- ============================================================================

-- Store current tooltip unit and its bar color so OnValueChanged can re-apply
local currentTooltipBarColor = nil

local function UpdateHealthBar(unit)
    local bar = GameTooltipStatusBar
    if not bar then return end

    if not unit or not UnitExists(unit) then
        currentTooltipBarColor = nil
        return
    end

    local config = GetModuleConfig()
    if not config or not config.health_bar then
        currentTooltipBarColor = nil
        return
    end

    -- Style the bar on first use
    StyleHealthBar()

    -- Color by class or reaction
    local r, g, b = 0.2, 0.8, 0.2
    if UnitIsPlayer(unit) then
        local _, class = UnitClass(unit)
        if class and CLASS_COLORS[class] then
            r = CLASS_COLORS[class].r
            g = CLASS_COLORS[class].g
            b = CLASS_COLORS[class].b
        end
    end
    bar:SetStatusBarColor(r, g, b)
    -- Cache the color so OnValueChanged can re-apply it
    currentTooltipBarColor = { r, g, b }
end

-- ============================================================================
-- TOOLTIP ANCHOR (optional: anchor to cursor vs default)
-- ============================================================================

-- This is hooked into GameTooltip_SetDefaultAnchor in ApplyTooltipSystem

-- ============================================================================
-- APPLY / RESTORE SYSTEM
-- ============================================================================

local function ApplyTooltipSystem()
    if TooltipModule.applied then return end

    -- Hook GameTooltip_SetDefaultAnchor to optionally anchor to cursor
    if not TooltipModule.hooks["DefaultAnchor"] then
        hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
            if not IsModuleEnabled() then return end
            local config = GetModuleConfig()
            if config and config.anchor_cursor then
                tooltip:SetOwner(parent, "ANCHOR_CURSOR")
            end
        end)
        TooltipModule.hooks["DefaultAnchor"] = true
    end

    -- Hook GameTooltip:SetUnit
    if not TooltipModule.hooks["SetUnit"] then
        GameTooltip:HookScript("OnTooltipSetUnit", function(self)
            if not IsModuleEnabled() then return end
            local _, unit = self:GetUnit()
            if unit then
                ColorTooltipBorder(unit)
                AddTargetOfTarget(unit)
                UpdateHealthBar(unit)
                self:Show() -- Resize after adding lines
                -- Color name AFTER Show() — calling Show() can reset text colors
                ColorTooltipName(unit)
                -- Extend tooltip to fit health bar inside the border
                AdjustTooltipForHealthBar(self)
            end
        end)
        TooltipModule.hooks["SetUnit"] = true
    end

    -- Hook GameTooltipStatusBar OnValueChanged to persist class color through
    -- health updates (Blizzard resets the bar color on each value change)
    if not TooltipModule.hooks["BarValueChanged"] then
        GameTooltipStatusBar:HookScript("OnValueChanged", function(self)
            if not IsModuleEnabled() then return end
            if currentTooltipBarColor then
                local c = currentTooltipBarColor
                self:SetStatusBarColor(c[1], c[2], c[3])
            end
        end)
        TooltipModule.hooks["BarValueChanged"] = true
    end

    -- Hook OnTooltipCleared to reset state
    if not TooltipModule.hooks["OnCleared"] then
        GameTooltip:HookScript("OnTooltipCleared", function(self)
            -- Reset border color
            self:SetBackdropBorderColor(1, 1, 1)
            -- Clear cached bar color so OnValueChanged stops overriding
            currentTooltipBarColor = nil
            -- Reset health bar color to default green
            if GameTooltipStatusBar then
                GameTooltipStatusBar:SetStatusBarColor(0.2, 0.8, 0.2)
            end
        end)
        TooltipModule.hooks["OnCleared"] = true
    end

    TooltipModule.applied = true
    TooltipModule.initialized = true
end

local function RestoreTooltipSystem()
    -- Hooks can't be removed, but they check IsModuleEnabled()
    -- Reset health bar color
    if GameTooltipStatusBar then
        GameTooltipStatusBar:SetStatusBarColor(0.2, 0.8, 0.2)
    end
    TooltipModule.applied = false
end

-- ============================================================================
-- PROFILE CHANGE HANDLER
-- ============================================================================

local function OnProfileChanged()
    if IsModuleEnabled() then
        ApplyTooltipSystem()
    else
        RestoreTooltipSystem()
    end
end

-- ============================================================================
-- INITIALIZATION
-- ============================================================================

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

eventFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "DragonUI" then
        if not IsModuleEnabled() then return end

        -- Register profile callbacks
        addon:After(0.5, function()
            if addon.db and addon.db.RegisterCallback then
                addon.db.RegisterCallback(addon, "OnProfileChanged", OnProfileChanged)
                addon.db.RegisterCallback(addon, "OnProfileCopied", OnProfileChanged)
                addon.db.RegisterCallback(addon, "OnProfileReset", OnProfileChanged)
            end
        end)

    elseif event == "PLAYER_ENTERING_WORLD" then
        if not IsModuleEnabled() then return end
        ApplyTooltipSystem()
    end
end)

-- Export for external use
addon.ApplyTooltipSystem = ApplyTooltipSystem
addon.RestoreTooltipSystem = RestoreTooltipSystem

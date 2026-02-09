--[[
  DragonUI - Focus Frame Module (focus.lua)

  Focus-specific configuration and hooks passed to the
  UF.TargetStyle closure factory defined in target_style.lua.
]]

local addon = select(2, ...)
local UF = addon.UF

-- ============================================================================
-- BLIZZARD FRAME CACHE
-- ============================================================================

local FocusFrame                      = _G.FocusFrame
local FocusFrameHealthBar             = _G.FocusFrameHealthBar
local FocusFrameManaBar               = _G.FocusFrameManaBar
local FocusFramePortrait              = _G.FocusFramePortrait
local FocusFrameTextureFrameName      = _G.FocusFrameTextureFrameName
local FocusFrameTextureFrameLevelText = _G.FocusFrameTextureFrameLevelText
local FocusFrameNameBackground        = _G.FocusFrameNameBackground

-- ============================================================================
-- CREATE VIA FACTORY
-- ============================================================================

local api = UF.TargetStyle.Create({
    -- Identity
    configKey        = "focus",
    unitToken        = "focus",
    widgetKey        = "focus",
    combatQueueKey   = "focus_position",

    -- Blizzard frame references
    blizzFrame       = FocusFrame,
    healthBar        = FocusFrameHealthBar,
    manaBar          = FocusFrameManaBar,
    portrait         = FocusFramePortrait,
    nameText         = FocusFrameTextureFrameName,
    levelText        = FocusFrameTextureFrameLevelText,
    nameBackground   = FocusFrameNameBackground,

    -- Naming & layout
    namePrefix       = "Focus",
    defaultPos       = { anchor = "TOPLEFT", posX = 250, posY = -170 },
    overlaySize      = { 180, 70 },

    -- Events
    unitChangedEvent = "PLAYER_FOCUS_CHANGED",

    -- Feature flags
    nameFrameAlpha   = 0.9,   -- SetAlpha on name background
    nameVertexAlpha  = 0.8,   -- 4th param of SetVertexColor
    nameFontSize     = 10,    -- Fixed font size for name text
    levelFontSize    = 10,    -- Fixed font size for level text

    -- Blizzard elements to hide
    hideListFn = function()
        return {
            _G.FocusFrameTextureFrameTexture,
            _G.FocusFrameBackground,
            _G.FocusFrameFlash,
            _G.FocusFrameNumericalThreat,
            FocusFrame.threatNumericIndicator,
            FocusFrame.threatIndicator,
            -- FoT children (visible as part of FocusFrame even if FoT module is disabled)
            _G.FocusFrameToTBackground,
            _G.FocusFrameToTTextureFrameTexture,
        }
    end,

    -- Extra bar hooks: force white on SetMinMaxValues
    afterBarHooks = function(Module, ManaBar, GetConfig, updateCache)
        hooksecurefunc(ManaBar, "SetMinMaxValues", function(self)
            if not UnitExists("focus") then return end
            local texture = self:GetStatusBarTexture()
            if texture then
                texture:SetVertexColor(1, 1, 1, 1)
            end
        end)
    end,

    -- After-init: FocusFrame_SetSmallSize hook
    afterInit = function(ctx)
        if not ctx.Module.scaleHooked then
            hooksecurefunc("FocusFrame_SetSmallSize", function()
                if InCombatLockdown() then return end
                local config = ctx.GetConfig()
                local correctScale = config.scale or 1
                FocusFrame:SetScale(correctScale)
                -- Force re-initialization to restore our customizations
                if ctx.Module.configured then
                    ctx.Module.configured = false
                    ctx.InitializeFrame()
                end
            end)
            ctx.Module.scaleHooked = true
        end
    end,
})

-- ============================================================================
-- PUBLIC API
-- ============================================================================

addon.FocusFrame = {
    Refresh               = api.Refresh,
    RefreshFocusFrame      = api.Refresh,
    Reset                  = api.Reset,
    anchor                 = api.anchor,
    ChangeFocusFrame       = api.Refresh,
    UpdateFocusClassPortrait = api.UpdateClassPortrait,
}

-- Legacy compatibility
addon.unitframe = addon.unitframe or {}
addon.unitframe.ChangeFocusFrame  = api.Refresh
addon.unitframe.ReApplyFocusFrame = api.Refresh

function addon:RefreshFocusFrame()
    api.Refresh()
end

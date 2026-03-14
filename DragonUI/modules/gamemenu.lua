local addon = select(2,...);
local L = addon.L

-- ============================================================================
-- DragonUI - Game Menu Button Module
-- Injects a "DragonUI" button into the Escape menu that opens the config panel.
-- ============================================================================

local CreateFrame = CreateFrame
local GameMenuFrame = GameMenuFrame
local HideUIPanel = HideUIPanel

local dragonUIButton = nil
local buttonAdded = false
local buttonPositioned = false -- set once to prevent repeated SetPoint calls

-- Fallback priority order for finding an anchor: Continue > Quit > Logout.
-- Only used by FindInsertPosition; not iterated at runtime.
local GAME_MENU_BUTTONS = {
    "GameMenuButtonHelp",
    "GameMenuButtonWhatsNew", 
    "GameMenuButtonStore",
    "GameMenuButtonOptions",
    "GameMenuButtonUIOptions", 
    "GameMenuButtonKeybindings",
    "GameMenuButtonMacros",
    "GameMenuButtonAddons",
    "GameMenuButtonLogout",
    "GameMenuButtonQuit",
    "GameMenuButtonContinue"
}

-- Tries Continue first, then Quit, then Logout as the anchor for our button.
local function FindInsertPosition()
    local afterButton = _G["GameMenuButtonContinue"]
    if not afterButton then afterButton = _G["GameMenuButtonQuit"] end
    if not afterButton then afterButton = _G["GameMenuButtonLogout"] end
    return afterButton, nil
end

-- Anchors the button below its reference and extends GameMenuFrame height once.
-- The guard prevents this running again on subsequent GameMenuFrame:Show() calls,
-- which would accumulate offsets and keep growing the frame height.
local function PositionDragonUIButton()
    if not dragonUIButton then return end
    if buttonPositioned then return end

    local afterButton, beforeButton = FindInsertPosition()

    if not afterButton then
        -- No known anchor found; fall back to a fixed offset from the top.
        dragonUIButton:ClearAllPoints()
        dragonUIButton:SetPoint("TOP", GameMenuFrame, "TOP", 0, -200)
        buttonPositioned = true
        return
    end

    dragonUIButton:ClearAllPoints()
    dragonUIButton:SetPoint("TOP", afterButton, "BOTTOM", 0, -2)

    -- Grow the frame to accommodate the new button (runs exactly once).
    local buttonHeight = dragonUIButton:GetHeight() or 16
    local spacing = 1
    local currentHeight = GameMenuFrame:GetHeight()
    GameMenuFrame:SetHeight(currentHeight + buttonHeight + spacing)

    buttonPositioned = true
end

local function OpenDragonUIConfig()
    HideUIPanel(GameMenuFrame)

    if addon and addon.ToggleOptionsUI then
        addon:ToggleOptionsUI()
        return
    end

    -- ToggleOptionsUI not available yet; fall back to slash command.
    if SlashCmdList and SlashCmdList["DRAGONUI"] then
        SlashCmdList["DRAGONUI"]("config")
        return
    end

    print("|cFFFF0000[DragonUI]|r " .. L["Unable to open configuration"])
end

-- ============================================================================
-- BUTTON CREATION
-- ============================================================================

local function CreateDragonUIButton()
    if dragonUIButton or buttonAdded then return true end
    if not GameMenuFrame then return false end

    -- Swap to nil to disable and fall back to the solid-color path.
    local TEX_CUSTOM_NORMAL = addon._dir .. "gamemenu_btn.tga"
    local TEX_CUSTOM_HOVER  = nil
    local TEX_CUSTOM_PUSHED = nil

    local FONT      = (addon.Fonts and addon.Fonts.PRIMARY) or "Fonts\\FRIZQT__.TTF"
    local FONT_SIZE = 12

    -- GameMenuButtonTemplate sets the correct hit rect and default sizing.
    dragonUIButton = CreateFrame("Button", "DragonUIGameMenuButton", GameMenuFrame, "GameMenuButtonTemplate")
    dragonUIButton:SetWidth(144)

    local useCustom = TEX_CUSTOM_NORMAL ~= nil

    -- Hide the template's built-in textures so our layers are the only visuals.
    local function hideTemplateTexture(tex)
        if tex then tex:SetAlpha(0) end
    end
    hideTemplateTexture(dragonUIButton:GetNormalTexture())
    hideTemplateTexture(dragonUIButton:GetHighlightTexture())
    hideTemplateTexture(dragonUIButton:GetPushedTexture())

    -- Background layer: 1.5px inset on each edge to leave a thin border gap.
    local bgTex = dragonUIButton:CreateTexture(nil, "BACKGROUND")
    bgTex:SetPoint("TOPLEFT",     dragonUIButton, "TOPLEFT",     0,  1.5)
    bgTex:SetPoint("BOTTOMRIGHT", dragonUIButton, "BOTTOMRIGHT", 0, -1.5)

    if useCustom then
        bgTex:SetTexture(TEX_CUSTOM_NORMAL)
        bgTex:SetTexCoord(0, 1, 0, 1)
        bgTex:SetVertexColor(0.40, 0.65, 1.00)
    else
        local WHITE = "Interface\\Buttons\\WHITE8X8"
        bgTex:SetTexture(WHITE)
        bgTex:SetBlendMode("ADD")
        bgTex:SetVertexColor(0.05, 0.22, 0.60, 1.0)
    end
    dragonUIButton._bgTex = bgTex

    -- Hover overlay: additive layer that fades in on mouse-enter.
    local hovTex = dragonUIButton:CreateTexture(nil, "ARTWORK")
    hovTex:SetPoint("TOPLEFT",     dragonUIButton, "TOPLEFT",     0,  1.5)
    hovTex:SetPoint("BOTTOMRIGHT", dragonUIButton, "BOTTOMRIGHT", 0, -1.5)
    if useCustom then
        hovTex:SetTexture(TEX_CUSTOM_NORMAL)
        hovTex:SetTexCoord(0, 1, 0, 1)
        hovTex:SetBlendMode("ADD")
    else
        hovTex:SetTexture("Interface\\Buttons\\WHITE8X8")
        hovTex:SetBlendMode("ADD")
    end
    hovTex:SetVertexColor(0.30, 0.50, 1.00, 0.0)  -- starts transparent
    dragonUIButton._hovTex = hovTex

    -- Label
    local label = dragonUIButton:GetFontString()
    if label then
        label:SetFont(FONT, FONT_SIZE, "OUTLINE")
        label:SetTextColor(1.0, 1.0, 1.0, 1.0)
        label:SetShadowColor(0.0, 0.10, 0.45, 1.0)
        label:SetShadowOffset(1, -1)
        label:ClearAllPoints()
        label:SetPoint("CENTER", dragonUIButton, "CENTER", 0, 1)
        label:SetText(L["DragonUI"])
    end

    -- ============================================================================
    -- HOVER ANIMATION
    -- ============================================================================

    -- RGB tuples for interpolation
    local NRM   = {0.40, 0.65, 1.00}  -- bgTex base color (custom texture)
    local HOV   = {0.70, 0.90, 1.00}  -- bgTex hover color (custom texture)
    local OVR   = {0.05, 0.22, 0.60}  -- bgTex base color (solid fallback)
    local OVR_H = {0.12, 0.40, 0.95}  -- bgTex hover color (solid fallback)
    local TXT   = {1.00, 1.00, 1.00}
    local TXT_H = {1.00, 1.00, 1.00}

    local hoverProgress = 0
    local hoverTarget   = 0
    local ANIM_SPEED    = 5  -- progress units per second (0→1 in ~0.2s)

    dragonUIButton:SetScript("OnUpdate", function(self, elapsed)
        if hoverProgress == hoverTarget then return end
        local step = ANIM_SPEED * elapsed
        if hoverTarget > hoverProgress then
            hoverProgress = math.min(hoverProgress + step, 1)
        else
            hoverProgress = math.max(hoverProgress - step, 0)
        end
        local p = hoverProgress
        -- Tint background
        if useCustom then
            self._bgTex:SetVertexColor(
                NRM[1] + (HOV[1] - NRM[1]) * p,
                NRM[2] + (HOV[2] - NRM[2]) * p,
                NRM[3] + (HOV[3] - NRM[3]) * p)
        else
            self._bgTex:SetVertexColor(
                OVR[1] + (OVR_H[1] - OVR[1]) * p,
                OVR[2] + (OVR_H[2] - OVR[2]) * p,
                OVR[3] + (OVR_H[3] - OVR[3]) * p,
                1.0)
        end
        -- Fade in additive glow overlay
        self._hovTex:SetVertexColor(0.30, 0.50, 1.00, 0.25 * p)
        -- Tint label text
        if label then
            label:SetTextColor(
                TXT[1] + (TXT_H[1] - TXT[1]) * p,
                TXT[2] + (TXT_H[2] - TXT[2]) * p,
                TXT[3] + (TXT_H[3] - TXT[3]) * p,
                1.0)
        end
    end)

    dragonUIButton:SetScript("OnEnter", function(self) hoverTarget = 1 end)
    dragonUIButton:SetScript("OnLeave", function(self) hoverTarget = 0 end)

    dragonUIButton:SetScript("OnClick", function(self, button)
        if button == "LeftButton" then OpenDragonUIConfig() end
    end)

    PositionDragonUIButton()
    buttonAdded = true
    return true
end

-- ============================================================================
-- INITIALIZATION
-- ============================================================================

-- Retries up to maxAttempts times in case GameMenuFrame isn't ready yet.
local function TryCreateButton()
    local attempts = 0
    local maxAttempts = 5

    local function attempt()
        attempts = attempts + 1
        if CreateDragonUIButton() then return end
        if attempts < maxAttempts then
            addon:After(0.5, attempt)
        end
    end

    attempt()
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")

eventFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "DragonUI" then
        TryCreateButton()

    elseif event == "PLAYER_LOGIN" then
        -- Second attempt in case the first ran before GameMenuFrame existed.
        addon:After(1.0, function()
            if not buttonAdded then TryCreateButton() end
        end)
        self:UnregisterEvent("PLAYER_LOGIN")
    end
end)

-- Hook Show instead of overriding it to avoid UI taint on the secure frame.
hooksecurefunc(GameMenuFrame, "Show", function(self)
    if not buttonAdded then
        CreateDragonUIButton()
    elseif dragonUIButton then
        dragonUIButton:Show()
        -- PositionDragonUIButton is intentionally NOT called here;
        -- calling it on every Show would accumulate height additions.
    end
end)


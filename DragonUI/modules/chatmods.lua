local addon = select(2, ...)

-- ============================================================================
-- CHAT MODS MODULE FOR DRAGONUI
-- Ported from KPack ChatMods by bkader
-- Features: hide chat buttons, editbox positioning, mousewheel scroll,
-- tell target (/tt), URL detection & copy, link hover tooltips,
-- chat copy (double-click tab), unlimited resizing, AFK/DND dedup.
-- ============================================================================

local _G = _G
local format, gsub = string.format, string.gsub
local pairs, ipairs, select, tostring = pairs, ipairs, select, tostring
local tinsert, table_concat = table.insert, table.concat
local NUM_CHAT_WINDOWS = NUM_CHAT_WINDOWS or 10

-- Module state tracking
local ChatModsModule = {
    initialized = false,
    applied = false,
    originalStates = {},
    hooks = {},
    frames = {}
}

-- Register with ModuleRegistry
if addon.RegisterModule then
    addon:RegisterModule("chatmods", ChatModsModule, "Chat Mods", "Chat enhancements: hide buttons, editbox position, URL copy, chat copy, link hover, tell target")
end

-- ============================================================================
-- CONFIGURATION FUNCTIONS
-- ============================================================================

local function GetModuleConfig()
    return addon:GetModuleConfig("chatmods")
end

local function IsModuleEnabled()
    return addon:IsModuleEnabled("chatmods")
end

-- ============================================================================
-- BUTTON HIDING & CHAT FRAME TWEAKS
-- ============================================================================

local function NoOp(f)
    if f then f:Hide() end
end

local function ScrollToBottom(self)
    self:GetParent():ScrollToBottom()
end

local function ApplyChatFrameTweaks()
    -- Hide chat buttons
    ChatFrameMenuButton:Hide()
    ChatFrameMenuButton:SetScript("OnShow", NoOp)
    FriendsMicroButton:Hide()
    FriendsMicroButton:SetScript("OnShow", NoOp)

    for i = 1, 10 do
        local cf = _G[format("ChatFrame%d", i)]
        if cf then
            -- Fix tab fading
            local tab = _G["ChatFrame" .. i .. "Tab"]
            if tab then
                tab:SetAlpha(1)
                tab.noMouseAlpha = 0.25
            end
            cf:SetFading(true)

            -- Unlimited resizing
            cf:SetMinResize(0, 0)
            cf:SetMaxResize(0, 0)

            -- Allow chat frame to reach screen edges
            cf:SetClampedToScreen(true)
            cf:SetClampRectInsets(0, 0, 0, 0)

            -- Transparent editbox
            local ebParts = {"Left", "Mid", "Right"}
            for _, part in ipairs(ebParts) do
                local tex = _G["ChatFrame" .. i .. "EditBox" .. part]
                if tex then tex:SetTexture(0, 0, 0, 0) end
                local focus = _G["ChatFrame" .. i .. "EditBoxFocus" .. part]
                if focus then
                    focus:SetTexture(0, 0, 0, 0.8)
                    focus:SetHeight(18)
                end
            end

            -- Remove scroll button frame, keep bottom button
            local bf = _G["ChatFrame" .. i .. "ButtonFrame"]
            if bf then
                bf:Hide()
                bf:SetScript("OnShow", NoOp)
            end

            local bb = _G["ChatFrame" .. i .. "ButtonFrameBottomButton"]
            if bb then
                bb:SetParent(cf)
                bb:SetHeight(18)
                bb:SetWidth(18)
                bb:ClearAllPoints()
                bb:SetPoint("TOPRIGHT", cf, "TOPRIGHT", 0, -6)
                bb:SetAlpha(0.4)
                bb.SetPoint = function() end
                bb:SetScript("OnClick", ScrollToBottom)
            end
        end
    end

    -- Keep toast frame on screen
    if BNToastFrame then
        BNToastFrame:SetClampedToScreen(true)
    end
end

-- ============================================================================
-- EDITBOX POSITIONING
-- ============================================================================

local function ApplyEditBoxPosition()
    local config = GetModuleConfig()
    local pos = config and config.editbox or "top"

    for i = 1, 10 do
        local cf = _G[format("ChatFrame%d", i)]
        local eb = _G["ChatFrame" .. i .. "EditBox"]
        if cf and eb then
            eb:SetAltArrowKeyMode(false)
            eb:ClearAllPoints()
            eb:EnableMouse(false)

            if pos == "middle" then
                eb:SetPoint("BOTTOMLEFT", UIParent, "BOTTOM", -200, 180)
                eb:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOM", 200, 180)
            elseif pos == "top" then
                eb:SetPoint("BOTTOMLEFT", cf, "TOPLEFT", 2, 20)
                eb:SetPoint("BOTTOMRIGHT", cf, "TOPRIGHT", -2, 20)
            else -- bottom
                eb:SetPoint("TOPLEFT", cf, "BOTTOMLEFT")
                eb:SetPoint("TOPRIGHT", cf, "BOTTOMRIGHT")
            end
        end
    end
end

-- ============================================================================
-- TELL TARGET (/tt)
-- ============================================================================

local function TellTarget(msg)
    if not UnitExists("target") then return end
    if not (msg and msg:len() > 0) then return end
    if not UnitIsFriend("player", "target") then return end
    local name, realm = UnitName("target")
    if realm and not UnitIsSameServer("player", "target") then
        name = format("%s-%s", name, realm)
    end
    SendChatMessage(msg, "WHISPER", nil, name)
end

-- ============================================================================
-- MOUSEWHEEL SCROLL ENHANCEMENTS
-- ============================================================================

local function OnMouseScroll(self, dir)
    if dir > 0 then
        if IsShiftKeyDown() then
            self:ScrollToTop()
        elseif IsControlKeyDown() then
            self:ScrollUp()
            self:ScrollUp()
        end
    elseif dir < 0 then
        if IsShiftKeyDown() then
            self:ScrollToBottom()
        elseif IsControlKeyDown() then
            self:ScrollDown()
            self:ScrollDown()
        end
    end
end

-- ============================================================================
-- EDITBOX MOUSE TOGGLE (enable on open, disable on send)
-- ============================================================================

local function OnChatFrameOpenChat()
    for i = 1, 10 do
        local box = _G["ChatFrame" .. i .. "EditBox"]
        if box then box:EnableMouse(true) end
    end
end

local function OnChatEditSendText()
    for i = 1, 10 do
        local box = _G["ChatFrame" .. i .. "EditBox"]
        if box then box:EnableMouse(false) end
    end
end

-- ============================================================================
-- LINK HOVER TOOLTIPS (Alt + hover)
-- ============================================================================

local HOVERABLE_LINK_TYPES = {
    achievement = true, enchant = true, glyph = true, item = true,
    quest = true, spell = true, talent = true, unit = true
}

local function OnHyperlinkEnter(self, data, link)
    local linkType = data:match("^(.-):")
    if HOVERABLE_LINK_TYPES[linkType] and IsAltKeyDown() then
        ShowUIPanel(GameTooltip)
        GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
        GameTooltip:SetHyperlink(link)
        GameTooltip:Show()
    end
end

local function OnHyperlinkLeave(self, data, link)
    local linkType = data:match("^(.-):")
    if HOVERABLE_LINK_TYPES[linkType] then
        HideUIPanel(GameTooltip)
    end
end

local function ApplyLinkHover()
    for i = 1, NUM_CHAT_WINDOWS do
        local frame = _G["ChatFrame" .. i]
        if frame then
            frame:SetScript("OnHyperlinkEnter", OnHyperlinkEnter)
            frame:SetScript("OnHyperlinkLeave", OnHyperlinkLeave)
        end
    end
end

-- ============================================================================
-- AFK / DND MESSAGE DEDUP
-- ============================================================================

local afkDndCache = {}
local function FilterAfkDnd(arg1, arg2)
    if afkDndCache[arg2] and afkDndCache[arg2] == arg1 then
        return true
    end
    afkDndCache[arg2] = arg1
end

-- ============================================================================
-- URL DETECTION AND COPY
-- ============================================================================

local URL_TLDs = {
    "[Cc][Oo][Mm]", "[Uu][Kk]", "[Nn][Ee][Tt]", "[Dd][Ee]", "[Ff][Rr]",
    "[Ee][Ss]", "[Bb][Ee]", "[Cc][Cc]", "[Uu][Ss]", "[Kk][Oo]", "[Cc][Hh]",
    "[Tt][Ww]", "[Cc][Nn]", "[Rr][Uu]", "[Gg][Rr]", "[Gg][Gg]", "[Ii][Tt]",
    "[Ee][Uu]", "[Tt][Vv]", "[Nn][Ll]", "[Hh][Uu]", "[Oo][Rr][Gg]"
}

local function URLFilter(self, event, msg, ...)
    for i = 1, #URL_TLDs do
        local newmsg, found = gsub(msg, "(%S-%." .. URL_TLDs[i] .. "/?%S*)", "|cffffffff|Hurl:%1|h[%1]|h|r")
        if found > 0 then
            return false, newmsg, ...
        end
    end
    -- IP address pattern
    local newmsg, found = gsub(msg, "(%d+%.%d+%.%d+%.%d+:?%d*/?%S*)", "|cffffffff|Hurl:%1|h[%1]|h|r")
    if found > 0 then
        return false, newmsg, ...
    end
end

local function ApplyURLDetection()
    local chatEvents = {
        "CHAT_MSG_CHANNEL", "CHAT_MSG_YELL", "CHAT_MSG_GUILD",
        "CHAT_MSG_OFFICER", "CHAT_MSG_PARTY", "CHAT_MSG_PARTY_LEADER",
        "CHAT_MSG_RAID", "CHAT_MSG_RAID_LEADER", "CHAT_MSG_SAY",
        "CHAT_MSG_WHISPER", "CHAT_MSG_BN_WHISPER", "CHAT_MSG_BN_CONVERSATION",
    }
    for _, event in ipairs(chatEvents) do
        ChatFrame_AddMessageEventFilter(event, URLFilter)
    end

    local currentLink
    local origOnHyperlinkShow = _G.ChatFrame_OnHyperlinkShow

    -- Store original for restore
    if not ChatModsModule.originalStates.ChatFrame_OnHyperlinkShow then
        ChatModsModule.originalStates.ChatFrame_OnHyperlinkShow = origOnHyperlinkShow
    end

    _G.ChatFrame_OnHyperlinkShow = function(self, link, text, button)
        if not StaticPopupDialogs["DRAGONUI_URLCOPY_DIALOG"] then
            StaticPopupDialogs["DRAGONUI_URLCOPY_DIALOG"] = {
                text = "URL",
                button2 = CLOSE or "Close",
                hasEditBox = 1,
                hasWideEditBox = 1,
                showAlert = 1,
                OnShow = function(frame)
                    local editBox = _G[frame:GetName() .. "WideEditBox"]
                    editBox:SetText(currentLink)
                    currentLink = nil
                    editBox:SetFocus()
                    editBox:HighlightText(0)
                    local btn = _G[frame:GetName() .. "Button2"]
                    btn:ClearAllPoints()
                    btn:SetWidth(200)
                    btn:SetPoint("CENTER", editBox, "CENTER", 0, -30)
                    _G[frame:GetName() .. "AlertIcon"]:Hide()
                end,
                EditBoxOnEscapePressed = function(frame)
                    frame:GetParent():Hide()
                end,
                timeout = 0,
                whileDead = 1,
                hideOnEscape = 1
            }
        end

        if link and link:sub(1, 3) == "url" then
            currentLink = link:sub(5)
            StaticPopup_Show("DRAGONUI_URLCOPY_DIALOG")
            return
        end

        SetItemRef(link, text, button, self)
    end
end

-- ============================================================================
-- CHAT COPY (double-click tab)
-- ============================================================================

local copyFrame

local function CreateCopyFrame()
    copyFrame = CreateFrame("Frame", "DragonUI_ChatCopyFrame", UIParent)
    copyFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 3, right = 3, top = 5, bottom = 3 }
    })
    copyFrame:SetBackdropColor(0, 0, 0, 1)
    copyFrame:SetWidth(500)
    copyFrame:SetHeight(400)
    copyFrame:SetPoint("CENTER", UIParent, "CENTER")
    copyFrame:Hide()
    copyFrame:SetFrameStrata("DIALOG")

    local scrollArea = CreateFrame("ScrollFrame", "DragonUI_ChatCopyScroll", copyFrame, "UIPanelScrollFrameTemplate")
    scrollArea:SetPoint("TOPLEFT", copyFrame, "TOPLEFT", 8, -30)
    scrollArea:SetPoint("BOTTOMRIGHT", copyFrame, "BOTTOMRIGHT", -30, 8)

    local editBox = CreateFrame("EditBox", "DragonUI_ChatCopyBox", copyFrame)
    editBox:SetMultiLine(true)
    editBox:SetMaxLetters(99999)
    editBox:EnableMouse(true)
    editBox:SetAutoFocus(false)
    editBox:SetFontObject(ChatFontNormal)
    editBox:SetWidth(400)
    editBox:SetHeight(270)
    editBox:SetScript("OnEscapePressed", function(self)
        self:GetParent():GetParent():Hide()
        self:SetText("")
    end)
    scrollArea:SetScrollChild(editBox)

    local close = CreateFrame("Button", "DragonUI_ChatCopyClose", copyFrame, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", copyFrame, "TOPRIGHT")
    tinsert(UISpecialFrames, "DragonUI_ChatCopyFrame")
end

local function ChatCopyFunc(frame)
    local cf = _G[format("ChatFrame%d", frame:GetID())]
    if not cf then return end
    local _, size = cf:GetFont()
    FCF_SetChatWindowFontSize(cf, cf, 0.01)

    local lines = {}
    local ct = 1
    for i = select("#", cf:GetRegions()), 1, -1 do
        local region = select(i, cf:GetRegions())
        if region:GetObjectType() == "FontString" then
            lines[ct] = tostring(region:GetText())
            ct = ct + 1
        end
    end

    local text = table_concat(lines, "\n", 1, ct - 1)
    FCF_SetChatWindowFontSize(cf, cf, size)
    DragonUI_ChatCopyFrame:Show()
    DragonUI_ChatCopyBox:SetText(text)
    DragonUI_ChatCopyBox:HighlightText(0)
end

local function ChatCopyHint(frame)
    GameTooltip:SetOwner(frame, "ANCHOR_TOP")
    if SHOW_NEWBIE_TIPS == "1" then
        GameTooltip:AddLine(CHAT_OPTIONS_LABEL, 1, 1, 1)
        GameTooltip:AddLine(NEWBIE_TOOLTIP_CHATOPTIONS, nil, nil, nil, 1)
    end
    GameTooltip:AddLine((SHOW_NEWBIE_TIPS == "1" and "\n" or "") .. "Double-Click to Copy")
    GameTooltip:Show()
end

local function ApplyChatCopy()
    if not copyFrame then
        CreateCopyFrame()
    end
    for i = 1, 10 do
        local tab = _G[format("ChatFrame%dTab", i)]
        if tab then
            tab:SetScript("OnDoubleClick", ChatCopyFunc)
            tab:SetScript("OnEnter", ChatCopyHint)
        end
    end
end

-- ============================================================================
-- STICKY CHANNELS
-- ============================================================================

local function ApplyStickyChannels()
    ChatTypeInfo.BN_WHISPER.sticky = 0
    ChatTypeInfo.EMOTE.sticky = 0
    ChatTypeInfo.OFFICER.sticky = 1
    ChatTypeInfo.RAID_WARNING.sticky = 0
    ChatTypeInfo.WHISPER.sticky = 1
    ChatTypeInfo.YELL.sticky = 0

    _G.CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA = 0
    _G.CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA = 0
end

-- ============================================================================
-- APPLY / RESTORE SYSTEM
-- ============================================================================

local function ApplyChatModsSystem()
    if ChatModsModule.applied then return end

    -- Expand available chat font sizes (default WoW only has a few)
    ChatModsModule.originalStates.CHAT_FONT_HEIGHTS = CHAT_FONT_HEIGHTS
    CHAT_FONT_HEIGHTS = {10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}

    ApplyChatFrameTweaks()
    ApplyEditBoxPosition()
    ApplyLinkHover()
    ApplyURLDetection()
    ApplyChatCopy()
    ApplyStickyChannels()

    -- AFK/DND dedup filters
    ChatFrame_AddMessageEventFilter("CHAT_MSG_AFK", FilterAfkDnd)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_DND", FilterAfkDnd)

    -- Tell Target slash command
    SlashCmdList["DRAGONUI_TELLTARGET"] = TellTarget
    SLASH_DRAGONUI_TELLTARGET1 = "/tt"
    SLASH_DRAGONUI_TELLTARGET2 = "/wt"

    -- Mousewheel scroll hook
    hooksecurefunc("FloatingChatFrame_OnMouseScroll", OnMouseScroll)

    -- Editbox mouse toggle hooks
    hooksecurefunc("ChatFrame_OpenChat", OnChatFrameOpenChat)
    hooksecurefunc("ChatEdit_SendText", OnChatEditSendText)

    ChatModsModule.applied = true
end

local function RestoreChatModsSystem()
    if not ChatModsModule.applied then return end

    -- Restore original chat font heights
    if ChatModsModule.originalStates.CHAT_FONT_HEIGHTS then
        CHAT_FONT_HEIGHTS = ChatModsModule.originalStates.CHAT_FONT_HEIGHTS
        ChatModsModule.originalStates.CHAT_FONT_HEIGHTS = nil
    end

    -- Restore URL handler
    if ChatModsModule.originalStates.ChatFrame_OnHyperlinkShow then
        _G.ChatFrame_OnHyperlinkShow = ChatModsModule.originalStates.ChatFrame_OnHyperlinkShow
        ChatModsModule.originalStates.ChatFrame_OnHyperlinkShow = nil
    end

    -- Hide copy frame
    if copyFrame then
        copyFrame:Hide()
    end

    -- Hooks installed via hooksecurefunc can't be removed, but they'll be
    -- guarded by ChatModsModule.applied check if we wrap them.
    -- For a full disable, a /reload is recommended.

    ChatModsModule.applied = false
end

-- ============================================================================
-- PROFILE CHANGE HANDLER
-- ============================================================================

local function OnProfileChanged()
    if IsModuleEnabled() then
        if not ChatModsModule.applied then
            ApplyChatModsSystem()
        end
        ApplyEditBoxPosition()
    else
        RestoreChatModsSystem()
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
        ApplyChatModsSystem()
    end
end)

-- Export for external use
addon.ApplyChatModsSystem = ApplyChatModsSystem
addon.RestoreChatModsSystem = RestoreChatModsSystem

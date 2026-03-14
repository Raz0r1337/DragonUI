--[[
================================================================================
DragonUI Options Panel - Profiles Tab
================================================================================
Profile management using AceDB-3.0 API directly.
Provides: select profile, copy, delete, reset.
================================================================================
]]

local addon = DragonUI
if not addon then return end

local L = addon.L
local LO = addon.LO
local AceGUI = LibStub("AceGUI-3.0")
local C = addon.PanelControls
local Panel = addon.OptionsPanel

-- ============================================================================
-- PROFILES TAB BUILDER
-- ============================================================================

local function BuildProfilesTab(scroll)
    local db = addon.db
    if not db then
        C:AddLabel(scroll, "|cFFFF0000" .. LO["Database not available."] .. "|r")
        return
    end

    C:AddLabel(scroll, "|cffFFD700" .. LO["Profiles"] .. "|r", { color = C.Theme.textGold })
    C:AddDescription(scroll, LO["Save and switch between different configurations per character."])
    C:AddSpacer(scroll)

    -- ====================================================================
    -- CURRENT PROFILE
    -- ====================================================================
    local current = C:AddSection(scroll, LO["Current Profile"])

    local currentProfile = db:GetCurrentProfile()
    C:AddLabel(current, LO["Active: "] .. "|cff1784d1" .. currentProfile .. "|r")

    -- ====================================================================
    -- SELECT / CREATE PROFILE
    -- ====================================================================
    local selectSection = C:AddSection(scroll, LO["Switch or Create Profile"])

    -- Build profile list for dropdown
    local function GetProfileList()
        local profiles = {}
        for _, name in ipairs(db:GetProfiles()) do
            profiles[name] = name
        end
        return profiles
    end

    C:AddDropdown(selectSection, {
        label = LO["Select Profile"],
        getFunc = function() return db:GetCurrentProfile() end,
        setFunc = function(val)
            db:SetProfile(val)
            Panel:SelectTab("profiles")
        end,
        values = GetProfileList(),
    })

    -- New profile input
    local newName = AceGUI:Create("EditBox")
    newName:SetLabel(LO["New Profile Name"])
    newName:SetWidth(250)
    newName:SetCallback("OnEnterPressed", function(widget, event, text)
        if text and text ~= "" then
            db:SetProfile(text)
            widget:SetText("")
            Panel:SelectTab("profiles")
        end
    end)
    selectSection:AddChild(newName)

    -- ====================================================================
    -- COPY FROM
    -- ====================================================================
    local copySection = C:AddSection(scroll, LO["Copy From"])

    C:AddDescription(copySection, LO["Copies all settings from the selected profile into your current one."])

    C:AddDropdown(copySection, {
        label = LO["Copy From"],
        getFunc = function() return nil end,
        setFunc = function(val)
            if val then
                db:CopyProfile(val)
                print("|cFF00FF00[DragonUI]|r " .. LO["Copied profile: "] .. val)
                Panel:SelectTab("profiles")
            end
        end,
        values = GetProfileList(),
    })

    -- ====================================================================
    -- DELETE
    -- ====================================================================
    local deleteSection = C:AddSection(scroll, LO["Delete Profile"])

    C:AddDescription(deleteSection, LO["|cffFF6600Warning:|r Deleting a profile is permanent and cannot be undone."])

    -- Build list excluding current
    local function GetDeletableProfiles()
        local profiles = {}
        local current = db:GetCurrentProfile()
        for _, name in ipairs(db:GetProfiles()) do
            if name ~= current then
                profiles[name] = name
            end
        end
        return profiles
    end

    C:AddDropdown(deleteSection, {
        label = LO["Delete"],
        getFunc = function() return nil end,
        setFunc = function(val)
            if val then
                db:DeleteProfile(val, true)
                print("|cFF00FF00[DragonUI]|r " .. LO["Deleted profile: "] .. val)
                Panel:SelectTab("profiles")
            end
        end,
        values = GetDeletableProfiles(),
    })

    -- ====================================================================
    -- RESET
    -- ====================================================================
    local resetSection = C:AddSection(scroll, LO["Reset Current Profile"])

    C:AddDescription(resetSection, LO["Restores the current profile to its defaults. This cannot be undone."])

    C:AddButton(resetSection, {
        label = LO["Reset Profile"],
        width = 160,
        callback = function()
            -- Show confirmation dialog before resetting
            StaticPopupDialogs["DRAGONUI_RESET_PROFILE"] = StaticPopupDialogs["DRAGONUI_RESET_PROFILE"] or {
                text = LO["All changes will be lost and the UI will be reloaded.\nAre you sure you want to reset your profile?"],
                button1 = LO["Yes"],
                button2 = LO["No"],
                OnAccept = function()
                    if addon.db then
                        addon.db:ResetProfile()
                        print("|cFF00FF00[DragonUI]|r " .. LO["Profile reset to defaults."])
                    end
                    ReloadUI()
                end,
                timeout = 0,
                whileDead = true,
                hideOnEscape = true,
                preferredIndex = 3,
            }
            StaticPopup_Show("DRAGONUI_RESET_PROFILE")
        end,
    })
end

-- Register the tab
Panel:RegisterTab("profiles", LO["Profiles"], BuildProfilesTab, 99)

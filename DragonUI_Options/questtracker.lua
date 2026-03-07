--[[
================================================================================
DragonUI Options - Quest Tracker
================================================================================
Options for quest tracker positioning and behavior.
Based on ElvUI_OptionsUI pattern.
================================================================================
]]

-- Access the main DragonUI addon
local addon = DragonUI
if not addon then return end

local L = addon.L
local LO = addon.LO

-- ============================================================================
-- QUEST TRACKER OPTIONS GROUP
-- ============================================================================

local questtrackerOptions = {
    name = LO["Quest Tracker"],
    type = "group",
    order = 9,
    args = {
        description = {
            type = 'description',
            name = LO["Configures the quest objective tracker position and behavior."],
            order = 1
        },
        show_header = {
            type = 'toggle',
            name = LO["Show Header Background"],
            desc = LO["Show/hide the decorative header background texture"],
            get = function()
                return addon.db.profile.questtracker.show_header ~= false
            end,
            set = function(_, value)
                addon.db.profile.questtracker.show_header = value
                if addon.RefreshQuestTracker then
                    addon.RefreshQuestTracker()
                end
            end,
            order = 1.5
        },
        font_size = {
            type = "range",
            name = LO["Font Size"],
            desc = LO["Font size for quest tracker text"],
            min = 8,
            max = 18,
            step = 1,
            get = function()
                return addon.db.profile.questtracker.font_size or 12
            end,
            set = function(_, value)
                addon.db.profile.questtracker.font_size = value
                if addon.RefreshQuestTracker then
                    addon.RefreshQuestTracker()
                end
            end,
            order = 2
        },
    }
}

-- ============================================================================
-- REGISTER OPTIONS
-- ============================================================================

addon:RegisterOptionsGroup("questtracker", questtrackerOptions)

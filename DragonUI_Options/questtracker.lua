--[[
================================================================================
DragonUI - Quest Tracker Options
================================================================================
Options for quest tracker positioning and behavior.
================================================================================
]]

local addon = select(2, ...)

-- ============================================================================
-- QUEST TRACKER OPTIONS GROUP
-- ============================================================================

local questtrackerOptions = {
    name = "Quest Tracker",
    type = "group",
    order = 9,
    args = {
        description = {
            type = 'description',
            name = "Configures the quest objective tracker position and behavior.",
            order = 1
        },
        show_header = {
            type = 'toggle',
            name = "Show Header Background",
            desc = "Show/hide the decorative header background texture",
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
        x = {
            type = "range",
            name = "X Position",
            desc = "Horizontal position offset",
            min = -500,
            max = 500,
            step = 1,
            get = function()
                return addon.db.profile.questtracker.x
            end,
            set = function(_, value)
                addon.db.profile.questtracker.x = value
                if addon.RefreshQuestTracker then
                    addon.RefreshQuestTracker()
                end
            end,
            order = 2
        },
        y = {
            type = "range",
            name = "Y Position",
            desc = "Vertical position offset",
            min = -500,
            max = 500,
            step = 1,
            get = function()
                return addon.db.profile.questtracker.y
            end,
            set = function(_, value)
                addon.db.profile.questtracker.y = value
                if addon.RefreshQuestTracker then
                    addon.RefreshQuestTracker()
                end
            end,
            order = 3
        },
        anchor = {
            type = 'select',
            name = "Anchor Point",
            desc = "Screen anchor point for the quest tracker",
            values = {
                ["TOPRIGHT"] = "Top Right",
                ["TOPLEFT"] = "Top Left",
                ["BOTTOMRIGHT"] = "Bottom Right",
                ["BOTTOMLEFT"] = "Bottom Left",
                ["CENTER"] = "Center"
            },
            get = function()
                return addon.db.profile.questtracker.anchor
            end,
            set = function(_, value)
                addon.db.profile.questtracker.anchor = value
                if addon.RefreshQuestTracker then
                    addon.RefreshQuestTracker()
                end
            end,
            order = 4
        },
        reset_position = {
            type = 'execute',
            name = "Reset Position",
            desc = "Reset quest tracker to default position",
            func = function()
                addon.db.profile.questtracker.anchor = "TOPRIGHT"
                addon.db.profile.questtracker.x = -140
                addon.db.profile.questtracker.y = -255
                if addon.RefreshQuestTracker then
                    addon.RefreshQuestTracker()
                end
            end,
            order = 5
        }
    }
}

-- ============================================================================
-- REGISTER OPTIONS
-- ============================================================================

addon:RegisterOptionsGroup("questtracker", questtrackerOptions)

print("|cFF00FF00[DragonUI]|r Quest tracker options loaded")

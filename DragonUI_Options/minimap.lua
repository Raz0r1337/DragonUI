--[[
================================================================================
DragonUI - Minimap Options
================================================================================
Options for minimap customization, scale, tracking, and positioning.
================================================================================
]]

local addon = select(2, ...)

-- ============================================================================
-- MINIMAP OPTIONS GROUP
-- ============================================================================

local minimapOptions = {
    name = "Minimap",
    type = "group",
    order = 10,
    args = {
        -- Basic Settings
        scale = {
            type = "range",
            name = "Scale",
            min = 0.5,
            max = 2,
            step = 0.1,
            get = function()
                return addon.db.profile.minimap.scale
            end,
            set = function(_, val)
                addon.db.profile.minimap.scale = val
                if addon.MinimapModule then
                    addon.MinimapModule:UpdateSettings()
                end
            end,
            order = 1
        },
        border_alpha = {
            type = 'range',
            name = "Border Alpha",
            desc = "Top border alpha (0 to hide)",
            min = 0,
            max = 1,
            step = 0.1,
            get = function()
                return addon.db.profile.minimap.border_alpha
            end,
            set = function(info, value)
                addon.db.profile.minimap.border_alpha = value
                if MinimapBorderTop then
                    MinimapBorderTop:SetAlpha(value)
                end
            end,
            order = 2
        },

        addon_button_skin = {
            type = 'toggle',
            name = "Addon Button Skin",
            desc = "Apply DragonUI border styling to addon icons (e.g., bag addons)",
            get = function()
                return addon.db.profile.minimap.addon_button_skin
            end,
            set = function(info, value)
                addon.db.profile.minimap.addon_button_skin = value
                if addon.RefreshMinimap then
                    addon:RefreshMinimap()
                end
            end,
            order = 3
        },

        addon_button_fade = {
            type = 'toggle',
            name = "Addon Button Fade",
            desc = "Addon icons fade out when not hovered (requires Addon Button Skin)",
            disabled = function()
                return not addon.db.profile.minimap.addon_button_skin
            end,
            get = function()
                return addon.db.profile.minimap.addon_button_fade
            end,
            set = function(info, value)
                addon.db.profile.minimap.addon_button_fade = value
                if addon.RefreshMinimap then
                    addon:RefreshMinimap()
                end
            end,
            order = 4
        },

        player_arrow_size = {
            type = 'range',
            name = "Player Arrow Size",
            desc = "Size of the player arrow on the minimap",
            min = 8,
            max = 50,
            step = 1,
            get = function()
                return addon.db.profile.minimap.player_arrow_size
            end,
            set = function(info, value)
                addon.db.profile.minimap.player_arrow_size = value
                if addon.MinimapModule then
                    addon.MinimapModule:UpdateSettings()
                end
            end,
            order = 5
        },

        -- Time & Calendar Section
        time_header = {
            type = 'header',
            name = "Time & Calendar",
            order = 10
        },
        clock = {
            type = 'toggle',
            name = "Show Clock",
            desc = "Show/hide the minimap clock",
            get = function()
                return addon.db.profile.minimap.clock
            end,
            set = function(info, value)
                addon.db.profile.minimap.clock = value
                if addon.MinimapModule then
                    addon.MinimapModule:UpdateSettings()
                end
            end,
            order = 11
        },
        calendar = {
            type = 'toggle',
            name = "Show Calendar",
            desc = "Show/hide the calendar frame",
            get = function()
                return addon.db.profile.minimap.calendar
            end,
            set = function(info, value)
                addon.db.profile.minimap.calendar = value
                if GameTimeFrame then
                    if value then
                        GameTimeFrame:Show()
                    else
                        GameTimeFrame:Hide()
                    end
                end
            end,
            order = 12
        },
        clock_font_size = {
            type = 'range',
            name = "Clock Font Size",
            desc = "Font size for the clock numbers on the minimap",
            min = 8,
            max = 20,
            step = 1,
            get = function()
                return addon.db.profile.minimap.clock_font_size
            end,
            set = function(info, value)
                addon.db.profile.minimap.clock_font_size = value
                if addon.MinimapModule then
                    addon.MinimapModule:UpdateSettings()
                end
            end,
            order = 13
        },

        -- Display Settings Section
        display_header = {
            type = 'header',
            name = "Display Settings",
            order = 20
        },
        tracking_icons = {
            type = "toggle",
            name = "Tracking Icons",
            desc = "Show current tracking icons (old style)",
            get = function()
                return addon.db.profile.minimap.tracking_icons
            end,
            set = function(_, val)
                addon.db.profile.minimap.tracking_icons = val
                if addon.MinimapModule then
                    addon.MinimapModule:UpdateTrackingIcon()
                end
            end,
            order = 21
        },
        zoom_buttons = {
            type = 'toggle',
            name = "Zoom Buttons",
            desc = "Show zoom buttons (+/-)",
            get = function()
                return addon.db.profile.minimap.zoom_buttons
            end,
            set = function(info, value)
                addon.db.profile.minimap.zoom_buttons = value
                if MinimapZoomIn and MinimapZoomOut then
                    if value then
                        MinimapZoomIn:Show()
                        MinimapZoomOut:Show()
                    else
                        MinimapZoomIn:Hide()
                        MinimapZoomOut:Hide()
                    end
                end
            end,
            order = 22
        },
        blip_skin = {
            type = 'toggle',
            name = "New Blip Style",
            desc = "Use new DragonUI object icons on the minimap. When disabled, uses classic Blizzard icons.",
            get = function()
                return addon.db.profile.minimap.blip_skin
            end,
            set = function(info, value)
                addon.db.profile.minimap.blip_skin = value
                if addon.MinimapModule then
                    addon.MinimapModule:UpdateSettings()
                end
            end,
            order = 23
        },
        zonetext_font_size = {
            type = 'range',
            name = "Zone Text Size",
            desc = "Zone text font size on top border",
            min = 8,
            max = 20,
            step = 1,
            get = function()
                return addon.db.profile.minimap.zonetext_font_size
            end,
            set = function(info, value)
                addon.db.profile.minimap.zonetext_font_size = value
                if MinimapZoneText then
                    local font, _, flags = MinimapZoneText:GetFont()
                    MinimapZoneText:SetFont(font, value, flags)
                end
            end,
            order = 24
        },

        -- Position Section
        position_header = {
            type = 'header',
            name = "Position",
            order = 30
        },
        position_reset = {
            type = 'execute',
            name = "Reset Position",
            desc = "Reset minimap to default position (top-right corner)",
            func = function()
                if not addon.db.profile.widgets then
                    addon.db.profile.widgets = {}
                end

                addon.db.profile.widgets.minimap = {
                    anchor = "TOPRIGHT",
                    posX = 0,
                    posY = 0
                }

                if addon.MinimapModule then
                    addon.MinimapModule:UpdateSettings()
                end

                print("|cFF00FF00[DragonUI]|r Minimap position reset to default")
            end,
            order = 31
        }
    }
}

-- ============================================================================
-- REGISTER OPTIONS
-- ============================================================================

addon:RegisterOptionsGroup("minimap", minimapOptions)

print("|cFF00FF00[DragonUI]|r Minimap options loaded")

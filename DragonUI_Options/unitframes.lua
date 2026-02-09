--[[
================================================================================
DragonUI Options - Unit Frames
================================================================================
Options for player, target, focus, pet, party, and ToT unit frames.
Based on ElvUI_OptionsUI pattern.
================================================================================
]]

-- Access the main DragonUI addon
local addon = DragonUI
if not addon then return end

-- ============================================================================
-- UNIT FRAMES OPTIONS GROUP
-- ============================================================================

local unitframeOptions = {
    type = 'group',
    name = "Unit Frames",
    order = 5,
    args = {
        -- ====================================================================
        -- GENERAL
        -- ====================================================================
        general = {
            type = 'group',
            name = "General",
            inline = true,
            order = 1,
            args = {
                scale = {
                    type = 'range',
                    name = "Global Scale",
                    desc = "Global scale for all unit frames",
                    min = 0.5,
                    max = 2.0,
                    step = 0.1,
                    get = function()
                        return addon.db.profile.unitframe.scale
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.scale = value
                        if addon.RefreshUnitFrames then
                            addon.RefreshUnitFrames()
                        end
                    end,
                    order = 1
                }
            }
        },

        -- ====================================================================
        -- PLAYER FRAME
        -- ====================================================================
        player = {
            type = 'group',
            name = "Player Frame",
            order = 2,
            args = {
                scale = {
                    type = 'range',
                    name = "Scale",
                    desc = "Scale of the player frame",
                    min = 0.5,
                    max = 2.0,
                    step = 0.1,
                    get = function()
                        return addon.db.profile.unitframe.player.scale
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.player.scale = value
                        if addon.PlayerFrame and addon.PlayerFrame.RefreshPlayerFrame then
                            addon.PlayerFrame.RefreshPlayerFrame()
                        end
                    end,
                    order = 1
                },
                classcolor = {
                    type = 'toggle',
                    name = "Class Color",
                    desc = "Use class color for health bar",
                    get = function()
                        return addon.db.profile.unitframe.player.classcolor
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.player.classcolor = value
                        if addon.PlayerFrame and addon.PlayerFrame.UpdatePlayerHealthBarColor then
                            addon.PlayerFrame.UpdatePlayerHealthBarColor()
                        end
                    end,
                    order = 2
                },
                classPortrait = {
                    type = 'toggle',
                    name = "Class Portrait",
                    desc = "Show class icon instead of 3D portrait",
                    get = function()
                        return addon.db.profile.unitframe.player.classPortrait
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.player.classPortrait = value
                        if addon.PlayerFrame and addon.PlayerFrame.UpdatePlayerClassPortrait then
                            addon.PlayerFrame.UpdatePlayerClassPortrait()
                        end
                    end,
                    order = 2.5
                },
                breakUpLargeNumbers = {
                    type = 'toggle',
                    name = "Large Numbers",
                    desc = "Format large numbers (1k, 1m)",
                    get = function()
                        return addon.db.profile.unitframe.player.breakUpLargeNumbers
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.player.breakUpLargeNumbers = value
                        if addon.PlayerFrame and addon.PlayerFrame.RefreshPlayerFrame then
                            addon.PlayerFrame.RefreshPlayerFrame()
                        end
                    end,
                    order = 3
                },
                textFormat = {
                    type = 'select',
                    name = "Text Format",
                    desc = "How to display health and mana values",
                    values = {
                        numeric = "Current Value Only",
                        percentage = "Percentage Only",
                        both = "Both (Numbers + Percentage)",
                        formatted = "Current/Max Values"
                    },
                    get = function()
                        return addon.db.profile.unitframe.player.textFormat
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.player.textFormat = value
                        if addon.PlayerFrame and addon.PlayerFrame.RefreshPlayerFrame then
                            addon.PlayerFrame.RefreshPlayerFrame()
                        end
                    end,
                    order = 4
                },
                showHealthTextAlways = {
                    type = 'toggle',
                    name = "Always Show Health Text",
                    desc = "Show health text always (true) or only on hover (false)",
                    get = function()
                        return addon.db.profile.unitframe.player.showHealthTextAlways
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.player.showHealthTextAlways = value
                        if addon.PlayerFrame and addon.PlayerFrame.RefreshPlayerFrame then
                            addon.PlayerFrame.RefreshPlayerFrame()
                        end
                    end,
                    order = 5
                },
                showManaTextAlways = {
                    type = 'toggle',
                    name = "Always Show Mana Text",
                    desc = "Show mana/power text always (true) or only on hover (false)",
                    get = function()
                        return addon.db.profile.unitframe.player.showManaTextAlways
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.player.showManaTextAlways = value
                        if addon.PlayerFrame and addon.PlayerFrame.RefreshPlayerFrame then
                            addon.PlayerFrame.RefreshPlayerFrame()
                        end
                    end,
                    order = 6
                },
                dragon_decoration = {
                    type = 'select',
                    name = "Dragon Decoration",
                    desc = "Add decorative dragon to your player frame for a premium look",
                    values = {
                        none = "None",
                        elite = "Elite Dragon (Golden)",
                        rareelite = "RareElite Dragon (Winged)"
                    },
                    get = function()
                        return addon.db.profile.unitframe.player.dragon_decoration or "none"
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.player.dragon_decoration = value
                        if addon.PlayerFrame and addon.PlayerFrame.RefreshPlayerFrame then
                            addon.PlayerFrame.RefreshPlayerFrame()
                        end
                    end,
                    order = 10
                },
                alwaysShowAlternateManaText = {
                    type = 'toggle',
                    name = "Always Show Alternate Mana Text",
                    desc = "Show mana text always visible (default: hover only)",
                    get = function()
                        return addon.db.profile.unitframe.player.alwaysShowAlternateManaText
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.player.alwaysShowAlternateManaText = value
                        if addon.PlayerFrame and addon.PlayerFrame.RefreshPlayerFrame then
                            addon.PlayerFrame.RefreshPlayerFrame()
                        end
                    end,
                    order = 11
                },
                alternateManaFormat = {
                    type = 'select',
                    name = "Alternate Mana Text Format",
                    desc = "Choose text format for alternate mana display",
                    values = {
                        numeric = "Current Value Only",
                        formatted = "Current / Max",
                        percentage = "Percentage Only",
                        both = "Percentage + Current/Max"
                    },
                    get = function()
                        return addon.db.profile.unitframe.player.alternateManaFormat or "both"
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.player.alternateManaFormat = value
                        if addon.PlayerFrame and addon.PlayerFrame.RefreshPlayerFrame then
                            addon.PlayerFrame.RefreshPlayerFrame()
                        end
                    end,
                    order = 12
                },
                player_header_healthbar = {
                    type = 'header',
                    name = "Health Bar Style",
                    order = 20
                },
                fat_healthbar = {
                    type = 'toggle',
                    name = "Fat Health Bar",
                    desc = "Full-width health bar that fills the entire frame area. Uses modified border texture that removes the inner divider line. |cffFF6600Note:|r Not compatible with Dragon Decoration - will be ignored if a dragon decoration is active.",
                    get = function()
                        return addon.db.profile.unitframe.player.fat_healthbar
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.player.fat_healthbar = value
                        if addon.PlayerFrame and addon.PlayerFrame.RefreshPlayerFrame then
                            addon.PlayerFrame.RefreshPlayerFrame()
                        end
                    end,
                    order = 21
                },
                fat_manabar_hidden = {
                    type = 'toggle',
                    name = "Hide Mana Bar (Fat Mode)",
                    desc = "Completely hide the mana bar when Fat Health Bar is active.",
                    get = function()
                        return addon.db.profile.unitframe.player.fat_manabar_hidden
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.player.fat_manabar_hidden = value
                        if addon.PlayerFrame and addon.PlayerFrame.RefreshPlayerFrame then
                            addon.PlayerFrame.RefreshPlayerFrame()
                        end
                    end,
                    disabled = function()
                        return not addon.db.profile.unitframe.player.fat_healthbar
                    end,
                    order = 22
                },
                fat_manabar_width = {
                    type = 'range',
                    name = "Mana Bar Width (Fat Mode)",
                    desc = "Width of the mana bar when Fat Health Bar is active. Movable via Editor Mode.",
                    min = 50,
                    max = 300,
                    step = 1,
                    get = function()
                        return addon.db.profile.unitframe.player.fat_manabar_width or 200
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.player.fat_manabar_width = value
                        if addon.PlayerFrame and addon.PlayerFrame.RefreshPlayerFrame then
                            addon.PlayerFrame.RefreshPlayerFrame()
                        end
                    end,
                    disabled = function()
                        return not addon.db.profile.unitframe.player.fat_healthbar
                            or addon.db.profile.unitframe.player.fat_manabar_hidden
                    end,
                    order = 23
                },
                fat_manabar_height = {
                    type = 'range',
                    name = "Mana Bar Height (Fat Mode)",
                    desc = "Height of the mana bar when Fat Health Bar is active.",
                    min = 4,
                    max = 30,
                    step = 1,
                    get = function()
                        return addon.db.profile.unitframe.player.fat_manabar_height or 8
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.player.fat_manabar_height = value
                        if addon.PlayerFrame and addon.PlayerFrame.RefreshPlayerFrame then
                            addon.PlayerFrame.RefreshPlayerFrame()
                        end
                    end,
                    disabled = function()
                        return not addon.db.profile.unitframe.player.fat_healthbar
                            or addon.db.profile.unitframe.player.fat_manabar_hidden
                    end,
                    order = 24
                }
            }
        },

        -- ====================================================================
        -- TARGET FRAME
        -- ====================================================================
        target = {
            type = 'group',
            name = "Target Frame",
            order = 3,
            args = {
                scale = {
                    type = 'range',
                    name = "Scale",
                    desc = "Scale of the target frame",
                    min = 0.5,
                    max = 2.0,
                    step = 0.1,
                    get = function()
                        return addon.db.profile.unitframe.target.scale
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.target.scale = value
                        if addon.TargetFrame and addon.TargetFrame.RefreshTargetFrame then
                            addon.TargetFrame.RefreshTargetFrame()
                        end
                    end,
                    order = 1
                },
                classcolor = {
                    type = 'toggle',
                    name = "Class Color",
                    desc = "Use class color for health bar",
                    get = function()
                        return addon.db.profile.unitframe.target.classcolor
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.target.classcolor = value
                        if addon.TargetFrame and addon.TargetFrame.UpdateTargetHealthBarColor then
                            addon.TargetFrame.UpdateTargetHealthBarColor()
                        end
                    end,
                    order = 2
                },
                classPortrait = {
                    type = 'toggle',
                    name = "Class Portrait",
                    desc = "Show class icon instead of 3D portrait (only for players)",
                    get = function()
                        return addon.db.profile.unitframe.target.classPortrait
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.target.classPortrait = value
                        if addon.TargetFrame and addon.TargetFrame.UpdateTargetClassPortrait then
                            addon.TargetFrame.UpdateTargetClassPortrait()
                        end
                    end,
                    order = 2.5
                },
                breakUpLargeNumbers = {
                    type = 'toggle',
                    name = "Large Numbers",
                    desc = "Format large numbers (1k, 1m)",
                    get = function()
                        return addon.db.profile.unitframe.target.breakUpLargeNumbers
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.target.breakUpLargeNumbers = value
                        if addon.TargetFrame and addon.TargetFrame.RefreshTargetFrame then
                            addon.TargetFrame.RefreshTargetFrame()
                        end
                    end,
                    order = 3
                },
                textFormat = {
                    type = 'select',
                    name = "Text Format",
                    desc = "How to display health and mana values",
                    values = {
                        numeric = "Current Value Only",
                        percentage = "Percentage Only",
                        both = "Both (Numbers + Percentage)",
                        formatted = "Current/Max Values"
                    },
                    get = function()
                        return addon.db.profile.unitframe.target.textFormat
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.target.textFormat = value
                        if addon.TargetFrame and addon.TargetFrame.RefreshTargetFrame then
                            addon.TargetFrame.RefreshTargetFrame()
                        end
                    end,
                    order = 4
                },
                showHealthTextAlways = {
                    type = 'toggle',
                    name = "Always Show Health Text",
                    desc = "Show health text always (true) or only on hover (false)",
                    get = function()
                        return addon.db.profile.unitframe.target.showHealthTextAlways
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.target.showHealthTextAlways = value
                        if addon.TargetFrame and addon.TargetFrame.RefreshTargetFrame then
                            addon.TargetFrame.RefreshTargetFrame()
                        end
                    end,
                    order = 5
                },
                showManaTextAlways = {
                    type = 'toggle',
                    name = "Always Show Mana Text",
                    desc = "Show mana/power text always (true) or only on hover (false)",
                    get = function()
                        return addon.db.profile.unitframe.target.showManaTextAlways
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.target.showManaTextAlways = value
                        if addon.TargetFrame and addon.TargetFrame.RefreshTargetFrame then
                            addon.TargetFrame.RefreshTargetFrame()
                        end
                    end,
                    order = 6
                },
                enableThreatGlow = {
                    type = 'toggle',
                    name = "Threat Glow",
                    desc = "Show threat glow effect",
                    get = function()
                        return addon.db.profile.unitframe.target.enableThreatGlow
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.target.enableThreatGlow = value
                        if addon.TargetFrame and addon.TargetFrame.RefreshTargetFrame then
                            addon.TargetFrame.RefreshTargetFrame()
                        end
                    end,
                    order = 7
                }
            }
        },

        -- ====================================================================
        -- TARGET OF TARGET
        -- ====================================================================
        tot = {
            type = 'group',
            name = "Target of Target",
            order = 4,
            args = {
                info = {
                    type = 'description',
                    name = "|cffFFD700Note:|r DragonUI styles the native WoW Target of Target frame.\n\n" ..
                          "|cffFF6347If you don't see it:|r\n" ..
                          "1. Press |cff00FF00ESC|r -> Interface -> Combat\n" ..
                          "2. Check |cff00FF00'Target of Target'|r\n" ..
                          "3. Reload UI",
                    order = 0
                },
                scale = {
                    type = 'range',
                    name = "Scale",
                    desc = "Scale of the target of target frame",
                    min = 0.5,
                    max = 2.0,
                    step = 0.1,
                    get = function()
                        return addon.db.profile.unitframe.tot.scale
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.tot.scale = value
                        if addon.TargetOfTarget and addon.TargetOfTarget.RefreshToTFrame then
                            addon.TargetOfTarget.RefreshToTFrame()
                        end
                    end,
                    order = 1
                },
                classcolor = {
                    type = 'toggle',
                    name = "Class Color",
                    desc = "Use class color for health bar",
                    get = function()
                        return addon.db.profile.unitframe.tot.classcolor
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.tot.classcolor = value
                        if addon.TargetOfTarget and addon.TargetOfTarget.RefreshToTFrame then
                            addon.TargetOfTarget.RefreshToTFrame()
                        end
                    end,
                    order = 2
                },
                x = {
                    type = 'range',
                    name = "X Position",
                    desc = "Horizontal position offset",
                    min = -200,
                    max = 200,
                    step = 1,
                    get = function()
                        return addon.db.profile.unitframe.tot.x
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.tot.x = value
                        if addon.TargetOfTarget and addon.TargetOfTarget.RefreshToTFrame then
                            addon.TargetOfTarget.RefreshToTFrame()
                        end
                    end,
                    order = 3
                },
                y = {
                    type = 'range',
                    name = "Y Position",
                    desc = "Vertical position offset",
                    min = -200,
                    max = 200,
                    step = 1,
                    get = function()
                        return addon.db.profile.unitframe.tot.y
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.tot.y = value
                        if addon.TargetOfTarget and addon.TargetOfTarget.RefreshToTFrame then
                            addon.TargetOfTarget.RefreshToTFrame()
                        end
                    end,
                    order = 4
                }
            }
        },

        -- ====================================================================
        -- TARGET OF FOCUS
        -- ====================================================================
        fot = {
            type = 'group',
            name = "Target of Focus",
            order = 4.5,
            args = {
                scale = {
                    type = 'range',
                    name = "Scale",
                    desc = "Scale of the focus of target frame",
                    min = 0.5,
                    max = 2.0,
                    step = 0.1,
                    get = function()
                        return addon.db.profile.unitframe.fot.scale
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.fot.scale = value
                        if addon.TargetOfFocus and addon.TargetOfFocus.RefreshToFFrame then
                            addon.TargetOfFocus.RefreshToFFrame()
                        end
                    end,
                    order = 1
                },
                classcolor = {
                    type = 'toggle',
                    name = "Class Color",
                    desc = "Use class color for health bar",
                    get = function()
                        return addon.db.profile.unitframe.fot.classcolor
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.fot.classcolor = value
                        if addon.TargetOfFocus and addon.TargetOfFocus.RefreshToFFrame then
                            addon.TargetOfFocus.RefreshToFFrame()
                        end
                    end,
                    order = 2
                },
                x = {
                    type = 'range',
                    name = "X Position",
                    desc = "Horizontal position offset",
                    min = -200,
                    max = 200,
                    step = 1,
                    get = function()
                        return addon.db.profile.unitframe.fot.x
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.fot.x = value
                        if addon.TargetOfFocus and addon.TargetOfFocus.RefreshToFFrame then
                            addon.TargetOfFocus.RefreshToFFrame()
                        end
                    end,
                    order = 3
                },
                y = {
                    type = 'range',
                    name = "Y Position",
                    desc = "Vertical position offset",
                    min = -200,
                    max = 200,
                    step = 1,
                    get = function()
                        return addon.db.profile.unitframe.fot.y
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.fot.y = value
                        if addon.TargetOfFocus and addon.TargetOfFocus.RefreshToFFrame then
                            addon.TargetOfFocus.RefreshToFFrame()
                        end
                    end,
                    order = 4
                }
            }
        },

        -- ====================================================================
        -- FOCUS FRAME
        -- ====================================================================
        focus = {
            type = 'group',
            name = "Focus Frame",
            order = 5,
            args = {
                scale = {
                    type = 'range',
                    name = "Scale",
                    desc = "Scale of the focus frame",
                    min = 0.5,
                    max = 2.0,
                    step = 0.1,
                    get = function()
                        return addon.db.profile.unitframe.focus.scale
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.focus.scale = value
                        if addon.RefreshFocusFrame then
                            addon.RefreshFocusFrame()
                        end
                    end,
                    order = 1
                },
                classcolor = {
                    type = 'toggle',
                    name = "Class Color",
                    desc = "Use class color for health bar",
                    get = function()
                        return addon.db.profile.unitframe.focus.classcolor
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.focus.classcolor = value
                        if addon.RefreshFocusFrame then
                            addon.RefreshFocusFrame()
                        end
                    end,
                    order = 2
                },
                classPortrait = {
                    type = 'toggle',
                    name = "Class Portrait",
                    desc = "Show class icon instead of 3D portrait (only for players)",
                    get = function()
                        return addon.db.profile.unitframe.focus.classPortrait
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.focus.classPortrait = value
                        if addon.FocusFrame and addon.FocusFrame.UpdateFocusClassPortrait then
                            addon.FocusFrame.UpdateFocusClassPortrait()
                        end
                    end,
                    order = 2.5
                },
                breakUpLargeNumbers = {
                    type = 'toggle',
                    name = "Large Numbers",
                    desc = "Format large numbers (1k, 1m)",
                    get = function()
                        return addon.db.profile.unitframe.focus.breakUpLargeNumbers
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.focus.breakUpLargeNumbers = value
                        if addon.RefreshFocusFrame then
                            addon.RefreshFocusFrame()
                        end
                    end,
                    order = 3
                },
                textFormat = {
                    type = 'select',
                    name = "Text Format",
                    desc = "How to display health and mana values",
                    values = {
                        numeric = "Current Value Only",
                        percentage = "Percentage Only",
                        both = "Both (Numbers + Percentage)",
                        formatted = "Current/Max Values"
                    },
                    get = function()
                        return addon.db.profile.unitframe.focus.textFormat
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.focus.textFormat = value
                        if addon.RefreshFocusFrame then
                            addon.RefreshFocusFrame()
                        end
                    end,
                    order = 4
                },
                showHealthTextAlways = {
                    type = 'toggle',
                    name = "Always Show Health Text",
                    desc = "Show health text always (true) or only on hover (false)",
                    get = function()
                        return addon.db.profile.unitframe.focus.showHealthTextAlways
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.focus.showHealthTextAlways = value
                        if addon.RefreshFocusFrame then
                            addon.RefreshFocusFrame()
                        end
                    end,
                    order = 5
                },
                showManaTextAlways = {
                    type = 'toggle',
                    name = "Always Show Mana Text",
                    desc = "Show mana/power text always (true) or only on hover (false)",
                    get = function()
                        return addon.db.profile.unitframe.focus.showManaTextAlways
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.focus.showManaTextAlways = value
                        if addon.RefreshFocusFrame then
                            addon.RefreshFocusFrame()
                        end
                    end,
                    order = 6
                },
                override = {
                    type = 'toggle',
                    name = "Override Position",
                    desc = "Override default positioning",
                    get = function()
                        return addon.db.profile.unitframe.focus.override
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.focus.override = value
                        if addon.RefreshFocusFrame then
                            addon.RefreshFocusFrame()
                        end
                    end,
                    order = 7
                }
            }
        },

        -- ====================================================================
        -- PET FRAME
        -- ====================================================================
        pet = {
            type = 'group',
            name = "Pet Frame",
            order = 6,
            args = {
                scale = {
                    type = 'range',
                    name = "Scale",
                    desc = "Scale of the pet frame",
                    min = 0.5,
                    max = 2.0,
                    step = 0.1,
                    get = function()
                        return addon.db.profile.unitframe.pet.scale
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.pet.scale = value
                        if addon.RefreshPetFrame then
                            addon.RefreshPetFrame()
                        end
                    end,
                    order = 1
                },
                textFormat = {
                    type = 'select',
                    name = "Text Format",
                    desc = "How to display health and mana values",
                    values = {
                        numeric = "Current Value Only",
                        percentage = "Percentage Only",
                        both = "Both (Numbers + Percentage)",
                        formatted = "Current/Max Values"
                    },
                    get = function()
                        return addon.db.profile.unitframe.pet.textFormat
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.pet.textFormat = value
                        if addon.RefreshPetFrame then
                            addon.RefreshPetFrame()
                        end
                    end,
                    order = 2
                },
                breakUpLargeNumbers = {
                    type = 'toggle',
                    name = "Large Numbers",
                    desc = "Format large numbers (1k, 1m)",
                    get = function()
                        return addon.db.profile.unitframe.pet.breakUpLargeNumbers
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.pet.breakUpLargeNumbers = value
                        if addon.RefreshPetFrame then
                            addon.RefreshPetFrame()
                        end
                    end,
                    order = 3
                },
                showHealthTextAlways = {
                    type = 'toggle',
                    name = "Always Show Health Text",
                    desc = "Always display health text (otherwise only on mouseover)",
                    get = function()
                        return addon.db.profile.unitframe.pet.showHealthTextAlways
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.pet.showHealthTextAlways = value
                        if addon.RefreshPetFrame then
                            addon.RefreshPetFrame()
                        end
                    end,
                    order = 4
                },
                showManaTextAlways = {
                    type = 'toggle',
                    name = "Always Show Mana Text",
                    desc = "Always display mana/energy/rage text (otherwise only on mouseover)",
                    get = function()
                        return addon.db.profile.unitframe.pet.showManaTextAlways
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.pet.showManaTextAlways = value
                        if addon.RefreshPetFrame then
                            addon.RefreshPetFrame()
                        end
                    end,
                    order = 5
                },
                enableThreatGlow = {
                    type = 'toggle',
                    name = "Threat Glow",
                    desc = "Show threat glow effect",
                    get = function()
                        return addon.db.profile.unitframe.pet.enableThreatGlow
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.pet.enableThreatGlow = value
                        if addon.RefreshPetFrame then
                            addon.RefreshPetFrame()
                        end
                    end,
                    order = 6
                },
                override = {
                    type = 'toggle',
                    name = "Override Position",
                    desc = "Allows the pet frame to be moved freely. When unchecked, it will be positioned relative to the player frame.",
                    get = function()
                        return addon.db.profile.unitframe.pet.override
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.pet.override = value
                        if addon.RefreshPetFrame then
                            addon.RefreshPetFrame()
                        end
                    end,
                    order = 7
                },
                x = {
                    type = 'range',
                    name = "X Position",
                    desc = "Horizontal position (only active if Override is checked)",
                    min = -2500,
                    max = 2500,
                    step = 1,
                    get = function()
                        return addon.db.profile.unitframe.pet.x
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.pet.x = value
                        if addon.RefreshPetFrame then
                            addon.RefreshPetFrame()
                        end
                    end,
                    order = 10,
                    disabled = function()
                        return not addon.db.profile.unitframe.pet.override
                    end
                },
                y = {
                    type = 'range',
                    name = "Y Position",
                    desc = "Vertical position (only active if Override is checked)",
                    min = -2500,
                    max = 2500,
                    step = 1,
                    get = function()
                        return addon.db.profile.unitframe.pet.y
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.pet.y = value
                        if addon.RefreshPetFrame then
                            addon.RefreshPetFrame()
                        end
                    end,
                    order = 11,
                    disabled = function()
                        return not addon.db.profile.unitframe.pet.override
                    end
                }
            }
        },

        -- ====================================================================
        -- PARTY FRAMES
        -- ====================================================================
        party = {
            type = 'group',
            name = "Party Frames",
            order = 7,
            args = {
                info_text = {
                    type = 'description',
                    name = "|cffFFD700Party Frames Configuration|r\n\nCustom styling for party member frames with automatic health/mana text display and class colors.",
                    order = 0
                },
                scale = {
                    type = 'range',
                    name = "Scale",
                    desc = "Scale of party frames",
                    min = 0.5,
                    max = 2.0,
                    step = 0.1,
                    get = function()
                        return addon.db.profile.unitframe.party.scale
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.party.scale = value
                        if addon.RefreshPartyFrames then
                            addon.RefreshPartyFrames()
                        end
                    end,
                    order = 1
                },
                classcolor = {
                    type = 'toggle',
                    name = "Class Color",
                    desc = "Use class color for health bars in party frames",
                    get = function()
                        return addon.db.profile.unitframe.party.classcolor
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.party.classcolor = value
                        if addon.RefreshPartyFrames then
                            addon.RefreshPartyFrames()
                        end
                    end,
                    order = 2
                },
                breakUpLargeNumbers = {
                    type = 'toggle',
                    name = "Large Numbers",
                    desc = "Format large numbers (1k, 1m)",
                    get = function()
                        return addon.db.profile.unitframe.party.breakUpLargeNumbers
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.party.breakUpLargeNumbers = value
                        if addon.RefreshPartyFrames then
                            addon.RefreshPartyFrames()
                        end
                    end,
                    order = 3
                },
                showHealthTextAlways = {
                    type = 'toggle',
                    name = "Always Show Health Text",
                    desc = "Always show health text on party frames (instead of only on hover)",
                    get = function()
                        return addon.db.profile.unitframe.party.showHealthTextAlways
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.party.showHealthTextAlways = value
                        if addon.RefreshPartyFrames then
                            addon.RefreshPartyFrames()
                        end
                    end,
                    order = 3.1
                },
                showManaTextAlways = {
                    type = 'toggle',
                    name = "Always Show Mana Text",
                    desc = "Always show mana text on party frames (instead of only on hover)",
                    get = function()
                        return addon.db.profile.unitframe.party.showManaTextAlways
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.party.showManaTextAlways = value
                        if addon.RefreshPartyFrames then
                            addon.RefreshPartyFrames()
                        end
                    end,
                    order = 3.2
                },
                textFormat = {
                    type = 'select',
                    name = "Text Format",
                    desc = "Choose how to display health and mana text",
                    values = {
                        ['numeric'] = 'Current Value Only (2345)',
                        ['formatted'] = 'Formatted Current (2.3k)', 
                        ['percentage'] = 'Percentage Only (75%)',
                        ['both'] = 'Percentage + Current (75% | 2.3k)'
                    },
                    get = function()
                        return addon.db.profile.unitframe.party.textFormat or 'both'
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.party.textFormat = value
                        if addon.RefreshPartyFrames then
                            addon.RefreshPartyFrames()
                        end
                    end,
                    order = 3.3
                },
                orientation = {
                    type = 'select',
                    name = "Orientation",
                    desc = "Party frame orientation",
                    values = {
                        ['vertical'] = 'Vertical',
                        ['horizontal'] = 'Horizontal'
                    },
                    get = function()
                        return addon.db.profile.unitframe.party.orientation
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.party.orientation = value
                        if addon.RefreshPartyFrames then
                            addon.RefreshPartyFrames()
                        end
                    end,
                    order = 4
                },
                padding = {
                    type = 'range',
                    name = "Padding",
                    desc = "Space between party frames",
                    min = 0,
                    max = 50,
                    step = 1,
                    get = function()
                        return addon.db.profile.unitframe.party.padding
                    end,
                    set = function(info, value)
                        addon.db.profile.unitframe.party.padding = value
                        if addon.RefreshPartyFrames then
                            addon.RefreshPartyFrames()
                        end
                    end,
                    order = 5
                }
            }
        }
    }
}

-- ============================================================================
-- REGISTER OPTIONS
-- ============================================================================

addon:RegisterOptionsGroup("unitframe", unitframeOptions)

print("|cFF00FF00[DragonUI]|r Unit frames options loaded")

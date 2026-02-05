--[[
================================================================================
DragonUI - Cast Bars Options
================================================================================
Options for player, target, and focus cast bars.
================================================================================
]]

local addon = select(2, ...)

-- ============================================================================
-- CAST BARS OPTIONS GROUP
-- ============================================================================

local castbarsOptions = {
    type = 'group',
    name = "Cast Bars",
    order = 4,
    args = {
        -- ====================================================================
        -- PLAYER CASTBAR
        -- ====================================================================
        player_castbar = {
            type = 'group',
            name = "Player Castbar",
            order = 1,
            args = {
                sizeX = {
                    type = 'range',
                    name = "Width",
                    desc = "Width of the cast bar",
                    min = 80,
                    max = 512,
                    step = 1,
                    get = function()
                        return addon.db.profile.castbar.sizeX
                    end,
                    set = function(info, val)
                        addon.db.profile.castbar.sizeX = val
                        addon.RefreshCastbar()
                    end,
                    order = 1
                },
                sizeY = {
                    type = 'range',
                    name = "Height",
                    desc = "Height of the cast bar",
                    min = 10,
                    max = 64,
                    step = 1,
                    get = function()
                        return addon.db.profile.castbar.sizeY
                    end,
                    set = function(info, val)
                        addon.db.profile.castbar.sizeY = val
                        addon.RefreshCastbar()
                    end,
                    order = 2
                },
                scale = {
                    type = 'range',
                    name = "Scale",
                    desc = "Size scale of the cast bar",
                    min = 0.5,
                    max = 2.0,
                    step = 0.1,
                    get = function()
                        return addon.db.profile.castbar.scale
                    end,
                    set = function(info, val)
                        addon.db.profile.castbar.scale = val
                        addon.RefreshCastbar()
                    end,
                    order = 3
                },
                showIcon = {
                    type = 'toggle',
                    name = "Show Icon",
                    desc = "Show the spell icon next to the cast bar",
                    get = function()
                        return addon.db.profile.castbar.showIcon
                    end,
                    set = function(info, val)
                        addon.db.profile.castbar.showIcon = val
                        addon.RefreshCastbar()
                    end,
                    order = 4
                },
                sizeIcon = {
                    type = 'range',
                    name = "Icon Size",
                    desc = "Size of the spell icon",
                    min = 1,
                    max = 64,
                    step = 1,
                    get = function()
                        return addon.db.profile.castbar.sizeIcon
                    end,
                    set = function(info, val)
                        addon.db.profile.castbar.sizeIcon = val
                        addon.RefreshCastbar()
                    end,
                    order = 5,
                    disabled = function()
                        return not addon.db.profile.castbar.showIcon
                    end
                },
                text_mode = {
                    type = 'select',
                    name = "Text Mode",
                    desc = "Choose how to display spell text: Simple (centered spell name only) or Detailed (spell name + time)",
                    values = {
                        simple = "Simple (Centered Name Only)",
                        detailed = "Detailed (Name + Time)"
                    },
                    get = function()
                        return addon.db.profile.castbar.text_mode or "simple"
                    end,
                    set = function(info, val)
                        addon.db.profile.castbar.text_mode = val
                        addon.RefreshCastbar()
                    end,
                    order = 6
                },
                precision_time = {
                    type = 'range',
                    name = "Time Precision",
                    desc = "Decimal places for remaining time",
                    min = 0,
                    max = 3,
                    step = 1,
                    get = function()
                        return addon.db.profile.castbar.precision_time
                    end,
                    set = function(info, val)
                        addon.db.profile.castbar.precision_time = val
                    end,
                    order = 7,
                    disabled = function()
                        return addon.db.profile.castbar.text_mode == "simple"
                    end
                },
                precision_max = {
                    type = 'range',
                    name = "Max Time Precision",
                    desc = "Decimal places for total time",
                    min = 0,
                    max = 3,
                    step = 1,
                    get = function()
                        return addon.db.profile.castbar.precision_max
                    end,
                    set = function(info, val)
                        addon.db.profile.castbar.precision_max = val
                    end,
                    order = 8,
                    disabled = function()
                        return addon.db.profile.castbar.text_mode == "simple"
                    end
                },
                holdTime = {
                    type = 'range',
                    name = "Hold Time (Success)",
                    desc = "How long the bar stays visible after a successful cast.",
                    min = 0,
                    max = 2,
                    step = 0.1,
                    get = function()
                        return addon.db.profile.castbar.holdTime
                    end,
                    set = function(info, val)
                        addon.db.profile.castbar.holdTime = val
                        addon.RefreshCastbar()
                    end,
                    order = 9
                },
                holdTimeInterrupt = {
                    type = 'range',
                    name = "Hold Time (Interrupt)",
                    desc = "How long the bar stays visible after being interrupted.",
                    min = 0,
                    max = 2,
                    step = 0.1,
                    get = function()
                        return addon.db.profile.castbar.holdTimeInterrupt
                    end,
                    set = function(info, val)
                        addon.db.profile.castbar.holdTimeInterrupt = val
                        addon.RefreshCastbar()
                    end,
                    order = 10
                },
                reset_position = {
                    type = 'execute',
                    name = "Reset Position",
                    desc = "Resets the X and Y position to default.",
                    func = function()
                        addon.db.profile.castbar.x_position = addon.defaults.profile.castbar.x_position
                        addon.db.profile.castbar.y_position = addon.defaults.profile.castbar.y_position
                        addon.RefreshCastbar()
                    end,
                    order = 11
                }
            }
        },

        -- ====================================================================
        -- TARGET CASTBAR
        -- ====================================================================
        target_castbar = {
            type = 'group',
            name = "Target Castbar",
            order = 2,
            args = {
                sizeX = {
                    type = 'range',
                    name = "Width",
                    desc = "Width of the target castbar",
                    min = 50,
                    max = 400,
                    step = 1,
                    get = function()
                        return addon.db.profile.castbar.target and addon.db.profile.castbar.target.sizeX or 150
                    end,
                    set = function(info, val)
                        if not addon.db.profile.castbar.target then
                            addon.db.profile.castbar.target = {}
                        end
                        addon.db.profile.castbar.target.sizeX = val
                        addon.RefreshTargetCastbar()
                    end,
                    order = 1
                },
                sizeY = {
                    type = 'range',
                    name = "Height",
                    desc = "Height of the target castbar",
                    min = 5,
                    max = 50,
                    step = 1,
                    get = function()
                        return addon.db.profile.castbar.target and addon.db.profile.castbar.target.sizeY or 10
                    end,
                    set = function(info, val)
                        if not addon.db.profile.castbar.target then
                            addon.db.profile.castbar.target = {}
                        end
                        addon.db.profile.castbar.target.sizeY = val
                        addon.RefreshTargetCastbar()
                    end,
                    order = 2
                },
                scale = {
                    type = 'range',
                    name = "Scale",
                    desc = "Scale of the target castbar",
                    min = 0.5,
                    max = 2.0,
                    step = 0.1,
                    get = function()
                        return addon.db.profile.castbar.target and addon.db.profile.castbar.target.scale or 1
                    end,
                    set = function(info, val)
                        if not addon.db.profile.castbar.target then
                            addon.db.profile.castbar.target = {}
                        end
                        addon.db.profile.castbar.target.scale = val
                        addon.RefreshTargetCastbar()
                    end,
                    order = 3
                },
                showIcon = {
                    type = 'toggle',
                    name = "Show Spell Icon",
                    desc = "Show the spell icon next to the target castbar",
                    get = function()
                        if not addon.db.profile.castbar.target then
                            return true
                        end
                        local value = addon.db.profile.castbar.target.showIcon
                        if value == nil then
                            return true
                        end
                        return value == true
                    end,
                    set = function(info, val)
                        if not addon.db.profile.castbar.target then
                            addon.db.profile.castbar.target = {}
                        end
                        addon.db.profile.castbar.target.showIcon = val
                        addon.RefreshTargetCastbar()
                    end,
                    order = 4
                },
                sizeIcon = {
                    type = 'range',
                    name = "Icon Size",
                    desc = "Size of the spell icon",
                    min = 10,
                    max = 50,
                    step = 1,
                    get = function()
                        return addon.db.profile.castbar.target and addon.db.profile.castbar.target.sizeIcon or 20
                    end,
                    set = function(info, val)
                        if not addon.db.profile.castbar.target then
                            addon.db.profile.castbar.target = {}
                        end
                        addon.db.profile.castbar.target.sizeIcon = val
                        addon.RefreshTargetCastbar()
                    end,
                    order = 5,
                    disabled = function()
                        return not (addon.db.profile.castbar.target and addon.db.profile.castbar.target.showIcon)
                    end
                },
                text_mode = {
                    type = 'select',
                    name = "Text Mode",
                    desc = "Choose how to display spell text: Simple (centered spell name only) or Detailed (spell name + time)",
                    values = {
                        simple = "Simple (Centered Name Only)",
                        detailed = "Detailed (Name + Time)"
                    },
                    get = function()
                        return (addon.db.profile.castbar.target and addon.db.profile.castbar.target.text_mode) or "simple"
                    end,
                    set = function(info, val)
                        if not addon.db.profile.castbar.target then
                            addon.db.profile.castbar.target = {}
                        end
                        addon.db.profile.castbar.target.text_mode = val
                        addon.RefreshTargetCastbar()
                    end,
                    order = 6
                },
                precision_time = {
                    type = 'range',
                    name = "Time Precision",
                    desc = "Decimal places for remaining time",
                    min = 0,
                    max = 3,
                    step = 1,
                    get = function()
                        return (addon.db.profile.castbar.target and addon.db.profile.castbar.target.precision_time) or 1
                    end,
                    set = function(info, val)
                        if not addon.db.profile.castbar.target then
                            addon.db.profile.castbar.target = {}
                        end
                        addon.db.profile.castbar.target.precision_time = val
                    end,
                    order = 7,
                    disabled = function()
                        return (addon.db.profile.castbar.target and addon.db.profile.castbar.target.text_mode) == "simple"
                    end
                },
                precision_max = {
                    type = 'range',
                    name = "Max Time Precision",
                    desc = "Decimal places for total time",
                    min = 0,
                    max = 3,
                    step = 1,
                    get = function()
                        return (addon.db.profile.castbar.target and addon.db.profile.castbar.target.precision_max) or 1
                    end,
                    set = function(info, val)
                        if not addon.db.profile.castbar.target then
                            addon.db.profile.castbar.target = {}
                        end
                        addon.db.profile.castbar.target.precision_max = val
                    end,
                    order = 8,
                    disabled = function()
                        return (addon.db.profile.castbar.target and addon.db.profile.castbar.target.text_mode) == "simple"
                    end
                },
                autoAdjust = {
                    type = 'toggle',
                    name = "Auto Adjust for Auras",
                    desc = "Automatically adjust position based on target auras (CRITICAL FEATURE)",
                    get = function()
                        if not addon.db.profile.castbar.target then
                            return true
                        end
                        local value = addon.db.profile.castbar.target.autoAdjust
                        if value == nil then
                            return true
                        end
                        return value == true
                    end,
                    set = function(info, val)
                        if not addon.db.profile.castbar.target then
                            addon.db.profile.castbar.target = {}
                        end
                        addon.db.profile.castbar.target.autoAdjust = val
                        addon.RefreshTargetCastbar()
                    end,
                    order = 9
                },
                holdTime = {
                    type = 'range',
                    name = "Hold Time (Success)",
                    desc = "How long to show the castbar after successful completion",
                    min = 0,
                    max = 3,
                    step = 0.1,
                    get = function()
                        return addon.db.profile.castbar.target and addon.db.profile.castbar.target.holdTime or 0.3
                    end,
                    set = function(info, val)
                        if not addon.db.profile.castbar.target then
                            addon.db.profile.castbar.target = {}
                        end
                        addon.db.profile.castbar.target.holdTime = val
                        addon.RefreshTargetCastbar()
                    end,
                    order = 10
                },
                holdTimeInterrupt = {
                    type = 'range',
                    name = "Hold Time (Interrupt)",
                    desc = "How long to show the castbar after interruption/failure",
                    min = 0,
                    max = 3,
                    step = 0.1,
                    get = function()
                        return addon.db.profile.castbar.target and addon.db.profile.castbar.target.holdTimeInterrupt or 0.8
                    end,
                    set = function(info, val)
                        if not addon.db.profile.castbar.target then
                            addon.db.profile.castbar.target = {}
                        end
                        addon.db.profile.castbar.target.holdTimeInterrupt = val
                        addon.RefreshTargetCastbar()
                    end,
                    order = 11
                },
                reset_position = {
                    type = 'execute',
                    name = "Reset Position",
                    desc = "Reset target castbar position to default",
                    func = function()
                        if not addon.db.profile.castbar.target then
                            addon.db.profile.castbar.target = {}
                        end
                        addon.db.profile.castbar.target.x_position = -20
                        addon.db.profile.castbar.target.y_position = -20
                        addon.RefreshTargetCastbar()
                    end,
                    order = 12
                }
            }
        },

        -- ====================================================================
        -- FOCUS CASTBAR
        -- ====================================================================
        focus_castbar = {
            type = 'group',
            name = "Focus Castbar",
            order = 3,
            args = {
                sizeX = {
                    type = 'range',
                    name = "Width",
                    desc = "Width of the focus castbar",
                    min = 50,
                    max = 400,
                    step = 1,
                    get = function()
                        return addon.db.profile.castbar.focus.sizeX or 200
                    end,
                    set = function(info, value)
                        addon.db.profile.castbar.focus.sizeX = value
                        if addon.RefreshFocusCastbar then
                            addon.RefreshFocusCastbar()
                        end
                    end,
                    order = 1
                },
                sizeY = {
                    type = 'range',
                    name = "Height",
                    desc = "Height of the focus castbar",
                    min = 5,
                    max = 50,
                    step = 1,
                    get = function()
                        return addon.db.profile.castbar.focus.sizeY or 16
                    end,
                    set = function(info, value)
                        addon.db.profile.castbar.focus.sizeY = value
                        if addon.RefreshFocusCastbar then
                            addon.RefreshFocusCastbar()
                        end
                    end,
                    order = 2
                },
                scale = {
                    type = 'range',
                    name = "Scale",
                    desc = "Scale of the focus castbar",
                    min = 0.5,
                    max = 2.0,
                    step = 0.1,
                    get = function()
                        return addon.db.profile.castbar.focus.scale or 1
                    end,
                    set = function(info, value)
                        addon.db.profile.castbar.focus.scale = value
                        if addon.RefreshFocusCastbar then
                            addon.RefreshFocusCastbar()
                        end
                    end,
                    order = 3
                },
                showIcon = {
                    type = 'toggle',
                    name = "Show Icon",
                    desc = "Show the spell icon next to the focus castbar",
                    get = function()
                        return addon.db.profile.castbar.focus.showIcon
                    end,
                    set = function(info, value)
                        addon.db.profile.castbar.focus.showIcon = value
                        if addon.RefreshFocusCastbar then
                            addon.RefreshFocusCastbar()
                        end
                    end,
                    order = 4
                },
                sizeIcon = {
                    type = 'range',
                    name = "Icon Size",
                    desc = "Size of the spell icon",
                    min = 10,
                    max = 50,
                    step = 1,
                    get = function()
                        return addon.db.profile.castbar.focus.sizeIcon or 20
                    end,
                    set = function(info, value)
                        addon.db.profile.castbar.focus.sizeIcon = value
                        if addon.RefreshFocusCastbar then
                            addon.RefreshFocusCastbar()
                        end
                    end,
                    order = 5,
                    disabled = function()
                        return not addon.db.profile.castbar.focus.showIcon
                    end
                },
                text_mode = {
                    type = 'select',
                    name = "Text Mode",
                    desc = "Choose how to display spell text: Simple (centered spell name only) or Detailed (spell name + time)",
                    values = {
                        simple = "Simple",
                        detailed = "Detailed"
                    },
                    get = function()
                        return addon.db.profile.castbar.focus.text_mode or "detailed"
                    end,
                    set = function(info, value)
                        addon.db.profile.castbar.focus.text_mode = value
                        if addon.RefreshFocusCastbar then
                            addon.RefreshFocusCastbar()
                        end
                    end,
                    order = 6
                },
                precision_time = {
                    type = 'range',
                    name = "Time Precision",
                    desc = "Decimal places for remaining time",
                    min = 0,
                    max = 3,
                    step = 1,
                    get = function()
                        return addon.db.profile.castbar.focus.precision_time or 1
                    end,
                    set = function(info, val)
                        addon.db.profile.castbar.focus.precision_time = val
                    end,
                    order = 7,
                    disabled = function()
                        return addon.db.profile.castbar.focus.text_mode == "simple"
                    end
                },
                precision_max = {
                    type = 'range',
                    name = "Max Time Precision",
                    desc = "Decimal places for total time",
                    min = 0,
                    max = 3,
                    step = 1,
                    get = function()
                        return addon.db.profile.castbar.focus.precision_max or 1
                    end,
                    set = function(info, val)
                        addon.db.profile.castbar.focus.precision_max = val
                    end,
                    order = 8,
                    disabled = function()
                        return addon.db.profile.castbar.focus.text_mode == "simple"
                    end
                },
                autoAdjust = {
                    type = 'toggle',
                    name = "Auto Adjust for Auras",
                    desc = "Automatically adjust position based on focus auras",
                    get = function()
                        return addon.db.profile.castbar.focus.autoAdjust
                    end,
                    set = function(info, value)
                        addon.db.profile.castbar.focus.autoAdjust = value
                        if addon.RefreshFocusCastbar then
                            addon.RefreshFocusCastbar()
                        end
                    end,
                    order = 9
                },
                holdTime = {
                    type = 'range',
                    name = "Hold Time (Success)",
                    desc = "Time to show the castbar after successful cast completion",
                    min = 0,
                    max = 3.0,
                    step = 0.1,
                    get = function()
                        return addon.db.profile.castbar.focus.holdTime or 0.3
                    end,
                    set = function(info, value)
                        addon.db.profile.castbar.focus.holdTime = value
                        if addon.RefreshFocusCastbar then
                            addon.RefreshFocusCastbar()
                        end
                    end,
                    order = 10
                },
                holdTimeInterrupt = {
                    type = 'range',
                    name = "Hold Time (Interrupt)",
                    desc = "Time to show the castbar after cast interruption",
                    min = 0,
                    max = 3.0,
                    step = 0.1,
                    get = function()
                        return addon.db.profile.castbar.focus.holdTimeInterrupt or 0.8
                    end,
                    set = function(info, value)
                        addon.db.profile.castbar.focus.holdTimeInterrupt = value
                        if addon.RefreshFocusCastbar then
                            addon.RefreshFocusCastbar()
                        end
                    end,
                    order = 11
                },
                reset_position = {
                    type = 'execute',
                    name = "Reset Position",
                    desc = "Reset focus castbar position to default",
                    func = function()
                        local defaults = addon.defaults.profile.castbar.focus
                        addon.db.profile.castbar.focus.x_position = defaults.x_position
                        addon.db.profile.castbar.focus.y_position = defaults.y_position
                        addon.RefreshFocusCastbar()
                    end,
                    order = 12
                }
            }
        }
    }
}

-- ============================================================================
-- REGISTER OPTIONS
-- ============================================================================

addon:RegisterOptionsGroup("castbars", castbarsOptions)

print("|cFF00FF00[DragonUI]|r Cast bars options loaded")

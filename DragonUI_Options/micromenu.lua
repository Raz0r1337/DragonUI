--[[
================================================================================
DragonUI - Micro Menu Options
================================================================================
Options for micro menu, bags, and related UI elements.
================================================================================
]]

local addon = select(2, ...)

-- ============================================================================
-- MICRO MENU OPTIONS GROUP
-- ============================================================================

local micromenuOptions = {
    type = 'group',
    name = "Micro Menu",
    order = 2,
    args = {
        grayscale_icons = {
            type = 'toggle',
            name = "Gray Scale Icons",
            desc = "Use grayscale icons instead of colored icons for the micro menu",
            get = function()
                return addon.db.profile.micromenu.grayscale_icons
            end,
            set = function(info, value)
                addon.db.profile.micromenu.grayscale_icons = value
                StaticPopup_Show("DRAGONUI_RELOAD_UI")
            end,
            order = 1
        },
        separator1 = {
            type = 'description',
            name = "",
            order = 2
        },
        current_mode_header = {
            type = 'header',
            name = function()
                return addon.db.profile.micromenu.grayscale_icons and "Grayscale Icons Settings" or "Normal Icons Settings"
            end,
            order = 3
        },
        scale_menu = {
            type = 'range',
            name = "Menu Scale",
            desc = function()
                local mode = addon.db.profile.micromenu.grayscale_icons and "grayscale" or "normal"
                return "Scale for micromenu (" .. mode .. " icons)"
            end,
            min = 0.5,
            max = 3.0,
            step = 0.1,
            get = function()
                local mode = addon.db.profile.micromenu.grayscale_icons and "grayscale" or "normal"
                return addon.db.profile.micromenu[mode].scale_menu
            end,
            set = function(info, value)
                local mode = addon.db.profile.micromenu.grayscale_icons and "grayscale" or "normal"
                addon.db.profile.micromenu[mode].scale_menu = value
                if addon.RefreshMicromenu then
                    addon.RefreshMicromenu()
                end
            end,
            order = 4
        },
        icon_spacing = {
            type = 'range',
            name = "Icon Spacing",
            desc = function()
                local mode = addon.db.profile.micromenu.grayscale_icons and "grayscale" or "normal"
                return "Gap between " .. mode .. " icons (pixels)"
            end,
            min = 5,
            max = 40,
            step = 1,
            get = function()
                local mode = addon.db.profile.micromenu.grayscale_icons and "grayscale" or "normal"
                return addon.db.profile.micromenu[mode].icon_spacing
            end,
            set = function(info, value)
                local mode = addon.db.profile.micromenu.grayscale_icons and "grayscale" or "normal"
                addon.db.profile.micromenu[mode].icon_spacing = value
                if addon.RefreshMicromenu then
                    addon.RefreshMicromenu()
                end
            end,
            order = 7
        },
        separator2 = {
            type = 'description',
            name = "",
            order = 8
        },
        hide_on_vehicle = {
            type = 'toggle',
            name = "Hide on Vehicle",
            desc = "Hide micromenu and bags if you sit on vehicle",
            get = function()
                return addon.db.profile.micromenu.hide_on_vehicle
            end,
            set = function(info, value)
                addon.db.profile.micromenu.hide_on_vehicle = value
                if addon.RefreshMicromenuVehicle then
                    addon.RefreshMicromenuVehicle()
                end
                if addon.RefreshBagsVehicle then
                    addon.RefreshBagsVehicle()
                end
            end,
            order = 9
        }
    }
}

-- ============================================================================
-- BAGS OPTIONS GROUP
-- ============================================================================

local bagsOptions = {
    type = 'group',
    name = "Bags",
    order = 3,
    args = {
        description = {
            type = 'description',
            name = "Configure the position and scale of the bag bar independently from the micro menu.",
            order = 1
        },
        scale = {
            type = 'range',
            name = "Scale",
            desc = "Scale for the bag bar",
            min = 0.5,
            max = 2.0,
            step = 0.1,
            get = function()
                return addon.db.profile.bags.scale
            end,
            set = function(info, value)
                addon.db.profile.bags.scale = value
                if addon.RefreshBagsPosition then
                    addon.RefreshBagsPosition()
                end
            end,
            order = 2
        }
    }
}

-- ============================================================================
-- XP & REP BARS OPTIONS GROUP
-- ============================================================================

local xprepbarOptions = {
    type = 'group',
    name = "XP & Rep Bars",
    order = 6,
    args = {
        bothbar_offset = {
            type = 'range',
            name = "Both Bars Offset",
            desc = "Y offset when XP & reputation bar are shown",
            min = 0,
            max = 100,
            step = 1,
            get = function()
                return addon.db.profile.xprepbar.bothbar_offset
            end,
            set = function(info, value)
                addon.db.profile.xprepbar.bothbar_offset = value
                if addon.RefreshXpRepBarPosition then
                    addon.RefreshXpRepBarPosition()
                end
            end,
            order = 1
        },
        singlebar_offset = {
            type = 'range',
            name = "Single Bar Offset",
            desc = "Y offset when XP or reputation bar is shown",
            min = 0,
            max = 100,
            step = 1,
            get = function()
                return addon.db.profile.xprepbar.singlebar_offset
            end,
            set = function(info, value)
                addon.db.profile.xprepbar.singlebar_offset = value
                if addon.RefreshXpRepBarPosition then
                    addon.RefreshXpRepBarPosition()
                end
            end,
            order = 2
        },
        nobar_offset = {
            type = 'range',
            name = "No Bar Offset",
            desc = "Y offset when no XP or reputation bar is shown",
            min = 0,
            max = 100,
            step = 1,
            get = function()
                return addon.db.profile.xprepbar.nobar_offset
            end,
            set = function(info, value)
                addon.db.profile.xprepbar.nobar_offset = value
                if addon.RefreshXpRepBarPosition then
                    addon.RefreshXpRepBarPosition()
                end
            end,
            order = 3
        },
        repbar_abovexp_offset = {
            type = 'range',
            name = "Rep Bar Above XP Offset",
            desc = "Y offset for reputation bar when XP bar is shown",
            min = 0,
            max = 50,
            step = 1,
            get = function()
                return addon.db.profile.xprepbar.repbar_abovexp_offset
            end,
            set = function(info, value)
                addon.db.profile.xprepbar.repbar_abovexp_offset = value
                if addon.RefreshRepBarPosition then
                    addon.RefreshRepBarPosition()
                end
            end,
            order = 4
        },
        repbar_offset = {
            type = 'range',
            name = "Rep Bar Offset",
            desc = "Y offset when XP bar is not shown",
            min = 0,
            max = 50,
            step = 1,
            get = function()
                return addon.db.profile.xprepbar.repbar_offset
            end,
            set = function(info, value)
                addon.db.profile.xprepbar.repbar_offset = value
                if addon.RefreshRepBarPosition then
                    addon.RefreshRepBarPosition()
                end
            end,
            order = 5
        },
        exhaustion_tick = {
            type = 'toggle',
            name = "Show Exhaustion Tick",
            desc = "Show the exhaustion tick indicator on the experience bar (blue marker for rested XP). RetailUI hides this completely.",
            get = function()
                return addon.db.profile.style.exhaustion_tick
            end,
            set = function(info, val)
                addon.db.profile.style.exhaustion_tick = val
                if addon.UpdateExhaustionTick then
                    addon.UpdateExhaustionTick()
                end
            end,
            order = 6
        },
        expbar_scale = {
            type = 'range',
            name = "Experience Bar Scale",
            desc = "Scale size of the experience bar",
            min = 0.5,
            max = 1.5,
            step = 0.05,
            get = function()
                return addon.db.profile.xprepbar.expbar_scale
            end,
            set = function(info, value)
                addon.db.profile.xprepbar.expbar_scale = value
                if addon.RefreshXpBarPosition then
                    addon.RefreshXpBarPosition()
                end
            end,
            order = 7
        },
        repbar_scale = {
            type = 'range',
            name = "Reputation Bar Scale",
            desc = "Scale size of the reputation bar",
            min = 0.5,
            max = 1.5,
            step = 0.05,
            get = function()
                return addon.db.profile.xprepbar.repbar_scale
            end,
            set = function(info, value)
                addon.db.profile.xprepbar.repbar_scale = value
                if addon.RefreshRepBarPosition then
                    addon.RefreshRepBarPosition()
                end
            end,
            order = 8
        }
    }
}

-- ============================================================================
-- GRYPHONS/STYLE OPTIONS GROUP
-- ============================================================================

local styleOptions = {
    type = 'group',
    name = "Gryphons",
    order = 7,
    args = {
        gryphons = {
            type = 'select',
            name = "Gryphon Style",
            desc = "Display style for the action bar end-cap gryphons.",
            values = function()
                local order = {'old', 'new', 'flying', 'none'}
                local labels = {
                    old = "Old",
                    new = "New",
                    flying = "Flying",
                    none = "Hide Gryphons"
                }
                local t = {}
                for _, k in ipairs(order) do
                    t[k] = labels[k]
                end
                return t
            end,
            get = function()
                return addon.db.profile.style.gryphons
            end,
            set = function(info, val)
                addon.db.profile.style.gryphons = val
                if addon.RefreshMainbars then
                    addon.RefreshMainbars()
                end
            end,
            order = 1
        },
        spacer = {
            type = 'description',
            name = " ",
            order = 1.5
        },
        gryphon_previews = {
            type = 'description',
            name = "|cffFFD700Old|r:      |TInterface\\AddOns\\DragonUI\\assets\\uiactionbar2x_:96:96:0:0:512:2048:1:357:209:543|t |TInterface\\AddOns\\DragonUI\\media\\uiactionbar2x_:96:96:0:0:512:2048:1:357:545:879|t\n" ..
                "|cffFFD700New|r:      |TInterface\\AddOns\\DragonUI\\assets\\uiactionbar2x_new:96:96:0:0:512:2048:1:357:209:543|t |TInterface\\AddOns\\DragonUI\\media\\uiactionbar2x_new:96:96:0:0:512:2048:1:357:545:879|t\n" ..
                "|cffFFD700Flying|r: |TInterface\\AddOns\\DragonUI\\assets\\uiactionbar2x_flying:105:105:0:0:256:2048:1:158:149:342|t |TInterface\\AddOns\\DragonUI\\media\\uiactionbar2x_flying:105:105:0:0:256:2048:1:157:539:732|t",
            order = 2
        }
    }
}

-- ============================================================================
-- ADDITIONAL BARS OPTIONS GROUP
-- ============================================================================

local additionalOptions = {
    type = 'group',
    name = "Additional Bars",
    desc = "Specialized bars that appear when needed (stance/pet/vehicle/totems)",
    order = 8,
    args = {
        info_header = {
            type = 'description',
            name = "|cffFFD700Additional Bars Configuration|r\n" ..
                "|cff00FF00Auto-show bars:|r Stance (Warriors/Druids/DKs) • Pet (Hunters/Warlocks/DKs) • Vehicle (All classes) • Totem (Shamans)",
            order = 0
        },

        -- Common Settings
        common_group = {
            type = 'group',
            name = "Common Settings",
            inline = true,
            order = 1,
            args = {
                size = {
                    type = 'range',
                    name = "Button Size",
                    desc = "Size of buttons for all additional bars",
                    min = 15,
                    max = 50,
                    step = 1,
                    get = function()
                        return addon.db.profile.additional.size
                    end,
                    set = function(info, value)
                        addon.db.profile.additional.size = value
                        if addon.RefreshStance then addon.RefreshStance() end
                        if addon.RefreshPetbar then addon.RefreshPetbar() end
                        if addon.RefreshVehicle then addon.RefreshVehicle() end
                        if addon.RefreshMulticast then addon.RefreshMulticast() end
                    end,
                    order = 1,
                    width = "half"
                },
                spacing = {
                    type = 'range',
                    name = "Button Spacing",
                    desc = "Space between buttons for all additional bars",
                    min = 0,
                    max = 20,
                    step = 1,
                    get = function()
                        return addon.db.profile.additional.spacing
                    end,
                    set = function(info, value)
                        addon.db.profile.additional.spacing = value
                        if addon.RefreshStance then addon.RefreshStance() end
                        if addon.RefreshPetbar then addon.RefreshPetbar() end
                        if addon.RefreshVehicle then addon.RefreshVehicle() end
                        if addon.RefreshMulticast then addon.RefreshMulticast() end
                    end,
                    order = 2,
                    width = "half"
                }
            }
        },

        -- Individual Bars
        individual_bars_group = {
            type = 'group',
            name = "Individual Bar Positions & Settings",
            desc = "|cffFFD700Now using Smart Anchoring:|r Bars automatically position relative to each other",
            inline = true,
            order = 2,
            args = {
                -- Stance Bar
                stance_group = {
                    type = 'group',
                    name = "Stance Bar",
                    desc = "Warriors, Druids, Death Knights",
                    inline = true,
                    order = 1,
                    args = {
                        x_position = {
                            type = 'range',
                            name = "X Position",
                            desc = "Horizontal position of stance bar from screen center. Negative values move left, positive values move right.",
                            min = -1500,
                            max = 1500,
                            step = 1,
                            get = function()
                                return addon.db.profile.additional.stance.x_position
                            end,
                            set = function(info, value)
                                addon.db.profile.additional.stance.x_position = value
                                if addon.RefreshStance then addon.RefreshStance() end
                            end,
                            order = 1,
                            width = "full"
                        },
                        y_offset = {
                            type = 'range',
                            name = "Y Offset",
                            desc = "|cff00FF00Static Positioning:|r The stance bar uses a fixed position from the bottom of the screen (base Y=200).\n" ..
                                "|cffFFFF00Y Offset:|r Additional vertical adjustment added to the base position.\n" ..
                                "|cffFFD700Note:|r Positive values move the bar up, negative values move it down.",
                            min = -1500,
                            max = 1500,
                            step = 1,
                            get = function()
                                return addon.db.profile.additional.stance.y_offset
                            end,
                            set = function(info, value)
                                addon.db.profile.additional.stance.y_offset = value
                                if addon.RefreshStance then addon.RefreshStance() end
                            end,
                            order = 2,
                            width = "full"
                        },
                        button_size = {
                            type = 'range',
                            name = "Button Size",
                            desc = "Size of individual stance buttons in pixels.",
                            min = 16,
                            max = 64,
                            step = 1,
                            get = function()
                                return addon.db.profile.additional.stance.button_size
                            end,
                            set = function(info, value)
                                addon.db.profile.additional.stance.button_size = value
                                if addon.RefreshStance then addon.RefreshStance() end
                            end,
                            order = 3,
                            width = "full"
                        },
                        button_spacing = {
                            type = 'range',
                            name = "Button Spacing",
                            desc = "Space between stance buttons in pixels.",
                            min = 0,
                            max = 20,
                            step = 1,
                            get = function()
                                return addon.db.profile.additional.stance.button_spacing
                            end,
                            set = function(info, value)
                                addon.db.profile.additional.stance.button_spacing = value
                                if addon.RefreshStance then addon.RefreshStance() end
                            end,
                            order = 4,
                            width = "full"
                        }
                    }
                },

                -- Pet Bar
                pet_group = {
                    type = 'group',
                    name = "Pet Bar",
                    desc = "Hunters, Warlocks, Death Knights - Use editor mode to move",
                    inline = true,
                    order = 2,
                    args = {
                        grid = {
                            type = 'toggle',
                            name = "Show Empty Slots",
                            desc = "Display empty action slots on pet bar",
                            get = function()
                                return addon.db.profile.additional.pet.grid
                            end,
                            set = function(info, value)
                                addon.db.profile.additional.pet.grid = value
                                if addon.RefreshPetbar then addon.RefreshPetbar() end
                            end,
                            order = 1,
                            width = "full"
                        }
                    }
                },

                -- Vehicle Bar
                vehicle_group = {
                    type = 'group',
                    name = "Vehicle Bar",
                    desc = "All classes (vehicles/special mounts)",
                    inline = true,
                    order = 3,
                    args = {
                        x_position = {
                            type = 'range',
                            name = "X Position",
                            desc = "Horizontal position of vehicle bar",
                            min = -500,
                            max = 500,
                            step = 1,
                            get = function()
                                return (addon.db.profile.additional.vehicle and addon.db.profile.additional.vehicle.x_position) or 0
                            end,
                            set = function(info, value)
                                addon.db.profile.additional.vehicle.x_position = value
                                if addon.RefreshVehicle then addon.RefreshVehicle() end
                            end,
                            order = 1,
                            width = "double"
                        },
                        artstyle = {
                            type = 'toggle',
                            name = "Blizzard Art Style",
                            desc = "Use Blizzard original bar arts style",
                            get = function()
                                return addon.db.profile.additional.vehicle.artstyle
                            end,
                            set = function(info, value)
                                addon.db.profile.additional.vehicle.artstyle = value
                                if addon.RefreshVehicle then addon.RefreshVehicle() end
                            end,
                            order = 2,
                            width = "full"
                        }
                    }
                }
            }
        }
    }
}

-- ============================================================================
-- REGISTER OPTIONS
-- ============================================================================

addon:RegisterOptionsGroup("micromenu", micromenuOptions)
addon:RegisterOptionsGroup("bags", bagsOptions)
addon:RegisterOptionsGroup("xprepbar", xprepbarOptions)
addon:RegisterOptionsGroup("style", styleOptions)
addon:RegisterOptionsGroup("additional", additionalOptions)

print("|cFF00FF00[DragonUI]|r Micro menu options loaded")

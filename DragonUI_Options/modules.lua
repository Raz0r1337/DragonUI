--[[
================================================================================
DragonUI - Modules Options
================================================================================
Module enable/disable toggles for all DragonUI systems.
================================================================================
]]

local addon = select(2, ...)

-- ============================================================================
-- MODULES OPTIONS GROUP
-- ============================================================================

local modulesOptions = {
    type = 'group',
    name = "Modules",
    desc = "Enable or disable specific DragonUI modules",
    order = 0.6,
    args = {
        description = {
            type = 'description',
            name = "|cffFFD700Module Control|r\n\nEnable or disable specific DragonUI modules. When disabled, the original Blizzard UI will be shown instead.",
            order = 1
        },

        -- ====================================================================
        -- CAST BARS SECTION
        -- ====================================================================
        castbars_header = {
            type = 'header',
            name = "Cast Bars",
            order = 10
        },

        player_castbar_enabled = {
            type = 'toggle',
            name = "Player Castbar",
            desc = "Enable DragonUI player castbar. When disabled, shows default Blizzard castbar.",
            get = function()
                return addon.db.profile.castbar.enabled
            end,
            set = function(info, val)
                addon.db.profile.castbar.enabled = val
                if addon.RefreshCastbar then
                    addon.RefreshCastbar()
                end
            end,
            order = 11
        },

        target_castbar_enabled = {
            type = 'toggle',
            name = "Target Castbar",
            desc = "Enable DragonUI target castbar. When disabled, shows default Blizzard castbar.",
            get = function()
                if not addon.db.profile.castbar.target then
                    return true
                end
                local value = addon.db.profile.castbar.target.enabled
                if value == nil then
                    return true
                end
                return value == true
            end,
            set = function(info, val)
                if not addon.db.profile.castbar.target then
                    addon.db.profile.castbar.target = {}
                end
                addon.db.profile.castbar.target.enabled = val
                if addon.RefreshTargetCastbar then
                    addon.RefreshTargetCastbar()
                end
            end,
            order = 12
        },

        focus_castbar_enabled = {
            type = 'toggle',
            name = "Focus Castbar",
            desc = "Enable DragonUI focus castbar. When disabled, shows default Blizzard castbar.",
            get = function()
                return addon.db.profile.castbar.focus.enabled
            end,
            set = function(info, value)
                addon.db.profile.castbar.focus.enabled = value
                if addon.RefreshFocusCastbar then
                    addon.RefreshFocusCastbar()
                end
            end,
            order = 13
        },

        -- ====================================================================
        -- OTHER MODULES SECTION
        -- ====================================================================
        other_modules_header = {
            type = 'header',
            name = "Other Modules",
            order = 20
        },

        -- Unified Action Bars System
        actionbars_system_enabled = {
            type = 'toggle',
            name = "Action Bars System",
            desc = "Enable the complete DragonUI action bars system. This controls: Main action bars, vehicle interface, stance/shapeshift bars, pet action bars, multicast bars (totems/possess), button styling, and hide Blizzard elements. When disabled, all action bar related features will use default Blizzard interface.",
            get = function()
                local modules = addon.db.profile.modules
                if not modules then
                    return false
                end
                return (modules.mainbars and modules.mainbars.enabled) and
                       (modules.vehicle and modules.vehicle.enabled) and
                       (modules.stance and modules.stance.enabled) and
                       (modules.petbar and modules.petbar.enabled) and
                       (modules.multicast and modules.multicast.enabled) and
                       (modules.buttons and modules.buttons.enabled) and
                       (modules.noop and modules.noop.enabled)
            end,
            set = function(info, val)
                if not addon.db.profile.modules then
                    addon.db.profile.modules = {}
                end
                local moduleNames = {"mainbars", "vehicle", "stance", "petbar", "multicast", "buttons", "noop"}
                for _, moduleName in ipairs(moduleNames) do
                    if not addon.db.profile.modules[moduleName] then
                        addon.db.profile.modules[moduleName] = {}
                    end
                    addon.db.profile.modules[moduleName].enabled = val
                end
                StaticPopup_Show("DRAGONUI_RELOAD_UI")
            end,
            order = 21
        },

        -- Micro Menu & Bags
        micromenu_enabled = {
            type = 'toggle',
            name = "Micro Menu & Bags",
            desc = "Apply DragonUI micro menu and bags system styling and positioning. Includes character button, spellbook, talents, etc. and bag management. When disabled, these elements will use default Blizzard positioning and styling.",
            get = function()
                return addon.db.profile.modules and addon.db.profile.modules.micromenu and
                       addon.db.profile.modules.micromenu.enabled
            end,
            set = function(info, val)
                if not addon.db.profile.modules then
                    addon.db.profile.modules = {}
                end
                if not addon.db.profile.modules.micromenu then
                    addon.db.profile.modules.micromenu = {}
                end
                addon.db.profile.modules.micromenu.enabled = val
                StaticPopup_Show("DRAGONUI_RELOAD_UI")
            end,
            order = 22
        },

        -- Cooldown Timers
        cooldowns_enabled = {
            type = 'toggle',
            name = "Cooldown Timers",
            desc = "Show cooldown timers on action buttons. When disabled, cooldown timers will be hidden and the system will be completely deactivated.",
            get = function()
                return addon.db.profile.modules and addon.db.profile.modules.cooldowns and
                       addon.db.profile.modules.cooldowns.enabled
            end,
            set = function(info, val)
                if not addon.db.profile.modules then
                    addon.db.profile.modules = {}
                end
                if not addon.db.profile.modules.cooldowns then
                    addon.db.profile.modules.cooldowns = {}
                end
                addon.db.profile.modules.cooldowns.enabled = val
                if addon.RefreshCooldownSystem then
                    addon.RefreshCooldownSystem()
                end
            end,
            order = 23
        },

        -- Minimap System
        minimap_enabled = {
            type = 'toggle',
            name = "Minimap System",
            desc = "Enable DragonUI minimap enhancements including custom styling, positioning, tracking icons, and calendar. When disabled, uses default Blizzard minimap appearance and positioning.",
            get = function()
                return addon.db.profile.modules and addon.db.profile.modules.minimap and
                       addon.db.profile.modules.minimap.enabled
            end,
            set = function(info, val)
                if not addon.db.profile.modules then
                    addon.db.profile.modules = {}
                end
                if not addon.db.profile.modules.minimap then
                    addon.db.profile.modules.minimap = {}
                end
                addon.db.profile.modules.minimap.enabled = val
                StaticPopup_Show("DRAGONUI_RELOAD_UI")
            end,
            order = 24
        },

        -- Buff Frame System
        buffs_enabled = {
            type = 'toggle',
            name = "Buff Frame System",
            desc = "Enable DragonUI buff frame with custom styling, positioning, and toggle button functionality. When disabled, uses default Blizzard buff frame appearance and positioning.",
            get = function()
                return addon.db.profile.modules and addon.db.profile.modules.buffs and
                       addon.db.profile.modules.buffs.enabled
            end,
            set = function(info, val)
                if not addon.db.profile.modules then
                    addon.db.profile.modules = {}
                end
                if not addon.db.profile.modules.buffs then
                    addon.db.profile.modules.buffs = {}
                end
                addon.db.profile.modules.buffs.enabled = val
                if addon.BuffFrameModule then
                    addon.BuffFrameModule:Toggle(val)
                end
                StaticPopup_Show("DRAGONUI_RELOAD_UI")
            end,
            order = 25
        }
    }
}

-- ============================================================================
-- REGISTER OPTIONS
-- ============================================================================

addon:RegisterOptionsGroup("modules", modulesOptions)

print("|cFF00FF00[DragonUI]|r Modules options loaded")

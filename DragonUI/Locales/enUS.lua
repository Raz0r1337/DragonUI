--[[
================================================================================
DragonUI - English Locale (Default)
================================================================================
Base locale. All keys use `true` (the key itself is the display value).

When adding new strings:
1. Add L["Your String"] = true here
2. Use L["Your String"] in your code
3. Add translations to other locale files
================================================================================
]]

local L = LibStub("AceLocale-3.0"):NewLocale("DragonUI", "enUS", true)
if not L then return end

-- ============================================================================
-- CORE / GENERAL
-- ============================================================================

-- Combat lockdown messages
L["Cannot toggle editor mode during combat!"] = true
L["Cannot reset positions during combat!"] = true
L["Cannot toggle keybind mode during combat!"] = true
L["Cannot move frames during combat!"] = true
L["Cannot open options in combat."] = true
L["Options panel not available. Try /reload."] = true

-- Module availability
L["Editor mode not available."] = true
L["Keybind mode not available."] = true
L["Vehicle debug not available"] = true
L["KeyBinding module not available"] = true
L["Unable to open configuration"] = true

-- Errors
L["Error executing pending operation:"] = true
L["Error -- Addon 'DragonUI_Options' not found or is disabled."] = true

-- ============================================================================
-- SLASH COMMANDS / HELP
-- ============================================================================

L["Unknown command: "] = true
L["=== DragonUI Commands ==="] = true
L["/dragonui or /dui - Open configuration"] = true
L["/dragonui config - Open configuration"] = true
L["/dragonui edit - Toggle editor mode (move UI elements)"] = true
L["/dragonui reset - Reset all positions to defaults"] = true
L["/dragonui reset <name> - Reset specific mover"] = true
L["/dragonui status - Show module status"] = true
L["/dragonui kb - Toggle keybind mode"] = true
L["/dragonui version - Show version info"] = true
L["/dragonui help - Show this help"] = true
L["/rl - Reload UI"] = true

-- ============================================================================
-- STATUS DISPLAY
-- ============================================================================

L["=== DragonUI Status ==="] = true
L["Detected Modules:"] = true
L["Loaded"] = true
L["Not Loaded"] = true
L["Registered Movers: "] = true
L["Editable Frames: "] = true
L["DragonUI Version: "] = true
L["Use /dragonui edit to enter edit mode, then right-click frames to reset."] = true

-- ============================================================================
-- EDITOR MODE
-- ============================================================================

L["Exit Edit Mode"] = true
L["Reset All Positions"] = true
L["Are you sure you want to reset all interface elements to their default positions?"] = true
L["Yes"] = true
L["No"] = true
L["UI elements have been repositioned. Reload UI to ensure all graphics display correctly?"] = true
L["Reload Now"] = true
L["Later"] = true

-- ============================================================================
-- KEYBINDING MODULE
-- ============================================================================

L["LibKeyBound-1.0 not found or failed to load:"] = true
L["Commands:"] = true
L["/dukb - Toggle keybinding mode"] = true
L["/dukb help - Show this help"] = true
L["Module disabled."] = true
L["Keybinding mode activated. Hover over buttons and press keys to bind them."] = true
L["Keybinding mode deactivated."] = true

-- ============================================================================
-- GAME MENU
-- ============================================================================

L["DragonUI"] = true

-- ============================================================================
-- MINIMAP MODULE
-- ============================================================================

L["DragonUI: Minimap module restored to Blizzard defaults"] = true

-- ============================================================================
-- EDITOR MODE LABELS (displayed on mover overlays)
-- ============================================================================

L["MainBar"] = "Main Bar"
L["RightBar"] = "Right Bar"
L["LeftBar"] = "Left Bar"
L["BottomBarLeft"] = "Bottom Left"
L["BottomBarRight"] = "Bottom Right"
L["XPBar"] = "XP Bar"
L["RepBar"] = "Rep Bar"
L["MinimapFrame"] = "Minimap"
L["LFGFrame"] = "Dungeon Eye"
L["PlayerFrame"] = "Player"
L["ManaBar"] = "Mana Bar"
L["PetFrame"] = "Pet"
L["ToT"] = "ToT"
L["ToF"] = "ToF"
L["tot"] = "ToT"
L["fot"] = "FoT"
L["PartyFrames"] = "Party"
L["TargetFrame"] = "Target"
L["FocusFrame"] = "Focus"
L["BagsBar"] = "Bags"
L["MicroMenu"] = "Micro Menu"
L["VehicleExitOverlay"] = "Vehicle Exit"
L["StanceOverlay"] = "Stance Bar"
L["petbar"] = "Pet Bar"
L["boss"] = "Boss Frames"
L["Boss Frames"] = true
L["Boss1Frame"] = "Boss Frames"
L["Boss2Frame"] = "Boss Frames"
L["Boss3Frame"] = "Boss Frames"
L["Boss4Frame"] = "Boss Frames"
L["TotemBarOverlay"] = "Totem Bar"
L["PlayerCastbar"] = "Castbar"
L["Auras"] = true
L["WeaponEnchants"] = "Weapon Enchants"
L["Loot Roll"] = true
L["Quest Tracker"] = true

-- Mover tooltip strings
L["Drag to move"] = true
L["Right-click to reset"] = true

-- Editor mode system messages
L["All editable frames shown for editing"] = true
L["All editable frames hidden, positions saved"] = true

-- ============================================================================
-- COMPATIBILITY MODULE
-- ============================================================================

-- Conflict warning popup
L["DragonUI Conflict Warning"] = true
L["The addon |cFFFFFF00%s|r conflicts with DragonUI."] = true
L["Reason:"] = true
L["Disable the conflicting addon now?"] = true
L["Disable"] = true
L["Keep Both"] = true

-- Conflict reasons
L["Conflicts with DragonUI's custom unit frame textures and power bar system."] = true
L["Known taint issues when manipulating party frames during combat. DragonUI provides automatic fixes."] = true
L["Resets minimap mask and blip textures. DragonUI re-applies its custom textures automatically."] = true
L["SexyMap modifies the minimap borders, shape, and zone text which conflicts with DragonUI's minimap module."] = true

-- SexyMap compatibility popup
L["DragonUI - SexyMap Detected"] = true
L["Which minimap do you want to use?"] = true
L["SexyMap"] = true
L["DragonUI"] = true
L["Hybrid"] = true
L["Recommended"] = true

-- SexyMap options panel
L["SexyMap Compatibility"] = true
L["Minimap Mode"] = true
L["Choose how DragonUI and SexyMap share the minimap."] = true
L["Requires UI reload to apply."] = true
L["Uses SexyMap for the minimap."] = true
L["Uses DragonUI for the minimap."] = true
L["SexyMap visuals with DragonUI editor and positioning."] = "SexyMap look, moveable and configurable from DragonUI."
L["Minimap mode changed. Reload UI to apply?"] = true

-- SexyMap slash commands
L["SexyMap compatibility mode has been reset. Reload UI to choose again."] = true
L["Current SexyMap mode: |cFFFFFF00%s|r"] = true
L["No SexyMap mode selected (SexyMap not detected or not yet chosen)."] = true
L["Show current SexyMap compatibility mode"] = true
L["Reset SexyMap mode choice (re-prompts on reload)"] = true
L["Loaded addons:"] = true

-- ============================================================================
-- STATIC POPUPS (shared between modules)
-- ============================================================================

L["Changing this setting requires a UI reload to apply correctly."] = true
L["Reload UI"] = true
L["Not Now"] = true
L["Disable"] = true
L["Ignore"] = true
L["The Blizzard option |cFFFFFF00Party/Arena Background|r is enabled. This conflicts with DragonUI's party frames."] = true
L["Disable it now?"] = true

-- Bag Sort
L["Sort Bags"] = true
L["Sort Bank"] = true
L["Sort Items"] = true
L["Click to sort items by type, rarity, and name."] = true

-- Micromenu Latency
L["Network"] = true
L["Latency"] = true

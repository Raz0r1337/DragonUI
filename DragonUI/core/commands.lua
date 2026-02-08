--[[
================================================================================
DragonUI - Slash Commands
================================================================================
Centralized slash command handling for DragonUI.
Based on ElvUI's Commands.lua pattern.
================================================================================
]]

local addon = select(2, ...)

-- ============================================================================
-- COMMAND HANDLERS
-- ============================================================================

-- Open configuration panel (uses ToggleOptionsUI which loads DragonUI_Options)
local function OpenConfig()
    addon:ToggleOptionsUI()
end

-- Toggle editor/move mode
local function ToggleEditorMode()
    if InCombatLockdown() then
        addon:Print("Cannot toggle editor mode during combat!")
        return
    end
    
    if addon.EditorMode then
        addon.EditorMode:Toggle()
    elseif addon.MoversSystem then
        local isActive = addon.MoversSystem.configMode
        addon.MoversSystem:ToggleConfigMode(not isActive)
    else
        addon:Print("Editor mode not available.")
    end
end

-- Reset all mover positions
local function ResetPositions(arg)
    if InCombatLockdown() then
        addon:Print("Cannot reset positions during combat!")
        return
    end
    
    if arg and arg ~= "" then
        -- Reset specific mover
        if addon.MoversSystem then
            addon.MoversSystem:ResetPosition(arg)
        end
    else
        -- Reset all
        if addon.MoversSystem then
            addon.MoversSystem:ResetAllPositions()
        elseif addon.HideAllEditableFrames then
            -- Legacy system - just inform user
            addon:Print("Use /dragonui edit to enter edit mode, then right-click frames to reset.")
        end
    end
end

-- Show module status
local function ShowStatus()
    addon:Print("=== DragonUI Status ===")
    
    -- Show registered modules from ModuleRegistry (if available)
    if addon.ModuleRegistry and addon.ModuleRegistry.Count and addon.ModuleRegistry:Count() > 0 then
        addon.ModuleRegistry:PrintStatus()
    else
        -- Fallback: Show manually detected modules
        print("  |cFF00FF00Detected Modules:|r")
        local modules = {
            { name = "Mainbars", check = function() return addon.RefreshMainbars end },
            { name = "Buttons", check = function() return addon.RefreshButtons end },
            { name = "Micromenu", check = function() return addon.RefreshMicromenu end },
            { name = "Minimap", check = function() return addon.RefreshMinimap end },
            { name = "Target Frame", check = function() return addon.RefreshTargetFrame end },
            { name = "Focus Frame", check = function() return addon.RefreshFocusFrame end },
            { name = "Party Frames", check = function() return addon.RefreshPartyFrames end },
            { name = "Stance Bar", check = function() return addon.RefreshStance end },
            { name = "Pet Bar", check = function() return addon.RefreshPetbar end },
            { name = "Vehicle", check = function() return addon.RefreshVehicle end },
            { name = "Multicast", check = function() return addon.RefreshMulticast end },
            { name = "Cooldowns", check = function() return addon.RefreshCooldowns end },
            { name = "Buff Frame", check = function() return addon.RefreshBuffFrame end },
            { name = "Castbar", check = function() return addon.RefreshCastbar end },
        }
        
        for _, module in ipairs(modules) do
            local status = module.check() and "|cFF00FF00Loaded|r" or "|cFFFF0000Not Loaded|r"
            print(string.format("    %s: %s", module.name, status))
        end
    end
    
    -- Show mover count
    if addon.MoversSystem then
        local count = 0
        for _ in pairs(addon.MoversSystem.created) do
            count = count + 1
        end
        print(string.format("  Registered Movers: |cFF00FF00%d|r", count))
    end
    
    -- Show editable frames count (legacy)
    if addon.EditableFrames then
        local count = 0
        for _ in pairs(addon.EditableFrames) do
            count = count + 1
        end
        print(string.format("  Editable Frames: |cFF00FF00%d|r", count))
    end
end

-- Toggle keybind mode
local function ToggleKeybindMode()
    if InCombatLockdown() then
        addon:Print("Cannot toggle keybind mode during combat!")
        return
    end
    
    if addon.KeybindModule and addon.KeybindModule.Toggle then
        addon.KeybindModule:Toggle()
    else
        addon:Print("Keybind mode not available.")
    end
end

-- Reload UI shortcut
local function ReloadUICommand()
    ReloadUI()
end

-- Print version info
local function ShowVersion()
    local version = GetAddOnMetadata("DragonUI", "Version") or "Unknown"
    addon:Print("DragonUI Version: " .. version)
end

-- Show help
local function ShowHelp()
    addon:Print("=== DragonUI Commands ===")
    print("  |cFF00FF00/dragonui|r or |cFF00FF00/dui|r - Open configuration")
    print("  |cFF00FF00/dragonui config|r - Open configuration")
    print("  |cFF00FF00/dragonui edit|r - Toggle editor mode (move UI elements)")
    print("  |cFF00FF00/dragonui reset|r - Reset all positions to defaults")
    print("  |cFF00FF00/dragonui reset <name>|r - Reset specific mover")
    print("  |cFF00FF00/dragonui status|r - Show module status")
    print("  |cFF00FF00/dragonui kb|r - Toggle keybind mode")
    print("  |cFF00FF00/dragonui version|r - Show version info")
    print("  |cFF00FF00/dragonui help|r - Show this help")
    print("  |cFF00FF00/rl|r - Reload UI")
end

-- ============================================================================
-- MAIN COMMAND HANDLER
-- ============================================================================

local function SlashCommandHandler(input)
    if not input or input:trim() == "" then
        OpenConfig()
        return
    end
    
    local cmd, arg = input:match("^(%S+)%s*(.*)$")
    cmd = cmd and cmd:lower() or ""
    
    if cmd == "config" or cmd == "options" or cmd == "opt" then
        OpenConfig()
    elseif cmd == "edit" or cmd == "editor" or cmd == "move" or cmd == "moveui" then
        ToggleEditorMode()
    elseif cmd == "reset" then
        ResetPositions(arg)
    elseif cmd == "status" then
        ShowStatus()
    elseif cmd == "kb" or cmd == "keybind" or cmd == "keybinds" then
        ToggleKeybindMode()
    elseif cmd == "version" or cmd == "ver" then
        ShowVersion()
    elseif cmd == "debugvehicle" then
        if addon.DebugVehicle then addon.DebugVehicle() else addon:Print("Vehicle debug not available") end
    elseif cmd == "help" or cmd == "?" then
        ShowHelp()
    else
        -- Unknown command
        addon:Print("Unknown command: " .. cmd)
        ShowHelp()
    end
end

-- ============================================================================
-- COMMAND REGISTRATION
-- ============================================================================

local Commands = {}

function Commands:RegisterCommands()
    -- Register with AceConsole if available
    if addon.core and addon.core.RegisterChatCommand then
        -- Main commands
        addon.core:RegisterChatCommand("dragonui", SlashCommandHandler)
        addon.core:RegisterChatCommand("dui", SlashCommandHandler)
        
        -- Legacy alias
        addon.core:RegisterChatCommand("pi", SlashCommandHandler)
        
        -- Quick reload
        addon.core:RegisterChatCommand("rl", ReloadUICommand)
    else
        -- Fallback to direct slash command registration
        SLASH_DRAGONUI1 = "/dragonui"
        SLASH_DRAGONUI2 = "/dui"
        SLASH_DRAGONUI3 = "/pi"
        SlashCmdList["DRAGONUI"] = SlashCommandHandler
        
        SLASH_DRAGONUIRL1 = "/rl"
        SlashCmdList["DRAGONUIRL"] = ReloadUICommand
    end
end

-- Store reference for module access
addon.Commands = Commands

-- ============================================================================
-- INTEGRATION WITH CORE
-- ============================================================================

-- Override the SlashCommand function in core.lua
-- This will be called from core.lua's OnEnable
function addon.LoadCommands()
    Commands:RegisterCommands()
end

-- Also expose individual handlers for other modules
addon.CommandHandlers = {
    OpenConfig = OpenConfig,
    ToggleEditorMode = ToggleEditorMode,
    ResetPositions = ResetPositions,
    ShowStatus = ShowStatus,
    ToggleKeybindMode = ToggleKeybindMode,
    ShowVersion = ShowVersion,
    ShowHelp = ShowHelp
}

print("|cFF00FF00[DragonUI]|r Commands loaded")

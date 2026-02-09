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
    elseif cmd == "debugshadow" then
        -- Enumerate ALL visible children/textures of TargetFrame to find the shadow source
        local function InspectFrame(frame, prefix, depth)
            if not frame or depth > 3 then return end
            local regions = { frame:GetRegions() }
            for _, region in ipairs(regions) do
                if region:IsShown() or (region.GetAlpha and region:GetAlpha() > 0) then
                    local rtype = region:GetObjectType()
                    local name = region:GetName() or "(unnamed)"
                    local alpha = region:GetAlpha()
                    local layer, sublevel = "", ""
                    if region.GetDrawLayer then layer, sublevel = region:GetDrawLayer() end
                    local w, h = region:GetWidth(), region:GetHeight()
                    local tex = ""
                    if region.GetTexture then tex = tostring(region:GetTexture() or "") end
                    local shown = region:IsShown() and "SHOWN" or "hidden"
                    local visible = region:IsVisible() and "VISIBLE" or "invisible"
                    print(string.format("%s%s [%s] a=%.2f %s/%s %s %s %.0fx%.0f tex=%s",
                        prefix, name, rtype, alpha, shown, visible,
                        tostring(layer), tostring(sublevel), w, h, tex))
                end
            end
            local children = { frame:GetChildren() }
            for _, child in ipairs(children) do
                local cname = child:GetName() or "(unnamed_frame)"
                local calpha = child:GetAlpha()
                local shown = child:IsShown() and "SHOWN" or "hidden"
                local visible = child:IsVisible() and "VISIBLE" or "invisible"
                print(string.format("%s> %s [Frame] a=%.2f %s/%s",
                    prefix, cname, calpha, shown, visible))
                InspectFrame(child, prefix .. "  ", depth + 1)
            end
        end
        print("=== TargetFrame children (depth 3) ===")
        InspectFrame(TargetFrame, "  ", 0)
        if FocusFrame then
            print("=== FocusFrame children (depth 3) ===")
            InspectFrame(FocusFrame, "  ", 0)
        end
    elseif cmd == "help" or cmd == "?" then
        ShowHelp()
    elseif cmd == "shadowcolor" then
        -- Tint DragonUI_TargetBG bright red/green to visualize its full extent
        local bg = _G["DragonUI_TargetBG"]
        if not bg then
            print("BG texture not found")
        else
            if arg == "red" then
                bg:SetVertexColor(1, 0, 0, 1)
                print("|cFFFF0000BG tinted RED|r")
            elseif arg == "green" then
                bg:SetVertexColor(0, 1, 0, 1)
                print("|cFF00FF00BG tinted GREEN|r")
            elseif arg == "reset" then
                bg:SetVertexColor(1, 1, 1, 1)
                print("BG color reset")
            elseif arg == "info" then
                local l, b, w, h = bg:GetRect()
                local p1, parent, p2, x, y = bg:GetPoint(1)
                local np = bg:GetNumPoints()
                print(string.format("Rect: left=%.1f bottom=%.1f w=%.1f h=%.1f", l or 0, b or 0, w or 0, h or 0))
                print(string.format("Point1: %s -> %s %s (%.1f, %.1f)", p1 or "?", parent and parent:GetName() or "?", p2 or "?", x or 0, y or 0))
                print(string.format("NumPoints: %d", np))
                local tc = {bg:GetTexCoord()}
                print(string.format("TexCoord: %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f",
                    tc[1] or 0, tc[2] or 0, tc[3] or 0, tc[4] or 0,
                    tc[5] or 0, tc[6] or 0, tc[7] or 0, tc[8] or 0))
            else
                print("Usage: /dui shadowcolor red|green|reset|info")
            end
        end
    elseif cmd == "shadowcrop" then
        -- Real-time SetTexCoord adjustment on BG
        local bg = _G["DragonUI_TargetBG"]
        if not bg then
            print("BG texture not found")
        elseif not arg or arg == "" then
            print("Usage: /dui shadowcrop <bottom_px> [right_px]")
            print("  e.g. /dui shadowcrop 90 — show top 90 of 128 px height")
            print("  e.g. /dui shadowcrop 90 200 — crop both bottom and right")
            print("  /dui shadowcrop reset — restore full texture")
        elseif arg == "reset" then
            bg:SetTexCoord(0, 1, 0, 1)
            bg:SetSize(256, 128)
            print("BG reset to 256x128 full texture")
        else
            local b, r = arg:match("^(%d+)%s*(%d*)$")
            b = tonumber(b)
            r = tonumber(r) or 256
            if b and b > 0 and b <= 128 and r > 0 and r <= 256 then
                bg:SetTexCoord(0, r/256, 0, b/128)
                bg:SetSize(r, b)
                print(string.format("|cFFFFD700Crop applied:|r showing %dx%d of 256x128 (texcoord 0-%.3f, 0-%.3f)", r, b, r/256, b/128))
            else
                print("Invalid values. Height 1-128, Width 1-256")
            end
        end
    elseif cmd == "shadowtest" then
        -- Interactive element hiding to find the shadow source
        -- Usage: /dui shadowtest <number> to toggle hiding element N
        -- /dui shadowtest alone lists all elements with numbers
        local elements = {}
        local function Collect(frame, depth)
            if not frame or depth > 3 then return end
            for _, region in ipairs({frame:GetRegions()}) do
                local name = region:GetName() or "(unnamed)"
                local rtype = region:GetObjectType()
                local shown = region:IsShown()
                local visible = region:IsVisible()
                local tex = ""
                if region.GetTexture then tex = tostring(region:GetTexture() or "") end
                table.insert(elements, {obj=region, name=name, type=rtype, shown=shown, visible=visible, tex=tex})
            end
            for _, child in ipairs({frame:GetChildren()}) do
                local cname = child:GetName() or "(unnamed_frame)"
                table.insert(elements, {obj=child, name=cname, type="Frame", shown=child:IsShown(), visible=child:IsVisible(), tex=""})
                Collect(child, depth+1)
            end
        end
        Collect(TargetFrame, 0)
        
        local n = tonumber(arg)
        if not n then
            -- List all elements
            print("|cFF00FF00=== TargetFrame elements (use /dui shadowtest N to toggle) ===|r")
            for i, e in ipairs(elements) do
                local vis = e.visible and "|cFF00FF00VIS|r" or "|cFFFF0000inv|r"
                local sh = e.shown and "SHOWN" or "hidden"
                print(string.format("  |cFFFFD700%d|r. %s [%s] %s %s %s", i, e.name, e.type, sh, vis, e.tex))
            end
            print("|cFFFFD700Total:|r " .. #elements .. " elements")
        else
            -- Toggle hide/show element N
            if n >= 1 and n <= #elements then
                local e = elements[n]
                if e.obj:IsShown() then
                    e.obj:Hide()
                    e.obj:SetAlpha(0)
                    print(string.format("|cFFFF0000HIDDEN|r: %d. %s [%s]", n, e.name, e.type))
                else
                    e.obj:Show()
                    e.obj:SetAlpha(1)
                    print(string.format("|cFF00FF00SHOWN|r: %d. %s [%s]", n, e.name, e.type))
                end
            else
                print("Invalid element number. Use /dui shadowtest to list.")
            end
        end
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

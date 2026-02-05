--[[
================================================================================
DragonUI - General Options
================================================================================
Editor mode button, keybind mode button, and other general UI controls.
================================================================================
]]

local addon = select(2, ...)

-- ============================================================================
-- GENERAL OPTIONS GROUP
-- ============================================================================

local generalOptions = {
    -- Editor Mode Button
    toggle_editor_mode = {
        type = 'execute',
        name = function()
            if addon.EditorMode then
                local success, isActive = pcall(function()
                    return addon.EditorMode:IsActive()
                end)
                if success and isActive then
                    return "|cffFF6347Exit Editor Mode|r"
                end
            end
            return "|cff00FF00Move UI Elements|r"
        end,
        desc = "Unlock UI elements to move them with your mouse. A button will appear to exit this mode.",
        func = function()
            GameTooltip:Hide()
            LibStub("AceConfigDialog-3.0"):Close("DragonUI")
            if addon.EditorMode then
                addon.EditorMode:Toggle()
            end
        end,
        disabled = false,
        order = 0
    },
    
    -- Keybinding Mode Button
    toggle_keybind_mode = {
        type = 'execute',
        name = function()
            if LibStub and LibStub("LibKeyBound-1.0", true) and LibStub("LibKeyBound-1.0"):IsShown() then
                return "|cffFF6347KeyBind Mode Active|r"
            else
                return "|cff00FF00KeyBind Mode|r"
            end
        end,
        desc = "Toggle keybinding mode. Hover over action buttons and press keys to bind them instantly. Press ESC to clear bindings.",
        func = function()
            GameTooltip:Hide()
            LibStub("AceConfigDialog-3.0"):Close("DragonUI")
            
            if addon.KeyBindingModule and LibStub and LibStub("LibKeyBound-1.0", true) then
                local LibKeyBound = LibStub("LibKeyBound-1.0")
                LibKeyBound:Toggle()
            else
                print("|cFFFF0000[DragonUI]|r KeyBinding module not available")
            end
        end,
        disabled = function()
            return not (addon.KeyBindingModule and addon.KeyBindingModule.enabled)
        end,
        order = 0.3
    },
    
    -- Visual Separator
    editor_separator = {
        type = 'header',
        name = ' ',
        order = 0.5
    }
}

-- ============================================================================
-- REGISTER OPTIONS
-- ============================================================================

-- These are direct args in the root options table, not a group
function addon:GetGeneralOptions()
    return generalOptions
end

print("|cFF00FF00[DragonUI]|r General options loaded")

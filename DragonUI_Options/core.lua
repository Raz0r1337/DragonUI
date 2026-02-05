--[[
================================================================================
DragonUI - Options Core
================================================================================
This file provides the base options registration system.
Individual option groups are registered from separate files.
Based on ElvUI_OptionsUI pattern.
================================================================================
]]

local addon = select(2, ...)

-- ============================================================================
-- OPTIONS REGISTRY
-- ============================================================================

-- Store for registered option groups
addon.optionsRegistry = {}

-- Static popup for reload confirmation
StaticPopupDialogs["DRAGONUI_RELOAD_UI"] = {
    text = "Changing this setting requires a UI reload to apply correctly.",
    button1 = "Reload UI",
    button2 = "Not Now",
    OnAccept = function()
        ReloadUI()
    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
    preferredIndex = 3
}

-- ============================================================================
-- REGISTRATION FUNCTIONS
-- ============================================================================

-- Register an options group
-- @param name: Unique identifier for the group
-- @param optionsTable: AceConfig options table
-- @param order: Display order (optional)
function addon:RegisterOptionsGroup(name, optionsTable, order)
    if self.optionsRegistry[name] then
        -- Merge with existing
        for k, v in pairs(optionsTable) do
            self.optionsRegistry[name][k] = v
        end
    else
        self.optionsRegistry[name] = optionsTable
        if order then
            self.optionsRegistry[name].order = order
        end
    end
end

-- Get a registered options group
function addon:GetOptionsGroup(name)
    return self.optionsRegistry[name]
end

-- ============================================================================
-- OPTIONS TABLE CREATION
-- ============================================================================

-- Build the complete options table from registered groups
function addon:CreateOptionsTable()
    local options = {
        name = "DragonUI",
        type = 'group',
        args = {}
    }
    
    -- Add all registered option groups
    for name, optionsTable in pairs(self.optionsRegistry) do
        options.args[name] = optionsTable
    end
    
    return options
end

-- ============================================================================
-- UTILITY FUNCTIONS FOR OPTIONS
-- ============================================================================

-- Create a toggle option with standard format
function addon:CreateToggleOption(info)
    return {
        type = 'toggle',
        name = info.name,
        desc = info.desc,
        order = info.order or 1,
        width = info.width or nil,
        get = function()
            if info.getFunc then
                return info.getFunc()
            elseif info.dbPath then
                local path = {strsplit(".", info.dbPath)}
                local value = addon.db.profile
                for _, key in ipairs(path) do
                    value = value and value[key]
                end
                return value
            end
            return false
        end,
        set = function(_, val)
            if info.setFunc then
                info.setFunc(val)
            elseif info.dbPath then
                local path = {strsplit(".", info.dbPath)}
                local target = addon.db.profile
                for i = 1, #path - 1 do
                    target = target[path[i]]
                end
                target[path[#path]] = val
            end
            if info.refresh then
                info.refresh()
            end
            if info.requiresReload then
                StaticPopup_Show("DRAGONUI_RELOAD_UI")
            end
        end,
        disabled = info.disabled
    }
end

-- Create a slider option with standard format
function addon:CreateSliderOption(info)
    return {
        type = 'range',
        name = info.name,
        desc = info.desc,
        order = info.order or 1,
        min = info.min or 0,
        max = info.max or 1,
        step = info.step or 0.01,
        isPercent = info.isPercent or false,
        width = info.width or nil,
        get = function()
            if info.getFunc then
                return info.getFunc()
            elseif info.dbPath then
                local path = {strsplit(".", info.dbPath)}
                local value = addon.db.profile
                for _, key in ipairs(path) do
                    value = value and value[key]
                end
                return value or info.default or 1
            end
            return info.default or 1
        end,
        set = function(_, val)
            if info.setFunc then
                info.setFunc(val)
            elseif info.dbPath then
                local path = {strsplit(".", info.dbPath)}
                local target = addon.db.profile
                for i = 1, #path - 1 do
                    target = target[path[i]]
                end
                target[path[#path]] = val
            end
            if info.refresh then
                info.refresh()
            end
        end
    }
end

-- Create a color picker option
function addon:CreateColorOption(info)
    return {
        type = 'color',
        name = info.name,
        desc = info.desc,
        order = info.order or 1,
        hasAlpha = info.hasAlpha or false,
        get = function()
            if info.getFunc then
                return info.getFunc()
            elseif info.dbPath then
                local path = {strsplit(".", info.dbPath)}
                local value = addon.db.profile
                for _, key in ipairs(path) do
                    value = value and value[key]
                end
                if value then
                    return value.r, value.g, value.b, value.a
                end
            end
            return 1, 1, 1, 1
        end,
        set = function(_, r, g, b, a)
            if info.setFunc then
                info.setFunc(r, g, b, a)
            elseif info.dbPath then
                local path = {strsplit(".", info.dbPath)}
                local target = addon.db.profile
                for i = 1, #path - 1 do
                    target = target[path[i]]
                end
                target[path[#path]] = { r = r, g = g, b = b, a = a }
            end
            if info.refresh then
                info.refresh()
            end
        end
    }
end

-- Create a select/dropdown option
function addon:CreateSelectOption(info)
    return {
        type = 'select',
        name = info.name,
        desc = info.desc,
        order = info.order or 1,
        values = info.values,
        style = info.style or "dropdown",
        get = function()
            if info.getFunc then
                return info.getFunc()
            elseif info.dbPath then
                local path = {strsplit(".", info.dbPath)}
                local value = addon.db.profile
                for _, key in ipairs(path) do
                    value = value and value[key]
                end
                return value
            end
            return info.default
        end,
        set = function(_, val)
            if info.setFunc then
                info.setFunc(val)
            elseif info.dbPath then
                local path = {strsplit(".", info.dbPath)}
                local target = addon.db.profile
                for i = 1, #path - 1 do
                    target = target[path[i]]
                end
                target[path[#path]] = val
            end
            if info.refresh then
                info.refresh()
            end
        end
    }
end

-- ============================================================================
-- INITIALIZATION
-- ============================================================================

print("|cFF00FF00[DragonUI]|r Options core loaded")

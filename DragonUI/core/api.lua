--[[
================================================================================
DragonUI - API Functions
================================================================================
This file contains utility functions used throughout DragonUI.
These are general-purpose functions that can be used by any module.
================================================================================
]]

local addon = select(2, ...)

-- ============================================================================
-- TABLE UTILITIES
-- ============================================================================

-- Recursively copy tables
function addon.DeepCopy(source, target)
    target = target or {}
    for key, value in pairs(source) do
        if type(value) == "table" then
            if not target[key] then
                target[key] = {}
            end
            addon.DeepCopy(value, target[key])
        else
            target[key] = value
        end
    end
    return target
end

-- Count elements in a table (works with non-sequential tables)
function addon:tcount(tbl)
    local count = 0
    for _ in pairs(tbl) do count = count + 1 end
    return count
end

-- ============================================================================
-- FRAME CREATION AND MANAGEMENT
-- ============================================================================

-- Frames registry for editor mode
addon.frames = addon.frames or {}

-- Create a UI frame with editor mode support
function addon.CreateUIFrame(width, height, frameName)
    local frame = CreateFrame("Frame", 'DragonUI_' .. frameName, UIParent)
    frame:SetSize(width, height)

    frame:RegisterForDrag("LeftButton")
    frame:EnableMouse(false)
    frame:SetMovable(false)
    
    frame:SetScript("OnDragStart", function(self, button)
        self:StartMoving()
    end)
    
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        
        -- AUTO-SAVE: Find this frame in EditableFrames and save position automatically
        for name, frameData in pairs(addon.EditableFrames) do
            if frameData.frame == self then
                -- Save position automatically
                if #frameData.configPath == 2 then
                    addon.SaveUIFramePosition(frameData.frame, frameData.configPath[1], frameData.configPath[2])
                else
                    addon.SaveUIFramePosition(frameData.frame, frameData.configPath[1])
                end
                break
            end
        end
    end)

    frame:SetFrameLevel(100)
    frame:SetFrameStrata('FULLSCREEN')

    -- Green texture for editor mode (like RetailUI)
    do
        local texture = frame:CreateTexture(nil, 'BACKGROUND')
        texture:SetAllPoints(frame)
        texture:SetTexture(0, 1, 0, 0.3) -- Semi-transparent green
        texture:Hide()
        frame.editorTexture = texture
    end

    -- Text label for editor mode
    do
        local fontString = frame:CreateFontString(nil, "BORDER", 'GameFontNormal')
        fontString:SetAllPoints(frame)
        fontString:SetText(frameName)
        fontString:Hide()
        frame.editorText = fontString
    end

    return frame
end

-- Global function alias for backwards compatibility
CreateUIFrame = addon.CreateUIFrame

-- ============================================================================
-- FRAME VISIBILITY FUNCTIONS (Editor Mode Support)
-- ============================================================================

-- Show a UI frame (disable editor mode for this frame)
function addon.ShowUIFrame(frame)
    frame:SetMovable(false)
    frame:EnableMouse(false)
    
    -- Safety check for editor overlay elements
    if frame.editorTexture then
        frame.editorTexture:Hide()
    end
    if frame.editorText then
        frame.editorText:Hide()
    end

    if addon.frames[frame] then
        for _, target in pairs(addon.frames[frame]) do
            target:SetAlpha(1)
        end
        addon.frames[frame] = nil
    end
end

-- Global function alias for backwards compatibility
ShowUIFrame = addon.ShowUIFrame

-- Hide a UI frame (enable editor mode for this frame)
function addon.HideUIFrame(frame, exclude)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    
    -- Safety check for editor overlay elements
    if frame.editorTexture then
        frame.editorTexture:Show()
    end
    if frame.editorText then
        frame.editorText:Show()
    end

    addon.frames[frame] = {}
    exclude = exclude or {}

    for _, target in pairs(exclude) do
        target:SetAlpha(0)
        table.insert(addon.frames[frame], target)
    end
end

-- Global function alias for backwards compatibility
HideUIFrame = addon.HideUIFrame

-- ============================================================================
-- POSITION SAVE/LOAD FUNCTIONS
-- ============================================================================

-- Save frame position to database
function addon.SaveUIFramePosition(frame, configPath1, configPath2)
    if not frame then
        return
    end

    local anchor, _, relativePoint, posX, posY = frame:GetPoint(1)

    -- Handle nested paths (widgets.player)
    if configPath2 then
        -- Case: SaveUIFramePosition(frame, "widgets", "player")
        if not addon.db.profile[configPath1] then
            addon.db.profile[configPath1] = {}
        end

        if not addon.db.profile[configPath1][configPath2] then
            addon.db.profile[configPath1][configPath2] = {}
        end

        addon.db.profile[configPath1][configPath2].anchor = anchor or "CENTER"
        addon.db.profile[configPath1][configPath2].posX = posX or 0
        addon.db.profile[configPath1][configPath2].posY = posY or 0
    else
        -- Case: SaveUIFramePosition(frame, "minimap") - backwards compatibility
        local widgetName = configPath1
        
        if not addon.db.profile.widgets then
            addon.db.profile.widgets = {}
        end

        if not addon.db.profile.widgets[widgetName] then
            addon.db.profile.widgets[widgetName] = {}
        end

        addon.db.profile.widgets[widgetName].anchor = anchor or "CENTER"
        addon.db.profile.widgets[widgetName].posX = posX or 0
        addon.db.profile.widgets[widgetName].posY = posY or 0
    end
end

-- Global function alias for backwards compatibility
SaveUIFramePosition = addon.SaveUIFramePosition

-- Apply frame position from database
function addon.ApplyUIFramePosition(frame, configPath)
    if not frame or not configPath then
        return
    end

    local section, key = configPath:match("([^%.]+)%.([^%.]+)")
    if not section or not key then
        return
    end

    local config = addon.db.profile[section] and addon.db.profile[section][key]
    if not config or not config.override then
        return
    end

    frame:ClearAllPoints()
    frame:SetPoint(config.anchor or "CENTER", UIParent, config.anchorParent or "CENTER", config.x or 0, config.y or 0)
end

-- Global function alias for backwards compatibility
ApplyUIFramePosition = addon.ApplyUIFramePosition

-- ============================================================================
-- SETTINGS VALIDATION
-- ============================================================================

-- Check if settings exist and load defaults if needed
function addon.CheckSettingsExists(moduleTable, configPaths)
    local needsDefaults = false

    for _, configPath in pairs(configPaths) do
        local section, key = configPath:match("([^%.]+)%.([^%.]+)")
        if section and key then
            if not addon.db.profile[section] or not addon.db.profile[section][key] then
                needsDefaults = true
                break
            end
        end
    end

    if needsDefaults and moduleTable.LoadDefaultSettings then
        moduleTable:LoadDefaultSettings()
    end

    if moduleTable.UpdateWidgets then
        moduleTable:UpdateWidgets()
    end
end

-- Global function alias for backwards compatibility
CheckSettingsExists = addon.CheckSettingsExists

-- ============================================================================
-- EDITABLE FRAMES REGISTRY
-- Centralized system for managing moveable UI elements
-- ============================================================================

addon.EditableFrames = addon.EditableFrames or {}

-- Register a frame as editable
function addon:RegisterEditableFrame(frameInfo)
    local frameData = {
        name = frameInfo.name,                    -- "player", "minimap", "target"
        frame = frameInfo.frame,                  -- The auxiliary frame
        blizzardFrame = frameInfo.blizzardFrame,  -- Real Blizzard frame (optional)
        configPath = frameInfo.configPath,        -- {"widgets", "player"} or {"unitframe", "target"}
        onShow = frameInfo.onShow,                -- Optional function when showing editor
        onHide = frameInfo.onHide,                -- Optional function when hiding editor
        showTest = frameInfo.showTest,            -- Function to show with fake data
        hideTest = frameInfo.hideTest,            -- Function to hide fake frame
        hasTarget = frameInfo.hasTarget,          -- Function to check if should be visible
        module = frameInfo.module                 -- Reference to the module
    }
    
    self.EditableFrames[frameInfo.name] = frameData
end

-- Show all frames in editor mode
function addon:ShowAllEditableFrames()
    for name, frameData in pairs(self.EditableFrames) do
        if frameData.frame then
            addon.HideUIFrame(frameData.frame) -- Show green overlay
            
            -- Show frame with fake data if needed
            if frameData.showTest then
                frameData.showTest()
            end
            
            if frameData.onShow then
                frameData.onShow()
            end
        end
    end
    print("|cFF00FF00[DragonUI]|r All editable frames shown for editing")
end

-- Hide all frames and save positions
function addon:HideAllEditableFrames(refresh)
    for name, frameData in pairs(self.EditableFrames) do
        if frameData.frame then
            addon.ShowUIFrame(frameData.frame) -- Hide green overlay
            
            -- Hide fake frame if it shouldn't be visible
            if frameData.hideTest then
                frameData.hideTest()
            end
            
            if refresh then
                -- Save position automatically
                if #frameData.configPath == 2 then
                    addon.SaveUIFramePosition(frameData.frame, frameData.configPath[1], frameData.configPath[2])
                else
                    addon.SaveUIFramePosition(frameData.frame, frameData.configPath[1])
                end
                
                if frameData.onHide then
                    frameData.onHide()
                end
            end
        end
    end
    print("|cFF00FF00[DragonUI]|r All editable frames hidden, positions saved")
end

-- Check if a frame should be visible
function addon:ShouldFrameBeVisible(frameName)
    local frameData = self.EditableFrames[frameName]
    if not frameData then return false end
    
    if frameData.hasTarget then
        return frameData.hasTarget()
    end
    
    -- By default, frames are always visible (player, minimap)
    return true
end

-- Get information about a registered frame
function addon:GetEditableFrameInfo(frameName)
    return self.EditableFrames[frameName]
end

-- ============================================================================
-- COMBAT QUEUE SYSTEM (ElvUI Pattern)
-- ============================================================================
-- Central system for deferring operations that cannot run during combat lockdown.
-- Pattern: Check InCombatLockdown() -> if true, queue operation -> execute after combat
-- Reference: ElvUI ActionBars.lua PLAYER_REGEN_ENABLED handler

addon.CombatQueue = addon.CombatQueue or {
    -- Pending operations table: { [id] = { func, args } }
    pending = {},
    -- Is the event frame registered?
    isRegistered = false,
    -- Event frame for PLAYER_REGEN_ENABLED
    eventFrame = nil,
}

local CQ = addon.CombatQueue

-- Initialize the combat queue event frame
local function InitializeCombatQueueFrame()
    if CQ.eventFrame then return end
    
    CQ.eventFrame = CreateFrame("Frame", "DragonUI_CombatQueueFrame", UIParent)
    CQ.eventFrame:Hide()
    CQ.eventFrame:SetScript("OnEvent", function(self, event)
        if event == "PLAYER_REGEN_ENABLED" then
            addon.CombatQueue:ProcessQueue()
        end
    end)
end

-- Add an operation to the combat queue
-- @param id: Unique identifier for this operation (prevents duplicates)
-- @param func: Function to call when combat ends
-- @param ...: Arguments to pass to the function
function CQ:Add(id, func, ...)
    if not id or not func then
        addon:Error("CombatQueue:Add requires id and func")
        return false
    end
    
    -- Initialize frame if needed
    InitializeCombatQueueFrame()
    
    -- Store the operation with its arguments
    self.pending[id] = { func = func, args = {...} }
    
    -- Register for PLAYER_REGEN_ENABLED if not already
    if not self.isRegistered then
        self.eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
        self.isRegistered = true
        addon:Debug("CombatQueue: Registered PLAYER_REGEN_ENABLED")
    end
    
    addon:Debug("CombatQueue: Queued operation -", id)
    return true
end

-- Remove an operation from the queue (if no longer needed)
-- @param id: Identifier of the operation to remove
function CQ:Remove(id)
    if self.pending[id] then
        self.pending[id] = nil
        addon:Debug("CombatQueue: Removed operation -", id)
    end
    
    -- If queue is empty, unregister the event
    if not next(self.pending) and self.isRegistered then
        self.eventFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")
        self.isRegistered = false
    end
end

-- Check if an operation is in the queue
-- @param id: Identifier to check
function CQ:HasPending(id)
    return self.pending[id] ~= nil
end

-- Process all queued operations (called on PLAYER_REGEN_ENABLED)
function CQ:ProcessQueue()
    addon:Debug("CombatQueue: Processing", addon:tcount(self.pending), "queued operations")
    
    -- Process all pending operations
    for id, operation in pairs(self.pending) do
        local success, err = pcall(function()
            operation.func(unpack(operation.args))
        end)
        
        if not success then
            addon:Error("CombatQueue: Failed to execute", id, "-", err)
        else
            addon:Debug("CombatQueue: Executed -", id)
        end
    end
    
    -- Clear all pending operations
    self.pending = {}
    
    -- Unregister the event
    if self.isRegistered then
        self.eventFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")
        self.isRegistered = false
        addon:Debug("CombatQueue: Unregistered PLAYER_REGEN_ENABLED")
    end
end

-- Execute immediately if out of combat, queue if in combat
-- @param id: Unique identifier for this operation
-- @param func: Function to call
-- @param ...: Arguments to pass to the function
-- @return true if executed immediately, false if queued
function CQ:ExecuteOrQueue(id, func, ...)
    if InCombatLockdown() then
        self:Add(id, func, ...)
        return false
    else
        -- Execute immediately
        local args = {...}
        local success, err = pcall(function()
            func(unpack(args))
        end)
        
        if not success then
            addon:Error("CombatQueue: Immediate execution failed -", id, "-", err)
        end
        return true
    end
end

-- Convenience function for modules to check and queue
-- Returns true if operation can proceed (not in combat)
-- @param moduleId: Module name for the queue ID
-- @param operationName: Name of the operation (combined with moduleId)
-- @param func: Function to call when combat ends
-- @param ...: Arguments
function addon:SafeExecute(moduleId, operationName, func, ...)
    local queueId = moduleId .. "_" .. operationName
    return CQ:ExecuteOrQueue(queueId, func, ...)
end

-- ============================================================================
-- PRINT / DEBUG UTILITIES
-- ============================================================================

-- Print a formatted message
function addon:Print(...)
    print("|cFF00FF00[DragonUI]|r", ...)
end

-- Print a debug message (only in debug mode)
function addon:Debug(...)
    if addon.debugMode then
        print("|cFFFFFF00[DragonUI Debug]|r", ...)
    end
end

-- Print an error message
function addon:Error(...)
    print("|cFFFF0000[DragonUI Error]|r", ...)
end

print("|cFF00FF00[DragonUI]|r API loaded")

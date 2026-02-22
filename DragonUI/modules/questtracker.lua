local addon = select(2, ...);

-- =============================================================================
-- DRAGONUI QUEST TRACKER MODULE 
-- =============================================================================

local QuestTrackerModule = {
    initialized = false,
    applied = false,
    originalWatchFramePoint = nil,
}
addon.QuestTrackerModule = QuestTrackerModule

-- Register with ModuleRegistry (if available)
if addon.RegisterModule then
    addon:RegisterModule("questtracker", QuestTrackerModule, "Quest Tracker", "Quest tracker positioning and styling")
end

QuestTrackerModule.questTrackerFrame = nil

-- =============================================================================
-- MODULE ENABLED CHECK
-- =============================================================================
local function GetModuleConfig()
    return addon:GetModuleConfig("questtracker")
end

local function IsModuleEnabled()
    return addon:IsModuleEnabled("questtracker")
end

-- =============================================================================
-- CONFIG SYSTEM (DragonUI style using database)
-- =============================================================================
local function GetQuestTrackerConfig()
    if not (addon.db and addon.db.profile and addon.db.profile.questtracker) then
        return -100, -37, "TOPRIGHT", true -- defaults with show_header = true
    end
    local config = addon.db.profile.questtracker
    return config.x or -100, config.y or -37, config.anchor or "TOPRIGHT", config.show_header ~= false
end

-- =============================================================================
-- TIMER FUNCTIONS FOR 3.3.5 COMPATIBILITY
-- =============================================================================
local timerFrames = {}
local function ScheduleTimer(delay, func)
    local timerFrame = CreateFrame("Frame")
    local elapsed = 0
    timerFrame:SetScript("OnUpdate", function(self, delta)
        elapsed = elapsed + delta
        if elapsed >= delay then
            func()
            self:Hide()
            self:SetScript("OnUpdate", nil)
            timerFrames[self] = nil
        end
    end)
    timerFrame:Show()
    timerFrames[timerFrame] = true
end

-- =============================================================================
-- REPLACE BLIZZARD FRAME (WITH DELAY FIX)
-- =============================================================================
local function ReplaceBlizzardFrame(frame)
    local watchFrame = WatchFrame
    if not watchFrame then return end

    -- Hide default frame immediately to prevent visual glitches
    watchFrame:SetAlpha(0)
    watchFrame:EnableMouse(false)
    
    -- SIMPLIFIED: Only reposition, DO NOT modify internal structure
    watchFrame:SetMovable(true)
    watchFrame:SetUserPlaced(true)
    watchFrame:ClearAllPoints()
    watchFrame:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
    
    -- Show again after a short delay (critical fix for quest display)
    ScheduleTimer(0.1, function()
        watchFrame:SetAlpha(1)
        -- Do NOT re-enable mouse on WatchFrame itself: child frames (quest lines,
        -- collapse button) handle their own click events independently.
        -- Enabling mouse on the parent WatchFrame blocks clicks on the game world
        -- across its entire bounding box.
    end)
end

-- =============================================================================
-- QUEST COUNTING FUNCTIONS (FIXED - includes IsQuestWatched check)
-- =============================================================================
local function GetTrackedQuestsCount()
    local count = 0
    local success, numWatches = pcall(GetNumQuestWatches)
    if success and numWatches then
        for i = 1, numWatches do
            local questIndex = GetQuestIndexForWatch(i)
            if questIndex and IsQuestWatched(questIndex) then
                count = count + 1
            end
        end
    end
    return count
end

-- =============================================================================
-- QUEST TRACKER STYLING (NON-INTRUSIVE APPROACH)
-- =============================================================================
local function ApplyQuestTrackerStyling()
    local watchFrame = WatchFrame
    if not watchFrame or not watchFrame:IsShown() then return end
    if not WatchFrameCollapseExpandButton then return end

    -- Use fixed quest counting
    local trackedQuestsCount = GetTrackedQuestsCount()

    -- Create/update background
    watchFrame.background = watchFrame.background or watchFrame:CreateTexture(nil, 'BACKGROUND')
    local background = watchFrame.background

    -- Apply atlas texture first
    local success, err = pcall(SetAtlasTexture, background, 'QuestTracker-Header')
    if not success then
        return
    end
    
    -- Fixed header positioning (RetailUI pattern)
    -- NOTE: SetSize MUST come AFTER SetAtlasTexture because it overwrites size
    -- Use WatchFrame width to match quest tracker, maintain 8:1 aspect ratio
    local headerWidth = watchFrame:GetWidth() or 230
    local headerHeight = headerWidth / 8  -- Maintain aspect ratio (560/70 = 8)
    background:ClearAllPoints()
    background:SetPoint('RIGHT', WatchFrameCollapseExpandButton, 'RIGHT', 0, 0)
    background:SetSize(headerWidth, headerHeight)  -- Dynamic size matching WatchFrame
    background:SetAlpha(0.9)

    -- Get show_header setting
    local _, _, _, showHeader = GetQuestTrackerConfig()

    -- Show background only when there are quests and header is enabled
    if trackedQuestsCount > 0 and showHeader then
        background:Show()
    else
        background:Hide()
    end
end

-- =============================================================================
-- ENHANCED UPDATE FUNCTION WITH PROTECTION
-- =============================================================================
local updateInProgress = false
local lastUpdateTime = 0

local function ForceUpdateQuestTracker()
    if InCombatLockdown() then return end
    if updateInProgress then return end
    
    local now = GetTime()
    if now - lastUpdateTime < 0.05 then return end -- Faster updates (20/sec max)
    
    updateInProgress = true
    lastUpdateTime = now
    
    -- Restore collapse/expand state before updating
    if WatchFrame and WatchFrame.userCollapsed then
        if WatchFrame_Collapse then
            WatchFrame_Collapse(WatchFrame)
        end
    elseif WatchFrame then
        if WatchFrame_Expand then
            WatchFrame_Expand(WatchFrame)
        end
    end
    
    -- Force Blizzard tracker update
    if WatchFrame_Update then
        pcall(WatchFrame_Update)
    end
    
    -- Then apply our styling
    pcall(ApplyQuestTrackerStyling)
    
    updateInProgress = false
end

-- =============================================================================
-- POSITION UPDATE
-- =============================================================================
local function UpdateQuestTrackerPosition()
    if InCombatLockdown() then return end

    if QuestTrackerModule.questTrackerFrame then
        local x, y, anchor = GetQuestTrackerConfig()
        QuestTrackerModule.questTrackerFrame:ClearAllPoints()
        QuestTrackerModule.questTrackerFrame:SetPoint(anchor, UIParent, anchor, x, y)
    end
end

-- =============================================================================
-- DRAGONUI REFRESH FUNCTION
-- =============================================================================
function addon.RefreshQuestTracker()
    if InCombatLockdown() then return end
    if not IsModuleEnabled() then return end
    
    UpdateQuestTrackerPosition()
    ForceUpdateQuestTracker()
end

-- =============================================================================
-- INITIALIZATION 
-- =============================================================================
function QuestTrackerModule:Initialize()
    if self.initialized then return end
    
    -- Check if module is enabled
    if not IsModuleEnabled() then
        return
    end

    self.questTrackerFrame = CreateFrame('Frame', 'DragonUI_QuestTrackerFrame', UIParent)
    self.questTrackerFrame:SetSize(230, 500)
    self.questTrackerFrame:SetFrameLevel(100)
    self.questTrackerFrame:SetFrameStrata('FULLSCREEN')
    self.questTrackerFrame:EnableMouse(false)
    self.questTrackerFrame:SetMovable(false)
    
    -- Add nineslice overlay for editor mode (DragonflightUI style)
    if addon.AddNineslice then
        addon.AddNineslice(self.questTrackerFrame)
        addon.SetNinesliceState(self.questTrackerFrame, false)
        addon.HideNineslice(self.questTrackerFrame)
        -- Legacy editorTexture reference for compatibility
        self.questTrackerFrame.editorTexture = self.questTrackerFrame.NineSlice and self.questTrackerFrame.NineSlice.Center
    end
    
    -- Create text label for editor mode
    do
        local fontString = self.questTrackerFrame:CreateFontString(nil, "OVERLAY", 'GameFontNormalLarge')
        fontString:SetPoint("CENTER", self.questTrackerFrame, "CENTER", 0, 0)
        fontString:SetText("Quest Tracker")
        fontString:Hide()
        self.questTrackerFrame.editorText = fontString
    end

    -- Save original WatchFrame position for restore
    if WatchFrame then
        local point, relativeTo, relativePoint, x, y = WatchFrame:GetPoint()
        self.originalWatchFramePoint = { point, relativeTo, relativePoint, x, y }
    end

    -- Position the frame
    UpdateQuestTrackerPosition()
    
    -- Replace the frame immediately upon initialization
    ReplaceBlizzardFrame(self.questTrackerFrame)

    -- Register with Editor Mode system
    if addon.RegisterEditableFrame then
        addon:RegisterEditableFrame({
            name = "questtracker",
            frame = self.questTrackerFrame,
            blizzardFrame = WatchFrame,
            configPath = nil,  -- Use custom save logic (handled in OnDragStop)
            showTest = function()
                QuestTrackerModule:ShowEditorTest()
            end,
            hideTest = function()
                QuestTrackerModule:HideEditorTest(true)
            end,
            onHide = function()
                -- Position is already saved by OnDragStop
                -- Just update WatchFrame position after editor mode
                UpdateQuestTrackerPosition()
                ReplaceBlizzardFrame(QuestTrackerModule.questTrackerFrame)
                ForceUpdateQuestTracker()
            end,
            module = QuestTrackerModule
        })
    end

    self.initialized = true
    self.applied = true
end

-- =============================================================================
-- APPLY/RESTORE SYSTEM
-- =============================================================================
function QuestTrackerModule:ApplySystem()
    if self.applied then return end
    if InCombatLockdown() then return end
    
    if not self.initialized then
        self:Initialize()
        return
    end
    
    if self.questTrackerFrame then
        ReplaceBlizzardFrame(self.questTrackerFrame)
        UpdateQuestTrackerPosition()
        ForceUpdateQuestTracker()
    end
    
    self.applied = true
end

function QuestTrackerModule:RestoreSystem()
    if not self.applied then return end
    if InCombatLockdown() then return end
    
    -- Restore original WatchFrame position
    if WatchFrame and self.originalWatchFramePoint then
        WatchFrame:ClearAllPoints()
        local p = self.originalWatchFramePoint
        WatchFrame:SetPoint(p[1], p[2] or UIParent, p[3], p[4], p[5])
        WatchFrame:SetAlpha(1)
        WatchFrame:EnableMouse(true)
    end
    
    -- Hide our frame's background
    if WatchFrame and WatchFrame.background then
        WatchFrame.background:Hide()
    end
    
    self.applied = false
end

-- =============================================================================
-- HOOK SYSTEM WITH PROTECTION (ENHANCED)
-- =============================================================================
local hooksInstalled = false

local function InstallQuestTrackerHooks()
    -- Check that WatchFrame exists and is fully initialized
    if not WatchFrame or hooksInstalled then return end

    -- Hook WatchFrame_Collapse for width adjustment
    if WatchFrame_Collapse then
        hooksecurefunc('WatchFrame_Collapse', function(self)
            if self then
                self:SetWidth(WATCHFRAME_EXPANDEDWIDTH or 204)
            end
        end)
    end

    -- Additional hooks to ensure quests are displayed correctly
    hooksecurefunc('AddQuestWatch', function(questIndex)
        ScheduleTimer(0.05, ForceUpdateQuestTracker)
    end)

    hooksecurefunc('RemoveQuestWatch', function(questIndex)
        ScheduleTimer(0.05, ForceUpdateQuestTracker)
    end)
    
    -- Add hook for abandoning quests
    if AbandonQuest then
        hooksecurefunc('AbandonQuest', function()
            ScheduleTimer(0.05, ForceUpdateQuestTracker)
        end)
    end
    
    -- Add hook for quest log updates
    if QuestLog_Update then
        hooksecurefunc('QuestLog_Update', function()
            ScheduleTimer(0.05, ForceUpdateQuestTracker)
        end)
    end
    
    -- Hook SetCVar for wide/narrow quest tracker toggle (Interface > Display option)
    hooksecurefunc("SetCVar", function(name)
        if name == "watchFrameWidth" then
            ScheduleTimer(0.2, function()
                if not IsModuleEnabled() then return end
                -- Update wrapper frame width to match new WatchFrame width
                if WatchFrame and QuestTrackerModule.questTrackerFrame then
                    local newWidth = WatchFrame:GetWidth() or 230
                    QuestTrackerModule.questTrackerFrame:SetWidth(newWidth)
                end
                ForceUpdateQuestTracker()
            end)
        end
    end)

    hooksInstalled = true
end

-- =============================================================================
-- EDITOR MODE FUNCTIONS
-- =============================================================================
function QuestTrackerModule:ShowEditorTest()
    if self.questTrackerFrame then
        self.questTrackerFrame:SetMovable(true)
        self.questTrackerFrame:EnableMouse(true)
        self.questTrackerFrame:RegisterForDrag("LeftButton")
        
        -- Update frame size to match WatchFrame dimensions
        if WatchFrame then
            local watchWidth = WatchFrame:GetWidth() or 230
            local watchHeight = WatchFrame:GetHeight() or 200
            self.questTrackerFrame:SetSize(watchWidth, watchHeight)
        end
        
        -- Show nineslice overlay
        if self.questTrackerFrame.NineSlice and addon.ShowNineslice then
            addon.SetNinesliceState(self.questTrackerFrame, false)
            addon.ShowNineslice(self.questTrackerFrame)
        end
        
        -- Show text
        if self.questTrackerFrame.editorText then
            self.questTrackerFrame.editorText:Show()
        end

        self.questTrackerFrame:SetScript("OnDragStart", function(frame)
            frame:StartMoving()
            -- Show selected state while dragging
            if frame.NineSlice and addon.SetNinesliceState then
                addon.SetNinesliceState(frame, true)
            end
        end)

        self.questTrackerFrame:SetScript("OnDragStop", function(frame)
            frame:StopMovingOrSizing()
            -- Return to highlight state
            if frame.NineSlice and addon.SetNinesliceState then
                addon.SetNinesliceState(frame, false)
            end
            -- Calculate position relative to screen quadrant (same logic as movers system)
            local screenWidth = UIParent:GetRight()
            local screenHeight = UIParent:GetTop()
            local screenCenterX = UIParent:GetCenter()
            local cx, cy = frame:GetCenter()
            if cx and cy then
                local LEFT = screenWidth / 3
                local RIGHT = screenWidth * 2 / 3
                local TOP = screenHeight / 2
                local point, x, y
                if cy >= TOP then
                    point = "TOP"
                    y = -(screenHeight - frame:GetTop())
                else
                    point = "BOTTOM"
                    y = frame:GetBottom()
                end
                if cx >= RIGHT then
                    point = point .. "RIGHT"
                    x = frame:GetRight() - screenWidth
                elseif cx <= LEFT then
                    point = point .. "LEFT"
                    x = frame:GetLeft()
                else
                    x = cx - screenCenterX
                end
                x = math.floor(x + 0.5)
                y = math.floor(y + 0.5)
                -- Re-anchor the frame properly
                frame:ClearAllPoints()
                frame:SetPoint(point, UIParent, point, x, y)
                frame:SetUserPlaced(false)
                -- Save position to DragonUI database
                if addon.db and addon.db.profile then
                    if not addon.db.profile.questtracker then
                        addon.db.profile.questtracker = {}
                    end
                    addon.db.profile.questtracker.anchor = point
                    addon.db.profile.questtracker.x = x
                    addon.db.profile.questtracker.y = y
                end
            end
        end)
    end
end

function QuestTrackerModule:HideEditorTest(savePosition)
    if self.questTrackerFrame then
        self.questTrackerFrame:SetMovable(false)
        self.questTrackerFrame:EnableMouse(false)
        self.questTrackerFrame:SetScript("OnDragStart", nil)
        self.questTrackerFrame:SetScript("OnDragStop", nil)
        
        -- Hide nineslice overlay
        if self.questTrackerFrame.NineSlice and addon.HideNineslice then
            addon.HideNineslice(self.questTrackerFrame)
        end
        if self.questTrackerFrame.editorText then
            self.questTrackerFrame.editorText:Hide()
        end

        if savePosition then
            UpdateQuestTrackerPosition()
        end
    end
end

-- =============================================================================
-- EVENT SYSTEM (WITH DELAYED HOOK INSTALLATION)
-- =============================================================================
local function OnPlayerEnteringWorld()
    -- Check if module is enabled
    if not IsModuleEnabled() then return end
    
    -- Set up hooks after world load completion with delay (critical fix)
    if not hooksInstalled then
        ScheduleTimer(1.0, function()
            InstallQuestTrackerHooks()
            ForceUpdateQuestTracker()
        end)
    end
end

-- Quest log update handler with change detection
local lastQuestUpdate = 0
local previousQuestCount = 0

local function OnQuestLogUpdate()
    -- Check if module is enabled
    if not IsModuleEnabled() then return end
    
    local now = GetTime()
    if now - lastQuestUpdate < 0.05 then return end
    lastQuestUpdate = now
    
    -- Only update when quest count actually changes
    local currentQuestCount = GetTrackedQuestsCount()
    if currentQuestCount ~= previousQuestCount then
        previousQuestCount = currentQuestCount
        ScheduleTimer(0.05, ForceUpdateQuestTracker)
    end
end

-- Initialize module
addon.package:RegisterEvents(function()
    if IsModuleEnabled() then
        QuestTrackerModule:Initialize()
    end
end, 'PLAYER_LOGIN')

-- Register PLAYER_ENTERING_WORLD 
addon.package:RegisterEvents(OnPlayerEnteringWorld, 'PLAYER_ENTERING_WORLD')

-- Register quest log update event
addon.package:RegisterEvents(OnQuestLogUpdate, 'QUEST_LOG_UPDATE')

-- Profile change handler
if addon.core and addon.core.RegisterMessage then
    addon.core.RegisterMessage(addon, "DRAGONUI_PROFILE_CHANGED", function()
        addon.RefreshQuestTracker()
    end)
end

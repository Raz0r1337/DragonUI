local addon = select(2, ...);

--[[
================================================================================
DragonUI - Core Initialization
================================================================================
This file handles the main addon initialization using AceAddon-3.0.
Utility functions have been moved to core/api.lua
================================================================================
]]

-- Create addon object using AceAddon
addon.core = LibStub("AceAddon-3.0"):NewAddon("DragonUI", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0");

function addon.core:OnInitialize()
    -- Replace the temporary addon.db with the real AceDB
    addon.db = LibStub("AceDB-3.0"):New("DragonUIDB", addon.defaults);

    -- Force defaults to be written to profile (check for specific key that should always exist)
    if not addon.db.profile.mainbars or not addon.db.profile.mainbars.scale_actionbar then
        -- Copy all defaults to profile to ensure they exist in SavedVariables
        addon.DeepCopy(addon.defaults.profile, addon.db.profile);
    end

    -- Register callbacks for configuration changes
    addon.db.RegisterCallback(addon, "OnProfileChanged", "RefreshConfig");
    addon.db.RegisterCallback(addon, "OnProfileCopied", "RefreshConfig");
    addon.db.RegisterCallback(addon, "OnProfileReset", "RefreshConfig");

    -- Apply current profile configuration immediately
    -- This ensures the profile is loaded when the addon starts
    addon:RefreshConfig();
end

function addon.core:OnEnable()
    -- Now we can safely create and register options (after all modules are loaded)
    
    addon.options = addon:CreateOptionsTable();
    

    -- Inject AceDBOptions into the profiles section
    local profilesOptions = LibStub("AceDBOptions-3.0"):GetOptionsTable(addon.db);
    addon.options.args.profiles = profilesOptions;
    addon.options.args.profiles.order = 10;

    LibStub("AceConfig-3.0"):RegisterOptionsTable("DragonUI", addon.options);
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions("DragonUI", "DragonUI");

    -- Setup custom window size that's resistant to refreshes
    local AceConfigDialog = LibStub("AceConfigDialog-3.0")
    if AceConfigDialog then
        -- Track if user has manually resized the window
        local userHasResized = false
        local defaultWidth, defaultHeight = 900, 600

        -- Hook into the status table system that manages window state
        local function setupDragonUIWindowSize()
            local configFrame = AceConfigDialog.OpenFrames["DragonUI"]
            if configFrame and configFrame.frame then
                -- Check if user has manually resized (status table contains user's size)
                local statusWidth = configFrame.status.width
                local statusHeight = configFrame.status.height

                -- If status has size and it's different from our default, user has resized
                if statusWidth and statusHeight then
                    if statusWidth ~= defaultWidth or statusHeight ~= defaultHeight then
                        userHasResized = true
                    end
                end

                -- Only apply our custom size if user hasn't manually resized
                if not userHasResized then
                    configFrame.frame:SetWidth(defaultWidth)
                    configFrame.frame:SetHeight(defaultHeight)
                    configFrame.frame:ClearAllPoints()
                    configFrame.frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)

                    -- Update AceGUI's internal size tracking
                    configFrame.status.width = defaultWidth
                    configFrame.status.height = defaultHeight
                else
                    -- User has resized, just maintain their size and center position
                    configFrame.frame:ClearAllPoints()
                    configFrame.frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
                end
            end
        end

        -- Hook the status table application (runs on every refresh)
        local originalSetStatusTable = AceConfigDialog.SetStatusTable
        AceConfigDialog.SetStatusTable = function(self, appName, statusTable)
            local result = originalSetStatusTable(self, appName, statusTable)

            if appName == "DragonUI" then
                -- Apply our custom size after status is set
                setupDragonUIWindowSize()
            end

            return result
        end

        -- Hook the initial Open to set size immediately
        local originalOpen = AceConfigDialog.Open
        AceConfigDialog.Open = function(self, appName, ...)
            local result = originalOpen(self, appName, ...)

            if appName == "DragonUI" then
                -- Reset user resize flag on new window opening
                userHasResized = false
                -- Apply size IMMEDIATELY without delay
                setupDragonUIWindowSize()
            end

            return result
        end
    end

    -- Register slash commands (using new commands.lua system)
    if addon.LoadCommands then
        addon.LoadCommands()
    else
        -- Fallback to legacy registration
        self:RegisterChatCommand("dragonui", "SlashCommand")
        self:RegisterChatCommand("pi", "SlashCommand")
    end

    -- Fire custom event to signal that DragonUI is fully initialized
    -- This ensures modules get the correct config values
    self:SendMessage("DRAGONUI_READY");
end

-- Callback function that refreshes all modules when configuration changes
function addon:RefreshConfig()
    -- Initialize cooldown system if it hasn't been already
    if addon.InitializeCooldowns then
        addon.InitializeCooldowns()
    end

    local failed = {};

    -- List of refresh functions to call
    local refreshFunctions = {
        "RefreshMainbars",
        "RefreshButtons",
        "RefreshMicromenu",
        "RefreshMinimap",
        "RefreshTargetFrame",
        "RefreshFocusFrame",
        "RefreshPartyFrames",
        "RefreshStance",
        "RefreshPetbar",
        "RefreshVehicle",
        "RefreshMulticast",
        "RefreshCooldowns",
        "RefreshXpBarPosition",
        "RefreshRepBarPosition",
        "RefreshMinimapTime",
        "RefreshBuffFrame"
    }

    -- Try to apply each configuration and track failures
    for _, funcName in ipairs(refreshFunctions) do
        if addon[funcName] then
            local success, err = pcall(addon[funcName])
            if not success then
                table.insert(failed, funcName)
            end
        end
    end

    -- If some configurations failed, retry them after 2 seconds
    if #failed > 0 then
        addon.core:ScheduleTimer(function()
            for _, funcName in ipairs(failed) do
                if addon[funcName] then
                    pcall(addon[funcName]);
                end
            end
        end, 2);
    end
end

-- Legacy SlashCommand handler (fallback if commands.lua not loaded)
function addon.core:SlashCommand(input)
    -- Delegate to new command system if available
    if addon.CommandHandlers then
        if not input or input:trim() == "" then
            addon.CommandHandlers.OpenConfig()
        elseif input:lower() == "config" then
            addon.CommandHandlers.OpenConfig()
        elseif input:lower() == "edit" or input:lower() == "editor" then
            addon.CommandHandlers.ToggleEditorMode()
        elseif input:lower() == "help" then
            addon.CommandHandlers.ShowHelp()
        else
            addon.CommandHandlers.ShowHelp()
        end
    else
        -- Original fallback
        if not input or input:trim() == "" then
            LibStub("AceConfigDialog-3.0"):Open("DragonUI")
        elseif input:lower() == "config" then
            LibStub("AceConfigDialog-3.0"):Open("DragonUI")
        elseif input:lower() == "edit" or input:lower() == "editor" then
            if addon.EditorMode then
                addon.EditorMode:Toggle()
            else
                addon:Print("Editor mode not available.")
            end
        else
            addon:Print("Commands: /dragonui config, /dragonui edit")
        end
    end
end

print("|cFF00FF00[DragonUI]|r Core loaded")

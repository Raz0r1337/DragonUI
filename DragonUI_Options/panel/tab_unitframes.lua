--[[
================================================================================
DragonUI Options Panel - Unit Frames Tab
================================================================================
Player, target, focus, pet, party, ToT, ToF unit frame options.
Sub-tabs for each frame type.
================================================================================
]]

local addon = DragonUI
if not addon then return end

local C = addon.PanelControls
local Panel = addon.OptionsPanel

-- ============================================================================
-- SHARED VALUES
-- ============================================================================

local textFormatValues = {
    numeric    = "Current Value",
    percentage = "Percentage",
    both       = "Numbers + %",
    formatted  = "Current / Max",
}

local dragonValues = {
    none      = "None",
    elite     = "Elite (Golden)",
    rareelite = "RareElite (Winged)",
}

local alternateManaFormatValues = {
    numeric    = "Current Value",
    formatted  = "Current / Max",
    percentage = "Percentage",
    both       = "Percentage + Current/Max",
}

local partyOrientationValues = {
    vertical   = "Vertical",
    horizontal = "Horizontal",
}

-- ============================================================================
-- ACTIVE SUB-TAB STATE
-- ============================================================================

local activeSubTab = "player"

local subTabs = {
    { key = "player",  label = "Player" },
    { key = "target",  label = "Target" },
    { key = "focus",   label = "Focus" },
    { key = "pet",     label = "Pet" },
    { key = "tot",     label = "ToT / ToF" },
    { key = "party",   label = "Party" },
}

-- ============================================================================
-- COMMON CONTROLS BUILDER
-- ============================================================================

local function AddCommonControls(parent, unitKey, refreshFunc, opts)
    opts = opts or {}

    C:AddSlider(parent, {
        label = "Scale",
        dbPath = "unitframe." .. unitKey .. ".scale",
        min = 0.5, max = 2.0, step = 0.1,
        width = 200,
        callback = refreshFunc,
    })

    C:AddToggle(parent, {
        label = "Class Color Health",
        dbPath = "unitframe." .. unitKey .. ".classcolor",
        callback = refreshFunc,
    })

    if opts.hasClassPortrait then
        C:AddToggle(parent, {
            label = "Class Portrait",
            desc = "Class icon instead of 3D model for players.",
            dbPath = "unitframe." .. unitKey .. ".classPortrait",
            callback = refreshFunc,
        })
    end

    C:AddToggle(parent, {
        label = "Format Large Numbers",
        dbPath = "unitframe." .. unitKey .. ".breakUpLargeNumbers",
        callback = refreshFunc,
    })

    C:AddDropdown(parent, {
        label = "Text Format",
        dbPath = "unitframe." .. unitKey .. ".textFormat",
        values = textFormatValues,
        callback = refreshFunc,
    })

    C:AddToggle(parent, {
        label = "Always Show Health Text",
        dbPath = "unitframe." .. unitKey .. ".showHealthTextAlways",
        callback = refreshFunc,
    })

    C:AddToggle(parent, {
        label = "Always Show Mana Text",
        dbPath = "unitframe." .. unitKey .. ".showManaTextAlways",
        callback = refreshFunc,
    })

    if opts.hasThreatGlow then
        C:AddToggle(parent, {
            label = "Threat Glow",
            dbPath = "unitframe." .. unitKey .. ".enableThreatGlow",
            callback = refreshFunc,
        })
    end
end

-- ============================================================================
-- SUB-TAB BUILDERS
-- ============================================================================

local function BuildPlayerSection(scroll)
    local refreshPlayer = function()
        if addon.PlayerFrame and addon.PlayerFrame.RefreshPlayerFrame then
            addon.PlayerFrame.RefreshPlayerFrame()
        end
    end

    local s = C:AddSection(scroll, "Player Frame")
    AddCommonControls(s, "player", refreshPlayer, {
        hasClassPortrait = true,
    })

    C:AddDropdown(s, {
        label = "Dragon Decoration",
        dbPath = "unitframe.player.dragon_decoration",
        values = dragonValues,
        callback = refreshPlayer,
    })

    -- Glow Effects
    C:AddHeading(s, "Glow Effects")

    C:AddToggle(s, {
        label = "Show Rest Glow",
        desc = "Golden glow around the player frame when resting (inn or city). Works with all frame modes.",
        dbPath = "unitframe.player.show_rest_glow",
        callback = refreshPlayer,
    })

    -- Alternate mana (druid)
    C:AddHeading(s, "Alternate Mana (Druid)")

    C:AddToggle(s, {
        label = "Always Show",
        desc = "Druid mana text visible at all times, not just on hover.",
        dbPath = "unitframe.player.alwaysShowAlternateManaText",
        callback = refreshPlayer,
    })

    C:AddDropdown(s, {
        label = "Text Format",
        dbPath = "unitframe.player.alternateManaFormat",
        values = alternateManaFormatValues,
        callback = refreshPlayer,
    })

    -- Fat Health Bar
    C:AddHeading(s, "Fat Health Bar")

    C:AddToggle(s, {
        label = "Enable",
        desc = "Full-width health bar. Auto-disabled in vehicles.",
        dbPath = "unitframe.player.fat_healthbar",
        callback = function(val)
            refreshPlayer()
            -- Rebuild tab so disabled states on mana controls update
            Panel:SelectTab("unitframes")
        end,
    })

    C:AddToggle(s, {
        label = "Hide Mana Bar",
        desc = "Completely hide the mana bar when Fat Health Bar is active.",
        dbPath = "unitframe.player.fat_manabar_hidden",
        disabled = function()
            return not C:GetDBValue("unitframe.player.fat_healthbar")
        end,
        callback = function(val)
            refreshPlayer()
            Panel:SelectTab("unitframes")
        end,
    })

    C:AddSlider(s, {
        label = "Mana Bar Width",
        dbPath = "unitframe.player.fat_manabar_width",
        min = 50, max = 300, step = 1,
        width = 200,
        disabled = function()
            return not C:GetDBValue("unitframe.player.fat_healthbar")
        end,
        callback = refreshPlayer,
    })

    C:AddSlider(s, {
        label = "Mana Bar Height",
        dbPath = "unitframe.player.fat_manabar_height",
        min = 4, max = 30, step = 1,
        width = 200,
        disabled = function()
            return not C:GetDBValue("unitframe.player.fat_healthbar")
        end,
        callback = refreshPlayer,
    })

    C:AddDropdown(s, {
        label = "Mana Bar Texture",
        desc = "Choose the texture style for the power/mana bar. Only applies in Fat Health Bar mode.",
        dbPath = "unitframe.player.manabar_texture",
        values = {
            dragonui       = "DragonUI (Default)",
            blizzard       = "Blizzard Classic",
            blizzard_flat  = "Flat Solid",
            smooth         = "Smooth",
            aluminium      = "Aluminium",
            litestep       = "LiteStep",
        },
        disabled = function()
            return not C:GetDBValue("unitframe.player.fat_healthbar")
        end,
        callback = function()
            refreshPlayer()
            Panel:SelectTab("unitframes")
        end,
    })

    -- Power bar color pickers (only visible when using override textures in fat mode)
    local isFat = C:GetDBValue("unitframe.player.fat_healthbar")
    local texSetting = C:GetDBValue("unitframe.player.manabar_texture") or "dragonui"
    local showColors = isFat and texSetting ~= "dragonui"

    if showColors then
        C:AddHeading(s, "Power Bar Colors")

        local powerColorEntries = {
            { key = "MANA",        label = "Mana" },
            { key = "RAGE",        label = "Rage" },
            { key = "ENERGY",      label = "Energy" },
            { key = "FOCUS",       label = "Focus" },
            { key = "RUNIC_POWER", label = "Runic Power" },
            { key = "HAPPINESS",   label = "Happiness" },
            { key = "RUNES",       label = "Runes" },
        }

        for _, entry in ipairs(powerColorEntries) do
            C:AddColorPicker(s, {
                label = entry.label,
                dbPath = "unitframe.player.power_colors." .. entry.key,
                hasAlpha = false,
                callback = function() refreshPlayer() end,
            })
        end

        C:AddButton(s, {
            label = "Reset Colors to Default",
            width = 200,
            callback = function()
                local defaults = {
                    MANA         = { r = 0.02, g = 0.32, b = 0.71 },
                    RAGE         = { r = 1.00, g = 0.00, b = 0.00 },
                    FOCUS        = { r = 1.00, g = 0.50, b = 0.25 },
                    ENERGY       = { r = 1.00, g = 1.00, b = 0.00 },
                    HAPPINESS    = { r = 0.00, g = 1.00, b = 1.00 },
                    RUNES        = { r = 0.50, g = 0.50, b = 0.50 },
                    RUNIC_POWER  = { r = 0.00, g = 0.82, b = 1.00 },
                }
                C:SetDBValue("unitframe.player.power_colors", defaults)
                refreshPlayer()
                Panel:SelectTab("unitframes")
            end,
        })
    end
end

local function BuildTargetSection(scroll)
    local refreshTarget = function()
        if addon.TargetFrame and addon.TargetFrame.RefreshTargetFrame then
            addon.TargetFrame.RefreshTargetFrame()
        end
    end

    local s = C:AddSection(scroll, "Target Frame")
    AddCommonControls(s, "target", refreshTarget, {
        hasClassPortrait = true,
    })
end

local function BuildFocusSection(scroll)
    local refreshFocus = function()
        if addon.RefreshFocusFrame then addon.RefreshFocusFrame() end
    end

    local s = C:AddSection(scroll, "Focus Frame")
    AddCommonControls(s, "focus", refreshFocus, {
        hasClassPortrait = true,
    })

    C:AddToggle(s, {
        label = "Override Position",
        dbPath = "unitframe.focus.override",
        callback = refreshFocus,
    })
end

local function BuildPetSection(scroll)
    local refreshPet = function()
        if addon.RefreshPetFrame then addon.RefreshPetFrame() end
    end

    local s = C:AddSection(scroll, "Pet Frame")

    C:AddSlider(s, {
        label = "Scale",
        dbPath = "unitframe.pet.scale",
        min = 0.5, max = 2.0, step = 0.1,
        width = 200,
        callback = refreshPet,
    })

    C:AddDropdown(s, {
        label = "Text Format",
        dbPath = "unitframe.pet.textFormat",
        values = textFormatValues,
        callback = refreshPet,
    })

    C:AddToggle(s, {
        label = "Format Large Numbers",
        dbPath = "unitframe.pet.breakUpLargeNumbers",
        callback = refreshPet,
    })

    C:AddToggle(s, {
        label = "Always Show Health Text",
        dbPath = "unitframe.pet.showHealthTextAlways",
        callback = refreshPet,
    })

    C:AddToggle(s, {
        label = "Always Show Mana Text",
        dbPath = "unitframe.pet.showManaTextAlways",
        callback = refreshPet,
    })

    C:AddToggle(s, {
        label = "Threat Glow",
        dbPath = "unitframe.pet.enableThreatGlow",
        callback = refreshPet,
    })

    C:AddHeading(s, "Position")

    C:AddToggle(s, {
        label = "Override Position",
        desc = "Move the pet frame independently from the player frame.",
        dbPath = "unitframe.pet.override",
        callback = refreshPet,
    })

    C:AddSlider(s, {
        label = "X Position",
        dbPath = "unitframe.pet.x",
        min = -2500, max = 2500, step = 1,
        width = 200,
        disabled = function()
            return not C:GetDBValue("unitframe.pet.override")
        end,
        callback = refreshPet,
    })

    C:AddSlider(s, {
        label = "Y Position",
        dbPath = "unitframe.pet.y",
        min = -2500, max = 2500, step = 1,
        width = 200,
        disabled = function()
            return not C:GetDBValue("unitframe.pet.override")
        end,
        callback = refreshPet,
    })
end

local function BuildToTSection(scroll)
    local refreshToT = function()
        if addon.TargetOfTarget and addon.TargetOfTarget.RefreshToTFrame then
            addon.TargetOfTarget.RefreshToTFrame()
        end
    end

    local tot = C:AddSection(scroll, "Target of Target")
    C:AddDescription(tot,
        "Follows the Target frame by default. Move it in Editor Mode (|cffffd700/dragonui edit|r) to detach and position freely.")

    C:AddSlider(tot, {
        label = "Scale",
        dbPath = "unitframe.tot.scale",
        min = 0.5, max = 2.0, step = 0.1,
        width = 200,
        callback = refreshToT,
    })

    C:AddToggle(tot, {
        label = "Class Color Health",
        dbPath = "unitframe.tot.classcolor",
        callback = refreshToT,
    })

    -- Attachment status indicator
    local totOverride = C:GetDBValue("unitframe.tot.override")
    if totOverride then
        C:AddDescription(tot, "|cff1784d1\226\151\143 Detached|r \226\128\148 positioned freely via Editor Mode")
    else
        C:AddDescription(tot, "|cffaaaaaa\226\151\143 Attached|r \226\128\148 follows Target frame")
    end

    -- Re-attach button (only useful when detached)
    C:AddButton(tot, {
        label = "Re-attach to Target",
        width = 200,
        disabled = function() return not C:GetDBValue("unitframe.tot.override") end,
        callback = function()
            if addon.TargetOfTarget and addon.TargetOfTarget.Reset then
                addon.TargetOfTarget.Reset()
            end
            Panel:SelectTab("unitframes")
        end,
    })

    -- ====================================================================
    -- Target of Focus
    -- ====================================================================
    local refreshToF = function()
        if addon.TargetOfFocus and addon.TargetOfFocus.RefreshToFFrame then
            addon.TargetOfFocus.RefreshToFFrame()
        end
    end

    local fot = C:AddSection(scroll, "Target of Focus")
    C:AddDescription(fot,
        "Follows the Focus frame by default. Move it in Editor Mode (|cffffd700/dragonui edit|r) to detach and position freely.")

    C:AddSlider(fot, {
        label = "Scale",
        dbPath = "unitframe.fot.scale",
        min = 0.5, max = 2.0, step = 0.1,
        width = 200,
        callback = refreshToF,
    })

    C:AddToggle(fot, {
        label = "Class Color Health",
        dbPath = "unitframe.fot.classcolor",
        callback = refreshToF,
    })

    -- Attachment status indicator
    local fotOverride = C:GetDBValue("unitframe.fot.override")
    if fotOverride then
        C:AddDescription(fot, "|cff1784d1\226\151\143 Detached|r \226\128\148 positioned freely via Editor Mode")
    else
        C:AddDescription(fot, "|cffaaaaaa\226\151\143 Attached|r \226\128\148 follows Focus frame")
    end

    -- Re-attach button (only useful when detached)
    C:AddButton(fot, {
        label = "Re-attach to Focus",
        width = 200,
        disabled = function() return not C:GetDBValue("unitframe.fot.override") end,
        callback = function()
            if addon.TargetOfFocus and addon.TargetOfFocus.Reset then
                addon.TargetOfFocus.Reset()
            end
            Panel:SelectTab("unitframes")
        end,
    })
end

local function BuildPartySection(scroll)
    local refreshParty = function()
        if addon.RefreshPartyFrames then addon.RefreshPartyFrames() end
    end

    local s = C:AddSection(scroll, "Party Frames")

    C:AddSlider(s, {
        label = "Scale",
        dbPath = "unitframe.party.scale",
        min = 0.5, max = 2.0, step = 0.1,
        width = 200,
        callback = refreshParty,
    })

    C:AddToggle(s, {
        label = "Class Color Health",
        dbPath = "unitframe.party.classcolor",
        callback = refreshParty,
    })

    C:AddToggle(s, {
        label = "Format Large Numbers",
        dbPath = "unitframe.party.breakUpLargeNumbers",
        callback = refreshParty,
    })

    C:AddToggle(s, {
        label = "Always Show Health Text",
        dbPath = "unitframe.party.showHealthTextAlways",
        callback = refreshParty,
    })

    C:AddToggle(s, {
        label = "Always Show Mana Text",
        dbPath = "unitframe.party.showManaTextAlways",
        callback = refreshParty,
    })

    C:AddDropdown(s, {
        label = "Text Format",
        dbPath = "unitframe.party.textFormat",
        values = textFormatValues,
        callback = refreshParty,
    })

    C:AddDropdown(s, {
        label = "Orientation",
        dbPath = "unitframe.party.orientation",
        values = partyOrientationValues,
        callback = refreshParty,
    })

    C:AddSlider(s, {
        label = "Vertical Padding",
        desc = "Space between party frames in vertical mode.",
        dbPath = "unitframe.party.padding_vertical",
        min = 10, max = 150, step = 1,
        width = 200,
        callback = refreshParty,
    })

    C:AddSlider(s, {
        label = "Horizontal Padding",
        desc = "Space between party frames in horizontal mode.",
        dbPath = "unitframe.party.padding_horizontal",
        min = 10, max = 150, step = 1,
        width = 200,
        callback = refreshParty,
    })
end

-- ============================================================================
-- SUB-TAB DISPATCH
-- ============================================================================

local subTabBuilders = {
    player = BuildPlayerSection,
    target = BuildTargetSection,
    focus  = BuildFocusSection,
    pet    = BuildPetSection,
    tot    = BuildToTSection,
    party  = BuildPartySection,
}

-- ============================================================================
-- MAIN TAB BUILDER
-- ============================================================================

local function BuildUnitframesTab(scroll)
    C:AddSubTabs(scroll, subTabs, activeSubTab, function(key)
        activeSubTab = key
        Panel:SelectTab("unitframes")
    end)

    local builder = subTabBuilders[activeSubTab]
    if builder then
        builder(scroll)
    end
end

-- Register the tab
Panel:RegisterTab("unitframes", "Unit Frames", BuildUnitframesTab, 6)

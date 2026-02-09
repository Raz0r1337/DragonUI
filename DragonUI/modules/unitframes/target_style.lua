--[[
  DragonUI - Target-Style Unit Frame Factory (target_style.lua)

  Closure factory for target-style unit frames (Target, Focus).
  Loaded after uf_core.lua, before target.lua and focus.lua.
]]

local _, addon = ...
local UF = addon.UF

UF.TargetStyle = {}

-- ============================================================================
-- FACTORY
-- ============================================================================

function UF.TargetStyle.Create(opts)
    -- ----------------------------------------------------------------
    -- Module table
    -- ----------------------------------------------------------------
    local Module = {
        overlay       = nil,    -- Editor overlay frame
        textSystem    = nil,    -- TextSystem reference
        initialized   = false,  -- ADDON_LOADED has fired
        configured    = false,  -- Frame setup is complete
        eventsFrame   = nil,    -- Event handler frame
    }

    -- ----------------------------------------------------------------
    -- Local aliases from opts
    -- ----------------------------------------------------------------
    local configKey       = opts.configKey
    local unitToken       = opts.unitToken
    local widgetKey       = opts.widgetKey or configKey
    local combatQueueKey  = opts.combatQueueKey or (configKey .. "_position")
    local BlizzFrame      = opts.blizzFrame
    local HealthBar       = opts.healthBar
    local ManaBar         = opts.manaBar
    local Portrait        = opts.portrait
    local NameText        = opts.nameText
    local LevelText       = opts.levelText
    local NameBackground  = opts.nameBackground
    local namePrefix      = opts.namePrefix
    local defaultPos      = opts.defaultPos

    -- Shared texture / constant tables from uf_core
    local TEXTURES    = UF.TEXTURES.targetStyle
    local BOSS_COORDS = UF.BOSS_COORDS.targetStyle
    local POWER_MAP   = UF.POWER_MAP

    -- ----------------------------------------------------------------
    -- Frame elements & throttle cache
    -- ----------------------------------------------------------------
    local frameElements = {
        background    = nil,
        border        = nil,
        elite         = nil,
        threatNumeric = nil,
    }

    local updateCache = {
        lastHealthUpdate  = 0,
        lastPowerUpdate   = 0,
        lastThreatUpdate  = 0,
        lastFamousMessage = 0,
        lastFamousTarget  = nil,
    }

    -- Class portrait overlays (lazy-created)
    local classPortraitBg   = nil
    local classPortraitIcon = nil

    -- ================================================================
    -- CONFIG
    -- ================================================================

    local function GetConfig()
        return UF.GetConfig(configKey)
    end

    -- ================================================================
    -- WIDGET POSITION
    -- ================================================================

    local function ApplyWidgetPosition()
        if not Module.overlay then return end
        if InCombatLockdown() then
            if addon.CombatQueue then
                addon.CombatQueue:Add(combatQueueKey, ApplyWidgetPosition)
            end
            return
        end

        local wc = addon.db and addon.db.profile.widgets
                    and addon.db.profile.widgets[widgetKey]
        if wc then
            Module.overlay:ClearAllPoints()
            Module.overlay:SetPoint(
                wc.anchor or defaultPos.anchor, UIParent,
                wc.anchor or defaultPos.anchor,
                wc.posX   or defaultPos.posX,
                wc.posY   or defaultPos.posY)
            BlizzFrame:ClearAllPoints()
            BlizzFrame:SetPoint("CENTER", Module.overlay, "CENTER", 20, -7)
        else
            Module.overlay:ClearAllPoints()
            Module.overlay:SetPoint(
                defaultPos.anchor, UIParent, defaultPos.anchor,
                defaultPos.posX, defaultPos.posY)
            BlizzFrame:ClearAllPoints()
            BlizzFrame:SetPoint("CENTER", Module.overlay, "CENTER", 0, 0)
        end
    end

    -- ================================================================
    -- VISIBILITY
    -- ================================================================

    local function ShouldBeVisible()
        return UnitExists(unitToken)
    end

    local function ShowFrameTest()
        if BlizzFrame and BlizzFrame.ShowTest then
            BlizzFrame:ShowTest()
        end
    end

    local function HideFrameTest()
        if BlizzFrame and BlizzFrame.HideTest then
            BlizzFrame:HideTest()
        end
    end

    -- ================================================================
    -- CLASS PORTRAIT
    -- ================================================================

    local function UpdateClassPortrait()
        local config = GetConfig()
        if not config then return end

        if config.classPortrait and UnitExists(unitToken)
           and UnitIsPlayer(unitToken) then
            local _, classFileName = UnitClass(unitToken)
            if classFileName and CLASS_ICON_TCOORDS
               and CLASS_ICON_TCOORDS[classFileName] then
                local coords = CLASS_ICON_TCOORDS[classFileName]

                -- Lazy-create background circle
                if not classPortraitBg then
                    classPortraitBg = BlizzFrame:CreateTexture(nil, "BACKGROUND", nil, 1)
                    classPortraitBg:SetTexture(
                        "Interface\\CHARACTERFRAME\\TempPortraitAlphaMask")
                    classPortraitBg:SetVertexColor(0, 0, 0, 1)
                end

                -- Lazy-create class icon
                if not classPortraitIcon then
                    classPortraitIcon = BlizzFrame:CreateTexture(nil, "ARTWORK", nil, 1)
                    classPortraitIcon:SetTexture(UF.TEXTURES.CLASS_ICON)
                end

                -- Position & show
                classPortraitBg:ClearAllPoints()
                classPortraitBg:SetPoint("CENTER", Portrait, "CENTER", 0, 0)
                classPortraitBg:SetSize(56, 56)
                classPortraitBg:Show()

                classPortraitIcon:ClearAllPoints()
                classPortraitIcon:SetPoint("CENTER", Portrait, "CENTER", 0, 0)
                classPortraitIcon:SetSize(56, 56)
                classPortraitIcon:SetTexCoord(
                    coords[1], coords[2], coords[3], coords[4])
                classPortraitIcon:Show()

                Portrait:SetAlpha(0)
            end
        else
            -- Disable: hide overlay, restore native portrait
            if classPortraitBg  then classPortraitBg:Hide()  end
            if classPortraitIcon then classPortraitIcon:Hide() end
            if UnitExists(unitToken) then
                SetPortraitTexture(Portrait, unitToken)
                Portrait:SetTexCoord(0, 1, 0, 1)
            end
            Portrait:SetAlpha(1)
        end
    end

    -- ================================================================
    -- HEALTH BAR COLOR
    -- ================================================================

    local function UpdateHealthBarColor()
        if not UnitExists(unitToken) or not HealthBar then return end

        local config  = GetConfig()
        local texture = HealthBar:GetStatusBarTexture()
        if not texture then return end

        if config.classcolor and UnitIsPlayer(unitToken) then
            local statusPath = TEXTURES.BAR_PREFIX .. "Health-Status"
            if texture:GetTexture() ~= statusPath then
                texture:SetTexture(statusPath)
                texture:SetDrawLayer("ARTWORK", 1)
            end
            local _, class = UnitClass(unitToken)
            local color = RAID_CLASS_COLORS[class]
            if color then
                texture:SetVertexColor(color.r, color.g, color.b, 1)
            else
                texture:SetVertexColor(1, 1, 1, 1)
            end
        else
            local normalPath = TEXTURES.BAR_PREFIX .. "Health"
            if texture:GetTexture() ~= normalPath then
                texture:SetTexture(normalPath)
                texture:SetDrawLayer("ARTWORK", 1)
            end
            texture:SetVertexColor(1, 1, 1, 1)
        end
    end

    -- ================================================================
    -- POWER BAR FORCE UPDATE
    -- ================================================================

    local function ForceUpdatePowerBar()
        if not UnitExists(unitToken) or not ManaBar then return end
        local texture = ManaBar:GetStatusBarTexture()
        if not texture then return end

        local powerType = UnitPowerType(unitToken)
        local powerName = POWER_MAP[powerType] or "Mana"
        texture:SetTexture(TEXTURES.BAR_PREFIX .. powerName)
        texture:SetDrawLayer("ARTWORK", 1)
        texture:SetVertexColor(1, 1, 1)

        local _, max = ManaBar:GetMinMaxValues()
        local current = ManaBar:GetValue()
        if max > 0 and current then
            texture:SetTexCoord(0, current / max, 0, 1)
        end
    end

    -- ================================================================
    -- LAYOUT REAPPLY
    -- ================================================================
    -- Overrides Blizzard element repositioning that occurs for special
    -- units (bosses, vehicles). Used by target; not needed for focus.

    local function ForceReapplyLayout()
        if Portrait then
            Portrait:ClearAllPoints()
            Portrait:SetSize(56, 56)
            Portrait:SetPoint("TOPRIGHT", BlizzFrame, "TOPRIGHT", -47, -15)
        end
        if HealthBar then
            HealthBar:ClearAllPoints()
            HealthBar:SetSize(125, 20)
            HealthBar:SetPoint("RIGHT", Portrait, "LEFT", -1, 0)
        end
        if ManaBar then
            ManaBar:ClearAllPoints()
            ManaBar:SetSize(132, 9)
            ManaBar:SetPoint("RIGHT", Portrait, "LEFT", 6.5, -16.5)
        end
        if NameText then
            NameText:ClearAllPoints()
            NameText:SetPoint("BOTTOM", HealthBar, "TOP", 10, 3)
        end
        if LevelText then
            LevelText:ClearAllPoints()
            LevelText:SetPoint("BOTTOMRIGHT", HealthBar, "TOPLEFT", 18, 3)
        end
        if NameBackground then
            NameBackground:ClearAllPoints()
            NameBackground:SetPoint("BOTTOMLEFT", HealthBar, "TOPLEFT", -2, -5)
        end
    end

    -- ================================================================
    -- BAR HOOKS
    -- ================================================================

    local function SetupBarHooks()
        -- Health bar hooks (once)
        if not HealthBar.DragonUI_Setup then
            local ht = HealthBar:GetStatusBarTexture()
            if ht then ht:SetDrawLayer("ARTWORK", 1) end

            hooksecurefunc(HealthBar, "SetValue", function(self)
                if not UnitExists(unitToken) then return end
                local now = GetTime()
                if now - updateCache.lastHealthUpdate < 0.05 then return end
                updateCache.lastHealthUpdate = now

                UpdateHealthBarColor()

                local texture = self:GetStatusBarTexture()
                if texture then
                    local _, max = self:GetMinMaxValues()
                    local cur = self:GetValue()
                    if max > 0 and cur then
                        texture:SetTexCoord(0, cur / max, 0, 1)
                    end
                end
            end)
            HealthBar.DragonUI_Setup = true
        end

        -- Power bar hooks (once)
        if not ManaBar.DragonUI_Setup then
            local pt = ManaBar:GetStatusBarTexture()
            if pt then pt:SetDrawLayer("ARTWORK", 1) end

            -- Force white on any color change attempt
            hooksecurefunc(ManaBar, "SetStatusBarColor", function(self)
                local texture = self:GetStatusBarTexture()
                if texture then texture:SetVertexColor(1, 1, 1, 1) end
            end)
            ManaBar:SetStatusBarColor(1, 1, 1, 1)

            -- Update texture & coords on every value change
            hooksecurefunc(ManaBar, "SetValue", function(self)
                if not UnitExists(unitToken) then return end
                local texture = self:GetStatusBarTexture()
                if not texture then return end

                local powerType = UnitPowerType(unitToken)
                local powerName = POWER_MAP[powerType] or "Mana"
                texture:SetTexture(TEXTURES.BAR_PREFIX .. powerName)
                texture:SetDrawLayer("ARTWORK", 1)
                texture:SetVertexColor(1, 1, 1)
                ManaBar:SetStatusBarColor(1, 1, 1)

                local _, max = self:GetMinMaxValues()
                local cur = self:GetValue()
                if max > 0 and cur then
                    texture:SetTexCoord(0, cur / max, 0, 1)
                end
            end)
            ManaBar.DragonUI_Setup = true
        end

        -- Portrait hook for class portrait
        if not BlizzFrame.DragonUI_PortraitHook then
            hooksecurefunc("UnitFramePortrait_Update", function(frame, unit)
                if frame == BlizzFrame and unit == unitToken then
                    UpdateClassPortrait()
                end
            end)
            BlizzFrame.DragonUI_PortraitHook = true
        end

        -- Hook afterBarHooks callback if provided
        if opts.afterBarHooks then
            opts.afterBarHooks(Module, ManaBar, GetConfig, updateCache)
        end
    end

    -- ================================================================
    -- THREAT SYSTEM
    -- ================================================================

    local function UpdateThreat()
        if not UnitExists(unitToken) then
            if frameElements.threatNumeric then
                frameElements.threatNumeric:Hide()
            end
            return
        end

        local status = UnitThreatSituation("player", unitToken)
        local level  = status and math.min(status, 3) or 0

        if level > 0 then
            local _, _, _, pct = UnitDetailedThreatSituation("player", unitToken)
            if frameElements.threatNumeric and pct and pct > 0 then
                local displayPct = math.floor(math.min(100, math.max(0, pct)))
                frameElements.threatNumeric.text:SetText(displayPct .. "%")
                if level == 1 then
                    frameElements.threatNumeric.text:SetTextColor(1.0, 1.0, 0.47)
                elseif level == 2 then
                    frameElements.threatNumeric.text:SetTextColor(1.0, 0.6, 0.0)
                else
                    frameElements.threatNumeric.text:SetTextColor(1.0, 0.0, 0.0)
                end
                frameElements.threatNumeric:Show()
            else
                if frameElements.threatNumeric then
                    frameElements.threatNumeric:Hide()
                end
            end
        else
            if frameElements.threatNumeric then
                frameElements.threatNumeric:Hide()
            end
        end
    end

    -- ================================================================
    -- CLASSIFICATION SYSTEM
    -- ================================================================

    local function UpdateClassification()
        if not UnitExists(unitToken) or not frameElements.elite then
            if frameElements.elite then frameElements.elite:Hide() end
            return
        end

        -- Vehicle override
        if UnitVehicleSeatCount and UnitVehicleSeatCount(unitToken) > 0 then
            frameElements.elite:Hide()
            return
        end

        local classification = UnitClassification(unitToken)
        local name   = UnitName(unitToken)
        local coords = nil

        if classification == "worldboss" or classification == "elite" then
            coords = BOSS_COORDS.elite
        elseif classification == "rareelite" then
            coords = BOSS_COORDS.rareelite
        elseif classification == "rare" then
            coords = BOSS_COORDS.rare
        else
            -- Famous NPC override
            if name and UF.FAMOUS_NPCS[name] then
                coords = BOSS_COORDS.elite
                -- Per-module callback (e.g. message throttle)
                if opts.onFamousNpc then
                    opts.onFamousNpc(name, updateCache)
                end
            else
                -- Skull-level = boss
                local unitLevel = UnitLevel(unitToken)
                if unitLevel == -1 then
                    coords = BOSS_COORDS.elite
                end
            end
        end

        if coords then
            frameElements.elite:SetTexCoord(
                coords[1], coords[2], coords[3], coords[4])
            frameElements.elite:SetSize(coords[5], coords[6])
            frameElements.elite:SetPoint(
                "CENTER", Portrait, "CENTER", coords[7], coords[8])
            frameElements.elite:Show()
        else
            frameElements.elite:Hide()
        end
    end

    -- ================================================================
    -- NAME BACKGROUND
    -- ================================================================

    local function UpdateNameBackground()
        if not NameBackground then return end
        if not UnitExists(unitToken) then
            NameBackground:Hide()
            return
        end

        local r, g, b
        -- Tap-denied check (target only)
        if opts.hasTapDenied
           and UnitIsTapped(unitToken)
           and not UnitIsTappedByPlayer(unitToken) then
            r, g, b = 0.5, 0.5, 0.5
        else
            r, g, b = UnitSelectionColor(unitToken)
        end

        if opts.nameVertexAlpha then
            NameBackground:SetVertexColor(
                r or 0.5, g or 0.5, b or 0.5, opts.nameVertexAlpha)
        else
            NameBackground:SetVertexColor(r, g, b)
        end
        NameBackground:Show()
    end

    -- ================================================================
    -- FRAME INITIALIZATION
    -- ================================================================

    local function InitializeFrame()
        if Module.configured then return end
        if not BlizzFrame then return end

        -- ---- Create editor overlay ----
        if not Module.overlay then
            Module.overlay = addon.CreateUIFrame(
                opts.overlaySize[1], opts.overlaySize[2],
                namePrefix .. "Frame")

            addon:RegisterEditableFrame({
                name       = widgetKey,
                frame      = Module.overlay,
                blizzardFrame = BlizzFrame,
                configPath = {"widgets", widgetKey},
                hasTarget  = ShouldBeVisible,
                showTest   = ShowFrameTest,
                hideTest   = HideFrameTest,
                onHide     = function() ApplyWidgetPosition() end,
                module     = Module,
            })
        end

        -- ---- Hide Blizzard elements ----
        if opts.hideListFn then
            for _, element in ipairs(opts.hideListFn()) do
                if element then
                    element:SetAlpha(0)
                    element:Hide()
                end
            end
        end

        -- ---- Create background texture ----
        if not frameElements.background then
            frameElements.background = BlizzFrame:CreateTexture(
                "DragonUI_" .. namePrefix .. "BG", "BACKGROUND", nil, -7)
            frameElements.background:SetTexture(TEXTURES.BACKGROUND)
            frameElements.background:SetPoint(
                "TOPLEFT", BlizzFrame, "TOPLEFT", 0, -8)
        end

        -- ---- Create border texture ----
        if not frameElements.border then
            frameElements.border = BlizzFrame:CreateTexture(
                "DragonUI_" .. namePrefix .. "Border", "OVERLAY", nil, 5)
            frameElements.border:SetTexture(TEXTURES.BORDER)
            frameElements.border:SetPoint(
                "TOPLEFT", frameElements.background, "TOPLEFT", 0, 0)
        end

        -- ---- Create elite decoration ----
        if not frameElements.elite then
            frameElements.elite = BlizzFrame:CreateTexture(
                "DragonUI_" .. namePrefix .. "Elite", "OVERLAY", nil, 7)
            frameElements.elite:SetTexture(TEXTURES.BOSS)
            frameElements.elite:Hide()
        end

        -- ---- Create threat numeric indicator ----
        if not frameElements.threatNumeric then
            local numeric = CreateFrame("Frame",
                "DragonUI" .. namePrefix .. "NumericalThreat", BlizzFrame)
            numeric:SetFrameStrata("HIGH")
            numeric:SetFrameLevel(BlizzFrame:GetFrameLevel() + 10)
            numeric:SetSize(71, 13)
            numeric:SetPoint("BOTTOM", BlizzFrame, "TOP", -45, -20)
            numeric:Hide()

            local bg = numeric:CreateTexture(nil, "ARTWORK")
            bg:SetTexture(TEXTURES.THREAT_NUMERIC)
            bg:SetTexCoord(0.927734375, 0.9970703125, 0.3125, 0.337890625)
            bg:SetAllPoints()

            numeric.text = numeric:CreateFontString(
                nil, "OVERLAY", "GameFontNormalSmall")
            numeric.text:SetPoint("CENTER", 0, 1)
            numeric.text:SetFont("Fonts\\FRIZQT__.TTF", 10)
            numeric.text:SetShadowOffset(1, -1)

            frameElements.threatNumeric = numeric
        end

        -- ---- Configure name background ----
        if NameBackground then
            NameBackground:ClearAllPoints()
            NameBackground:SetPoint(
                "BOTTOMLEFT", HealthBar, "TOPLEFT", -2, -5)
            NameBackground:SetSize(135, 18)
            NameBackground:SetTexture(TEXTURES.NAME_BACKGROUND)
            NameBackground:SetDrawLayer("BORDER", 1)
            NameBackground:SetBlendMode("ADD")
            if opts.nameFrameAlpha then
                NameBackground:SetAlpha(opts.nameFrameAlpha)
            end
        end

        -- ---- Configure portrait ----
        Portrait:ClearAllPoints()
        Portrait:SetSize(56, 56)
        Portrait:SetPoint("TOPRIGHT", BlizzFrame, "TOPRIGHT", -47, -15)
        Portrait:SetDrawLayer("ARTWORK", 1)

        -- ---- Configure health bar ----
        HealthBar:ClearAllPoints()
        HealthBar:SetSize(125, 20)
        HealthBar:SetPoint("RIGHT", Portrait, "LEFT", -1, 0)
        HealthBar:SetFrameLevel(BlizzFrame:GetFrameLevel())

        -- ---- Configure power bar ----
        ManaBar:ClearAllPoints()
        ManaBar:SetSize(132, 9)
        ManaBar:SetPoint("RIGHT", Portrait, "LEFT", 6.5, -16.5)
        ManaBar:SetFrameLevel(BlizzFrame:GetFrameLevel())

        -- ---- Configure text elements ----
        if NameText then
            NameText:ClearAllPoints()
            NameText:SetPoint("BOTTOM", HealthBar, "TOP", 10, 3)
            NameText:SetDrawLayer("OVERLAY", 2)
            if opts.nameFontSize then
                local font, _, flags = NameText:GetFont()
                if font and flags then
                    NameText:SetFont(font, opts.nameFontSize, flags)
                end
            end
        end

        if LevelText then
            LevelText:ClearAllPoints()
            LevelText:SetPoint("BOTTOMRIGHT", HealthBar, "TOPLEFT", 18, 3)
            LevelText:SetDrawLayer("OVERLAY", 2)
            if opts.levelFontSize then
                local font, _, flags = LevelText:GetFont()
                if font and flags then
                    LevelText:SetFont(font, opts.levelFontSize, flags)
                end
            end
        end

        -- ---- Setup bar hooks ----
        SetupBarHooks()

        -- ---- Apply config (scale + position) ----
        local config = GetConfig()
        if not InCombatLockdown() then
            BlizzFrame:ClearAllPoints()
            BlizzFrame:SetClampedToScreen(false)
            BlizzFrame:SetScale(config.scale or 1)
        end
        ApplyWidgetPosition()

        Module.configured = true

        -- ---- After-init callback (frame-specific hooks) ----
        if opts.afterInit then
            opts.afterInit({
                Module              = Module,
                frameElements       = frameElements,
                BlizzFrame          = BlizzFrame,
                GetConfig           = GetConfig,
                updateCache         = updateCache,
                UpdateClassification = UpdateClassification,
                Portrait            = Portrait,
                TEXTURES            = TEXTURES,
                InitializeFrame     = InitializeFrame,
            })
        end

        -- ---- ShowTest / HideTest (editor mode) ----
        if not BlizzFrame.ShowTest then
            BlizzFrame.ShowTest = function(self)
                self:Show()
                self:SetFrameStrata("MEDIUM")
                self:SetFrameLevel(10)

                -- Force layout for frames that need it (target)
                if opts.forceLayoutOnUnitChange then
                    ForceReapplyLayout()
                end

                -- Custom textures
                if frameElements.background then
                    frameElements.background:Show()
                end
                if frameElements.border then
                    frameElements.border:Show()
                end

                -- Player portrait
                if Portrait then
                    SetPortraitTexture(Portrait, "player")
                end

                -- Name background with player color
                if NameBackground then
                    local r, g, b = UnitSelectionColor("player")
                    if opts.nameVertexAlpha then
                        NameBackground:SetVertexColor(
                            r, g, b, opts.nameVertexAlpha)
                    else
                        NameBackground:SetVertexColor(r, g, b)
                    end
                    NameBackground:Show()
                end

                -- Name & level text (preserve original color)
                if NameText then
                    if not NameText.originalColor then
                        local r, g, b, a = NameText:GetTextColor()
                        NameText.originalColor = {r, g, b, a}
                    end
                    NameText:SetText(UnitName("player"))
                end
                if LevelText then
                    if not LevelText.originalColor then
                        local r, g, b, a = LevelText:GetTextColor()
                        LevelText.originalColor = {r, g, b, a}
                    end
                    LevelText:SetText(UnitLevel("player"))
                end

                -- Health bar with class color system
                if HealthBar then
                    local curHP  = UnitHealth("player")
                    local maxHP  = UnitHealthMax("player")
                    HealthBar:SetMinMaxValues(0, maxHP)
                    HealthBar:SetValue(curHP)

                    local tex = HealthBar:GetStatusBarTexture()
                    if tex then
                        local cfg = GetConfig()
                        if cfg.classcolor then
                            tex:SetTexture(
                                TEXTURES.BAR_PREFIX .. "Health-Status")
                            local _, cls = UnitClass("player")
                            local clr = RAID_CLASS_COLORS[cls]
                            if clr then
                                tex:SetVertexColor(
                                    clr.r, clr.g, clr.b, 1)
                            else
                                tex:SetVertexColor(1, 1, 1, 1)
                            end
                        else
                            tex:SetTexture(
                                TEXTURES.BAR_PREFIX .. "Health")
                            tex:SetVertexColor(1, 1, 1, 1)
                        end
                        if maxHP > 0 then
                            tex:SetTexCoord(0, curHP / maxHP, 0, 1)
                        end
                    end
                    HealthBar:Show()
                end

                -- Power bar with custom texture
                if ManaBar then
                    local pType    = UnitPowerType("player")
                    local curPwr   = UnitPower("player", pType)
                    local maxPwr   = UnitPowerMax("player", pType)
                    ManaBar:SetMinMaxValues(0, maxPwr)
                    ManaBar:SetValue(curPwr)

                    local tex = ManaBar:GetStatusBarTexture()
                    if tex then
                        local pName = POWER_MAP[pType] or "Mana"
                        tex:SetTexture(TEXTURES.BAR_PREFIX .. pName)
                        tex:SetDrawLayer("ARTWORK", 1)
                        tex:SetVertexColor(1, 1, 1, 1)
                        if maxPwr > 0 then
                            tex:SetTexCoord(0, curPwr / maxPwr, 0, 1)
                        end
                    end
                    ManaBar:Show()
                end

                -- Elite decoration
                if frameElements.elite then
                    local classification = UnitClassification("player")
                    local pName   = UnitName("player")
                    local eCoords = nil

                    if pName and UF.FAMOUS_NPCS[pName] then
                        eCoords = BOSS_COORDS.elite
                    elseif classification
                           and classification ~= "normal" then
                        eCoords = BOSS_COORDS[classification]
                                  or BOSS_COORDS.elite
                    end

                    if eCoords then
                        frameElements.elite:SetTexCoord(
                            eCoords[1], eCoords[2],
                            eCoords[3], eCoords[4])
                        frameElements.elite:SetSize(
                            eCoords[5], eCoords[6])
                        frameElements.elite:SetPoint(
                            "CENTER", Portrait, "CENTER",
                            eCoords[7], eCoords[8])
                        frameElements.elite:Show()
                    else
                        frameElements.elite:Hide()
                    end
                end

                -- Hide threat in test mode
                if frameElements.threatNumeric then
                    frameElements.threatNumeric:Hide()
                end
            end

            BlizzFrame.HideTest = function(self)
                self:SetFrameStrata("LOW")
                self:SetFrameLevel(1)

                if NameText and NameText.originalColor then
                    NameText:SetVertexColor(
                        NameText.originalColor[1],
                        NameText.originalColor[2],
                        NameText.originalColor[3],
                        NameText.originalColor[4])
                end
                if LevelText and LevelText.originalColor then
                    LevelText:SetVertexColor(
                        LevelText.originalColor[1],
                        LevelText.originalColor[2],
                        LevelText.originalColor[3],
                        LevelText.originalColor[4])
                end

                if not UnitExists(unitToken) then
                    self:Hide()
                end
            end
        end
    end -- InitializeFrame

    -- ================================================================
    -- EVENT HANDLING
    -- ================================================================

    local function OnEvent(self, event, ...)
        if event == "ADDON_LOADED" then
            local name = ...
            if name == "DragonUI" and not Module.initialized then
                Module.initialized = true
            end

        elseif event == "PLAYER_ENTERING_WORLD" then
            InitializeFrame()

            -- Setup TextSystem
            if addon.TextSystem and not Module.textSystem then
                Module.textSystem = addon.TextSystem.SetupFrameTextSystem(
                    configKey, unitToken, BlizzFrame, HealthBar,
                    ManaBar, namePrefix .. "Frame")
            end

            if UnitExists(unitToken) then
                if opts.forceLayoutOnUnitChange then
                    ForceReapplyLayout()
                end
                UpdateNameBackground()
                UpdateClassification()
                UpdateThreat()
                if Module.textSystem then Module.textSystem.update() end
            end

        elseif event == opts.unitChangedEvent then
            -- Unit changed (target/focus)
            if UnitExists(unitToken) and opts.forceLayoutOnUnitChange then
                ForceReapplyLayout()
            end
            UpdateNameBackground()
            UpdateClassification()
            UpdateThreat()
            UpdateHealthBarColor()
            UpdateClassPortrait()
            if Module.textSystem then Module.textSystem.update() end

        elseif event == "UNIT_CLASSIFICATION_CHANGED" then
            local unit = ...
            if unit == unitToken then UpdateClassification() end

        elseif event == "UNIT_THREAT_SITUATION_UPDATE"
            or event == "UNIT_THREAT_LIST_UPDATE" then
            UpdateThreat()

        elseif event == "UNIT_FACTION" then
            local unit = ...
            if unit == unitToken then UpdateNameBackground() end

        elseif event == "UNIT_DISPLAYPOWER" then
            local unit = ...
            if unit == unitToken and UnitExists(unitToken) then
                ForceUpdatePowerBar()
                UpdateClassification()
                UpdateHealthBarColor()
                if Module.textSystem then Module.textSystem.update() end
            end

        elseif event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH" then
            local unit = ...
            if unit == unitToken and UnitExists(unitToken)
               and Module.textSystem then
                Module.textSystem.update()
            end

        elseif event == "UNIT_POWER_UPDATE"
            or event == "UNIT_MAXPOWER" then
            local unit = ...
            if unit == unitToken and UnitExists(unitToken) then
                ForceUpdatePowerBar()
                if Module.textSystem then Module.textSystem.update() end
            end

        else
            -- Forward unhandled events to per-module handler
            if opts.extraEventHandler then
                opts.extraEventHandler(
                    event, unitToken,
                    UpdateClassification, UpdateHealthBarColor,
                    ForceUpdatePowerBar, Module.textSystem, ...)
            end
        end
    end

    -- ---- Register events ----
    if not Module.eventsFrame then
        Module.eventsFrame = CreateFrame("Frame")
        local ef = Module.eventsFrame
        ef:RegisterEvent("ADDON_LOADED")
        ef:RegisterEvent("PLAYER_ENTERING_WORLD")
        ef:RegisterEvent(opts.unitChangedEvent)
        ef:RegisterEvent("UNIT_CLASSIFICATION_CHANGED")
        ef:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE")
        ef:RegisterEvent("UNIT_THREAT_LIST_UPDATE")
        ef:RegisterEvent("UNIT_FACTION")
        ef:RegisterEvent("UNIT_HEALTH")
        ef:RegisterEvent("UNIT_MAXHEALTH")
        ef:RegisterEvent("UNIT_POWER_UPDATE")
        ef:RegisterEvent("UNIT_MAXPOWER")
        ef:RegisterEvent("UNIT_DISPLAYPOWER")

        -- Register additional per-module events
        if opts.extraEvents then
            for _, ev in ipairs(opts.extraEvents) do
                ef:RegisterEvent(ev)
            end
        end

        ef:SetScript("OnEvent", OnEvent)
    end

    -- ================================================================
    -- PUBLIC API: Refresh / Reset
    -- ================================================================

    local function RefreshFrame()
        if not Module.configured then
            InitializeFrame()
        end

        local config = GetConfig()
        if not InCombatLockdown() then
            BlizzFrame:SetScale(config.scale or 1)
        end

        ApplyWidgetPosition()

        if UnitExists(unitToken) then
            if opts.forceLayoutOnUnitChange then
                ForceReapplyLayout()
            end
            UpdateNameBackground()
            UpdateClassification()
            UpdateThreat()
            UpdateHealthBarColor()
            ForceUpdatePowerBar()
            if Module.textSystem then Module.textSystem.update() end
        end
    end

    local function ResetFrame()
        local defaults = addon.defaults
            and addon.defaults.profile.unitframe[configKey] or {}
        for key, value in pairs(defaults) do
            addon:SetConfigValue("unitframe", configKey, key, value)
        end

        if not addon.db.profile.widgets then
            addon.db.profile.widgets = {}
        end
        addon.db.profile.widgets[widgetKey] = {
            anchor = defaultPos.anchor,
            posX   = defaultPos.posX,
            posY   = defaultPos.posY,
        }

        local config = GetConfig()
        if not InCombatLockdown() then
            BlizzFrame:ClearAllPoints()
            BlizzFrame:SetScale(config.scale or 1)
        end
        ApplyWidgetPosition()
    end

    -- ================================================================
    -- EDITOR MODE SUPPORT
    -- ================================================================

    function Module:LoadDefaultSettings()
        if not addon.db.profile.widgets then
            addon.db.profile.widgets = {}
        end
        addon.db.profile.widgets[widgetKey] = {
            anchor = defaultPos.anchor,
            posX   = defaultPos.posX,
            posY   = defaultPos.posY,
        }
    end

    function Module:UpdateWidgets()
        if not addon.db or not addon.db.profile.widgets
           or not addon.db.profile.widgets[widgetKey] then
            self:LoadDefaultSettings()
            return
        end
        ApplyWidgetPosition()
    end

    -- ================================================================
    -- EXTRA HOOKS
    -- ================================================================

    if opts.setupExtraHooks then
        opts.setupExtraHooks(UpdateHealthBarColor, UpdateClassPortrait)
    end

    -- ================================================================
    -- RETURN API
    -- ================================================================

    return {
        Refresh              = RefreshFrame,
        Reset                = ResetFrame,
        anchor               = function() return Module.overlay end,
        Module               = Module,
        -- Exposed for external use (options panel, wrapper modules)
        GetConfig            = GetConfig,
        UpdateHealthBarColor = UpdateHealthBarColor,
        UpdateClassPortrait  = UpdateClassPortrait,
        UpdateThreat         = UpdateThreat,
        UpdateClassification = UpdateClassification,
        UpdateNameBackground = UpdateNameBackground,
        ForceUpdatePowerBar  = ForceUpdatePowerBar,
        frameElements        = frameElements,
        updateCache          = updateCache,
    }
end

# 🐉 DragonUI - Experimental Changelog

> **⚠️ Experimental Branch** - All changes below still need further in-game testing and may contain bugs or incomplete features. If you run into any problems, feel free to let me know [here](https://github.com/NeticSoul/DragonUI/issues/141) - any feedback helps!

## 📅 2026-03-16

### Added
- **Bag slot lock system** - You can lock specific bag slots to exclude them from automatic sorting.
- **Quick lock controls** - Added `Alt + LeftClick` slot locking and a clear button to remove all locked slots.

### Fixed
- **Target PvP icon overlap** - The PvP flag icon now renders in front of the elite dragon decoration.
- **Bank slot locking** - Slot locks now work correctly on main bank slots (previously locks were stored under the wrong bag ID and ignored during sorting).
- **CompactRaidFrame** - Fixed a compatibility issue with the CompactRaidFrame addon.

### Changed
- **Localization coverage** - All new bag lock system texts and related changes are fully localized.
- **Game menu compatibility mode** - Added compatibility handling with an Ascension-specific menu path.

## 📅 2026-03-15

### Fixed
- **Target/Focus elite dragon overlap** - Fixed a bug where the Target/Focus frame border was positioned in front of the elite dragon decoration.
- **Minimap rotation stability** - Rotation now behaves correctly in indoor/outdoor transitions, including reload/relog and dungeon doors.
- **SexyMap Hybrid Mode** - DragonUI no longer overrides mask/rotation state in Hybrid mode, so the minimap displays correctly as it should.
- **Party frame recovery (experimental)** - Added an experimental patch to reduce party frames disappearing after reloads/party changes.
- **Target/Focus mana text alignment** - Mana text is now better centered and easier to read.

### Changed
- **Unit Frame Layers options cleanup** - Removed the experimental Builder/Spender toggle from Unit Frame Layers options.

## 📅 2026-03-14

### Added
- **Unit Frame Layers module (beta)** - New optional module that adds heal prediction bars, absorb shield overlays, and animated health loss effect to player and target unit frames. Configurable from the Modules tab
- **UnitFrameLayers compatibility** - If the standalone UnitFrameLayers addon is detected, a popup now lets you choose between using DragonUI's built-in version or disabling both to avoid conflicts
- **Focus name background toggle** - New option to show or hide the colored background behind the focus frame name

### Changed
- **Centralized font system** - All fonts are now managed from a single source that automatically picks the right font for your client language. This also fixes the "???" rendering bug on Korean, Chinese, and Russian clients

### Fixed
- **Attempted fix for UI freezes** - Applied texture coordinate clipping to player and pet health/mana bars to prevent visual corruption that could cause the game to freeze
- **Options panel translation errors** - Fixed missing or mismatched locale keys that caused errors in the options panel for non-English clients
- **Korean translations updated** - Improved Korean localization across the options panel (contributed by nadugi)

## 📅 2026-03-12

### Added
- **Target name background toggle** - New option to hide the colored background behind target name text
- **Chat font sizes** - Extended font size range (10–20) now available by default without manual commands
- **QuestHelper compatibility** - Quest tracker header auto-hides when QuestHelper is loaded

### Fixed
- **Target class color** - Attempted fix for health bar reverting to default green when Blizzard resets the color (needs testing)
- **Player icon layering** - PvP, leader, and master looter icons no longer render above other UI windows
- **Micromenu latency tooltip** - "Network" / "Latency" text now localized
- **Modules tab locale error** - Missing locale entry for bag sort description
- **Party background CVar conflict** - Blizzard's "Party/Arena Background" option no longer breaks party frames; a popup warns and offers to disable it
- **Item quality borders on inspect** - Quality glow borders now display correctly when inspecting other players
- **Party frames vehicle texture** - Blizzard's vanilla vehicle texture no longer bleeds through when party members enter vehicles

## 📅 2026-03-10

### Added
- **Bag Sort module** - Sort buttons for bags and bank frames (both Combuctor and vanilla). Sorts items by type, rarity, equip slot, level, and name. Also adds `/sort`, `/sortbags`, and `/sortbank` slash commands. Enabled by default
- **Bag Sort translations** - Full localization for enUS, esES, esMX, deDE, and koKR (options panel and in-game tooltips)

### Changed
- **Combuctor disabled by default** - Combuctor module now ships disabled; enable it from the Bags options tab

### Fixed
- **Combuctor bank tooltips** - Item tooltips in the bank now display correctly when hovering

## 📅 2026-03-09

### Added
- **Chat enhancements module** - Moveable editbox, URL detection & copy, chat copy via double-click tab, mousewheel scroll (ported from KPack ChatMods)
- **Combuctor bags module** - All-in-one bag/bank replacement with item filtering and search (ported from KPack Combuctor)
- **Bags options tab** - New panel section for configuring the Combuctor module
- **Boss frames in Editor Mode** - Boss unit frames can now be repositioned via Editor Mode
- **esMX locale** - Full Mexican Spanish translation for both addons

### Fixed
- **Boss frames** - Restyled with Dragonflight atlas textures
- **Dark mode** - Now covers XP/Rep bar textures, pet frame border, ToT/ToF custom borders, and skinned minimap addon buttons
- **Party frames** - Vehicle texture hidden correctly; strata/level fixes to prevent overlap
- **Options panel** - Removed legacy options panel; reduced file size across all options tabs

## 📅 2026-03-07

### Added
- **Quest tracker font size option** - You can now change the size of the text in the quest tracker from the options panel

### Fixed
- **Death Knight runes** - Rune textures no longer break when rune types change mid-combat

## 📅 2026-03-04

### Added
- **SexyMap compatibility system** - Detects SexyMap and offers three modes: SexyMap, DragonUI, or Hybrid. A new section at the bottom of the Minimap options tab (visible only when SexyMap is installed) lets you switch between modes. Use `/duicomp` to check or reset

### Fixed
- **Item quality borders** - Now correctly applied to guild bank slots
- **Party frames Master Looter icon** - Fixed incorrect positioning
- **Pet unitframe default position** - Adjusted to avoid overlapping with Death Knight runes

## 📅 2026-03-03

### Added
- **Weapon Enchants frame** - Weapon enchant icons can now be separated from the buff bar into their own moveable frame (new "Auras" tab in options)
- **Game menu button** - Restyled with custom texture __ <img width="170" height="29" alt="image" src="https://github.com/user-attachments/assets/9a9d3a4d-6923-4441-868e-0bd1dd0cc78c" />
- **Dungeon Eye mover** - The LFG eye icon is now independently moveable via Editor Mode


### Fixed
- **Action bar CVar** - Multibar buttons now correctly respect the "Always Show Action Bars" CVar
- **Korean font** - UI text no longer renders as "???" on koKR clients (2002.ttf now used as default font for Korean locale)
- **Compatibility module** - Fixed missing localized popup text
- **Leader icon** - Fixed overlapping with portrait and border frames
- **Quest tracker** - Frame anchor no longer causes position drift after reload

## 📅 2026-02-25

### Fixed
- Buff/debuff cooldown sweep no longer flickers on target change
- Castbar: no ghost green bar when module is disabled; hidden from editor when off
- Vehicle exit button no longer drifts to center in editor mode
- Main bar buttons properly centered within border frame
- Minimap: improved compatibility with Carbonite and Questie
- Quest tracker now shows all tracked quests
- Party frames: disconnected members now display correctly (including mod-playerbots bots)
- Party frames: hover text no longer hides "always show" text

## 📅 2026-02-23

### Added
- **Localization system (Beta)** - Full AceLocale-3.0 integration. Base language: enUS. Spanish (esES) translation (may be incomplete). Locale stubs included for deDE, frFR, koKR, ptBR, ruRU, zhCN, zhTW. All UI strings, options panels, slash commands, popups, and editor labels are now localized
- Loot roll frames now moveable via editor mode
- Castbar detailed mode: long spell names auto-truncate with "..."
- Castbar channel ticks auto-localized for any client language
- Castbar text mode change now prompts for UI reload

### Fixed
- Chat frame no longer shifts when both XP and reputation bars are visible at the same time
- Quest tracker position persists correctly after reload, even in combat
- ToT/ToF health bar no longer flickers with class colors enabled
- Castbar time direction: counts up for casts, down for channels
- DurabilityFrame no longer overlaps right side action bars
- Petbar and stance bar now shift up correctly when both XP and reputation bars are visible
- Editor mode saved positions no longer drift after reload
- Vehicle exit button no longer anchored to stance bar
- Action bar overlay sizing now matches actual bar dimensions
- Bags editor mode overlay now matches actual bag area including keyring

## 📅 2026-02-22

### Fixed
- Buff frame: weapon enchant buffs no longer overlap the toggle button
- Latency indicator: no longer blocks HelpMicroButton clicks
- Tooltip: health bar now renders inside the tooltip border
- Quest tracker: "Wide" watch frame option now applies without reload

## 📅 2026-02-18

### Added
- **Latency Indicator** - Color-coded StatusBar overlay on the HelpMicroButton showing latency (green < 200 ms, yellow 200–300 ms, red > 300 ms). Tooltip displays ms. Toggleable in DragonUI Micro Menu options

### Changed
- Party frames: the single "Gap" slider has been split into two separate sliders - one for vertical spacing and one for horizontal spacing

### Fixed
- Buff frame: buff/debuff positioning, second row alignment, and GM ticket interaction no longer break debuff layout
- Buff toggle button: state now persists through aura updates and reloads
- Vehicle: mechanical vehicle button offset corrected
- Stance bar: combat taint error on protected frame
- XP/Rep bar: reputation bar position persists at max level; hover text and "always show text" mode now display correctly in RetailUI style; robust max level detection for custom servers
- XP/Rep bar: Exhaustion (rested) tick now refreshes correctly on level-up
- KeyRing button no longer hidden when toggling "Hide Main Bar Background"

## 📅 2026-02-17

### Fixed
- Converted critical bar textures (XP, Rep, ToT, Party, Castbar, NameBackground) from BLP to TGA to prevent white texture corruption when changing texture resolution in Video Settings
- Vehicle module: action bars (main and secondary) no longer hide when entering a vehicle with Blizzard Art Style disabled
- Vehicle exit button now appears for multi-seat mount passengers (previously only showed for vehicles with full UI)
- Vehicle: empty button slots are now hidden, bars behave correctly on reload and in combat for both art style modes
- Party frames: horizontal layout persists after reload, correct power type colors (energy, rage, etc.), better default spacing

## 📅 2026-02-16

### Added
- **Dark Mode** - Darkens all UI borders and frame chrome (action bars, unit frames, minimap, bags, micro menu, castbar, stance/pet bars, XP/Rep bars). Three intensity presets (Light, Medium, Dark) plus a custom color picker for full control
- **Item Quality Borders** - Colored glow borders around items based on their rarity. Works in bags, character panel, inspect, bank, merchant, and guild bank. Configurable minimum quality threshold (e.g., only show for Rare+)
- **Enhanced Tooltips** - Class-colored tooltip borders, class-colored unit names, target-of-target line, styled health bar, and optional anchor-to-cursor mode. 
- **Range Indicator** - Action buttons turn red when out of range, blue when not enough resources, and grey when unusable.
- **Enhancements Tab** in the options panel grouping all new visual features (Dark Mode, Range Indicator, Item Quality Borders, Enhanced Tooltips) in one place
- **XP & Reputation Bars** - DragonflightUI-style XP and reputation bars; plus a second RetailUI style to choose from. Configurable bar height, scale, rested XP background visibility, always-show text mode, and XP percentage display.  
- **Show Rest Glow toggle** in Player Frame options to enable or disable the resting glow effect

### Fixed
- Buff frame now correctly shifts down when a GM ticket or GM chat panel is open, and returns to its original position when closed. Custom positions set via Editor Mode are always respected
- GM Ticket frame no longer overlaps the minimap
- Rest glow (golden pulsing glow when resting in an inn or city) was broken by previous modifications, now works correctly again
- Stance bar buttons now update correctly in all situations (entering/leaving water as druid, zone transitions, cooldown changes)
- Stance bar and other bottom-anchored frames automatically shift up when both XP and reputation bars are visible simultaneously, preventing overlap
- Reputation bar now correctly repositions to the experience bar slot at max level
- Compact raid frame compatibility polling no longer runs constantly out of combat, reducing CPU usage
- Removed leftover debug messages that were cluttering the chat on login
- XP and reputation bars are now managed as separate, independently movable frames in Editor Mode instead of sharing a single combined frame
- Durability frame now dynamically repositions below the minimap when PvP capture bars (Eye of the Storm, etc.) appear, preventing overlap
- All Spanish code comments translated to English across the codebase
- Internal code cleanup: centralized timer system, shared module helpers, and removed redundant utility functions

## 📅 2026-02-14

### Added
- **Action Bar Layout & Visibility Options** - New options for all action bars including grid layout with columns slider, quick presets, and per-bar visibility controls (show on hover, show in combat)
- Reworked horizontal bar system for better, more consistent behavior
- Bar enable/disable settings sync with Blizzard's Interface Options - no reload needed

### Fixed
- Action bars now properly hide when entering vehicles
- Minimap addon button skin now toggles on/off instantly without reload
- Skinned addon buttons show hover highlight correctly
- Vanilla minimap border no longer reappears after closing Interface Options
- PvP capture bar (territory control) now positions correctly below the minimap on first appearance - no longer requires a reload
- Vanilla combat flash no longer shows around the player portrait during combat
- Cooldown sweep animation no longer flickers when targeting yourself
- Class portrait on target/focus frames updates more efficiently

### Changed
- Health and mana bar textures clamped to prevent visual glitches during Battleground loading and phasing

### Credits
- Action bar grid/preset system based on work by [RovBot](https://github.com/RovxBot/DragonUI/commit/4e6ee66aa3ad6e304f5cc6aa9327a57723b40537)

## 📅 2026-02-12

### Added
- **ToT/ToF Editor Mode** - Target of Target and Target of Focus frames now appear in editor mode with drag support. Dragging detaches them from parent; re-attach via options panel button
- Options panel shows attachment status (Attached/Detached) with re-attach button for ToT and ToF
- Editor mode buttons restyled to match options panel dark theme (grey + blue accent)

### Fixed
- Rest glow now displays gold in normal and fat bar modes (was white due to wrong blend mode)
- Sub-tab font size no longer flickers between 12→11 on tab switch (Castbar, Unit Frames)
- Totem bar editor overlay now only visible for shamans


## 📅 2026-02-11

### Added
- **Custom Options Panel** - New dark-themed, resizable panel with vertical tab navigation, profile management, and quick-launch buttons for Editor/KeyBind modes. Access legacy options via `/dragonui legacy`
- **Fat Mana Bar Textures** - Selectable power bar textures (Blizzard, Flat, Smooth, Aluminium, LiteStep) with customizable Dragonflight-style power colors
- Editor mode now hides fat mana bar anchor when fat mode is disabled

### Fixed
- Stance and totem bars now hide properly during vehicle UI
- Minor positioning corrections (fat healthbar width, pet frame offset)

## 📅 2026-02-10

### Compatibility
- New/edited target-style textures to make Fat Health Bar compatible with Dragon Decoration
- Player frame layout updated for Fat + Decoration

### Vehicle
- Vehicle combat/status glow frames using the vehicle atlas
- Vehicle layout updated (portrait/texture updates on enter/exit)
- Vehicle action buttons centered using calculated offsets
- Vehicle transitions more stable after /reload and after leaving combat

### Combat Feedback
- PlayerHitIndicator (healing/damage numbers) now renders above border/decoration/PvP icon
- Blizzard flash/status textures no longer interfere with DragonUI glow effects

## 📅 2026-02-09

### Added
- Fat Health Bar system for player frame with full-width health bar display (thanks [CrimsonHollow](https://github.com/CrimsonHollow))
- Configurable mana bar in fat mode (width, height, hide toggle, movable via Editor Mode)
- **Note:** ~~Fat Health Bar is currently incompatible with Dragon Decoration mode due to missing texture edits (will be addressed in future update)~~

### Refactored
- Unit frame system restructured with shared factories (`uf_core.lua`, `target_style.lua`, `small_frame.lua`)
- Target, Focus, ToT, and FoT modules now use shared code instead of duplicated logic (~930 lines removed)

### Fixed
- Target/Focus background texture no longer shows a floating shadow artifact
- Castbar aura offset: replaced manual `UnitAura()` counting with Blizzard's native `auraRows` via `TargetFrame_UpdateAuras` hook
- Castbar no longer overlaps buffs/debuffs on target or focus frames
- Health bar class color no longer resets to green (race condition fix via `OnValueChanged` + `SetStatusBarColor` hooks)
- Focus castbar default position adjusted to match target castbar spacing

## 📅 2026-02-08

### Fixed
- Vehicle UI completely rewritten and functional
- Vehicle exit button now displays correctly and can be repositioned in editor mode
- Bottom bars properly hide/show when entering/leaving vehicles
- Micro menu editor overlay now aligns correctly with icons in both colored and grayscale modes
- Quest tracker invisible frame no longer blocks mouse clicks outside editor mode
- Castbar now shows the actual spell name during channeling instead of "Channeling"
- Castbar: improved self-interrupt detection for channeled spells
- Unit frames (player, target, focus, target-of-target) protected against combat errors
- Focus frame scale no longer breaks when entering combat
- Party frame textures no longer become invisible after dying or releasing spirit
- Memory leaks fixed in several modules (vehicle, player, castbar)
- Potential infinite recursion in minimap removed

### Changed
- All Blizzard frame modifications now use secure hooks (hooksecurefunc)
- General cleanup of dead and duplicated code across multiple modules

## 📅 2026-02-06

### Added
- Class Portrait option for Player, Target, Focus (shows class icons instead of 3D portraits)
- Totem bar size/spacing options with auto-anchoring to visible action bars

### Changed  
- Editor Mode: Complete visual rework with DragonflightUI-style overlays
- Editor Mode: New highlight/selected states for all draggable frames
- Editor Mode: Stance and Totem bars now integrated into editor system
- Editor Mode: All modules (except ToT/ToF) now use the new system

### Fixed
- Stance & Totem bars disappearing after `/reload`
- Stance & Totem bars breaking when changing settings
- Stance & Totem size/spacing options now work correctly
- Party frames horizontal mode
- Sidebar editor overlay follows orientation changes
- Castbar advanced mode time display

## 📅 2026-02-05

### Added
- `DragonUI_Options` as separate addon (loads on demand for faster startup)
- Advanced individual module control panel 
- `core/api.lua` with centralized utility functions
- `core/movers.lua` with unified frame movement system
- `core/commands.lua` with slash command handling
- `core/module_base.lua` with standardized module template
- CombatQueue system for safe combat-deferred operations
- Module Registry system for tracking and managing modules
- Quest tracker now works in Editor Mode

### Changed
- Core utilities reorganized into `core/` folder
- Action bar modules consolidated in `modules/actionbars/`
- Options divided into modular files (general, actionbars, unitframes, etc.)
- Standardized module initialization patterns across all modules

### Fixed
- Target of Target not working on Bronzebeard private server (thanks xius)
- Bag icons displaying incorrectly (thanks @mikki33)
- Quest tracker visual fixes (thanks @mikki33)
- Combat lockdown handling improved across modules
- `mainbars.lua` module scope issue (MainbarsModule now at file level)

# 🐉 DragonUI - Experimental Changelog

> **⚠️ Experimental Branch** — All changes below still need further in-game testing and may contain bugs or incomplete features. If you run into any problems, feel free to let me know [here](https://github.com/NeticSoul/DragonUI/issues/141) — any feedback helps!

## 📅 2026-02-12

### Added
- **ToT/ToF Editor Mode** — Target of Target and Target of Focus frames now appear in editor mode with drag support. Dragging detaches them from parent; re-attach via options panel button
- Options panel shows attachment status (Attached/Detached) with re-attach button for ToT and ToF

### Fixed
- Rest glow now displays gold in normal and fat bar modes (was white due to wrong blend mode)
- Editor mode buttons restyled to match options panel dark theme (grey + blue accent)
- Sub-tab font size no longer flickers between 12→11 on tab switch (Castbar, Unit Frames)
- Totem bar editor overlay now only visible for shamans


## 📅 2026-02-11

### Added
- **Custom Options Panel** — New dark-themed, resizable panel with vertical tab navigation, profile management, and quick-launch buttons for Editor/KeyBind modes. Access legacy options via `/dragonui legacy`
- **Fat Mana Bar Textures** — Selectable power bar textures (Blizzard, Flat, Smooth, Aluminium, LiteStep) with customizable Dragonflight-style power colors
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
- **Note:** Fat Health Bar is currently incompatible with Dragon Decoration mode due to missing texture edits (will be addressed in future update)

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

# 🐉 DragonUI - Experimental Changelog

## 2026-02-08

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

## 2026-02-06

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

## 2026-02-05

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

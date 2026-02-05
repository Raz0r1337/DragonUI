# Changelog

All notable changes to DragonUI experimental branch.

## [Unreleased]

### Structure
- Separated options into `DragonUI_Options` addon (loads on demand)
- New `core/` folder with centralized API, movers, and commands
- Action bar modules consolidated in `modules/actionbars/`
- Module Registry system for standardized module management
- CombatQueue system for safe combat operations

### Fixed
- **ToT/ToF**: Not working on some private servers (thanks xius)
- **Bag icons**: Displaying incorrectly (thanks @mikki33)
- **Quest tracker**: Visual fixes and header sizing (thanks @mikki33)
- **Quest tracker**: Integrated with Editor Mode
- **Modules**: Standardized initialization patterns (mainbars, petbar, multicast)

### Changed
- Options panel loads on demand (faster addon startup)
- Improved combat lockdown handling across modules

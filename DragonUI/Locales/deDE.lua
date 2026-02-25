--[[
================================================================================
DragonUI - German Locale (deDE)
================================================================================
]]

local L = LibStub("AceLocale-3.0"):NewLocale("DragonUI", "deDE")
if not L then return end

-- ============================================================================
-- CORE / GENERAL
-- ============================================================================

L["Cannot toggle editor mode during combat!"] = "Editor-Modus kann im Kampf nicht umgeschaltet werden!"
L["Cannot reset positions during combat!"] = "Positionen können im Kampf nicht zurückgesetzt werden!"
L["Cannot toggle keybind mode during combat!"] = "Tastenbelegungsmodus kann im Kampf nicht umgeschaltet werden!"
L["Cannot move frames during combat!"] = "Fenster können im Kampf nicht bewegt werden!"
L["Cannot open options in combat."] = "Optionen können im Kampf nicht geöffnet werden."

L["Editor mode not available."] = "Editor-Modus ist nicht verfügbar."
L["Keybind mode not available."] = "Tastenbelegungsmodus ist nicht verfügbar."
L["Vehicle debug not available"] = "Fahrzeug-Debug ist nicht verfügbar"
L["KeyBinding module not available"] = "Tastenbelegungs-Modul ist nicht verfügbar"
L["Unable to open configuration"] = "Konfiguration kann nicht geöffnet werden"

L["Error executing pending operation:"] = "Fehler beim Ausführen der ausstehenden Operation:"
L["Error -- Addon 'DragonUI_Options' not found or is disabled."] = "Fehler -- Addon 'DragonUI_Options' wurde nicht gefunden oder ist deaktiviert."

-- ============================================================================
-- SLASH COMMANDS / HELP
-- ============================================================================

L["Unknown command: "] = "Unbekannter Befehl: "
L["=== DragonUI Commands ==="] = "=== DragonUI-Befehle ==="
L["/dragonui or /dui - Open configuration"] = "/dragonui oder /dui - Konfiguration öffnen"
L["/dragonui config - Open configuration"] = "/dragonui config - Konfiguration öffnen"
L["/dragonui legacy - Open legacy AceConfig options"] = "/dragonui legacy - Alte AceConfig-Optionen öffnen"
L["/dragonui edit - Toggle editor mode (move UI elements)"] = "/dragonui edit - Editor-Modus umschalten (UI-Elemente verschieben)"
L["/dragonui reset - Reset all positions to defaults"] = "/dragonui reset - Alle Positionen auf Standard zurücksetzen"
L["/dragonui reset <name> - Reset specific mover"] = "/dragonui reset <name> - Bestimmten Mover zurücksetzen"
L["/dragonui status - Show module status"] = "/dragonui status - Modulstatus anzeigen"
L["/dragonui kb - Toggle keybind mode"] = "/dragonui kb - Tastenbelegungsmodus umschalten"
L["/dragonui version - Show version info"] = "/dragonui version - Versionsinfo anzeigen"
L["/dragonui help - Show this help"] = "/dragonui help - Diese Hilfe anzeigen"
L["/rl - Reload UI"] = "/rl - UI neu laden"

-- ============================================================================
-- STATUS DISPLAY
-- ============================================================================

L["=== DragonUI Status ==="] = "=== DragonUI-Status ==="
L["Detected Modules:"] = "Erkannte Module:"
L["Loaded"] = "Geladen"
L["Not Loaded"] = "Nicht geladen"
L["Registered Movers: "] = "Registrierte Mover: "
L["Editable Frames: "] = "Bearbeitbare Frames: "
L["DragonUI Version: "] = "DragonUI-Version: "
L["Use /dragonui edit to enter edit mode, then right-click frames to reset."] = "Nutze /dragonui edit, um den Bearbeitungsmodus zu aktivieren, und klicke dann mit Rechtsklick auf Frames, um sie zurückzusetzen."

-- ============================================================================
-- EDITOR MODE
-- ============================================================================

L["Exit Edit Mode"] = "Bearbeitungsmodus beenden"
L["Reset All Positions"] = "Alle Positionen zurücksetzen"
L["Are you sure you want to reset all interface elements to their default positions?"] = "Bist du sicher, dass du alle Interface-Elemente auf ihre Standardpositionen zurücksetzen möchtest?"
L["Yes"] = "Ja"
L["No"] = "Nein"
L["UI elements have been repositioned. Reload UI to ensure all graphics display correctly?"] = "UI-Elemente wurden neu positioniert. UI neu laden, damit alle Grafiken korrekt angezeigt werden?"
L["Reload Now"] = "Jetzt neu laden"
L["Later"] = "Später"

-- ============================================================================
-- KEYBINDING MODULE
-- ============================================================================

L["LibKeyBound-1.0 not found or failed to load:"] = "LibKeyBound-1.0 nicht gefunden oder Laden fehlgeschlagen:"
L["Commands:"] = "Befehle:"
L["/dukb - Toggle keybinding mode"] = "/dukb - Tastenbelegungsmodus umschalten"
L["/dukb help - Show this help"] = "/dukb help - Diese Hilfe anzeigen"
L["Module disabled."] = "Modul deaktiviert."
L["Keybinding mode activated. Hover over buttons and press keys to bind them."] = "Tastenbelegungsmodus aktiviert. Fahre über Buttons und drücke Tasten, um sie zu belegen."
L["Keybinding mode deactivated."] = "Tastenbelegungsmodus deaktiviert."

-- ============================================================================
-- GAME MENU
-- ============================================================================

L["DragonUI"] = "DragonUI"

-- ============================================================================
-- MINIMAP MODULE
-- ============================================================================

L["DragonUI: Minimap module restored to Blizzard defaults"] = "DragonUI: Minimap-Modul auf Blizzard-Standard zurückgesetzt"

-- ============================================================================
-- EDITOR MODE LABELS (displayed on mover overlays - keep SHORT)
-- ============================================================================

L["MainBar"] = "Hauptleiste"
L["RightBar"] = "Rechte Leiste"
L["LeftBar"] = "Linke Leiste"
L["BottomBarLeft"] = "Unten links"
L["BottomBarRight"] = "Unten rechts"
L["XPBar"] = "EP-Leiste"
L["RepBar"] = "Ruf-Leiste"
L["MinimapFrame"] = "Minimap"
L["PlayerFrame"] = "Spieler"
L["ManaBar"] = "Mana-Leiste"
L["PetFrame"] = "Begleiter"
L["ToT"] = "Ziel des Ziels"
L["ToF"] = "Ziel des Fokus"
L["tot"] = "Ziel des Ziels"
L["fot"] = "Ziel des Fokus"
L["PartyFrames"] = "Gruppe"
L["TargetFrame"] = "Ziel"
L["FocusFrame"] = "Fokus"
L["BagsBar"] = "Taschen"
L["MicroMenu"] = "Mikromenü"
L["VehicleExitOverlay"] = "Fahrzeug verlassen"
L["StanceOverlay"] = "Haltungsleiste"
L["petbar"] = "Begleiterleiste"
L["TotemBarOverlay"] = "Totemleiste"
L["PlayerCastbar"] = "Zauberleiste"
L["Auras"] = "Auren"
L["Loot Roll"] = "Beute würfeln"
L["Quest Tracker"] = "Questverfolgung"

-- Mover tooltip strings
L["Drag to move"] = "Ziehen zum Verschieben"
L["Right-click to reset"] = "Rechtsklick zum Zurücksetzen"

-- Editor mode system messages
L["All editable frames shown for editing"] = "Alle bearbeitbaren Frames zum Bearbeiten angezeigt"
L["All editable frames hidden, positions saved"] = "Alle bearbeitbaren Frames ausgeblendet, Positionen gespeichert"

-- ============================================================================
-- STATIC POPUPS
-- ============================================================================

L["Changing this setting requires a UI reload to apply correctly."] = "Das Ändern dieser Einstellung erfordert ein Neuladen der UI, damit es korrekt angewendet wird."
L["Reload UI"] = "UI neu laden"
L["Not Now"] = "Nicht jetzt"

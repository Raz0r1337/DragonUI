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

-- Combat lockdown messages
L["Cannot toggle editor mode during combat!"] = "Editor-Modus kann im Kampf nicht umgeschaltet werden!"
L["Cannot reset positions during combat!"] = "Positionen können im Kampf nicht zurückgesetzt werden!"
L["Cannot toggle keybind mode during combat!"] = "Tastenbelegungsmodus kann im Kampf nicht umgeschaltet werden!"
L["Cannot move frames during combat!"] = "Fenster können im Kampf nicht bewegt werden!"
L["Cannot open options in combat."] = "Optionen können im Kampf nicht geöffnet werden."
L["Options panel not available. Try /reload."] = "Optionsfeld nicht verfügbar. Versuche /reload."

-- Module availability
L["Editor mode not available."] = "Editor-Modus ist nicht verfügbar."
L["Keybind mode not available."] = "Tastenbelegungsmodus ist nicht verfügbar."
L["Vehicle debug not available"] = "Fahrzeug-Debug ist nicht verfügbar"
L["KeyBinding module not available"] = "Tastenbelegungs-Modul ist nicht verfügbar"
L["Unable to open configuration"] = "Konfiguration kann nicht geöffnet werden"

-- Errors
L["Error executing pending operation:"] = "Fehler beim Ausführen der ausstehenden Operation:"
L["Error -- Addon 'DragonUI_Options' not found or is disabled."] = "Fehler -- Addon 'DragonUI_Options' wurde nicht gefunden oder ist deaktiviert."

-- ============================================================================
-- SLASH COMMANDS / HELP
-- ============================================================================

L["Unknown command: "] = "Unbekannter Befehl: "
L["=== DragonUI Commands ==="] = "=== DragonUI-Befehle ==="
L["/dragonui or /dui - Open configuration"] = "/dragonui oder /dui - Konfiguration öffnen"
L["/dragonui config - Open configuration"] = "/dragonui config - Konfiguration öffnen"
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
L["LFGFrame"] = "Dungeon Auge"
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
L["boss"] = "Boss-Rahmen"
L["Boss Frames"] = "Boss-Rahmen"
L["Boss1Frame"] = "Boss-Rahmen"
L["Boss2Frame"] = "Boss-Rahmen"
L["Boss3Frame"] = "Boss-Rahmen"
L["Boss4Frame"] = "Boss-Rahmen"
L["TotemBarOverlay"] = "Totemleiste"
L["PlayerCastbar"] = "Zauberleiste"
L["Auras"] = "Auren"
L["WeaponEnchants"] = "Waffenverzauberungen"
L["Loot Roll"] = "Beute würfeln"
L["Quest Tracker"] = "Questverfolgung"

-- Mover tooltip strings
L["Drag to move"] = "Ziehen zum Verschieben"
L["Right-click to reset"] = "Rechtsklick zum Zurücksetzen"

-- Editor mode system messages
L["All editable frames shown for editing"] = "Alle bearbeitbaren Frames zum Bearbeiten angezeigt"
L["All editable frames hidden, positions saved"] = "Alle bearbeitbaren Frames ausgeblendet, Positionen gespeichert"

-- ============================================================================
-- COMPATIBILITY MODULE
-- ============================================================================

-- Conflict warning popup
L["DragonUI Conflict Warning"] = "DragonUI-Konfliktwarnung"
L["The addon |cFFFFFF00%s|r conflicts with DragonUI."] = "Das Addon |cFFFFFF00%s|r kollidiert mit DragonUI."
L["Reason:"] = "Grund:"
L["Disable the conflicting addon now?"] = "Das konfliktverursachende Addon jetzt deaktivieren?"
L["Disable"] = "Deaktivieren"
L["Keep Both"] = "Beide behalten"

-- Conflict reasons
L["Conflicts with DragonUI's custom unit frame textures and power bar system."] = "Kollidiert mit DragonUIs benutzerdefinierten Einheiten-Rahmen-Texturen und dem Machtleistensystem."
L["Known taint issues when manipulating party frames during combat. DragonUI provides automatic fixes."] = "Bekannte Kontaminationsprobleme beim Manipulieren von Gruppenrahmen im Kampf. DragonUI bietet automatische Korrekturen."
L["Resets minimap mask and blip textures. DragonUI re-applies its custom textures automatically."] = "Setzt Minimap-Maske und Markierungs-Texturen zurück. DragonUI wendet seine benutzerdefinierten Texturen automatisch erneut an."
L["SexyMap modifies the minimap borders, shape, and zone text which conflicts with DragonUI's minimap module."] = "SexyMap verändert die Minimap-Rahmen, Form und Zonentexte, was mit dem Minimap-Modul von DragonUI kollidiert."

-- SexyMap-Kompatibilitäts-Popup
L["DragonUI - SexyMap Detected"] = "DragonUI - SexyMap erkannt"
L["Which minimap do you want to use?"] = "Welche Minikarte möchtest du verwenden?"
L["SexyMap"] = "SexyMap"
L["DragonUI"] = "DragonUI"
L["Hybrid"] = "Hybrid"
L["Recommended"] = "Empfohlen"

-- SexyMap-Optionspanel
L["SexyMap Compatibility"] = "SexyMap-Kompatibilität"
L["Minimap Mode"] = "Minikarten-Modus"
L["Choose how DragonUI and SexyMap share the minimap."] = "Wähle, wie DragonUI und SexyMap die Minikarte teilen."
L["Requires UI reload to apply."] = "Erfordert UI-Neuladen."
L["Uses SexyMap for the minimap."] = "Verwendet SexyMap für die Minikarte."
L["Uses DragonUI for the minimap."] = "Verwendet DragonUI für die Minikarte."
L["SexyMap visuals with DragonUI editor and positioning."] = "SexyMap-Optik, bewegbar und konfigurierbar über DragonUI."
L["Minimap mode changed. Reload UI to apply?"] = "Minikarten-Modus geändert. UI neu laden?"

-- SexyMap-Kompatibilitäts-Befehle
L["SexyMap compatibility mode has been reset. Reload UI to choose again."] = "Der SexyMap-Kompatibilitätsmodus wurde zurückgesetzt. Lade die UI neu, um erneut zu wählen."
L["Current SexyMap mode: |cFFFFFF00%s|r"] = "Aktueller SexyMap-Modus: |cFFFFFF00%s|r"
L["No SexyMap mode selected (SexyMap not detected or not yet chosen)."] = "Kein SexyMap-Modus ausgewählt (SexyMap nicht erkannt oder noch nicht gewählt)."
L["Show current SexyMap compatibility mode"] = "Aktuellen SexyMap-Kompatibilitätsmodus anzeigen"
L["Reset SexyMap mode choice (re-prompts on reload)"] = "SexyMap-Modusauswahl zurücksetzen (fragt beim Neuladen erneut)"
L["Loaded addons:"] = "Geladene Addons:"

-- ============================================================================
-- STATIC POPUPS (shared between modules)
-- ============================================================================

L["Changing this setting requires a UI reload to apply correctly."] = "Das Ändern dieser Einstellung erfordert ein Neuladen der UI, damit es korrekt angewendet wird."
L["Reload UI"] = "UI neu laden"
L["Not Now"] = "Nicht jetzt"

-- Taschen sortieren (Bag Sort)
L["Sort Bags"] = "Taschen sortieren"
L["Sort Bank"] = "Bank sortieren"
L["Sort Items"] = "Gegenstände sortieren"
L["Click to sort items by type, rarity, and name."] = "Klicken, um Gegenstände nach Typ, Seltenheit und Name zu sortieren."

-- Mikromenu Latenz
L["Network"] = "Netzwerk"
L["Latency"] = "Latenz"

-- Party Background CVar
L["Disable"] = "Deaktivieren"
L["Ignore"] = "Ignorieren"
L["The Blizzard option |cFFFFFF00Party/Arena Background|r is enabled. This conflicts with DragonUI's party frames."] = "Die Blizzard-Option |cFFFFFF00Gruppen/Arena-Hintergrund|r ist aktiviert. Dies steht im Konflikt mit DragonUIs Gruppenfenstern."
L["Disable it now?"] = "Jetzt deaktivieren?"

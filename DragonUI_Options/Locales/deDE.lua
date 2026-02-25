--[[
================================================================================
DragonUI_Options - German (deDE) Locale
================================================================================
]]

local L = LibStub("AceLocale-3.0"):NewLocale("DragonUI_Options", "deDE")
if not L then return end

-- ============================================================================
-- GENERAL / PANEL
-- ============================================================================

L["DragonUI"] = "DragonUI"
L["experimental"] = "experimentell"
L["Editor Mode"] = "Editor-Modus"
L["KeyBind Mode"] = "Tastenbelegungsmodus"
L["Exit Editor Mode"] = "Editor-Modus beenden"
L["KeyBind Mode Active"] = "Tastenbelegungsmodus aktiv"
L["Move UI Elements"] = "UI-Elemente verschieben"
L["/dragonui  |  /dragonui legacy for classic options"] = "/dragonui  |  /dragonui legacy für klassische Optionen"
L["Cannot open options during combat."] = "Optionen können im Kampf nicht geöffnet werden."

-- Quick Actions
L["Quick Actions"] = "Schnellaktionen"
L["About"] = "Über"
L["Dragonflight-inspired UI for WotLK 3.3.5a."] = "Dragonflight-inspiriertes UI für WotLK 3.3.5a."
L["Experimental Branch — This options panel is in early beta."] = "Experimenteller Branch — Dieses Optionsfenster ist in einer frühen Beta."
L["Features may change or be incomplete. Report issues on GitHub."] = "Funktionen können sich ändern oder unvollständig sein. Melde Probleme auf GitHub."
L["Use /dragonui or /pi to toggle this panel."] = "Nutze /dragonui oder /pi, um dieses Fenster ein-/auszublenden."
L["Use /dragonui legacy to open the classic AceConfig options."] = "Nutze /dragonui legacy, um die klassischen AceConfig-Optionen zu öffnen."

-- ============================================================================
-- STATIC POPUPS
-- ============================================================================

L["Changing this setting requires a UI reload to apply correctly."] = "Das Ändern dieser Einstellung erfordert ein Neuladen der UI, damit änderungen korrekt angewendet werden."
L["Reload UI"] = "UI neu laden"
L["Not Now"] = "Nicht jetzt"
L["Reload Now"] = "Jetzt neu laden"
L["Cancel"] = "Abbrechen"
L["Yes"] = "Ja"
L["No"] = "Nein"

-- ============================================================================
-- TAB NAMES
-- ============================================================================

L["General"] = "Allgemein"
L["Modules"] = "Module"
L["Action Bars"] = "Aktionsleisten"
L["Additional Bars"] = "Zusätzliche Leisten"
L["Cast Bars"] = "Zauberleiste"
L["Enhancements"] = "Verbesserungen"
L["Micro Menu"] = "Mikromenü"
L["Minimap"] = "Minikarte"
L["Profiles"] = "Profile"
L["Quest Tracker"] = "Questverfolgung"
L["Unit Frames"] = "Einheitenfenster"
L["XP & Rep Bars"] = "EP- & Rufleisten"

-- ============================================================================
-- MODULES TAB
-- ============================================================================

-- Headers & descriptions
L["Module Control"] = "Modulsteuerung"
L["Enable or disable specific DragonUI modules"] = "Bestimmte DragonUI-Module aktivieren oder deaktivieren"
L["Toggle individual modules on or off. Disabled modules revert to the default Blizzard UI."] = "Einzelne Module ein- oder ausschalten. Deaktivierte Module fallen auf die Blizzard-Standard-UI zurück."
L["Visual enhancements that add Dragonflight-style polish to the UI."] = "Visuelle Verbesserungen, die der UI Dragonflight-Ästhetik geben."
L["Warning: These are individual module controls. The options above may control multiple modules at once. Changes here will be reflected above and vice versa."] = "Warnung: Das sind Einzel-Modul-Steuerungen. Die Optionen oben können mehrere Module gleichzeitig steuern. Änderungen hier werden oben übernommen und umgekehrt."
L["Warning:"] = "Warnung:"
L["Individual overrides. The grouped toggles above take priority."] = "Einzel-Overrides. Die gruppierten Schalter oben haben Vorrang."
L["Advanced - Individual Module Control"] = "Erweitert - Einzelne Modulsteuerung"

-- Section headers
L["Cast Bars"] = "Zauberleisten"
L["Other Modules"] = "Weitere Module"
L["UI Systems"] = "UI-Systeme"
L["Enable All Action Bar Modules"] = "Alle Aktionsleisten-Module aktivieren"

-- Toggle labels
L["Player Castbar"] = "Spieler-Zauberleisten"
L["Target Castbar"] = "Ziel-Zauberleiste"
L["Focus Castbar"] = "Fokus-Zauberleiste"
L["Action Bars System"] = "Aktionsleisten-System"
L["Micro Menu & Bags"] = "Mikromenü & Taschen"
L["Cooldown Timers"] = "Abklingzeit-Timer"
L["Minimap System"] = "Minikarten-System"
L["Buff Frame System"] = "Stärkungsfenster-System"
L["Dark Mode"] = "Dunkelmodus"
L["Range Indicator"] = "Reichweitenanzeige"
L["Item Quality Borders"] = "Rahmen nach Gegenstandsqualität"
L["Enable Enhanced Tooltips"] = "Erweiterte Tooltips aktivieren"
L["KeyBind Mode"] = "Tastenbelegungsmodus"
L["Quest Tracker"] = "Questverfolgung"

-- Module toggle descriptions
L["Enable DragonUI player castbar. When disabled, shows default Blizzard castbar."] = "DragonUI-Spieler-Zauberleiste aktivieren. Wenn deaktiviert, wird die Blizzard-Standard-Zauberleiste angezeigt."
L["Enable DragonUI player castbar styling."] = "DragonUI-Stil für die Spieler-Zauberleiste aktivieren."
L["Enable DragonUI target castbar. When disabled, shows default Blizzard castbar."] = "DragonUI-Ziel-Zauberleiste aktivieren. Wenn deaktiviert, wird die Blizzard-Standard-Zauberleiste angezeigt."
L["Enable DragonUI target castbar styling."] = "DragonUI-Stil für die Ziel-Zauberleiste aktivieren."
L["Enable DragonUI focus castbar. When disabled, shows default Blizzard castbar."] = "DragonUI-Fokus-Zauberleiste aktivieren. Wenn deaktiviert, wird die Blizzard-Standard-Zauberleiste angezeigt."
L["Enable DragonUI focus castbar styling."] = "DragonUI-Stil für die Fokus-Zauberleiste aktivieren."
L["Enable the complete DragonUI action bars system. This controls: Main action bars, vehicle interface, stance/shapeshift bars, pet action bars, multicast bars (totems/possess), button styling, and hide Blizzard elements. When disabled, all action bar related features will use default Blizzard interface."] = "Das komplette DragonUI-Aktionsleisten-System aktivieren. Steuert: Hauptaktionsleisten, Fahrzeug-Interface, Haltungs-/Gestaltleisten, Begleiteraktionsleisten, Multicast-Leisten (Totems/Besessenheit), Button-Styling und das Ausblenden von Blizzard-Elementen. Wenn deaktiviert, nutzen alle Aktionsleisten-Funktionen die Blizzard-Standardoberfläche."
L["Master toggle for the complete action bars system."] = "Hauptschalter für das komplette Aktionsleisten-System."
L["Includes main bars, vehicle, stance, pet, totem bars, and button styling."] = "Enthält Hauptleisten, Fahrzeug, Haltung, Begleiter, Totemleisten und Button-Styling."
L["Apply DragonUI micro menu and bags system styling and positioning. Includes character button, spellbook, talents, etc. and bag management. When disabled, these elements will use default Blizzard positioning and styling."] = "DragonUI-Styling und Positionierung für Mikromenü & Taschen anwenden. Enthält Charakter-Button, Zauberbuch, Talente usw. sowie Taschenverwaltung. Wenn deaktiviert, nutzen diese Elemente Blizzard-Standard-Positionierung und -Stil."
L["Micro menu and bags styling."] = "Stil für Mikromenü & Taschen."
L["Show cooldown timers on action buttons. When disabled, cooldown timers will be hidden and the system will be completely deactivated."] = "Abklingzeit-Timer auf Aktionsbuttons anzeigen. Wenn deaktiviert, werden Timer ausgeblendet und das System vollständig deaktiviert."
L["Show cooldown timers on action buttons."] = "Abklingzeit-Timer auf Aktionsbuttons anzeigen."
L["Enable DragonUI minimap enhancements including custom styling, positioning, tracking icons, and calendar. When disabled, uses default Blizzard minimap appearance and positioning."] = "DragonUI-Minimap-Verbesserungen aktivieren: eigenes Styling, Positionierung, Tracking-Icons und Kalender. Wenn deaktiviert, wird die Blizzard-Standard-Minimap verwendet."
L["Minimap styling, tracking icons, and calendar."] = "Minimap-Styling, Tracking-Icons und Kalender."
L["Enable DragonUI buff frame with custom styling, positioning, and toggle button functionality. When disabled, uses default Blizzard buff frame appearance and positioning."] = "DragonUI-Stärkungsfenster mit eigenem Styling, Positionierung und Umschalt-Button aktivieren. Wenn deaktiviert, wird das Blizzard-Standard-Stärkungsfenster verwendet."
L["Buff frame styling and toggle button."] = "Stärkungsfenster-Styling und Umschalt-Button."
L["DragonUI quest tracker positioning and styling."] = "Positionierung und Styling der DragonUI-Questverfolgung."
L["LibKeyBound integration for intuitive hover + key press binding."] = "LibKeyBound-Integration für intuitives Belegen (Hover + Tastendruck)."

-- Toggle keybinding mode description
L["Toggle keybinding mode. Hover over action buttons and press keys to bind them instantly. Press ESC to clear bindings."] = "Tastenbelegungsmodus umschalten. Fahre über Aktionsbuttons und drücke Tasten, um sie sofort zu belegen. Drücke ESC, um Belegungen zu löschen."

-- Enable/disable dynamic descriptions
L["Enable/disable "] = "Aktivieren/deaktivieren "

-- Dark Mode
L["Dark Mode Intensity"] = "Dunkelmodus-Intensität"
L["Light (subtle)"] = "Hell (dezent)"
L["Medium (balanced)"] = "Mittel (ausgewogen)"
L["Dark (maximum)"] = "Dunkel (maximal)"
L["Apply darker tinted textures to all UI chrome: action bars, unit frames, minimap, bags, micro menu, and more."] = "Dunkler getönte Texturen auf alle UI-Elemente anwenden: Aktionsleisten, Einheitenfenster, Minimap, Taschen, Mikromenü und mehr."
L["Apply darker tinted textures to all UI elements."] = "Dunkler getönte Texturen auf alle UI-Elemente anwenden."
L["Darkens UI borders and chrome only: action bar borders, unit frame borders, minimap border, bag slot borders, micro menu, castbar borders, and decorative elements. Icons, portraits, and abilities are never affected."] = "Dunkelt nur UI-Rahmen und Zierleisten ab: Aktionsleisten-Rahmen, Einheitenfenster-Rahmen, Minimap-Rahmen, Taschenplatz-Rahmen, Mikromenü, Zauberbalken-Rahmen und Deko-Elemente. Icons, Porträts und Fähigkeiten sind nicht betroffen."
L["Enable Dark Mode"] = "Dunkelmodus aktivieren"

-- Dark Mode - Custom Color
L["Custom Color"] = "Benutzerdefinierte Farbe"
L["Override presets with a custom tint color."] = "Voreinstellungen mit einer eigenen Tönungsfarbe überschreiben."
L["Tint Color"] = "Tönungsfarbe"
L["Intensity"] = "Intensität"

-- Range Indicator
L["Tint action button icons when target is out of range (red), not enough mana (blue), or unusable (gray)."] = "Aktionsbutton-Icons einfärben, wenn das Ziel außer Reichweite ist (rot), nicht genug Mana vorhanden ist (blau) oder die Fähigkeit nicht nutzbar ist (grau)."
L["Tints action button icons based on range and usability: red = out of range, blue = not enough mana, gray = unusable."] = "Färbt Aktionsbutton-Icons je nach Reichweite/Nutzbarkeit: rot = außer Reichweite, blau = nicht genug Mana, grau = nicht nutzbar."
L["Enable Range Indicator"] = "Reichweitenanzeige aktivieren"
L["Color action button icons when target is out of range or ability is unusable."] = "Aktionsbutton-Icons färben, wenn das Ziel außer Reichweite ist oder die Fähigkeit nicht nutzbar ist."

-- Item Quality Borders
L["Show colored glow borders on action buttons containing items, colored by item quality (green = uncommon, blue = rare, purple = epic, etc.)."] = "Farbige Leuchtrahmen auf Aktionsbuttons mit Gegenständen anzeigen – je nach Qualität (grün = ungewöhnlich, blau = selten, lila = episch, usw.)."
L["Enable Item Quality Borders"] = "Rahmen nach Gegenstandsqualität aktivieren"
L["Show quality-colored borders on items in bags, character panel, bank, merchant, and inspect frames."] = "Rahmen nach Qualität bei Gegenständen in Taschen, Charakterfenster, Bank, Händler und Inspizieren anzeigen."
L["Adds quality-colored glow borders to items in your bags, character panel, bank, merchant, and inspect frames: green = uncommon, blue = rare, purple = epic, orange = legendary."] = "Fügt Leuchtrahmen nach Qualität in Taschen hinzu, Charakterfenster, Bank, Händler und Inspizieren: grün = ungewöhnlich, blau = selten, lila = episch, orange = legendär."
L["Minimum Quality"] = "Mindestqualität"
L["Only show colored borders for items at or above this quality level."] = "Farbige Rahmen nur für Gegenstände dieser Qualität oder höher anzeigen."
L["Poor"] = "Schlecht"
L["Common"] = "Gewöhnlich"
L["Uncommon"] = "Ungewöhnlich"
L["Rare"] = "Selten"
L["Epic"] = "Episch"
L["Legendary"] = "Legendär"

-- Enhanced Tooltips
L["Enhanced Tooltips"] = "Erweiterte Tooltips"
L["Improve GameTooltip with class-colored borders, class-colored names, target-of-target info, and styled health bars."] = "GameTooltip verbessern: Rahmen nach Klassenfarbe, Namen nach Klassenfarbe, Ziel-des-Ziels-Info und stilisierte Lebensleisten."
L["Improves GameTooltip with class-colored borders, class-colored names, target-of-target info, and styled health bars."] = "Verbessert GameTooltip: Rahmen nach Klassenfarbe, Namen nach Klassenfarbe, Ziel-des-Ziels-Info und stilisierte Lebensleisten."
L["Activate all tooltip improvements. Sub-options below control individual features."] = "Alle Tooltip-Verbesserungen aktivieren. Unteroptionen steuern einzelne Features."
L["Class-Colored Border"] = "Rahmen nach Klassenfarbe"
L["Color the tooltip border by the unit's class (players) or reaction (NPCs)."] = "Tooltip-Rahmen nach Klasse (Spieler) oder Reaktion (NPCs) einfärben."
L["Class-Colored Name"] = "Name nach Klassenfarbe"
L["Color the unit name text in the tooltip by class color (players only)."] = "Einheitenname im Tooltip nach Klassenfarbe einfärben (nur Spieler)."
L["Target of Target"] = "Ziel des Ziels"
L["Add a 'Targeting: <name>' line showing who the unit is targeting."] = "Eine Zeile „Zielt auf: <name>“ hinzufügen, die zeigt, wen die Einheit anvisiert."
L["Add a 'Targeting: <name>' line to the tooltip showing who the unit is targeting."] = "Eine Zeile „Zielt auf: <name>“ im Tooltip hinzufügen, die zeigt, wen die Einheit anvisiert."
L["Styled Health Bar"] = "Stilisierte Lebensleiste"
L["Restyle the tooltip health bar with class/reaction colors."] = "Tooltip-Lebensleiste mit Klassen-/Reaktionsfarben neu stylen."
L["Restyle the tooltip health bar with class/reaction colors and slimmer look."] = "Tooltip-Lebensleiste mit Klassen-/Reaktionsfarben und schlanker Optik neu stylen."
L["Anchor to Cursor"] = "Am Cursor verankern"
L["Make the tooltip follow the cursor position instead of the default anchor."] = "Tooltip der Cursorposition folgen lassen statt der Standard-Verankerung."
L["Make the tooltip follow the cursor position instead of using the default anchor."] = "Tooltip der Cursorposition folgen lassen statt die Standard-Verankerung zu verwenden."

-- Advanced modules - Fallback display names
L["Main Bars"] = "Hauptleisten"
L["Vehicle"] = "Fahrzeug"
L["Stance Bar"] = "Haltungsleiste"
L["Pet Bar"] = "Begleiterleiste"
L["Multicast"] = "Multicast"
L["Buttons"] = "Buttons"
L["Hide Blizzard Elements"] = "Blizzard-Elemente ausblenden"
L["Buffs"] = "Stärkungen"
L["KeyBinding"] = "Tastenbelegung"
L["Cooldowns"] = "Abklingzeiten"

-- Advanced modules - RegisterModule display names
L["Micro Menu"] = "Mikromenü"
L["Loot Roll"] = "Beute würfeln"
L["Key Binding"] = "Tastenbelegung"
L["Item Quality"] = "Gegenstandsqualität"
L["Buff Frame"] = "Stärkungsfenster"
L["Hide Blizzard"] = "Blizzard ausblenden"
L["Tooltip"] = "Tooltip"

-- Advanced modules - RegisterModule descriptions
L["Micro menu and bags system styling and positioning"] = "Styling und Positionierung von Mikromenü & Taschen"
L["Quest tracker positioning and styling"] = "Positionierung und Styling der Questverfolgung"
L["Enhanced tooltip styling with class colors and health bars"] = "Erweitertes Tooltip-Styling mit Klassenfarben und Lebensleisten"
L["Hide default Blizzard UI elements"] = "Blizzard-Standard-UI-Elemente ausblenden"
L["Custom minimap styling, positioning, tracking icons and calendar"] = "Eigenes Minimap-Styling, Positionierung, Tracking-Icons und Kalender"
L["Main action bars, status bars, scaling and positioning"] = "Hauptaktionsleisten, Statusleisten, Skalierung und Positionierung"
L["LibKeyBound integration for intuitive keybinding"] = "LibKeyBound-Integration für intuitive Tastenbelegung"
L["Color item borders by quality in bags, character panel, bank, and merchant"] = "Gegenstandsrahmen nach Qualität in Taschen, Charakterfenster, Bank und Händler einfärben"
L["Darken UI borders and chrome"] = "UI-Rahmen und Zierleisten abdunkeln"
L["Action button styling and enhancements"] = "Styling und Verbesserungen für Aktionsbuttons"
L["Custom buff frame styling, positioning and toggle button"] = "Eigenes Styling/Positionierung fürs Stärkungsfenster und Umschalt-Button"
L["Vehicle interface enhancements"] = "Verbesserungen fürs Fahrzeug-Interface"
L["Stance/shapeshift bar positioning and styling"] = "Positionierung und Styling der Haltungs-/Gestaltleiste"
L["Pet action bar positioning and styling"] = "Positionierung und Styling der Begleiteraktionsleiste"
L["Multicast (totem/possess) bar positioning and styling"] = "Positionierung und Styling der Multicast-Leiste (Totems/Besessenheit)"

-- ============================================================================
-- ACTION BARS TAB
-- ============================================================================

-- Sub-tabs
L["Layout"] = "Layout"
L["Visibility"] = "Sichtbarkeit"

-- Scales section
L["Action Bar Scales"] = "Aktionsleisten-Skalierung"
L["Main Bar Scale"] = "Hauptleiste-Skalierung"
L["Right Bar Scale"] = "Skalierung der rechten Leiste"
L["Left Bar Scale"] = "Skalierung der linken Leiste"
L["Bottom Left Bar Scale"] = "Skalierung der Leiste unten links"
L["Bottom Right Bar Scale"] = "Skalierung der Leiste unten rechts"
L["Scale for main action bar"] = "Skalierung der Hauptaktionsleiste"
L["Scale for right action bar (MultiBarRight)"] = "Skalierung der rechten Aktionsleiste (MultiBarRight)"
L["Scale for left action bar (MultiBarLeft)"] = "Skalierung der linken Aktionsleiste (MultiBarLeft)"
L["Scale for bottom left action bar (MultiBarBottomLeft)"] = "Skalierung der unten linken Aktionsleiste (MultiBarBottomLeft)"
L["Scale for bottom right action bar (MultiBarBottomRight)"] = "Skalierung der unten rechten Aktionsleiste (MultiBarBottomRight)"
L["Reset All Scales"] = "Alle Skalierungen zurücksetzen"
L["Reset all action bar scales to their default values (0.9)"] = "Alle Aktionsleisten-Skalierungen auf Standardwerte (0.9) zurücksetzen"
L["All action bar scales reset to default values (0.9)"] = "Alle Aktionsleisten-Skalierungen auf Standardwerte (0.9) zurückgesetzt"
L["All action bar scales reset to 0.9"] = "Alle Aktionsleisten-Skalierungen auf 0.9 zurückgesetzt"

-- Positions section
L["Action Bar Positions"] = "Aktionsleisten-Positionen"
L["Tip: Use the Move UI Elements button above to reposition action bars with your mouse."] = "Tipp: Nutze oben „UI-Elemente verschieben“, um Aktionsleisten mit der Maus neu zu positionieren."
L["Left Bar Horizontal"] = "Linke Leiste horizontal"
L["Make the left secondary bar horizontal instead of vertical"] = "Linke Nebenleiste horizontal statt vertikal machen"
L["Make the left secondary bar horizontal instead of vertical."] = "Linke Nebenleiste horizontal statt vertikal machen."
L["Right Bar Horizontal"] = "Rechte Leiste horizontal"
L["Make the right secondary bar horizontal instead of vertical"] = "Rechte Nebenleiste horizontal statt vertikal machen"
L["Make the right secondary bar horizontal instead of vertical."] = "Rechte Nebenleiste horizontal statt vertikal machen."

-- Button Appearance section
L["Button Appearance"] = "Button-Aussehen"
L["Main Bar Only Background"] = "Hintergrund nur für Hauptleiste"
L["If checked, only the main action bar buttons will have a background. If unchecked, all action bar buttons will have a background."] = "Wenn aktiviert, haben nur Buttons der Hauptaktionsleiste einen Hintergrund. Wenn deaktiviert, haben alle Aktionsleisten-Buttons einen Hintergrund."
L["Only the main action bar buttons will have a background."] = "Nur Buttons der Hauptaktionsleiste haben einen Hintergrund."
L["Hide Main Bar Background"] = "Hauptleisten-Hintergrund ausblenden"
L["Hide the background texture of the main action bar (makes it completely transparent)"] = "Hintergrundtextur der Hauptaktionsleiste ausblenden (macht sie komplett transparent)"
L["Hide the background texture of the main action bar."] = "Hintergrundtextur der Hauptaktionsleiste ausblenden."

-- Text visibility
L["Text Visibility"] = "Text-Sichtbarkeit"
L["Count Text"] = "Anzahltext"
L["Show Count"] = "Anzahl anzeigen"
L["Show Count Text"] = "Anzahltext anzeigen"
L["Hotkey Text"] = "Hotkey-Text"
L["Show Hotkey"] = "Hotkey anzeigen"
L["Show Hotkey Text"] = "Hotkey-Text anzeigen"
L["Show small range indicator point on buttons"] = "Kleinen Reichweitenpunkt auf Buttons anzeigen"
L["Show range indicator dot on buttons."] = "Reichweitenpunkt auf Buttons anzeigen."
L["Macro Text"] = "Makrotext"
L["Show Macro Names"] = "Makronamen anzeigen"
L["Page Numbers"] = "Seitennummern"
L["Show Pages"] = "Seiten anzeigen"
L["Show Page Numbers"] = "Seitennummern anzeigen"

-- Cooldown text
L["Cooldown Text"] = "Abklingzeit-Text"
L["Min Duration"] = "Mindestdauer"
L["Minimum duration for text triggering"] = "Mindestdauer zum Einblenden des Textes"
L["Minimum duration for cooldown text to appear."] = "Mindestdauer, damit Abklingzeit-Text erscheint."
L["Text Color"] = "Textfarbe"
L["Cooldown text color"] = "Textfarbe für Abklingzeiten"
L["Cooldown Text Color"] = "Abklingzeit-Textfarbe"
L["Font Size"] = "Schriftgröße"
L["Size of cooldown text"] = "Größe des Abklingzeit-Textes"
L["Size of cooldown text."] = "Größe des Abklingzeit-Textes."

-- Colors
L["Colors"] = "Farben"
L["Macro Text Color"] = "Makrotext-Farbe"
L["Color for macro text"] = "Farbe für Makrotext"
L["Hotkey Shadow Color"] = "Hotkey-Schattenfarbe"
L["Shadow color for hotkey text"] = "Schattenfarbe für Hotkey-Text"
L["Border Color"] = "Rahmenfarbe"
L["Border color for buttons"] = "Rahmenfarbe für Buttons"

-- Gryphons
L["Gryphons"] = "Greifen"
L["Gryphon Style"] = "Greifen-Stil"
L["Display style for the action bar end-cap gryphons."] = "Anzeigestil für die Greifen an den Endkappen der Aktionsleiste."
L["End-cap ornaments flanking the main action bar."] = "Endkappen-Ornamente links/rechts der Hauptaktionsleiste."
L["Style"] = "Stil"
L["Old"] = "Alt"
L["New"] = "Neu"
L["Flying"] = "Fliegend"
L["Hide Gryphons"] = "Greifen ausblenden"
L["Classic"] = "Klassisch"
L["Dragonflight"] = "Dragonflight"
L["Hidden"] = "Ausgeblendet"
L["Dragonflight (Wyvern)"] = "Dragonflight (Wyvern)"
L["Dragonflight (Gryphon)"] = "Dragonflight (Greif)"

-- Layout section
L["Main Bar Layout"] = "Layout Hauptleiste"
L["Bottom Left Bar Layout"] = "Layout unten links"
L["Bottom Right Bar Layout"] = "Layout unten rechts"
L["Right Bar Layout"] = "Layout rechte Leiste"
L["Left Bar Layout"] = "Layout linke Leiste"
L["Configure the main action bar grid layout. Rows are determined automatically from columns and buttons shown."] = "Rasterlayout der Hauptaktionsleiste konfigurieren. Reihen werden automatisch aus Spalten und angezeigten Buttons bestimmt."
L["Columns"] = "Spalten"
L["Buttons Shown"] = "Angezeigte Buttons"
L["Quick Presets"] = "Schnell-Presets"
L["Apply layout presets to multiple bars at once."] = "Layout-Presets auf mehrere Leisten gleichzeitig anwenden."
L["Both 1x12"] = "Beide 1x12"
L["Both 2x6"] = "Beide 2x6"
L["Reset All"] = "Alles zurücksetzen"
L["All bar layouts reset to defaults."] = "Alle Leisten-Layouts auf Standard zurückgesetzt."

-- Visibility section
L["Bar Visibility"] = "Leisten-Sichtbarkeit"
L["Control when action bars are visible. Bars can show only on hover, only in combat, or both. When no option is checked the bar is always visible."] = "Steuert, wann Aktionsleisten sichtbar sind. Leisten können nur beim Darüberfahren, nur im Kampf oder beides angezeigt werden. Wenn keine Option aktiv ist, sind Leisten immer sichtbar."
L["Enable / Disable Bars"] = "Leisten aktivieren/deaktivieren"
L["Bottom Left Bar"] = "Unten links"
L["Bottom Right Bar"] = "Unten rechts"
L["Right Bar"] = "Rechte Leiste"
L["Left Bar"] = "Linke Leiste"
L["Main Bar"] = "Hauptleiste"
L["Show on Hover Only"] = "Nur beim Darüberfahren anzeigen"
L["Show in Combat Only"] = "Nur im Kampf anzeigen"
L["Hide the main bar until you hover over it."] = "Hauptleiste ausblenden, bis du darüberfährst."
L["Hide the main bar until you enter combat."] = "Hauptleiste ausblenden, bis du in den Kampf gehst."

-- ============================================================================
-- ADDITIONAL BARS TAB
-- ============================================================================

L["Bars that appear based on your class and situation."] = "Leisten, die je nach Klasse und Situation erscheinen."
L["Specialized bars that appear when needed (stance/pet/vehicle/totems)"] = "Spezialleisten, die bei Bedarf erscheinen (Haltung/Begleiter/Fahrzeug/Totems)"
L["Auto-show bars: Stance (Warriors/Druids/DKs) • Pet (Hunters/Warlocks/DKs) • Vehicle (All classes) • Totem (Shamans)"] = "Auto-Leisten: Haltung (Krieger/Druiden/Todesritter) • Begleiter (Jäger/Hexenmeister/Todesritter) • Fahrzeug (alle Klassen) • Totem (Schamanen)"

-- Common settings
L["Common Settings"] = "Allgemeine Einstellungen"
L["Button Size"] = "Button-Größe"
L["Size of buttons for all additional bars"] = "Größe der Buttons für alle zusätzlichen Leisten"
L["Button Spacing"] = "Button-Abstand"
L["Space between buttons for all additional bars"] = "Abstand zwischen Buttons für alle zusätzlichen Leisten"

-- Stance Bar
L["Stance Bar"] = "Haltungsleiste"
L["Warriors, Druids, Death Knights"] = "Krieger, Druiden, Todesritter"
L["X Position"] = "X-Position"
L["Y Offset"] = "Y-Versatz"
L["Horizontal position of stance bar from screen center. Negative values move left, positive values move right."] = "Horizontale Position der Haltungsleiste relativ zur Bildschirmmitte. Negative Werte nach links, positive nach rechts."

-- Pet Bar
L["Pet Bar"] = "Begleiterleiste"
L["Hunters, Warlocks, Death Knights - Use editor mode to move"] = "Jäger, Hexenmeister, Todesritter – zum Verschieben Editor-Modus nutzen"
L["Show Empty Slots"] = "Leere Plätze anzeigen"
L["Display empty action slots on pet bar"] = "Leere Aktionsplätze auf der Begleiterleiste anzeigen"

-- Vehicle Bar
L["Vehicle Bar"] = "Fahrzeugleiste"
L["All classes (vehicles/special mounts)"] = "Alle Klassen (Fahrzeuge/spezielle Reittiere)"
L["Custom Art Style"] = "Eigener Art-Stil"
L["Use custom vehicle bar art style with health/power bars and themed skin. Requires UI reload to apply."] = "Eigenen Fahrzeugleisten-Artstil mit Lebens-/Ressourcenleisten und thematischem Skin verwenden. Erfordert UI-Neuladen."
L["Blizzard Art Style"] = "Blizzard-Art-Stil"
L["Use Blizzard vehicle bar art with health/power display. Requires reload."] = "Blizzard-Fahrzeugleisten-Stil mit Lebens-/Ressourcenanzeige verwenden. Erfordert Neuladen."

-- Totem Bar
L["Totem Bar"] = "Totemleiste"
L["Totem Bar (Shaman)"] = "Totemleiste (Schamane)"
L["Shamans only - Totem multicast bar. Position is controlled via Editor Mode."] = "Nur Schamanen – Totem-Multicast-Leiste. Position wird über den Editor-Modus gesteuert."
L["TIP: Use Editor Mode to position the totem bar (type /dragonui edit)."] = "TIPP: Nutze den Editor-Modus, um die Totemleiste zu positionieren (Befehl: /dragonui edit)."

-- ============================================================================
-- CAST BARS TAB
-- ============================================================================

-- Sub-tabs
L["Player"] = "Spieler"
L["Target"] = "Ziel"
L["Focus"] = "Fokus"

-- Common options
L["Width"] = "Breite"
L["Width of the cast bar"] = "Breite der Zauberleiste"
L["Height"] = "Höhe"
L["Height of the cast bar"] = "Höhe der Zauberleiste"
L["Scale"] = "Skalierung"
L["Size scale of the cast bar"] = "Größenskalierung der Zauberleiste"
L["Show Icon"] = "Icon anzeigen"
L["Show the spell icon next to the cast bar"] = "Zauber-Icon neben der Zauberleiste anzeigen"
L["Show Spell Icon"] = "Zauber-Icon anzeigen"
L["Show the spell icon next to the target castbar"] = "Zauber-Icon neben der Ziel-Zauberleiste anzeigen"
L["Icon Size"] = "Icon-Größe"
L["Size of the spell icon"] = "Größe des Zauber-Icons"
L["Text Mode"] = "Textmodus"
L["Choose how to display spell text: Simple (centered spell name only) or Detailed (spell name + time)"] = "Wähle, wie Zaubertext angezeigt wird: Einfach (nur zentrierter Zaubername) oder Detailliert (Zaubername + Zeit)"
L["Simple (Centered Name Only)"] = "Einfach (nur zentrierter Name)"
L["Simple (Name Only)"] = "Einfach (nur Name)"
L["Simple"] = "Einfach"
L["Detailed (Name + Time)"] = "Detailliert (Name + Zeit)"
L["Detailed"] = "Detailliert"
L["Time Precision"] = "Zeitgenauigkeit"
L["Decimal places for remaining time"] = "Dezimalstellen für Restzeit"
L["Decimal places for remaining time."] = "Dezimalstellen für Restzeit."
L["Max Time Precision"] = "Max. Zeitgenauigkeit"
L["Decimal places for total time"] = "Dezimalstellen für Gesamtzeit"
L["Decimal places for total time."] = "Dezimalstellen für Gesamtzeit."
L["Hold Time (Success)"] = "Haltezeit (Erfolg)"
L["How long the bar stays visible after a successful cast."] = "Wie lange die Leiste nach einem erfolgreichen Zauber sichtbar bleibt."
L["How long the bar stays after a successful cast."] = "Wie lange die Leiste nach einem erfolgreichen Zauber bleibt."
L["How long to show the castbar after successful completion"] = "Wie lange die Zauberleiste nach erfolgreichem Abschluss angezeigt wird"
L["Hold Time (Interrupt)"] = "Haltezeit (Unterbrechung)"
L["How long the bar stays visible after being interrupted."] = "Wie lange die Leiste nach einer Unterbrechung sichtbar bleibt."
L["How long the bar stays after being interrupted."] = "Wie lange die Leiste nach einer Unterbrechung bleibt."
L["How long to show the castbar after interruption/failure"] = "Wie lange die Zauberleiste nach Unterbrechung/Fehlschlag angezeigt wird"
L["Auto Adjust for Auras"] = "Auto-Anpassung für Auren"
L["Auto-Adjust for Auras"] = "Auto-Anpassung für Auren"
L["Automatically adjust position based on target auras (CRITICAL FEATURE)"] = "Position automatisch anhand der Ziel-Auren anpassen (KRITISCHE FUNKTION)"
L["Shift castbar when buff/debuff rows are showing."] = "Zauberleiste verschieben, wenn Buff-/Debuff-Reihen angezeigt werden."
L["Automatically adjust position based on focus auras"] = "Position automatisch anhand der Fokus-Auren anpassen"
L["Reset Position"] = "Position zurücksetzen"
L["Resets the X and Y position to default."] = "Setzt X- und Y-Position auf Standard zurück."
L["Reset target castbar position to default"] = "Ziel-Zauberleiste-Position auf Standard zurücksetzen"
L["Reset focus castbar position to default"] = "Fokus-Zauberleiste-Position auf Standard zurücksetzen"
L["Player castbar position reset."] = "Spieler-Zauberleiste-Position zurückgesetzt."
L["Target castbar position reset."] = "Ziel-Zauberleiste-Position zurückgesetzt."
L["Focus castbar position reset."] = "Fokus-Zauberleiste-Position zurückgesetzt."

-- Width/height descriptions for target/focus
L["Width of the target castbar"] = "Breite der Ziel-Zauberleiste"
L["Height of the target castbar"] = "Höhe der Ziel-Zauberleiste"
L["Scale of the target castbar"] = "Skalierung der Ziel-Zauberleiste"
L["Width of the focus castbar"] = "Breite der Fokus-Zauberleiste"
L["Height of the focus castbar"] = "Höhe der Fokus-Zauberleiste"
L["Scale of the focus castbar"] = "Skalierung der Fokus-Zauberleiste"
L["Show the spell icon next to the focus castbar"] = "Zauber-Icon neben der Fokus-Zauberleiste anzeigen"
L["Time to show the castbar after successful cast completion"] = "Anzeigezeit nach erfolgreichem Zauberabschluss"
L["Time to show the castbar after cast interruption"] = "Anzeigezeit nach Zauberunterbrechung"

-- ============================================================================
-- ENHANCEMENTS TAB
-- ============================================================================

L["Enhancements"] = "Verbesserungen"
L["Visual enhancements that add Dragonflight-style polish to the UI. These are optional — disable any you don't want."] = "Visuelle Verbesserungen, die der UI den Dragonflight-Feinschliff geben. Optional — deaktiviere, was du nicht willst."

-- ============================================================================
-- MICRO MENU TAB
-- ============================================================================

L["Gray Scale Icons"] = "Graustufen-Icons"
L["Grayscale Icons"] = "Graustufen-Icons"
L["Use grayscale icons instead of colored icons for the micro menu"] = "Graustufen-Icons statt farbiger Icons im Mikromenü verwenden"
L["Use grayscale icons instead of colored icons."] = "Graustufen-Icons statt farbiger Icons verwenden."
L["Grayscale Icons Settings"] = "Einstellungen: Graustufen-Icons"
L["Normal Icons Settings"] = "Einstellungen: Normale Icons"
L["Menu Scale"] = "Menü-Skalierung"
L["Icon Spacing"] = "Icon-Abstand"
L["Hide on Vehicle"] = "Im Fahrzeug ausblenden"
L["Hide micromenu and bags if you sit on vehicle"] = "Mikromenü und Taschen ausblenden, wenn du in einem Fahrzeug sitzt"
L["Hide micromenu and bags while in a vehicle."] = "Mikromenü und Taschen im Fahrzeug ausblenden."
L["Show Latency Indicator"] = "Latenzindikator anzeigen"
L["Show a colored bar below the Help button indicating connection quality (green/yellow/red). Requires UI reload."] = "Farbigen Balken unter dem Hilfe-Button anzeigen, der die Verbindungsqualität zeigt (grün/gelb/rot). Erfordert UI-Neuladen."

-- Bags
L["Bags"] = "Taschen"
L["Configure the position and scale of the bag bar independently from the micro menu."] = "Position und Skalierung der Taschenleiste unabhängig vom Mikromenü konfigurieren."
L["Bag Bar Scale"] = "Skalierung Taschenleiste"

-- XP & Rep Bars
L["XP & Rep Bars (Legacy Offsets)"] = "EP- & Rufleisten (Legacy-Versatz)"
L["Main XP & Rep bar options have moved to the XP & Rep Bars tab."] = "Die Hauptoptionen für EP- & Rufleisten sind in den Tab „EP- & Rufleisten“ umgezogen."
L["These offset options are for advanced positioning adjustments."] = "Diese Versatz-Optionen sind für erweiterte Positionsanpassungen."
L["Both Bars Offset"] = "Versatz beider Leisten"
L["Y offset when XP & reputation bar are shown"] = "Y-Versatz, wenn EP- & Rufleiste angezeigt werden"
L["Single Bar Offset"] = "Versatz einzelner Leiste"
L["Y offset when XP or reputation bar is shown"] = "Y-Versatz, wenn EP- oder Rufleiste angezeigt wird"
L["No Bar Offset"] = "Kein Leisten-Versatz"
L["Y offset when no XP or reputation bar is shown"] = "Y-Versatz, wenn keine EP- oder Rufleiste angezeigt wird"
L["Rep Bar Above XP Offset"] = "Versatz Rufleiste über EP"
L["Y offset for reputation bar when XP bar is shown"] = "Y-Versatz der Rufleiste, wenn die EP-Leiste angezeigt wird"
L["Rep Bar Offset"] = "Versatz Rufleiste"
L["Y offset when XP bar is not shown"] = "Y-Versatz, wenn die EP-Leiste nicht angezeigt wird"

-- ============================================================================
-- MINIMAP TAB
-- ============================================================================

L["Basic Settings"] = "Grundeinstellungen"
L["Border Alpha"] = "Rahmen-Alpha"
L["Top border alpha (0 to hide)"] = "Alpha der oberen Leiste (0 zum Ausblenden)"
L["Top border alpha (0 to hide)."] = "Alpha der oberen Leiste (0 zum Ausblenden)."
L["Addon Button Skin"] = "Addon-Button-Skin"
L["Apply DragonUI border styling to addon icons (e.g., bag addons)"] = "DragonUI-Rahmenstil auf Addon-Icons anwenden (z. B. Taschen-Addons)"
L["Apply DragonUI border styling to addon icons."] = "DragonUI-Rahmenstil auf Addon-Icons anwenden."
L["Addon Button Fade"] = "Addon-Button-Ausblenden"
L["Addon icons fade out when not hovered"] = "Addon-Icons ausblenden, wenn nicht darübergefahren wird"
L["Addon icons fade out when not hovered."] = "Addon-Icons ausblenden, wenn nicht darübergefahren wird."
L["Player Arrow Size"] = "Spielerpfeil-Größe"
L["Size of the player arrow on the minimap"] = "Größe des Spielerpfeils auf der Minikarte"
L["New Blip Style"] = "Neuer Blip-Stil"
L["Use new DragonUI object icons on the minimap. When disabled, uses classic Blizzard icons."] = "Neue DragonUI-Objekticons auf der Minikarte verwenden. Wenn deaktiviert, werden klassische Blizzard-Icons genutzt."
L["Use newer-style minimap blip icons."] = "Minimap-Blip-Icons im neueren Stil verwenden."

-- Time & Calendar
L["Time & Calendar"] = "Uhrzeit & Kalender"
L["Show Clock"] = "Uhr anzeigen"
L["Show/hide the minimap clock"] = "Minimap-Uhr ein-/ausblenden"
L["Show Calendar"] = "Kalender anzeigen"
L["Show/hide the calendar frame"] = "Kalenderfenster ein-/ausblenden"
L["Clock Font Size"] = "Uhr-Schriftgröße"
L["Font size for the clock numbers on the minimap"] = "Schriftgröße der Uhrzahlen auf der Minikarte"

-- Display Settings
L["Display Settings"] = "Anzeigeeinstellungen"
L["Tracking Icons"] = "Tracking-Icons"
L["Show current tracking icons (old style)"] = "Aktuelle Tracking-Icons anzeigen (alter Stil)"
L["Show current tracking icons (old style)."] = "Aktuelle Tracking-Icons anzeigen (alter Stil)."
L["Zoom Buttons"] = "Zoom-Buttons"
L["Show zoom buttons (+/-)"] = "Zoom-Buttons anzeigen (+/-)"
L["Show zoom buttons (+/-)."] = "Zoom-Buttons anzeigen (+/-)."
L["Zone Text Size"] = "Zonentext-Größe"
L["Zone Text Font Size"] = "Zonentext-Schriftgröße"
L["Zone text font size on top border"] = "Schriftgröße des Zonentextes in der oberen Leiste"
L["Font size of the zone text above the minimap."] = "Schriftgröße des Zonentextes über der Minikarte."

-- Position
L["Position"] = "Position"
L["Reset minimap to default position (top-right corner)"] = "Minikarte auf Standardposition zurücksetzen (oben rechts)"
L["Reset Minimap Position"] = "Minikarten-Position zurücksetzen"
L["Minimap position reset to default"] = "Minikarten-Position auf Standard zurückgesetzt"
L["Minimap position reset."] = "Minikarten-Position zurückgesetzt."

-- ============================================================================
-- QUEST TRACKER TAB
-- ============================================================================

L["Configures the quest objective tracker position and behavior."] = "Konfiguriert Position und Verhalten der Questziel-Verfolgung."
L["Position and display settings for the objective tracker."] = "Positions- und Anzeigeeinstellungen für die Questziel-Verfolgung."
L["Show Header Background"] = "Header-Hintergrund anzeigen"
L["Show/hide the decorative header background texture"] = "Dekorative Header-Hintergrundtextur ein-/ausblenden"
L["Show/hide the decorative header background texture."] = "Dekorative Header-Hintergrundtextur ein-/ausblenden."
L["Anchor Point"] = "Ankerpunkt"
L["Screen anchor point for the quest tracker"] = "Bildschirm-Ankerpunkt für die Questverfolgung"
L["Screen anchor point for the quest tracker."] = "Bildschirm-Ankerpunkt für die Questverfolgung."
L["Top Right"] = "Oben rechts"
L["Top Left"] = "Oben links"
L["Bottom Right"] = "Unten rechts"
L["Bottom Left"] = "Unten links"
L["Center"] = "Mitte"
L["Horizontal position offset"] = "Horizontaler Positionsversatz"
L["Vertical position offset"] = "Vertikaler Positionsversatz"
L["Reset quest tracker to default position"] = "Questverfolgung auf Standardposition zurücksetzen"

-- ============================================================================
-- UNIT FRAMES TAB
-- ============================================================================

-- Sub-tabs
L["Pet"] = "Begleiter"
L["ToT / ToF"] = "ZdZ / ZdF"
L["Party"] = "Gruppe"

-- Common options
L["Global Scale"] = "Globale Skalierung"
L["Global scale for all unit frames"] = "Globale Skalierung für alle Einheitenfenster"
L["Scale of the player frame"] = "Skalierung des Spielerfensters"
L["Scale of the target frame"] = "Skalierung des Zielfensters"
L["Scale of the focus frame"] = "Skalierung des Fokusfensters"
L["Scale of the pet frame"] = "Skalierung des Begleiterfensters"
L["Scale of the target of target frame"] = "Skalierung des Ziel-des-Ziels-Fensters"
L["Scale of the focus of target frame"] = "Skalierung des Ziel-des-Fokus-Fensters"
L["Scale of party frames"] = "Skalierung der Gruppenfenster"
L["Class Color"] = "Klassenfarbe"
L["Class Color Health"] = "Leben nach Klassenfarbe"
L["Use class color for health bar"] = "Klassenfarbe für Lebensleiste verwenden"
L["Use class color for health bars in party frames"] = "Klassenfarbe für Lebensleisten in Gruppenfenstern verwenden"
L["Class Portrait"] = "Klassenporträt"
L["Show class icon instead of 3D portrait"] = "Klassenicon statt 3D-Porträt anzeigen"
L["Show class icon instead of 3D portrait (only for players)"] = "Klassenicon statt 3D-Porträt anzeigen (nur Spieler)"
L["Class icon instead of 3D model for players."] = "Klassenicon statt 3D-Modell bei Spielern."
L["Large Numbers"] = "Große Zahlen"
L["Format Large Numbers"] = "Große Zahlen formatieren"
L["Format large numbers (1k, 1m)"] = "Große Zahlen formatieren (1k, 1m)"
L["Text Format"] = "Textformat"
L["How to display health and mana values"] = "Wie Lebens- und Manawerte angezeigt werden"
L["Choose how to display health and mana text"] = "Wähle, wie Lebens- und Manatext angezeigt wird"

-- Text format values
L["Current Value Only"] = "Nur aktueller Wert"
L["Current Value"] = "Aktueller Wert"
L["Percentage Only"] = "Nur Prozent"
L["Percentage"] = "Prozent"
L["Both (Numbers + Percentage)"] = "Beides (Zahlen + Prozent)"
L["Numbers + %"] = "Zahlen + %"
L["Current/Max Values"] = "Aktuell/Max"
L["Current / Max"] = "Aktuell / Max"

-- Party text format values
L["Current Value Only (2345)"] = "Nur aktueller Wert (2345)"
L["Formatted Current (2.3k)"] = "Formatiert aktuell (2.3k)"
L["Percentage Only (75%)"] = "Nur Prozent (75%)"
L["Percentage + Current (75% | 2.3k)"] = "Prozent + Aktuell (75% | 2.3k)"
L["Percentage + Current/Max"] = "Prozent + Aktuell/Max"

-- Health/Mana text
L["Always Show Health Text"] = "Lebens-Text immer anzeigen"
L["Show health text always (true) or only on hover (false)"] = "Lebens-Text immer anzeigen (true) oder nur beim Darüberfahren (false)"
L["Always show health text on party frames (instead of only on hover)"] = "Lebens-Text in Gruppenfenstern immer anzeigen (statt nur beim Darüberfahren)"
L["Always display health text (otherwise only on mouseover)"] = "Lebens-Text immer anzeigen (sonst nur bei Mouseover)"
L["Always Show Mana Text"] = "Mana-Text immer anzeigen"
L["Show mana/power text always (true) or only on hover (false)"] = "Mana-/Ressourcen-Text immer anzeigen (true) oder nur beim Darüberfahren (false)"
L["Always show mana text on party frames (instead of only on hover)"] = "Mana-Text in Gruppenfenstern immer anzeigen (statt nur beim Darüberfahren)"
L["Always display mana/energy/rage text (otherwise only on mouseover)"] = "Mana-/Energie-/Wut-Text immer anzeigen (sonst nur bei Mouseover)"

-- Player frame specific
L["Player Frame"] = "Spielerfenster"
L["Dragon Decoration"] = "Drachendekoration"
L["Add decorative dragon to your player frame for a premium look"] = "Dekorativen Drachen am Spielerfenster hinzufügen (Premium-Look)"
L["None"] = "Keine"
L["Elite Dragon (Golden)"] = "Elite-Drache (golden)"
L["Elite (Golden)"] = "Elite (golden)"
L["RareElite Dragon (Winged)"] = "Selten-Elite-Drache (geflügelt)"
L["RareElite (Winged)"] = "Selten-Elite (geflügelt)"
L["Glow Effects"] = "Leuchteffekte"
L["Show Rest Glow"] = "Ruhen-Leuchten anzeigen"
L["Show a golden glow around the player frame when resting (in an inn or city). Works with all frame modes: normal, elite, fat health bar, and vehicle."] = "Goldenes Leuchten um das Spielerfenster anzeigen, wenn du ruhst (in Gasthaus oder Stadt). Funktioniert mit allen Modi: normal, elite, breite Lebensleiste und Fahrzeug."
L["Golden glow around the player frame when resting (inn or city). Works with all frame modes."] = "Goldenes Leuchten um das Spielerfenster beim Ruhen (Gasthaus oder Stadt). Funktioniert mit allen Fenster-Modi."
L["Always Show Alternate Mana Text"] = "Alternativen Mana-Text immer anzeigen"
L["Show mana text always visible (default: hover only)"] = "Mana-Text immer sichtbar anzeigen (Standard: nur beim Darüberfahren)"
L["Alternate Mana (Druid)"] = "Alternatives Mana (Druide)"
L["Always Show"] = "Immer anzeigen"
L["Druid mana text visible at all times, not just on hover."] = "Druiden-Mana-Text immer sichtbar, nicht nur beim Darüberfahren."
L["Alternate Mana Text Format"] = "Format alternativer Mana-Text"
L["Choose text format for alternate mana display"] = "Textformat für die Anzeige des alternativen Manas wählen"

-- Fat Health Bar
L["Health Bar Style"] = "Lebensleisten-Stil"
L["Fat Health Bar"] = "Breite Lebensleiste"
L["Enable"] = "Aktivieren"
L["Full-width health bar that fills the entire frame area. Uses modified border texture that removes the inner divider line. Compatible with Dragon Decoration (requires fat variant textures). Note: Automatically disabled during vehicle UI."] = "Lebensleiste in voller Breite, die den gesamten Fensterbereich füllt. Verwendet eine angepasste Rahmen-Textur ohne innere Trennlinie. Kompatibel mit Drachendekoration (benötigt breite Variant-Texturen). Hinweis: Wird automatisch im Fahrzeug-UI deaktiviert."
L["Full-width health bar. Auto-disabled in vehicles."] = "Lebensleiste in voller Breite. Im Fahrzeug automatisch deaktiviert."
L["Hide Mana Bar (Fat Mode)"] = "Mana-Leiste ausblenden (Breitmodus)"
L["Hide Mana Bar"] = "Mana-Leiste ausblenden"
L["Completely hide the mana bar when Fat Health Bar is active."] = "Mana-Leiste vollständig ausblenden, wenn die breite Lebensleiste aktiv ist."
L["Mana Bar Width (Fat Mode)"] = "Mana-Leistenbreite (Breitmodus)"
L["Mana Bar Width"] = "Mana-Leistenbreite"
L["Width of the mana bar when Fat Health Bar is active. Movable via Editor Mode."] = "Breite der Mana-Leiste, wenn die breite Lebensleiste aktiv ist. Verschiebbar über Editor-Modus."
L["Mana Bar Height (Fat Mode)"] = "Mana-Leistenhöhe (Breitmodus)"
L["Mana Bar Height"] = "Mana-Leistenhöhe"
L["Height of the mana bar when Fat Health Bar is active."] = "Höhe der Mana-Leiste, wenn die breite Lebensleiste aktiv ist."
L["Mana Bar Texture"] = "Mana-Leistentextur"
L["Choose the texture style for the power/mana bar. Only applies in Fat Health Bar mode."] = "Texturstil für Ressourcen-/Mana-Leiste wählen. Gilt nur im Breitmodus."
L["DragonUI (Default)"] = "DragonUI (Standard)"
L["Blizzard Classic"] = "Blizzard Classic"
L["Flat Solid"] = "Flach (einfarbig)"
L["Smooth"] = "Glatt"
L["Aluminium"] = "Aluminium"
L["LiteStep"] = "LiteStep"

-- Power Bar Colors
L["Power Bar Colors"] = "Ressourcenleisten-Farben"
L["Mana"] = "Mana"
L["Rage"] = "Wut"
L["Energy"] = "Energie"
L["Runic Power"] = "Runenmacht"
L["Happiness"] = "Zufriedenheit"
L["Runes"] = "Runen"
L["Reset Colors to Default"] = "Farben auf Standard zurücksetzen"

-- Target frame
L["Target Frame"] = "Zielfenster"
L["Threat Glow"] = "Bedrohungs-Glühen"
L["Show threat glow effect"] = "Bedrohungs-Leuchteffekt anzeigen"

-- Focus frame
L["Focus Frame"] = "Fokusfenster"
L["Override Position"] = "Position überschreiben"
L["Override default positioning"] = "Standardpositionierung überschreiben"
L["Move the pet frame independently from the player frame."] = "Begleiterfenster unabhängig vom Spielerfenster bewegen."

-- Pet frame
L["Pet Frame"] = "Begleiterfenster"
L["Allows the pet frame to be moved freely. When unchecked, it will be positioned relative to the player frame."] = "Erlaubt, das Begleiterfenster frei zu bewegen. Wenn deaktiviert, wird es relativ zum Spielerfenster positioniert."
L["Horizontal position (only active if Override is checked)"] = "Horizontale Position (nur aktiv, wenn Überschreiben aktiviert ist)"
L["Vertical position (only active if Override is checked)"] = "Vertikale Position (nur aktiv, wenn Überschreiben aktiviert ist)"

-- Target of Target
L["Follows the Target frame by default. Move it in Editor Mode (/dragonui edit) to detach and position freely."] = "Folgt standardmäßig dem Zielfenster. Im Editor-Modus (/dragonui edit) bewegen, um es zu lösen und frei zu positionieren."
L["Detached — positioned freely via Editor Mode"] = "Gelöst — frei positioniert via Editor-Modus"
L["Attached — follows Target frame"] = "Angeheftet — folgt dem Zielfenster"
L["Re-attach to Target"] = "Wieder ans Ziel anheften"

-- Target of Focus
L["Target of Focus"] = "Ziel des Fokus"
L["Follows the Focus frame by default. Move it in Editor Mode (/dragonui edit) to detach and position freely."] = "Folgt standardmäßig dem Fokusfenster. Im Editor-Modus (/dragonui edit) bewegen, um es zu lösen und frei zu positionieren."
L["Attached — follows Focus frame"] = "Angeheftet — folgt dem Fokusfenster"
L["Re-attach to Focus"] = "Wieder an den Fokus anheften"

-- Party Frames
L["Party Frames"] = "Gruppenfenster"
L["Party Frames Configuration"] = "Gruppenfenster-Konfiguration"
L["Custom styling for party member frames with automatic health/mana text display and class colors."] = "Eigenes Styling für Gruppenmitgliederfenster mit automatischer Lebens-/Mana-Textanzeige und Klassenfarben."
L["Orientation"] = "Ausrichtung"
L["Vertical"] = "Vertikal"
L["Horizontal"] = "Horizontal"
L["Party frame orientation"] = "Ausrichtung der Gruppenfenster"
L["Vertical Padding"] = "Vertikaler Abstand"
L["Space between party frames in vertical mode"] = "Abstand zwischen Gruppenfenstern im vertikalen Modus"
L["Space between party frames in vertical mode."] = "Abstand zwischen Gruppenfenstern im vertikalen Modus."
L["Horizontal Padding"] = "Horizontaler Abstand"
L["Space between party frames in horizontal mode"] = "Abstand zwischen Gruppenfenstern im horizontalen Modus"
L["Space between party frames in horizontal mode."] = "Abstand zwischen Gruppenfenstern im horizontalen Modus."

-- ============================================================================
-- XP & REP BARS TAB
-- ============================================================================

L["Bar Style"] = "Leistenstil"
L["XP / Rep Bar Style"] = "EP-/Rufleisten-Stil"
L["DragonflightUI: fully custom bars with rested XP background.\nRetailUI: atlas-based reskin of Blizzard bars.\n\nChanging style requires a UI reload."] = "DragonflightUI: vollständig eigene Leisten mit Ruh-EP-Hintergrund.\nRetailUI: atlasbasierter Reskin der Blizzard-Leisten.\n\nStilwechsel erfordert ein UI-Neuladen."
L["DragonflightUI"] = "DragonflightUI"
L["RetailUI"] = "RetailUI"
L["XP bar style changed to "] = "EP-Leistenstil geändert zu "
L["A UI reload is required to apply this change."] = "Ein UI-Neuladen ist erforderlich, um diese Änderung anzuwenden."

-- Size & Scale
L["Size & Scale"] = "Größe & Skalierung"
L["Bar Height"] = "Leistenhöhe"
L["Height of the XP and Reputation bars (in pixels)."] = "Höhe der EP- und Rufleisten (in Pixel)."
L["Experience Bar Scale"] = "Skalierung EP-Leiste"
L["Scale of the experience bar."] = "Skalierung der EP-Leiste."
L["Reputation Bar Scale"] = "Rufleisten-Skalierung"
L["Scale of the reputation bar."] = "Skalierung der Rufleiste."

-- Rested XP
L["Rested XP"] = "Ruhe-EP"
L["Show Rested XP Background"] = "Ruhe-EP-Hintergrund anzeigen"
L["Display a translucent bar showing the total available rested XP range.\n(DragonflightUI style only)"] = "Durchsichtige Leiste anzeigen, die den gesamten verfügbaren Ruhe-EP-Bereich zeigt.\n(Nur DragonflightUI-Stil)"
L["Show Exhaustion Tick"] = "Erschöpfungsmarke anzeigen"
L["Show the exhaustion tick indicator on the XP bar, marking where rested XP ends."] = "Erschöpfungs-Markierung auf der EP-Leiste anzeigen, die das Ende der Ruhe-EP markiert."

-- Text Display
L["Text Display"] = "Textanzeige"
L["Always Show Text"] = "Text immer anzeigen"
L["Always display XP/Rep text instead of only on hover."] = "EP-/Ruf-Text immer anzeigen statt nur beim Darüberfahren."
L["Show XP Percentage"] = "EP-Prozent anzeigen"
L["Display XP percentage alongside the value text."] = "EP-Prozent zusätzlich zum Wert anzeigen."

-- ============================================================================
-- PROFILES TAB
-- ============================================================================

L["Database not available."] = "Datenbank nicht verfügbar."
L["Save and switch between different configurations per character."] = "Pro Charakter unterschiedliche Konfigurationen speichern und wechseln."
L["Current Profile"] = "Aktuelles Profil"
L["Active: "] = "Aktiv: "
L["Switch or Create Profile"] = "Profil wechseln oder erstellen"
L["Select Profile"] = "Profil auswählen"
L["New Profile Name"] = "Neuer Profilname"
L["Copy From"] = "Kopieren von"
L["Copies all settings from the selected profile into your current one."] = "Kopiert alle Einstellungen des gewählten Profils in dein aktuelles Profil."
L["Copied profile: "] = "Profil kopiert: "
L["Delete Profile"] = "Profil löschen"
L["Warning: Deleting a profile is permanent and cannot be undone."] = "Warnung: Das Löschen eines Profils ist dauerhaft und kann nicht rückgängig gemacht werden."
L["Delete"] = "Löschen"
L["Deleted profile: "] = "Profil gelöscht: "
L["Reset Current Profile"] = "Aktuelles Profil zurücksetzen"
L["Restores the current profile to its defaults. This cannot be undone."] = "Setzt das aktuelle Profil auf Standardwerte zurück. Das kann nicht rückgängig gemacht werden."
L["Reset Profile"] = "Profil zurücksetzen"
L["All changes will be lost and the UI will be reloaded.\nAre you sure you want to reset your profile?"] = "Alle Änderungen gehen verloren und die UI wird neu geladen.\nBist du sicher, dass du dein Profil zurücksetzen möchtest?"
L["Profile reset to defaults."] = "Profil auf Standard zurückgesetzt."
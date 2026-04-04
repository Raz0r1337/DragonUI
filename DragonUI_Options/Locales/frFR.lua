--[[
 DragonUI_Options - French Locale (frFR)
 Community translation — Edit this file to contribute!

 Guidelines:
 - Use `true` for strings you haven't translated yet (falls back to English)
 - Keep format specifiers like %s, %d, %.1f intact
 - Keep "DragonUI" as addon name untranslated
 - Keep color codes |cff...|r outside of L[] strings
]]

local L = LibStub("AceLocale-3.0"):NewLocale("DragonUI_Options", "frFR")
if not L then return end

-- Example:
-- L["General"] = "Général"

-- LAYOUT PRESETS
L["Layout Presets"] = "Préréglages de disposition"
L["Save and restore complete UI layouts. Each preset captures all positions, scales, and settings."] = "Sauvegardez et restaurez des dispositions d'interface complètes. Chaque préréglage capture toutes les positions, échelles et paramètres."
L["No presets saved yet."] = "Aucun préréglage sauvegardé."
L["Save New Preset"] = "Nouveau préréglage"
L["Save your current UI layout as a new preset."] = "Sauvegarder votre disposition actuelle comme nouveau préréglage."
L["Preset"] = "Préréglage"
L["Enter a name for this preset:"] = "Entrez un nom pour ce préréglage :"
L["Save"] = "Sauvegarder"
L["Load"] = "Charger"
L["Load preset '%s'? This will overwrite your current layout settings."] = "Charger le préréglage '%s' ? Cela écrasera vos paramètres de disposition actuels."
L["Load Preset"] = "Charger un préréglage"
L["Delete preset '%s'? This cannot be undone."] = "Supprimer le préréglage '%s' ? Cette action est irréversible."
L["Delete Preset"] = "Supprimer un préréglage"
L["Duplicate Preset"] = "Dupliquer un préréglage"
L["Preset saved: "] = "Préréglage sauvegardé : "
L["Preset loaded: "] = "Préréglage chargé : "
L["Preset deleted: "] = "Préréglage supprimé : "
L["Preset duplicated: "] = "Préréglage dupliqué : "
L["Also delete all saved layout presets?"] = "Supprimer également tous les préréglages de disposition sauvegardés ?"
L["Presets kept."] = "Préréglages conservés."

-- PRESET IMPORT / EXPORT
L["Export Preset"] = "Exporter le préréglage"
L["Import Preset"] = "Importer un préréglage"
L["Import a preset from a text string shared by another player."] = "Importer un préréglage depuis un texte partagé par un autre joueur."
L["Import"] = "Importer"
L["Select All"] = "Tout sélectionner"
L["Close"] = "Fermer"
L["Enter a name for the imported preset:"] = "Entrez un nom pour le préréglage importé :"
L["Imported Preset"] = "Préréglage importé"
L["Preset imported: "] = "Préréglage importé : "
L["Invalid preset string."] = "Texte de préréglage invalide."
L["Not a valid DragonUI preset string."] = "Ce n'est pas un texte de préréglage DragonUI valide."
L["Failed to export preset."] = "Échec de l'exportation du préréglage."
L["Show Buff/Debuff on Focus"] = "Afficher les buffs/debuffs sur la focalisation"
L["Uses the native large focus frame mode to show buffs and debuffs on the focus frame."] = "Utilise le mode natif de grand cadre de focalisation pour afficher les buffs et debuffs sur le cadre de focalisation."

-- Chat Mods
L["Enable Chat Mods"] = "Activer les mods de chat"
L["Enables or disables Chat Mods."] = "Active ou désactive les mods de chat."
L["Editbox Position"] = "Position de la zone de saisie"
L["Choose where the chat editbox is positioned."] = "Choisissez o\u00f9 se trouve la zone de saisie du chat."
L["Top"] = "Haut"
L["Bottom"] = "Bas"
L["Middle"] = "Milieu"
L["Tab & Button Fade"] = "Fondu des onglets et boutons"
L["Opacity of tabs, buttons and chat background when not hovered. 0 = hidden, 1 = always visible."] = "Opacit\u00e9 des onglets, boutons et fond du chat sans survol. 0 = cach\u00e9, 1 = toujours visible."
L["Style Min Opacity"] = "Opacité minimale du style"
L["Minimum opacity of the chat and text box skin. At 0 it fades in sync with tabs; above 0 it stays partially visible even when idle."] = "Opacité minimale du style du chat et de la zone de texte. À 0 il s'estompe avec les onglets ; au-dessus, il reste partiellement visible au repos."
L["Chat Style"] = "Style du chat"
L["Visual style for the chat frame background."] = "Style visuel du fond du cadre de chat."
L["Editbox Style"] = "Style de la zone de saisie"
L["Visual style for the chat input box background."] = "Style visuel du fond de la zone de saisie du chat."
L["Dark"] = "Sombre"
L["DragonUI Style"] = "Style DragonUI"
L["Midnight"] = "Minuit"
L["Chat"] = "Chat"
L["Appearance"] = "Apparence"

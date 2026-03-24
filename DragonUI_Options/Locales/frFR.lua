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

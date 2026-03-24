--[[
 DragonUI_Options - Portuguese (Brazil) Locale (ptBR)
 Community translation — Edit this file to contribute!

 Guidelines:
 - Use `true` for strings you haven't translated yet (falls back to English)
 - Keep format specifiers like %s, %d, %.1f intact
 - Keep "DragonUI" as addon name untranslated
 - Keep color codes |cff...|r outside of L[] strings
]]

local L = LibStub("AceLocale-3.0"):NewLocale("DragonUI_Options", "ptBR")
if not L then return end

-- Example:
-- L["General"] = "Geral"

-- LAYOUT PRESETS
L["Layout Presets"] = "Predefinições de Layout"
L["Save and restore complete UI layouts. Each preset captures all positions, scales, and settings."] = "Salve e restaure layouts completos de interface. Cada predefinição captura todas as posições, escalas e configurações."
L["No presets saved yet."] = "Nenhuma predefinição salva ainda."
L["Save New Preset"] = "Salvar Nova Predefinição"
L["Save your current UI layout as a new preset."] = "Salvar o layout atual da interface como nova predefinição."
L["Preset"] = "Predefinição"
L["Enter a name for this preset:"] = "Digite um nome para esta predefinição:"
L["Save"] = "Salvar"
L["Load"] = "Carregar"
L["Load preset '%s'? This will overwrite your current layout settings."] = "Carregar predefinição '%s'? Isso sobrescreverá suas configurações de layout atuais."
L["Load Preset"] = "Carregar Predefinição"
L["Delete preset '%s'? This cannot be undone."] = "Excluir predefinição '%s'? Isso não pode ser desfeito."
L["Delete Preset"] = "Excluir Predefinição"
L["Duplicate Preset"] = "Duplicar Predefinição"
L["Preset saved: "] = "Predefinição salva: "
L["Preset loaded: "] = "Predefinição carregada: "
L["Preset deleted: "] = "Predefinição excluída: "
L["Preset duplicated: "] = "Predefinição duplicada: "
L["Also delete all saved layout presets?"] = "Também excluir todas as predefinições de layout salvas?"
L["Presets kept."] = "Predefinições mantidas."

-- PRESET IMPORT / EXPORT
L["Export Preset"] = "Exportar Predefinição"
L["Import Preset"] = "Importar Predefinição"
L["Import a preset from a text string shared by another player."] = "Importe uma predefinição de um texto compartilhado por outro jogador."
L["Import"] = "Importar"
L["Select All"] = "Selecionar Tudo"
L["Close"] = "Fechar"
L["Enter a name for the imported preset:"] = "Digite um nome para a predefinição importada:"
L["Imported Preset"] = "Predefinição Importada"
L["Preset imported: "] = "Predefinição importada: "
L["Invalid preset string."] = "Texto de predefinição inválido."
L["Not a valid DragonUI preset string."] = "Não é um texto de predefinição DragonUI válido."
L["Failed to export preset."] = "Falha ao exportar a predefinição."
L["Show Buff/Debuff on Focus"] = "Mostrar buffs/debuffs no foco"
L["Uses the native large focus frame mode to show buffs and debuffs on the focus frame."] = "Usa o modo nativo de quadro de foco grande para mostrar buffs e debuffs no quadro de foco."

--[[
================================================================================
DragonUI - Spanish Locale (esES)
================================================================================
]]

local L = LibStub("AceLocale-3.0"):NewLocale("DragonUI", "esES")
if not L then return end

-- ============================================================================
-- CORE / GENERAL
-- ============================================================================

L["Cannot toggle editor mode during combat!"] = "¡No se puede cambiar el modo editor durante combate!"
L["Cannot reset positions during combat!"] = "¡No se pueden restablecer las posiciones durante combate!"
L["Cannot toggle keybind mode during combat!"] = "¡No se puede cambiar el modo de atajos durante combate!"
L["Cannot move frames during combat!"] = "¡No se pueden mover marcos durante combate!"
L["Cannot open options in combat."] = "No se pueden abrir las opciones en combate."

L["Editor mode not available."] = "Modo editor no disponible."
L["Keybind mode not available."] = "Modo de atajos no disponible."
L["Vehicle debug not available"] = "Depuración de vehículo no disponible"
L["KeyBinding module not available"] = "Módulo de atajos de teclado no disponible"
L["Unable to open configuration"] = "No se pudo abrir la configuración"

L["Error executing pending operation:"] = "Error al ejecutar operación pendiente:"
L["Error -- Addon 'DragonUI_Options' not found or is disabled."] = "Error -- El addon 'DragonUI_Options' no se encontró o está desactivado."

-- ============================================================================
-- SLASH COMMANDS / HELP
-- ============================================================================

L["Unknown command: "] = "Comando desconocido: "
L["=== DragonUI Commands ==="] = "=== Comandos de DragonUI ==="
L["/dragonui or /dui - Open configuration"] = "/dragonui o /dui - Abrir configuración"
L["/dragonui config - Open configuration"] = "/dragonui config - Abrir configuración"
L["/dragonui edit - Toggle editor mode (move UI elements)"] = "/dragonui edit - Cambiar modo editor (mover elementos de UI)"
L["/dragonui reset - Reset all positions to defaults"] = "/dragonui reset - Restablecer todas las posiciones"
L["/dragonui reset <name> - Reset specific mover"] = "/dragonui reset <nombre> - Restablecer posición específica"
L["/dragonui status - Show module status"] = "/dragonui status - Mostrar estado de módulos"
L["/dragonui kb - Toggle keybind mode"] = "/dragonui kb - Cambiar modo de atajos"
L["/dragonui version - Show version info"] = "/dragonui version - Mostrar versión"
L["/dragonui help - Show this help"] = "/dragonui help - Mostrar esta ayuda"
L["/rl - Reload UI"] = "/rl - Recargar interfaz"

-- ============================================================================
-- STATUS DISPLAY
-- ============================================================================

L["=== DragonUI Status ==="] = "=== Estado de DragonUI ==="
L["Detected Modules:"] = "Módulos detectados:"
L["Loaded"] = "Cargado"
L["Not Loaded"] = "No cargado"
L["Registered Movers: "] = "Movedores registrados: "
L["Editable Frames: "] = "Marcos editables: "
L["DragonUI Version: "] = "Versión de DragonUI: "
L["Use /dragonui edit to enter edit mode, then right-click frames to reset."] = "Usa /dragonui edit para entrar en modo edición, luego haz clic derecho en marcos para restablecer."

-- ============================================================================
-- EDITOR MODE
-- ============================================================================

L["Exit Edit Mode"] = "Salir Editor"
L["Reset All Positions"] = "Restablecer Posiciones"
L["Are you sure you want to reset all interface elements to their default positions?"] = "¿Restablecer todos los elementos a su posición predeterminada?"
L["Yes"] = "Sí"
L["No"] = "No"
L["UI elements have been repositioned. Reload UI to ensure all graphics display correctly?"] = "Los elementos de la interfaz han sido reposicionados. ¿Recargar la interfaz para que se muestren correctamente?"
L["Reload Now"] = "Recargar Ahora"
L["Later"] = "Más Tarde"

-- ============================================================================
-- KEYBINDING MODULE
-- ============================================================================

L["LibKeyBound-1.0 not found or failed to load:"] = "LibKeyBound-1.0 no encontrado o error al cargar:"
L["Commands:"] = "Comandos:"
L["/dukb - Toggle keybinding mode"] = "/dukb - Cambiar modo de atajos"
L["/dukb help - Show this help"] = "/dukb help - Mostrar esta ayuda"
L["Module disabled."] = "Módulo desactivado."
L["Keybinding mode activated. Hover over buttons and press keys to bind them."] = "Modo de atajos activado. Pasa el ratón sobre los botones y pulsa teclas para asignarlas."
L["Keybinding mode deactivated."] = "Modo de atajos desactivado."

-- ============================================================================
-- GAME MENU
-- ============================================================================

L["DragonUI"] = "DragonUI"

-- ============================================================================
-- MINIMAP MODULE
-- ============================================================================

L["DragonUI: Minimap module restored to Blizzard defaults"] = "DragonUI: Módulo de minimapa restaurado a los valores de Blizzard"

-- ============================================================================
-- EDITOR MODE LABELS (displayed on mover overlays - keep SHORT)
-- ============================================================================

L["MainBar"] = "Barra Princ."
L["RightBar"] = "Barra Der."
L["LeftBar"] = "Barra Izq."
L["BottomBarLeft"] = "Barra Inf. Izq."
L["BottomBarRight"] = "Barra Inf. Der."
L["XPBar"] = "Barra XP"
L["RepBar"] = "Barra Rep."
L["MinimapFrame"] = "Minimapa"
L["LFGFrame"] = "Ojo de Mazmorra"
L["PlayerFrame"] = "Jugador"
L["ManaBar"] = "Barra Maná"
L["PetFrame"] = "Mascota"
L["ToT"] = "OdO"
L["ToF"] = "OdF"
L["tot"] = "OdO"
L["fot"] = "OdF"
L["PartyFrames"] = "Grupo"
L["TargetFrame"] = "Objetivo"
L["FocusFrame"] = "Foco"
L["BagsBar"] = "Bolsas"
L["MicroMenu"] = "Micromenú"
L["VehicleExitOverlay"] = "Salir Vehículo"
L["StanceOverlay"] = "Posturas"
L["petbar"] = "Barra Mascota"
L["TotemBarOverlay"] = "Tótems"
L["PlayerCastbar"] = "Barra Hechizos"
L["Auras"] = "Auras"
L["WeaponEnchants"] = "Encantamientos"
L["Loot Roll"] = "Botín"
L["Quest Tracker"] = "Misiones"

-- Mover tooltip strings
L["Drag to move"] = "Arrastra para mover"
L["Right-click to reset"] = "Clic der. para reiniciar"

-- Editor mode system messages
L["All editable frames shown for editing"] = "Marcos editables mostrados"
L["All editable frames hidden, positions saved"] = "Marcos ocultados, posiciones guardadas"

-- ============================================================================
-- COMPATIBILITY MODULE
-- ============================================================================

L["DragonUI Conflict Warning"] = "Advertencia de Conflicto de DragonUI"
L["The addon |cFFFFFF00%s|r conflicts with DragonUI."] = "El addon |cFFFFFF00%s|r entra en conflicto con DragonUI."
L["Reason:"] = "Razón:"
L["Disable the conflicting addon now?"] = "¿Desactivar el addon conflictivo ahora?"
L["Disable"] = "Desactivar"
L["Keep Both"] = "Mantener Ambos"

L["Conflicts with DragonUI's custom unit frame textures and power bar system."] = "Entra en conflicto con las texturas personalizadas de marcos de unidad y el sistema de barra de poder de DragonUI."
L["Known taint issues when manipulating party frames during combat. DragonUI provides automatic fixes."] = "Problemas conocidos de contaminación al manipular marcos de grupo en combate. DragonUI proporciona correcciones automáticas."
L["Resets minimap mask and blip textures. DragonUI re-applies its custom textures automatically."] = "Restablece la máscara del minimapa y las texturas de puntos. DragonUI vuelve a aplicar sus texturas personalizadas automáticamente."
L["SexyMap modifies the minimap borders, shape, and zone text which conflicts with DragonUI's minimap module."] = "SexyMap modifica los bordes del minimapa, la forma y el texto de zona, lo cual entra en conflicto con el módulo de minimapa de DragonUI."

-- Popup de compatibilidad SexyMap
L["DragonUI - SexyMap Detected"] = "DragonUI - SexyMap Detectado"
L["Which minimap do you want to use?"] = "¿Qué minimapa quieres usar?"
L["SexyMap"] = "SexyMap"
L["DragonUI"] = "DragonUI"
L["Hybrid"] = "Híbrido"
L["Recommended"] = "Recomendado"

-- Panel de opciones SexyMap
L["SexyMap Compatibility"] = "Compatibilidad SexyMap"
L["Minimap Mode"] = "Modo de Minimapa"
L["Choose how DragonUI and SexyMap share the minimap."] = "Elige cómo comparten el minimapa DragonUI y SexyMap."
L["Requires UI reload to apply."] = "Requiere recargar la interfaz para aplicar."
L["Uses SexyMap for the minimap."] = "Usa SexyMap para el minimapa."
L["Uses DragonUI for the minimap."] = "Usa DragonUI para el minimapa."
L["SexyMap visuals with DragonUI editor and positioning."] = "Aspecto de SexyMap, movible y configurable desde DragonUI."
L["Minimap mode changed. Reload UI to apply?"] = "Modo de minimapa cambiado. ¿Recargar interfaz para aplicar?"

-- Comandos de compatibilidad SexyMap
L["SexyMap compatibility mode has been reset. Reload UI to choose again."] = "El modo de compatibilidad SexyMap se ha restablecido. Recarga la interfaz para elegir de nuevo."
L["Current SexyMap mode: |cFFFFFF00%s|r"] = "Modo SexyMap actual: |cFFFFFF00%s|r"
L["No SexyMap mode selected (SexyMap not detected or not yet chosen)."] = "No se ha seleccionado modo SexyMap (SexyMap no detectado o aún no elegido)."
L["Show current SexyMap compatibility mode"] = "Mostrar modo de compatibilidad SexyMap actual"
L["Reset SexyMap mode choice (re-prompts on reload)"] = "Restablecer la elección de modo SexyMap (vuelve a preguntar al recargar)"
L["Loaded addons:"] = "Addons cargados:"

-- Boss Frames
L["boss"] = "Marcos de Jefe"
L["Boss Frames"] = "Marcos de Jefe"
L["Boss1Frame"] = "Marcos de Jefe"
L["Boss2Frame"] = "Marcos de Jefe"
L["Boss3Frame"] = "Marcos de Jefe"
L["Boss4Frame"] = "Marcos de Jefe"

-- ============================================================================
-- STATIC POPUPS
-- ============================================================================

L["Changing this setting requires a UI reload to apply correctly."] = "Cambiar esta opción requiere recargar la interfaz para aplicarse correctamente."
L["Reload UI"] = "Recargar Interfaz"
L["Not Now"] = "Ahora No"

-- Bag Sort
L["Sort Bags"] = "Ordenar Bolsas"
L["Sort Bank"] = "Ordenar Banco"
L["Sort Items"] = "Ordenar Objetos"
L["Click to sort items by type, rarity, and name."] = "Clic para ordenar objetos por tipo, rareza y nombre."

-- Micromenu Latencia
L["Network"] = "Red"
L["Latency"] = "Latencia"

-- Party Background CVar
L["Disable"] = "Desactivar"
L["Ignore"] = "Ignorar"
L["The Blizzard option |cFFFFFF00Party/Arena Background|r is enabled. This conflicts with DragonUI's party frames."] = "La opción de Blizzard |cFFFFFF00Fondo de Grupo/Arena|r está activada. Esto entra en conflicto con los marcos de grupo de DragonUI."
L["Disable it now?"] = "¿Desactivarla ahora?"

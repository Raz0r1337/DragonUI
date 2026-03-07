--[[
================================================================================
 DragonUI - 한국어 로케일 (koKR)
================================================================================
 지침(Guidelines):
 - 아직 번역하지 않은 문자열에는 `true`를 사용하세요. (영문이 기본값으로 출력됩니다)
 - %s, %d, %.1f와 같은 형식 지정자는 그대로 유지하세요.
 - /dragonui, /dui, /rl과 같은 슬래시 명령어는 번역하지 마세요.
 - 애드온 이름인 "DragonUI"는 번역하지 않고 그대로 둡니다.
 - 색상 코드(|cff...|r)는 L[] 문자열 바깥에 유지하세요.
================================================================================
]]

local L = LibStub("AceLocale-3.0"):NewLocale("DragonUI", "koKR")
if not L then return end

-- ============================================================================
-- 핵심 / 일반 (CORE / GENERAL)
-- ============================================================================

-- 전투 중 잠금 메시지 (Combat lockdown messages)
L["Cannot toggle editor mode during combat!"] = "전투 중에는 편집 모드를 열 수 없습니다!"
L["Cannot reset positions during combat!"] = "전투 중에는 위치를 초기화할 수 없습니다!"
L["Cannot toggle keybind mode during combat!"] = "전투 중에는 단축키 설정 모드를 열 수 없습니다!"
L["Cannot move frames during combat!"] = "전투 중에는 프레임을 이동할 수 없습니다!"
L["Cannot open options in combat."] = "전투 중에는 옵션을 열 수 없습니다."

-- 모듈 가용성 (Module availability)
L["Editor mode not available."] = "편집 모드를 사용할 수 없습니다."
L["Keybind mode not available."] = "단축키 설정 모드를 사용할 수 없습니다."
L["Vehicle debug not available"] = "탈것 디버그를 사용할 수 없습니다."
L["KeyBinding module not available"] = "단축키 설정 모듈을 사용할 수 없습니다."
L["Unable to open configuration"] = "설정창을 열 수 없습니다."

-- 오류 (Errors)
L["Error executing pending operation:"] = "대기 중인 작업 실행 오류:"
L["Error -- Addon 'DragonUI_Options' not found or is disabled."] = "오류 -- 'DragonUI_Options' 애드온을 찾을 수 없거나 비활성화되어 있습니다."

-- ============================================================================
-- 슬래시 명령어 / 도움말 (SLASH COMMANDS / HELP)
-- ============================================================================

L["Unknown command: "] = "알 수 없는 명령어: "
L["=== DragonUI Commands ==="] = "=== DragonUI 명령어 ==="
L["/dragonui or /dui - Open configuration"] = "/dragonui 또는 /dui - 설정창 열기"
L["/dragonui config - Open configuration"] = "/dragonui config - 설정창 열기"
L["/dragonui legacy - Open legacy AceConfig options"] = "/dragonui legacy - 기존 AceConfig 옵션 열기"
L["/dragonui edit - Toggle editor mode (move UI elements)"] = "/dragonui edit - 편집 모드 전환 (UI 요소 이동)"
L["/dragonui reset - Reset all positions to defaults"] = "/dragonui reset - 모든 위치를 기본값으로 초기화"
L["/dragonui reset <name> - Reset specific mover"] = "/dragonui reset <이름> - 특정 요소의 위치 초기화"
L["/dragonui status - Show module status"] = "/dragonui status - 모듈 상태 표시"
L["/dragonui kb - Toggle keybind mode"] = "/dragonui kb - 단축키 설정 모드 전환"
L["/dragonui version - Show version info"] = "/dragonui version - 버전 정보 표시"
L["/dragonui help - Show this help"] = "/dragonui help - 도움말 표시"
L["/rl - Reload UI"] = "/rl - UI 재설정(리로드)"

-- ============================================================================
-- 상태 표시 (STATUS DISPLAY)
-- ============================================================================

L["=== DragonUI Status ==="] = "=== DragonUI 상태 ==="
L["Detected Modules:"] = "감지된 모듈:"
L["Loaded"] = "로드됨"
L["Not Loaded"] = "로드되지 않음"
L["Registered Movers: "] = "등록된 이동 지점: "
L["Editable Frames: "] = "편집 가능한 프레임: "
L["DragonUI Version: "] = "DragonUI 버전: "
L["Use /dragonui edit to enter edit mode, then right-click frames to reset."] = "/dragonui edit를 입력하여 편집 모드로 들어간 뒤, 프레임을 우클릭하면 위치가 초기화됩니다."

-- ============================================================================
-- 편집 모드 (EDITOR MODE)
-- ============================================================================

L["Exit Edit Mode"] = "편집 모드 종료"
L["Reset All Positions"] = "모든 위치 초기화"
L["Are you sure you want to reset all interface elements to their default positions?"] = "모든 인터페이스 요소를 기본 위치로 초기화하시겠습니까?"
L["Yes"] = "예"
L["No"] = "아니요"
L["UI elements have been repositioned. Reload UI to ensure all graphics display correctly?"] = "UI 요소의 위치가 변경되었습니다. 모든 그래픽이 올바르게 표시되도록 UI를 재설정하시겠습니까?"
L["Reload Now"] = "지금 재설정"
L["Later"] = "나중에"

-- ============================================================================
-- 단축키 설정 모듈 (KEYBINDING MODULE)
-- ============================================================================

L["LibKeyBound-1.0 not found or failed to load:"] = "LibKeyBound-1.0을 찾을 수 없거나 로드에 실패했습니다:"
L["Commands:"] = "명령어:"
L["/dukb - Toggle keybinding mode"] = "/dukb - 단축키 설정 모드 전환"
L["/dukb help - Show this help"] = "/dukb help - 도움말 표시"
L["Module disabled."] = "모듈이 비활성화되었습니다."
L["Keybinding mode activated. Hover over buttons and press keys to bind them."] = "단축키 설정 모드가 활성화되었습니다. 버튼 위에 마우스를 올리고 키를 누르면 지정됩니다."
L["Keybinding mode deactivated."] = "단축키 설정 모드가 비활성화되었습니다."

-- ============================================================================
-- 게임 메뉴 (GAME MENU)
-- ============================================================================

L["DragonUI"] = "DragonUI"

-- ============================================================================
-- 미니맵 모듈 (MINIMAP MODULE)
-- ============================================================================

L["DragonUI: Minimap module restored to Blizzard defaults"] = "DragonUI: 미니맵 모듈이 블리자드 기본값으로 복구되었습니다."

-- ============================================================================
-- 편집 모드 레이블 (EDITOR MODE LABELS)
-- ============================================================================

L["MainBar"] = "주 단축바"
L["RightBar"] = "우측 단축바"
L["LeftBar"] = "좌측 단축바"
L["BottomBarLeft"] = "하단 좌측"
L["BottomBarRight"] = "하단 우측"
L["XPBar"] = "경험치 바"
L["RepBar"] = "평판 바"
L["MinimapFrame"] = "미니맵"
L["PlayerFrame"] = "플레이어"
L["ManaBar"] = "마나 바"
L["PetFrame"] = "소환수"
L["ToT"] = "대상의 대상"
L["ToF"] = "주시의 대상"
L["tot"] = "대상의 대상"
L["fot"] = "주시의 대상"
L["PartyFrames"] = "파티"
L["TargetFrame"] = "대상"
L["FocusFrame"] = "주시 대상"
L["BagsBar"] = "가방"
L["MicroMenu"] = "마이크로 메뉴"
L["VehicleExitOverlay"] = "탈것 내리기"
L["StanceOverlay"] = "태세바"
L["petbar"] = "소환수바"
L["TotemBarOverlay"] = "토템바"
L["PlayerCastbar"] = "시전바"
L["Auras"] = "오라 (버프/디버프)"
L["Loot Roll"] = "주사위 굴림"
L["Quest Tracker"] = "퀘스트 추적기"

-- 이동 지점 툴팁 (Mover tooltip strings)
L["Drag to move"] = "드래그 이동"
L["Right-click to reset"] = "우클릭으로 초기화"

-- 편집 모드 시스템 메시지
L["All editable frames shown for editing"] = "편집을 위해 모든 프레임을 표시합니다."
L["All editable frames hidden, positions saved"] = "모든 프레임을 숨기고 위치를 저장했습니다."

-- ============================================================================
-- 고정 팝업창 (STATIC POPUPS)
-- ============================================================================

L["Changing this setting requires a UI reload to apply correctly."] = "이 설정을 올바르게 적용하려면 UI를 재설정해야 합니다."
L["Reload UI"] = "UI 재설정"
L["Not Now"] = "나중에"

--[[
================================================================================
 DragonUI_Options - 한국어 로케일 (koKR)
================================================================================
 지침(Guidelines):
 - 아직 번역하지 않은 문자열에는 `true`를 사용하세요. (영문이 기본값으로 출력됩니다)
 - %s, %d, %.1f와 같은 형식 지정자(변수값 자리)는 그대로 유지하세요.
 - 애드온 이름인 "DragonUI"는 번역하지 않고 그대로 둡니다.
 - 색상 코드(|cff...|r)는 L[] 문자열 바깥에 유지하세요.
================================================================================											
]]

local L = LibStub("AceLocale-3.0"):NewLocale("DragonUI_Options", "koKR")
if not L then return end
-- ============================================================================
-- 일반 / 패널 (GENERAL / PANEL)
-- ============================================================================

L["DragonUI"] = "DragonUI"
L["experimental"] = "실험적 기능"
L["Editor Mode"] = "편집 모드"
L["KeyBind Mode"] = "단축키 설정 모드"
L["Exit Editor Mode"] = "편집 모드 종료"
L["KeyBind Mode Active"] = "단축키 설정 모드 활성화됨"
L["Move UI Elements"] = "UI 요소 이동"
L["/dragonui  |  /dragonui legacy for classic options"] = "/dragonui  |  기존 Ace 옵션은 /dragonui legacy"
L["Cannot open options during combat."] = "전투 중에는 옵션을 열 수 없습니다."

-- 빠른 설정 (Quick Actions)
L["Quick Actions"] = "빠른 설정"
L["About"] = "정보"
L["Dragonflight-inspired UI for WotLK 3.3.5a."] = "용군단 스타일에서 영감을 받은 리분(3.3.5a)용 UI입니다."
L["Experimental Branch — This options panel is in early beta."] = "실험적 버전 — 이 옵션 패널은 초기 베타 단계입니다."
L["Features may change or be incomplete. Report issues on GitHub."] = "기능이 변경되거나 미완성일 수 있습니다. 문제는 GitHub에 제보해 주세요."
L["Use /dragonui or /pi to toggle this panel."] = "/dragonui 또는 /pi 명령어로 이 창을 열 수 있습니다."
L["Use /dragonui legacy to open the classic AceConfig options."] = "/dragonui legacy를 사용하여 기존 AceConfig 옵션을 엽니다."

-- ============================================================================
-- 고정 팝업창 (STATIC POPUPS)
-- ============================================================================
L["Changing this setting requires a UI reload to apply correctly."] = "이 설정을 적용하려면 UI를 재설정(Reload)해야 합니다."
L["Reload UI"] = "UI 재설정"
L["Not Now"] = "나중에"
L["Reload Now"] = "지금 재설정"
L["Cancel"] = "취소"
L["Yes"] = "예"
L["No"] = "아니요"

-- ============================================================================
-- 탭 이름 (TAB NAMES)
-- ============================================================================

L["General"] = "일반"
L["Modules"] = "모듈"
L["Action Bars"] = "행동 단축바"
L["Additional Bars"] = "추가 단축바"
L["Cast Bars"] = "시전바"
L["Enhancements"] = "시각 효과"
L["Micro Menu"] = "마이크로 메뉴"
L["Minimap"] = "미니맵"
L["Profiles"] = "프로필"
L["Quest Tracker"] = "퀘스트 추적기"
L["Unit Frames"] = "유닛 프레임"
L["XP & Rep Bars"] = "경험치 및 평판 바"

-- ============================================================================
-- 모듈 탭 (MODULES TAB)
-- ============================================================================

-- 제목 및 설명 (Headers & descriptions)
L["Module Control"] = "모듈 제어"
L["Enable or disable specific DragonUI modules"] = "특정 DragonUI 모듈 활성화/비활성화"
L["Toggle individual modules on or off. Disabled modules revert to the default Blizzard UI."] = "개별 모듈을 켜거나 끕니다. 비활성화된 모듈은 기본 블리자드 UI로 돌아갑니다."
L["Visual enhancements that add Dragonflight-style polish to the UI."] = "용군단 스타일의 세련미를 더해주는 시각적 강화 기능입니다."
L["Warning: These are individual module controls. The options above may control multiple modules at once. Changes here will be reflected above and vice versa."] = "경고: 개별 모듈 제어 설정입니다. 위의 그룹 설정이 우선순위를 가질 수 있으며, 여기서 변경한 내용은 상단 설정에도 반영됩니다."
L["Warning:"] = "경고:"
L["Individual overrides. The grouped toggles above take priority."] = "개별 설정보다 상단의 그룹 통합 설정이 우선합니다."
L["Advanced - Individual Module Control"] = "고급 - 개별 모듈 제어"

-- 섹션 제목 (Section headers)
L["Cast Bars"] = "시전바"
L["Other Modules"] = "기타 모듈"
L["UI Systems"] = "UI 시스템"
L["Enable All Action Bar Modules"] = "모든 단축바 모듈 활성화"

-- 토글 레이블 (Toggle labels)
L["Player Castbar"] = "플레이어 시전바"
L["Target Castbar"] = "대상 시전바"
L["Focus Castbar"] = "주시 대상 시전바"
L["Action Bars System"] = "행동 단축바 시스템"
L["Micro Menu & Bags"] = "마이크로 메뉴 및 가방"
L["Cooldown Timers"] = "재사용 대기시간 타이머"
L["Minimap System"] = "미니맵 시스템"
L["Buff Frame System"] = "버프 프레임 시스템"
L["Dark Mode"] = "다크 모드"
L["Range Indicator"] = "거리 표시기"
L["Item Quality Borders"] = "아이템 품질 테두리"
L["Enable Enhanced Tooltips"] = "강화된 툴팁 활성화"
L["KeyBind Mode"] = "단축키 설정 모드"
L["Quest Tracker"] = "퀘스트 추적기"

-- 모듈 활성화 설명 (Module toggle descriptions)
L["Enable DragonUI player castbar. When disabled, shows default Blizzard castbar."] = "DragonUI 플레이어 시전바를 활성화합니다. 비활성 시 기본 시전바가 표시됩니다."
L["Enable DragonUI player castbar styling."] = "DragonUI 스타일의 플레이어 시전바를 사용합니다."
L["Enable DragonUI target castbar. When disabled, shows default Blizzard castbar."] = "DragonUI 대상 시전바를 활성화합니다."
L["Enable DragonUI target castbar styling."] = "DragonUI 스타일의 대상 시전바를 사용합니다."
L["Enable DragonUI focus castbar. When disabled, shows default Blizzard castbar."] = "DragonUI 주시 대상 시전바를 활성화합니다."
L["Enable DragonUI focus castbar styling."] = "DragonUI 스타일의 주시 대상 시전바를 사용합니다."
L["Enable the complete DragonUI action bars system. This controls: Main action bars, vehicle interface, stance/shapeshift bars, pet action bars, multicast bars (totems/possess), button styling, and hide Blizzard elements. When disabled, all action bar related features will use default Blizzard interface."] = "DragonUI 행동 단축바 시스템 전체를 활성화합니다. 주 단축바, 탈것 인터페이스, 태세/변신 바, 소환수 바, 토템 바, 버튼 스타일 및 기본 UI 숨기기를 제어합니다. 비활성 시 모든 단축바는 블리자드 기본 인터페이스를 사용합니다."
L["Master toggle for the complete action bars system."] = "단축바 시스템 전체 통합 설정입니다."
L["Includes main bars, vehicle, stance, pet, totem bars, and button styling."] = "기본 바, 탈것, 태세, 소환수, 토템 바 및 버튼 스타일을 포함합니다."
L["Apply DragonUI micro menu and bags system styling and positioning. Includes character button, spellbook, talents, etc. and bag management. When disabled, these elements will use default Blizzard positioning and styling."] = "마이크로 메뉴 및 가방의 스타일과 위치를 적용합니다. 비활성 시 기본 위치와 스타일을 사용합니다."
L["Micro menu and bags styling."] = "마이크로 메뉴 및 가방 스타일 설정."
L["Show cooldown timers on action buttons. When disabled, cooldown timers will be hidden and the system will be completely deactivated."] = "단축바 버튼에 재사용 대기시간 숫자를 표시합니다."
L["Show cooldown timers on action buttons."] = "단축바에 쿨타임 숫자를 표시합니다."
L["Enable DragonUI minimap enhancements including custom styling, positioning, tracking icons, and calendar. When disabled, uses default Blizzard minimap appearance and positioning."] = "커스텀 스타일, 위치 설정, 추적 아이콘 및 달력을 포함한 미니맵 강화 기능을 활성화합니다."
L["Minimap styling, tracking icons, and calendar."] = "미니맵 스타일, 추적 아이콘 및 달력 설정."
L["Enable DragonUI buff frame with custom styling, positioning, and toggle button functionality. When disabled, uses default Blizzard buff frame appearance and positioning."] = "커스텀 스타일과 위치가 적용된 버프 프레임을 활성화합니다."
L["Buff frame styling and toggle button."] = "버프 프레임 스타일 및 토글 버튼."
L["DragonUI quest tracker positioning and styling."] = "DragonUI 퀘스트 추적기 위치 및 스타일 설정."
L["LibKeyBound integration for intuitive hover + key press binding."] = "마우스를 올리고 키를 눌러 즉시 단축키를 지정하는 기능을 활성화합니다."

-- 단축키 설정 모드 활성화 설명 (Toggle keybinding mode description)
L["Toggle keybinding mode. Hover over action buttons and press keys to bind them instantly. Press ESC to clear bindings."] = "단축키 설정 모드를 켭니다. 버튼 위에 마우스를 올리고 키를 누르면 즉시 지정됩니다. ESC를 누르면 해제됩니다."

-- 동적 설명 활성화/비활성화 (Enable/disable dynamic descriptions)
L["Enable/disable "] = "활성화/비활성화: "

-- 다크 모드 (Dark Mode)
L["Dark Mode Intensity"] = "다크 모드 강도"
L["Light (subtle)"] = "밝게 (약함)"
L["Medium (balanced)"] = "중간 (보통)"
L["Dark (maximum)"] = "어둡게 (강함)"
L["Apply darker tinted textures to all UI chrome: action bars, unit frames, minimap, bags, micro menu, and more."] = "모든 UI 요소(단축바, 유닛 프레임, 미니맵, 가방 등)에 어두운 질감을 적용합니다."
L["Apply darker tinted textures to all UI elements."] = "모든 UI 요소에 어두운 틴트를 적용합니다."
L["Darkens UI borders and chrome only: action bar borders, unit frame borders, minimap border, bag slot borders, micro menu, castbar borders, and decorative elements. Icons, portraits, and abilities are never affected."] = "테두리와 프레임만 어둡게 만듭니다. 아이콘, 초상화, 스킬 자체에는 영향을 주지 않습니다."
L["Enable Dark Mode"] = "다크 모드 활성화"

-- 다크 모드 - 사용자 지정 색상 (Dark Mode - Custom Color)
L["Custom Color"] = "사용자 지정 색상"
L["Override presets with a custom tint color."] = "프리셋 대신 사용자가 지정한 색조를 적용합니다."
L["Tint Color"] = "색조 선택"
L["Intensity"] = "강도"

-- 사거리 표시기 (Range Indicator)
L["Tint action button icons when target is out of range (red), not enough mana (blue), or unusable (gray)."] = "대상이 사거리 밖이면 빨간색, 마나 부족 시 파란색, 사용 불가 시 회색으로 아이콘을 색칠합니다."
L["Tints action button icons based on range and usability: red = out of range, blue = not enough mana, gray = unusable."] = "사거리 및 사용 가능 여부에 따라 아이콘 색상을 변경합니다."
L["Enable Range Indicator"] = "거리 표시기 활성화"
L["Color action button icons when target is out of range or ability is unusable."] = "대상이 사거리 밖이거나 기술을 사용할 수 없을 때 단축바 아이콘에 색상을 입힙니다."

-- 아이템 등급 테두리 (Item Quality Borders)
L["Show colored glow borders on action buttons containing items, colored by item quality (green = uncommon, blue = rare, purple = epic, etc.)."] = "단축바에 등록된 아이템의 품질에 따라 테두리 색상을 표시합니다."
L["Enable Item Quality Borders"] = "아이템 품질 테두리 활성화"
L["Show quality-colored borders on items in bags, character panel, bank, merchant, and inspect frames."] = "가방, 캐릭터 창, 은행, 상점 등의 아이템에 품질 색상 테두리를 표시합니다."
L["Adds quality-colored glow borders to items in your bags, character panel, bank, merchant, and inspect frames: green = uncommon, blue = rare, purple = epic, orange = legendary."] = "가방, 캐릭터 창, 은행, 상점, 살펴보기 창의 아이템에 등급별 색상 테두리를 추가합니다: 녹색 = 고급, 파란색 = 희귀, 보라색 = 영웅, 주황색 = 전설."
L["Minimum Quality"] = "최소 품질"
L["Only show colored borders for items at or above this quality level."] = "설정된 등급 이상의 아이템만 품질 테두리를 표시합니다."
L["Poor"] = "하급 (회색)"
L["Common"] = "일반 (흰색)"
L["Uncommon"] = "고급 (녹색)"
L["Rare"] = "희귀 (청색)"
L["Epic"] = "영웅 (자색)"
L["Legendary"] = "전설 (주황)"

-- 강화된 툴팁 (Enhanced Tooltips)
L["Enhanced Tooltips"] = "강화된 툴팁"
L["Improve GameTooltip with class-colored borders, class-colored names, target-of-target info, and styled health bars."] = "직업 색상 테두리, 이름, 대상의 대상 정보 및 생명력 바 스타일을 개선합니다."
L["Improves GameTooltip with class-colored borders, class-colored names, target-of-target info, and styled health bars."] = "툴팁에 직업 색상 테두리와 이름, 대상의 대상 정보, 강화된 생명력 바 기능을 추가합니다."
L["Activate all tooltip improvements. Sub-options below control individual features."] = "모든 툴팁 개선 기능을 활성화합니다. 아래 옵션으로 개별 제어가 가능합니다."
L["Class-Colored Border"] = "직업 색상 테두리"
L["Color the tooltip border by the unit's class (players) or reaction (NPCs)."] = "툴팁 테두리를 직업 색상(플레이어) 또는 관계 색상(NPC)으로 표시합니다."
L["Class-Colored Name"] = "직업 색상 이름"
L["Color the unit name text in the tooltip by class color (players only)."] = "툴팁 내 이름을 직업 색상으로 표시합니다."
L["Target of Target"] = "대상의 대상"
L["Add a 'Targeting: <name>' line showing who the unit is targeting."] = "단위가 누구를 대상으로 잡고 있는지 정보를 추가합니다."
L["Add a 'Targeting: <name>' line to the tooltip showing who the unit is targeting."] = "툴팁에 해당 유닛의 대상을 보여주는 '대상: <이름>' 줄을 추가합니다."
L["Styled Health Bar"] = "강화된 생명력 바"
L["Restyle the tooltip health bar with class/reaction colors."] = "툴팁의 생명력 바를 직업 또는 관계 색상에 맞춰 변경합니다."
L["Restyle the tooltip health bar with class/reaction colors and slimmer look."] = "툴팁의 생명력 바를 직업 또는 관계 색상에 맞추고 더 얇은 외형으로 변경합니다."
L["Anchor to Cursor"] = "커서에 고정"
L["Make the tooltip follow the cursor position instead of the default anchor."] = "툴팁을 기본 고정 위치 대신 커서 위치를 따라다니게 합니다."
L["Make the tooltip follow the cursor position instead of using the default anchor."] = "툴팁이 기본 고정 위치를 사용하지 않고 커서 위치를 따라다니도록 설정합니다."

-- 고급 모듈 - 대체 표시 이름 (Advanced modules - Fallback display names)
L["Main Bars"] = "주 단축바"
L["Vehicle"] = "탈것"
L["Stance Bar"] = "태세바"
L["Pet Bar"] = "소환수바"
L["Multicast"] = "멀티캐스트"
L["Buttons"] = "버튼"
L["Hide Blizzard Elements"] = "블리자드 기본 요소 숨기기"
L["Buffs"] = "버프"
L["KeyBinding"] = "단축키 설정"
L["Cooldowns"] = "재사용 대기시간"

-- 고급 모듈 - 등록 모듈 표시 이름 (Advanced modules - RegisterModule display names (from module files))
L["Micro Menu"] = "마이크로 메뉴"
L["Loot Roll"] = "주사위 굴림"
L["Key Binding"] = "단축키 설정"
L["Item Quality"] = "아이템 등급"
L["Buff Frame"] = "버프 프레임"
L["Hide Blizzard"] = "기본 요소 숨기기"
L["Tooltip"] = "툴팁"

-- 고급 모듈 - 등록 모듈 설명 (Advanced modules - RegisterModule descriptions (from module files))
L["Micro menu and bags system styling and positioning"] = "마이크로 메뉴 및 가방 시스템의 스타일과 위치를 설정합니다."
L["Quest tracker positioning and styling"] = "퀘스트 추적기의 위치와 스타일을 설정합니다."
L["Enhanced tooltip styling with class colors and health bars"] = "직업 색상 및 생명력 바가 포함된 강화된 툴팁 스타일을 제공합니다."
L["Hide default Blizzard UI elements"] = "기본 블리자드 UI 요소들을 숨깁니다."
L["Custom minimap styling, positioning, tracking icons and calendar"] = "미니맵 스타일, 위치, 추적 아이콘 및 달력을 설정합니다."
L["Main action bars, status bars, scaling and positioning"] = "주 단축바, 상태 바의 크기와 위치를 설정합니다."
L["LibKeyBound integration for intuitive keybinding"] = "직관적인 단축키 설정을 위한 LibKeyBound 통합 기능을 제공합니다."
L["Color item borders by quality in bags, character panel, bank, and merchant"] = "가방, 캐릭터 창, 은행, 상점에서 아이템 등급에 따라 테두리 색상을 표시합니다."
L["Darken UI borders and chrome"] = "UI 테두리와 외곽선을 어둡게 변경합니다."
L["Action button styling and enhancements"] = "단축바 버튼의 스타일과 강화 기능을 설정합니다."
L["Custom buff frame styling, positioning and toggle button"] = "커스텀 버프 프레임의 스타일, 위치 및 전환 버튼을 설정합니다."
L["Vehicle interface enhancements"] = "탈것 인터페이스 강화 기능을 설정합니다."
L["Stance/shapeshift bar positioning and styling"] = "태세/변신 바의 위치와 스타일을 설정합니다."
L["Pet action bar positioning and styling"] = "소환수 단축바의 위치와 스타일을 설정합니다."
L["Multicast (totem/possess) bar positioning and styling"] = "멀티캐스트(토템/지배) 바의 위치와 스타일을 설정합니다."

-- ============================================================================
-- 단축바 탭 (ACTION BARS TAB)
-- ============================================================================

-- 하위 탭 (Sub-tabs)
L["Layout"] = "레이아웃"
L["Visibility"] = "표시 설정"

-- 크기 조절 섹션 (Scales section)
L["Action Bar Scales"] = "단축바 크기 비율"
L["Main Bar Scale"] = "주 단축바 크기"
L["Right Bar Scale"] = "우측 단축바 크기"
L["Left Bar Scale"] = "좌측 단축바 크기"
L["Bottom Left Bar Scale"] = "하단 좌측 단축바 크기"
L["Bottom Right Bar Scale"] = "하단 우측 단축바 크기"
L["Scale for main action bar"] = "주 단축바의 크기 비율을 설정합니다."
L["Scale for right action bar (MultiBarRight)"] = "우측 단축바(MultiBarRight)의 크기 비율을 설정합니다."
L["Scale for left action bar (MultiBarLeft)"] = "좌측 단축바(MultiBarLeft)의 크기 비율을 설정합니다."
L["Scale for bottom left action bar (MultiBarBottomLeft)"] = "하단 좌측 단축바(MultiBarBottomLeft)의 크기 비율을 설정합니다."
L["Scale for bottom right action bar (MultiBarBottomRight)"] = "하단 우측 단축바(MultiBarBottomRight)의 크기 비율을 설정합니다."
L["Reset All Scales"] = "모든 크기 초기화"
L["Reset all action bar scales to their default values (0.9)"] = "모든 단축바 크기를 기본값(0.9)으로 초기화합니다."
L["All action bar scales reset to default values (0.9)"] = "모든 단축바 크기가 기본값(0.9)으로 초기화되었습니다."
L["All action bar scales reset to 0.9"] = "모든 단축바 크기가 0.9로 초기화되었습니다."

-- 위치 섹션 (Positions section)
L["Action Bar Positions"] = "단축바 위치"
L["Tip: Use the Move UI Elements button above to reposition action bars with your mouse."] = "팁: 위의 'UI 요소 이동' 버튼을 사용하여 마우스로 단축바의 위치를 직접 조정할 수 있습니다."
L["Left Bar Horizontal"] = "좌측 바 가로 배치"
L["Make the left secondary bar horizontal instead of vertical"] = "좌측 보조 단축바를 세로 대신 가로로 배치합니다."
L["Make the left secondary bar horizontal instead of vertical."] = "좌측 보조 단축바를 세로 대신 가로로 배치합니다."
L["Right Bar Horizontal"] = "우측 바 가로 배치"
L["Make the right secondary bar horizontal instead of vertical"] = "우측 보조 단축바를 세로 대신 가로로 배치합니다."
L["Make the right secondary bar horizontal instead of vertical."] = "우측 보조 단축바를 세로 대신 가로로 배치합니다."

-- 버튼 외형 섹션 (Button Appearance section)
L["Button Appearance"] = "버튼 외형"
L["Main Bar Only Background"] = "주 단축바만 배경 표시"
L["If checked, only the main action bar buttons will have a background. If unchecked, all action bar buttons will have a background."] = "체크하면 주 단축바 버튼에만 배경이 표시됩니다. 체크를 해제하면 모든 단축바 버튼에 배경이 표시됩니다."
L["Only the main action bar buttons will have a background."] = "주 단축바 버튼에만 배경을 표시합니다."
L["Hide Main Bar Background"] = "주 단축바 배경 숨기기"
L["Hide the background texture of the main action bar (makes it completely transparent)"] = "주 단축바의 배경 텍스처를 숨깁니다 (완전 투명하게 만듭니다)."
L["Hide the background texture of the main action bar."] = "주 단축바의 배경 텍스처를 숨깁니다."

-- 텍스트 표시 설정 (Text visibility)
L["Text Visibility"] = "텍스트 표시 설정"
L["Count Text"] = "중첩 횟수 텍스트"
L["Show Count"] = "중첩 횟수 표시"
L["Show Count Text"] = "중첩 횟수 텍스트 표시"
L["Hotkey Text"] = "단축키 텍스트"
L["Show Hotkey"] = "단축키 표시"
L["Show Hotkey Text"] = "단축키 텍스트 표시"
L["Range Indicator"] = "사거리 표시기"
L["Show small range indicator point on buttons"] = "버튼에 작은 점 형태의 사거리 표시기를 표시합니다."
L["Show range indicator dot on buttons."] = "버튼에 사거리 표시기 점을 표시합니다."
L["Macro Text"] = "매크로 텍스트"
L["Show Macro Names"] = "매크로 이름 표시"
L["Page Numbers"] = "페이지 번호"
L["Show Pages"] = "페이지 표시"
L["Show Page Numbers"] = "페이지 번호 표시"

-- 재사용 대기시간 텍스트 (Cooldown text)
L["Cooldown Text"] = "재사용 대기시간 텍스트"
L["Min Duration"] = "최소 지속시간"
L["Minimum duration for text triggering"] = "텍스트가 나타나기 위한 최소 지속시간입니다."
L["Minimum duration for cooldown text to appear."] = "재사용 대기시간 텍스트가 표시될 최소 지속시간을 설정합니다."
L["Text Color"] = "텍스트 색상"
L["Cooldown text color"] = "재사용 대기시간 텍스트 색상"
L["Cooldown Text Color"] = "재사용 대기시간 텍스트 색상"
L["Font Size"] = "글꼴 크기"
L["Size of cooldown text"] = "재사용 대기시간 텍스트의 크기"
L["Size of cooldown text."] = "재사용 대기시간 텍스트의 크기를 설정합니다."

-- 색상 (Colors)
L["Colors"] = "색상"
L["Macro Text Color"] = "매크로 텍스트 색상"
L["Color for macro text"] = "매크로 텍스트에 사용할 색상"
L["Hotkey Shadow Color"] = "단축키 그림자 색상"
L["Shadow color for hotkey text"] = "단축키 텍스트의 그림자 색상"
L["Border Color"] = "테두리 색상"
L["Border color for buttons"] = "버튼의 테두리 색상"

-- Gryphons
L["Gryphons"] = "그리핀"
L["Gryphon Style"] = "그리핀 스타일"
L["Display style for the action bar end-cap gryphons."] = "주 단축바 양 끝의 장식 스타일을 선택합니다."
L["End-cap ornaments flanking the main action bar."] = "주 단축바 양 끝을 장식하는 문양입니다."
L["Style"] = "스타일"
L["Old"] = "기존 (클래식)"
L["New"] = "신규 (용군단)"
L["Flying"] = "비행"
L["Hide Gryphons"] = "그리핀 숨기기"
L["Classic"] = "클래식"
L["Dragonflight"] = "용군단"
L["Hidden"] = "숨김"
L["Dragonflight (Wyvern)"] = "용군단 (와이번)"
L["Dragonflight (Gryphon)"] = "용군단 (그리핀)"

-- 레이아웃 섹션 (Layout section)
L["Main Bar Layout"] = "주 단축바 레이아웃"
L["Bottom Left Bar Layout"] = "하단 좌측 단축바 레이아웃"
L["Bottom Right Bar Layout"] = "하단 우측 단축바 레이아웃"
L["Right Bar Layout"] = "우측 단축바 레이아웃"
L["Left Bar Layout"] = "좌측 단축바 레이아웃"
L["Configure the main action bar grid layout. Rows are determined automatically from columns and buttons shown."] = "주 단축바의 그리드 레이아웃을 설정합니다. 줄(Row) 수는 설정된 칸(Column) 수와 표시될 버튼 수에 따라 자동으로 결정됩니다."
L["Columns"] = "칸 수"
L["Buttons Shown"] = "표시될 버튼 수"
L["Quick Presets"] = "빠른 프리셋"
L["Apply layout presets to multiple bars at once."] = "여러 단축바에 레이아웃 프리셋을 한꺼번에 적용합니다."
L["Both 1x12"] = "모두 1x12"
L["Both 2x6"] = "모두 2x6"
L["Reset All"] = "모두 초기화"
L["All bar layouts reset to defaults."] = "모든 단축바 레이아웃이 기본값으로 초기화되었습니다."

-- 표시 설정 섹션 (Visibility section)
L["Bar Visibility"] = "단축바 표시 설정"
L["Control when action bars are visible. Bars can show only on hover, only in combat, or both. When no option is checked the bar is always visible."] = "단축바가 표시되는 조건을 제어합니다. 마우스를 올렸을 때만, 혹은 전투 중일 때만 표시되도록 설정할 수 있습니다. 아무것도 체크하지 않으면 항상 표시됩니다."
L["Enable / Disable Bars"] = "단축바 활성화 / 비활성화"
L["Bottom Left Bar"] = "하단 좌측 단축바"
L["Bottom Right Bar"] = "하단 우측 단축바"
L["Right Bar"] = "우측 단축바"
L["Left Bar"] = "좌측 단축바"
L["Main Bar"] = "주 단축바"
L["Show on Hover Only"] = "마우스 오버 시에만 표시"
L["Show in Combat Only"] = "전투 중에만 표시"
L["Hide the main bar until you hover over it."] = "마우스를 올리기 전까지 주 단축바를 숨깁니다."
L["Hide the main bar until you enter combat."] = "전투에 돌입하기 전까지 주 단축바를 숨깁니다."

-- ============================================================================
-- 추가 단축바 탭 (ADDITIONAL BARS TAB)
-- ============================================================================

L["Bars that appear based on your class and situation."] = "직업 및 상황에 따라 나타나는 단축바입니다."
L["Specialized bars that appear when needed (stance/pet/vehicle/totems)"] = "필요 시 나타나는 특수 단축바입니다 (태세/소환수/탈것/토템)."
L["Auto-show bars: Stance (Warriors/Druids/DKs) • Pet (Hunters/Warlocks/DKs) • Vehicle (All classes) • Totem (Shamans)"] = "자동 표시 단축바: 태세 (전사/드루이드/죽음의 기사) • 소환수 (사냥꾼/흑마법사/죽음의 기사) • 탈것 (모든 직업) • 토템 (주술사)"

-- 공용 설정 (Common settings)
L["Common Settings"] = "공용 설정"
L["Button Size"] = "버튼 크기"
L["Size of buttons for all additional bars"] = "모든 추가 단축바의 버튼 크기를 설정합니다."
L["Button Spacing"] = "버튼 간격"
L["Space between buttons for all additional bars"] = "모든 추가 단축바의 버튼 사이 간격을 설정합니다."

-- 태세바 (Stance Bar)
L["Stance Bar"] = "태세바"
L["Warriors, Druids, Death Knights"] = "전사, 드루이드, 죽음의 기사"
L["X Position"] = "가로 위치"
L["Y Offset"] = "세로 오프셋"
L["Horizontal position of stance bar from screen center. Negative values move left, positive values move right."] = "화면 중앙으로부터 태세바의 가로 위치입니다. 음수 값은 왼쪽으로, 양수 값은 오른쪽으로 이동합니다."

-- 소환수바 (Pet Bar)
L["Pet Bar"] = "소환수바"
L["Hunters, Warlocks, Death Knights - Use editor mode to move"] = "사냥꾼, 흑마법사, 죽음의 기사 - 이동하려면 편집 모드를 사용하세요"
L["Show Empty Slots"] = "빈 슬롯 표시"
L["Display empty action slots on pet bar"] = "소환수바에 비어 있는 슬롯을 표시합니다."

-- 탈것바 (Vehicle Bar)
L["Vehicle Bar"] = "탈것바"
L["All classes (vehicles/special mounts)"] = "모든 직업 (탈것/특수 탈것)"
L["Custom Art Style"] = "사용자 정의 아트 스타일"
L["Use custom vehicle bar art style with health/power bars and themed skin. Requires UI reload to apply."] = "생명력/자원 바와 테마 스킨이 포함된 사용자 정의 탈것바 스타일을 사용합니다. 적용하려면 UI 재실행(Reload)이 필요합니다."
L["Blizzard Art Style"] = "블리자드 아트 스타일"
L["Use Blizzard vehicle bar art with health/power display. Requires reload."] = "생명력/자원이 표시되는 블리자드 기본 탈것바 스타일을 사용합니다. 재실행이 필요합니다."

-- 토템바 (Totem Bar)
L["Totem Bar"] = "토템바"
L["Totem Bar (Shaman)"] = "토템바 (주술사)"
L["Shamans only - Totem multicast bar. Position is controlled via Editor Mode."] = "주술사 전용 - 토템 멀티캐스트 바입니다. 위치는 편집 모드에서 조절할 수 있습니다."
L["TIP: Use Editor Mode to position the totem bar (type /dragonui edit)."] = "팁: 토템바 위치를 잡으려면 편집 모드를 사용하세요 (/dragonui edit 입력)."

-- ============================================================================
-- 시전바 탭 (CAST BARS TAB)
-- ============================================================================

L["Player Castbar"] = "플레이어 시전바"
L["Target Castbar"] = "대상 시전바"
L["Focus Castbar"] = "주시 대상 시전바"

-- 하위 탭 (Sub-tabs)
L["Player"] = "플레이어"
L["Target"] = "대상"
L["Focus"] = "주시 대상"

-- 공용 옵션 (Common options)
L["Width"] = "너비"
L["Width of the cast bar"] = "시전바의 너비를 설정합니다."
L["Height"] = "높이"
L["Height of the cast bar"] = "시전바의 높이를 설정합니다."
L["Scale"] = "크기 비율"
L["Size scale of the cast bar"] = "시전바의 전체적인 크기 비율을 설정합니다."
L["Show Icon"] = "아이콘 표시"
L["Show the spell icon next to the cast bar"] = "시전바 옆에 주문 아이콘을 표시합니다."
L["Show Spell Icon"] = "주문 아이콘 표시"
L["Show the spell icon next to the target castbar"] = "대상 시전바 옆에 주문 아이콘을 표시합니다."
L["Icon Size"] = "아이콘 크기"
L["Size of the spell icon"] = "주문 아이콘의 크기를 설정합니다."
L["Text Mode"] = "텍스트 모드"
L["Choose how to display spell text: Simple (centered spell name only) or Detailed (spell name + time)"] = "주문 텍스트 표시 방식을 선택하세요: 단순형 (중앙에 주문 이름만 표시) 또는 상세형 (주문 이름 + 시간 표시)"
L["Simple (Centered Name Only)"] = "단순형 (중앙에 이름만 표시)"
L["Simple (Name Only)"] = "단순형 (이름만 표시)"
L["Simple"] = "단순형"
L["Detailed (Name + Time)"] = "상세형 (이름 + 시간)"
L["Detailed"] = "상세형"
L["Time Precision"] = "시간 정밀도"
L["Decimal places for remaining time"] = "남은 시간의 소수점 자릿수를 설정합니다."
L["Decimal places for remaining time."] = "남은 시간의 소수점 자릿수입니다."
L["Max Time Precision"] = "최대 시간 정밀도"
L["Decimal places for total time"] = "전체 시간의 소수점 자릿수를 설정합니다."
L["Decimal places for total time."] = "전체 시간의 소수점 자릿수입니다."
L["Hold Time (Success)"] = "유지 시간 (성공 시)"
L["How long the bar stays visible after a successful cast."] = "시전 성공 후 바가 화면에 머무는 시간입니다."
L["How long the bar stays after a successful cast."] = "시전 성공 후 바가 유지되는 시간입니다."
L["How long to show the castbar after successful completion"] = "시전 완료 후 시전바를 표시할 시간입니다."
L["Hold Time (Interrupt)"] = "유지 시간 (차단 시)"
L["How long the bar stays visible after being interrupted."] = "시전 차단 후 바가 화면에 머무는 시간입니다."
L["How long the bar stays after being interrupted."] = "시전 차단 후 바가 유지되는 시간입니다."
L["How long to show the castbar after interruption/failure"] = "차단 또는 실패 후 시전바를 표시할 시간입니다."
L["Auto Adjust for Auras"] = "오라에 따라 자동 조정"
L["Auto-Adjust for Auras"] = "오라에 따른 자동 위치 조정"
L["Automatically adjust position based on target auras (CRITICAL FEATURE)"] = "대상 오라(버프/디버프)에 따라 위치를 자동으로 조정합니다 (중요 기능)."
L["Shift castbar when buff/debuff rows are showing."] = "버프/디버프 줄이 표시될 때 시전바 위치를 이동시킵니다."
L["Automatically adjust position based on focus auras"] = "주시 대상 오라에 따라 위치를 자동으로 조정합니다."
L["Reset Position"] = "위치 초기화"
L["Resets the X and Y position to default."] = "X축과 Y축 위치를 기본값으로 초기화합니다."
L["Reset target castbar position to default"] = "대상 시전바 위치를 기본값으로 초기화합니다."
L["Reset focus castbar position to default"] = "주시 대상 시전바 위치를 기본값으로 초기화합니다."
L["Player castbar position reset."] = "플레이어 시전바 위치가 초기화되었습니다."
L["Target castbar position reset."] = "대상 시전바 위치가 초기화되었습니다."
L["Focus castbar position reset."] = "주시 대상 시전바 위치가 초기화되었습니다."						 

-- 대상/주시 대상의 너비/높이 설명 (Width/height descriptions for target/focus)
L["Width of the target castbar"] = "대상 시전바의 너비"
L["Height of the target castbar"] = "대상 시전바의 높이"
L["Scale of the target castbar"] = "대상 시전바의 크기 비율"
L["Width of the focus castbar"] = "주시 대상 시전바의 너비"
L["Height of the focus castbar"] = "주시 대상 시전바의 높이"
L["Scale of the focus castbar"] = "주시 대상 시전바의 크기 비율"
L["Show the spell icon next to the focus castbar"] = "주시 대상 시전바 옆에 주문 아이콘을 표시합니다."
L["Time to show the castbar after successful cast completion"] = "시전 성공 후 시전바를 표시할 시간입니다."
L["Time to show the castbar after cast interruption"] = "시전 차단 후 시전바를 표시할 시간입니다."

-- ============================================================================
-- 강화 기능 탭 (ENHANCEMENTS TAB)
-- ============================================================================

L["Enhancements"] = "강화 기능"
L["Visual enhancements that add Dragonflight-style polish to the UI. These are optional — disable any you don't want."] = "UI에 용군단 스타일의 세련미를 더해주는 시각적 강화 기능입니다. 선택 사항이며 원하지 않는 기능은 비활성화할 수 있습니다."

-- (Dark Mode, Range Indicator, Item Quality, Tooltips defined above in MODULES section)
-- (다크 모드, 사거리 표시기, 아이템 등급, 툴팁 설정은 위의 모듈(MODULES) 섹션에서 정의됨)

-- ============================================================================
-- 마이크로 메뉴 탭 (MICRO MENU TAB)
-- ============================================================================

L["Gray Scale Icons"] = "회색조 아이콘"
L["Grayscale Icons"] = "회색조 아이콘"
L["Use grayscale icons instead of colored icons for the micro menu"] = "마이크로 메뉴에 컬러 아이콘 대신 회색조 아이콘을 사용합니다."
L["Use grayscale icons instead of colored icons."] = "컬러 아이콘 대신 회색조 아이콘을 사용합니다."
L["Grayscale Icons Settings"] = "회색조 아이콘 설정"
L["Normal Icons Settings"] = "일반 아이콘 설정"
L["Menu Scale"] = "메뉴 크기 비율"
L["Icon Spacing"] = "아이콘 간격"
L["Hide on Vehicle"] = "탈것 탑승 시 숨기기"
L["Hide micromenu and bags if you sit on vehicle"] = "탈것에 탑승하면 마이크로 메뉴와 가방을 숨깁니다."
L["Hide micromenu and bags while in a vehicle."] = "탈것 탑승 중에는 마이크로 메뉴와 가방을 숨깁니다."
L["Show Latency Indicator"] = "지연 시간 표시기"
L["Show a colored bar below the Help button indicating connection quality (green/yellow/red). Requires UI reload."] = "도움말 버튼 아래에 연결 상태를 나타내는 색상 바(녹색/노란색/빨간색)를 표시합니다. UI 재실행이 필요합니다."

-- 가방 (Bags)
L["Bags"] = "가방"
L["Configure the position and scale of the bag bar independently from the micro menu."] = "마이크로 메뉴와 별개로 가방 바의 위치와 크기 비율을 설정합니다."
L["Bag Bar Scale"] = "가방 바 크기 비율"

-- 경험치 및 평판 바 (XP & Rep Bars)
L["XP & Rep Bars (Legacy Offsets)"] = "경험치 및 평판 바 (레거시 오프셋)"
L["Main XP & Rep bar options have moved to the XP & Rep Bars tab."] = "주요 경험치 및 평판 바 옵션은 '경험치 및 평판 바' 탭으로 이동되었습니다."
L["These offset options are for advanced positioning adjustments."] = "이 오프셋 옵션들은 고급 위치 조정을 위한 설정입니다."
L["Both Bars Offset"] = "두 바 모두 표시 시 오프셋"
L["Y offset when XP & reputation bar are shown"] = "경험치와 평판 바가 모두 표시될 때의 Y축 오프셋"
L["Single Bar Offset"] = "단일 바 표시 시 오프셋"
L["Y offset when XP or reputation bar is shown"] = "경험치 혹은 평판 바 중 하나만 표시될 때의 Y축 오프셋"
L["No Bar Offset"] = "바 미표시 시 오프셋"
L["Y offset when no XP or reputation bar is shown"] = "표시되는 바가 없을 때의 Y축 오프셋"
L["Rep Bar Above XP Offset"] = "경험치 바 위 평판 바 오프셋"
L["Y offset for reputation bar when XP bar is shown"] = "경험치 바가 표시될 때 평판 바의 Y축 오프셋"
L["Rep Bar Offset"] = "평판 바 오프셋"
L["Y offset when XP bar is not shown"] = "경험치 바가 표시되지 않을 때의 Y축 오프셋"

-- ============================================================================
-- 미니맵 탭 (MINIMAP TAB)
-- ============================================================================

L["Basic Settings"] = "기본 설정"
L["Border Alpha"] = "테두리 투명도"
L["Top border alpha (0 to hide)"] = "상단 테두리 투명도 (0으로 설정 시 숨김)"
L["Top border alpha (0 to hide)."] = "상단 테두리 투명도 (0으로 설정 시 숨김)."
L["Addon Button Skin"] = "애드온 버튼 스킨"
L["Apply DragonUI border styling to addon icons (e.g., bag addons)"] = "애드온 아이콘(예: 가방 애드온)에 DragonUI 테두리 스타일을 적용합니다."
L["Apply DragonUI border styling to addon icons."] = "애드온 아이콘에 DragonUI 테두리 스타일을 적용합니다."
L["Addon Button Fade"] = "애드온 버튼 페이드"
L["Addon icons fade out when not hovered"] = "마우스를 올리지 않았을 때 애드온 아이콘을 서서히 숨깁니다."
L["Addon icons fade out when not hovered."] = "마우스를 올리지 않았을 때 애드온 아이콘을 서서히 숨깁니다."
L["Player Arrow Size"] = "플레이어 화살표 크기"
L["Size of the player arrow on the minimap"] = "미니맵에 표시되는 플레이어 화살표의 크기"
L["New Blip Style"] = "새로운 아이콘 스타일"
L["Use new DragonUI object icons on the minimap. When disabled, uses classic Blizzard icons."] = "미니맵에 새로운 DragonUI 개체 아이콘을 사용합니다. 비활성화 시 클래식 블리자드 아이콘을 사용합니다."
L["Use newer-style minimap blip icons."] = "새로운 스타일의 미니맵 아이콘을 사용합니다."

-- 시간 및 달력 (Time & Calendar)
L["Time & Calendar"] = "시간 및 달력"
L["Show Clock"] = "시계 표시"
L["Show/hide the minimap clock"] = "미니맵 시계를 표시하거나 숨깁니다."
L["Show Calendar"] = "달력 표시"
L["Show/hide the calendar frame"] = "달력 창을 표시하거나 숨깁니다."
L["Clock Font Size"] = "시계 글꼴 크기"
L["Font size for the clock numbers on the minimap"] = "미니맵 시계 숫자의 글꼴 크기"

-- 표시 설정 (Display Settings)
L["Display Settings"] = "표시 설정"
L["Tracking Icons"] = "추적 아이콘"
L["Show current tracking icons (old style)"] = "현재 추적 아이콘을 표시합니다 (구버전 방식)"
L["Show current tracking icons (old style)."] = "현재 추적 아이콘을 표시합니다 (구버전 방식)."
L["Zoom Buttons"] = "확대/축소 버튼"
L["Show zoom buttons (+/-)"] = "확대/축소 버튼 (+/-)을 표시합니다"
L["Show zoom buttons (+/-)."] = "확대/축소 버튼 (+/-)을 표시합니다."
L["Zone Text Size"] = "지역 텍스트 크기"
L["Zone Text Font Size"] = "지역 텍스트 글꼴 크기"
L["Zone text font size on top border"] = "상단 테두리에 표시되는 지역 텍스트의 글꼴 크기입니다"
L["Font size of the zone text above the minimap."] = "미니맵 상단 지역 텍스트의 글꼴 크기를 설정합니다."

-- 위치 (Position)
L["Position"] = "위치"
L["Reset minimap to default position (top-right corner)"] = "미니맵을 기본 위치(우측 상단 모서리)로 초기화합니다"
L["Reset Minimap Position"] = "미니맵 위치 초기화"
L["Minimap position reset to default"] = "미니맵 위치가 기본값으로 초기화되었습니다"
L["Minimap position reset."] = "미니맵 위치가 초기화되었습니다."

-- ============================================================================
-- 퀘스트 추적기 탭 (QUEST TRACKER TAB)
-- ============================================================================

L["Configures the quest objective tracker position and behavior."] = "퀘스트 목적 추적기의 위치와 동작을 설정합니다."
L["Position and display settings for the objective tracker."] = "퀘스트 추적기의 위치 및 표시 설정입니다."
L["Show Header Background"] = "제목 배경 표시"
L["Show/hide the decorative header background texture"] = "장식용 제목 배경 텍스처를 표시하거나 숨깁니다."
L["Show/hide the decorative header background texture."] = "장식용 제목 배경 텍스처를 표시하거나 숨깁니다."
L["Anchor Point"] = "고정 지점"
L["Screen anchor point for the quest tracker"] = "퀘스트 추적기의 화면 고정 지점입니다."
L["Screen anchor point for the quest tracker."] = "퀘스트 추적기의 화면 고정 지점입니다."
L["Top Right"] = "우측 상단"
L["Top Left"] = "좌측 상단"
L["Bottom Right"] = "우측 하단"
L["Bottom Left"] = "좌측 하단"
L["Center"] = "중앙"
L["Horizontal position offset"] = "가로 위치 오프셋"
L["Vertical position offset"] = "세로 위치 오프셋"
L["Reset quest tracker to default position"] = "퀘스트 추적기를 기본 위치로 초기화"

-- ============================================================================
-- 유닛 프레임 탭 (UNIT FRAMES TAB)
-- ============================================================================

-- 하위 탭 (Sub-tabs)
L["Pet"] = "소환수"
L["ToT / ToF"] = "대상의 대상 / 주시의 대상"
L["Party"] = "파티"

-- Common options
L["Global Scale"] = "전체 크기 비율"
L["Global scale for all unit frames"] = "모든 유닛 프레임에 적용되는 기본 크기 비율."
L["Scale of the player frame"] = "플레이어 프레임 크기"
L["Scale of the target frame"] = "대상 프레임 크기"
L["Scale of the focus frame"] = "주시 대상 프레임 크기"
L["Scale of the pet frame"] = "소환수 프레임 크기"
L["Scale of the target of target frame"] = "대상의 대상 프레임 크기"
L["Scale of the focus of target frame"] = "주시 대상의 대상 프레임 크기"
L["Scale of party frames"] = "파티 프레임 크기"
L["Class Color"] = "직업 색상"
L["Class Color Health"] = "생명력 바 직업 색상"
L["Use class color for health bar"] = "생명력 바를 직업 색상으로 표시합니다."
L["Use class color for health bars in party frames"] = "파티 프레임의 생명력 바에 직업 색상을 적용합니다."
L["Class Portrait"] = "직업 초상화"
L["Show class icon instead of 3D portrait"] = "3D 초상화 대신 직업 아이콘을 표시합니다."
L["Show class icon instead of 3D portrait (only for players)"] = "플레이어에 한해 3D 초상화 대신 직업 아이콘을 표시합니다."
L["Class icon instead of 3D model for players."] = "플레이어 초상화에 3D 모델 대신 직업 아이콘을 사용합니다."
L["Large Numbers"] = "큰 숫자 표시"
L["Format Large Numbers"] = "큰 숫자 축약 표시"
L["Format large numbers (1k, 1m)"] = "큰 숫자를 축약 형식(1k, 1m 등)으로 표시합니다."
L["Text Format"] = "텍스트 형식"
L["How to display health and mana values"] = "생명력 및 마나 수치를 표시하는 방법"
L["Choose how to display health and mana text"] = "생명력 및 마나 텍스트 표시 형식을 선택하세요."

-- Text format values
L["Current Value Only"] = "현재 수치만"
L["Current Value"] = "현재 수치"
L["Percentage Only"] = "백분율만"
L["Percentage"] = "백분율"
L["Both (Numbers + Percentage)"] = "모두 표시 (수치 + 백분율)"
L["Numbers + %"] = "수치 + %"
L["Current/Max Values"] = "현재/최대 수치"
L["Current / Max"] = "현재 / 최대"

-- Party text format values
L["Current Value Only (2345)"] = "현재 수치만 (2345)"
L["Formatted Current (2.3k)"] = "축약된 현재 수치 (2.3k)"
L["Percentage Only (75%)"] = "백분율만 (75%)"
L["Percentage + Current (75% | 2.3k)"] = "백분율 + 현재 수치 (75% | 2.3k)"
L["Percentage + Current/Max"] = "백분율 + 현재/최대 수치"

-- Health/Mana text
L["Always Show Health Text"] = "생명력 수치 항상 표시"
L["Show health text always (true) or only on hover (false)"] = "생명력 수치를 항상 표시하거나(켜기), 마우스를 올렸을 때만 표시합니다(끄기)."
L["Always show health text on party frames (instead of only on hover)"] = "파티 프레임에서 생명력 수치를 항상 표시합니다 (마우스 오버 시에만 표시하는 대신)."
L["Always display health text (otherwise only on mouseover)"] = "생명력 수치를 항상 표시합니다 (그렇지 않으면 마우스 오버 시에만 표시)."
L["Always Show Mana Text"] = "마나 수치 항상 표시"
L["Show mana/power text always (true) or only on hover (false)"] = "마나/자원 수치를 항상 표시하거나(켜기), 마우스를 올렸을 때만 표시합니다(끄기)."
L["Always show mana text on party frames (instead of only on hover)"] = "파티 프레임에서 마나 수치를 항상 표시합니다 (마우스 오버 시에만 표시하는 대신)."
L["Always display mana/energy/rage text (otherwise only on mouseover)"] = "마나/기력/분노 수치를 항상 표시합니다 (그렇지 않으면 마우스 오버 시에만 표시)."

-- Player frame specific
L["Player Frame"] = "플레이어 프레임"
L["Dragon Decoration"] = "용 장식"
L["Add decorative dragon to your player frame for a premium look"] = "플레이어 프레임에 장식용 용 문양을 추가하여 고급스러운 외형을 만듭니다."
L["None"] = "없음"
L["Elite Dragon (Golden)"] = "정예 용 (황금색)"
L["Elite (Golden)"] = "정예 (황금)"
L["RareElite Dragon (Winged)"] = "희귀 정예 용 (날개)"
L["RareElite (Winged)"] = "희귀 정예 (날개)"
L["Glow Effects"] = "반짝임 효과"
L["Show Rest Glow"] = "휴식 중 반짝임 표시"
L["Show a golden glow around the player frame when resting (in an inn or city). Works with all frame modes: normal, elite, fat health bar, and vehicle."] = "휴식 중(여관이나 대도시)일 때 플레이어 프레임 주변에 황금색 반짝임 효과를 표시합니다. 일반, 정예, 두꺼운 생명력 바, 탈것 등 모든 프레임 모드에서 작동합니다."
L["Golden glow around the player frame when resting (inn or city). Works with all frame modes."] = "휴식 중(여관 또는 대도시)일 때 플레이어 프레임 주변에 황금색 반짝임을 표시합니다. 모든 프레임 모드에 적용됩니다."
L["Always Show Alternate Mana Text"] = "보조 마나 수치 항상 표시"
L["Show mana text always visible (default: hover only)"] = "마나 수치를 항상 표시합니다 (기본값: 마우스 오버 시에만 표시)."
L["Alternate Mana (Druid)"] = "보조 마나 (드루이드)"
L["Always Show"] = "항상 표시"
L["Druid mana text visible at all times, not just on hover."] = "드루이드의 마나 수치를 마우스 오버 시뿐만 아니라 항상 표시합니다."
L["Alternate Mana Text Format"] = "보조 마나 텍스트 형식"
L["Choose text format for alternate mana display"] = "보조 마나 표시를 위한 텍스트 형식을 선택하세요."
L["Percentage + Current/Max"] = "백분율 + 현재/최대 수치"

-- Fat Health Bar
L["Health Bar Style"] = "생명력 바 스타일"
L["Fat Health Bar"] = "두꺼운 생명력 바"
L["Enable"] = "활성화"
L["Full-width health bar that fills the entire frame area. Uses modified border texture that removes the inner divider line. Compatible with Dragon Decoration (requires fat variant textures). Note: Automatically disabled during vehicle UI."] = "프레임 영역 전체를 채우는 전체 너비 생명력 바입니다. 내부 구분선을 제거한 수정된 테두리 텍스처를 사용합니다. 용 장식과 호환됩니다(전용 텍스트 필요). 참고: 탈것 UI 중에는 자동으로 비활성화됩니다."
L["Full-width health bar. Auto-disabled in vehicles."] = "프레임 전체 너비 생명력 바입니다. 탈것 탑승 시 자동으로 비활성화됩니다."
L["Hide Mana Bar (Fat Mode)"] = "마나 바 숨기기 (두꺼운 모드)"
L["Hide Mana Bar"] = "마나 바 숨기기"
L["Completely hide the mana bar when Fat Health Bar is active."] = "두꺼운 생명력 바가 활성화된 경우 마나 바를 완전히 숨깁니다."
L["Mana Bar Width (Fat Mode)"] = "마나 바 너비 (두꺼운 모드)"
L["Mana Bar Width"] = "마나 바 너비"
L["Width of the mana bar when Fat Health Bar is active. Movable via Editor Mode."] = "두꺼운 생명력 바가 활성화된 경우의 마나 바 너비입니다. 편집 모드에서 이동 가능합니다."
L["Mana Bar Height (Fat Mode)"] = "마나 바 높이 (두꺼운 모드)"
L["Mana Bar Height"] = "마나 바 높이"
L["Height of the mana bar when Fat Health Bar is active."] = "두꺼운 생명력 바가 활성화된 경우의 마나 바 높이입니다."
L["Mana Bar Texture"] = "마나 바 텍스처"
L["Choose the texture style for the power/mana bar. Only applies in Fat Health Bar mode."] = "자원/마나 바의 텍스처 스타일을 선택하세요. 두꺼운 생명력 바 모드에서만 적용됩니다."
L["DragonUI (Default)"] = "DragonUI (기본값)"
L["Blizzard Classic"] = "블리자드 클래식"
L["Flat Solid"] = "플랫 솔리드 (단색)"
L["Smooth"] = "부드럽게"
L["Aluminium"] = "알루미늄"
L["LiteStep"] = "라이트스텝"

-- Power Bar Colors
L["Power Bar Colors"] = "마력 바 색상"
L["Mana"] = "마나"
L["Rage"] = "분노"
L["Energy"] = "기력"
-- L["Focus"] = true -- 위에서 이미 정의됨 (집중)
L["Runic Power"] = "룬 마력"
L["Happiness"] = "만족도"
L["Runes"] = "룬"
L["Reset Colors to Default"] = "기본 색상으로 초기화"

-- Target frame
L["Target Frame"] = "대상 프레임"
L["Threat Glow"] = "위협 수준 반짝임"
L["Show threat glow effect"] = "위협 수준 반짝임 효과 표시"

-- Focus frame
L["Focus Frame"] = "주시 대상 프레임"
L["Override Position"] = "위치 수동 설정"
L["Override default positioning"] = "기본 위치 설정을 무시하고 직접 지정합니다."
L["Move the pet frame independently from the player frame."] = "소환수 프레임을 플레이어 프레임과 별개로 이동시킵니다."

-- Pet frame
L["Pet Frame"] = "소환수 프레임"
L["Allows the pet frame to be moved freely. When unchecked, it will be positioned relative to the player frame."] = "체크하면 소환수 프레임을 자유롭게 이동할 수 있습니다. 체크를 해제하면 플레이어 프레임 위치에 따라 고정됩니다."
L["Horizontal position (only active if Override is checked)"] = "가로 위치 (수동 설정 시 활성화)"
L["Vertical position (only active if Override is checked)"] = "세로 위치 (수동 설정 시 활성화)"

-- Target of Target
L["Target of Target"] = "대상의 대상"
L["Follows the Target frame by default. Move it in Editor Mode (/dragonui edit) to detach and position freely."] = "기본적으로 대상 프레임을 따라다닙니다. 편집 모드(/dragonui edit)에서 이동시키면 고정을 해제하고 자유롭게 배치할 수 있습니다."
L["Detached — positioned freely via Editor Mode"] = "분리됨 — 편집 모드를 통해 자유롭게 배치"
L["Attached — follows Target frame"] = "고정됨 — 대상 프레임을 따라다님"
L["Re-attach to Target"] = "대상 프레임에 다시 고정"

-- Target of Focus
L["Target of Focus"] = "주시 대상의 대상"
L["Follows the Focus frame by default. Move it in Editor Mode (/dragonui edit) to detach and position freely."] = "기본적으로 주시 대상 프레임을 따라다닙니다. 편집 모드(/dragonui edit)에서 이동시키면 고정을 해제하고 자유롭게 배치할 수 있습니다."
L["Attached — follows Focus frame"] = "고정됨 — 주시 대상 프레임을 따라다님"
L["Re-attach to Focus"] = "주시 대상 프레임에 다시 고정"

-- Party Frames
L["Party Frames"] = "파티 프레임"
L["Party Frames Configuration"] = "파티 프레임 설정"
L["Custom styling for party member frames with automatic health/mana text display and class colors."] = "자동 생명력/마나 텍스트 표시 및 직업 색상이 적용된 커스텀 파티 프레임 설정입니다."
L["Orientation"] = "배치 방향"
L["Vertical"] = "세로 방향"
L["Horizontal"] = "가로 방향"
L["Party frame orientation"] = "파티 프레임이 나열되는 방향을 설정."
L["Vertical Padding"] = "세로 간격"
L["Space between party frames in vertical mode"] = "세로 배치 모드에서 프레임 사이의 간격을 조절합니다."
L["Space between party frames in vertical mode."] = "세로 배치 시 프레임 간의 여백입니다."
L["Horizontal Padding"] = "가로 간격"
L["Space between party frames in horizontal mode"] = "가로 배치 모드에서 프레임 사이의 간격을 조절합니다."
L["Space between party frames in horizontal mode."] = "가로 배치 시 프레임 간의 여백입니다."

-- ============================================================================
-- XP & REP BARS TAB
-- ============================================================================

L["Bar Style"] = "바 스타일"
L["XP / Rep Bar Style"] = "경험치 / 평판 바 스타일"
L["DragonflightUI: fully custom bars with rested XP background.\nRetailUI: atlas-based reskin of Blizzard bars.\n\nChanging style requires a UI reload."] = "DragonflightUI: 휴식 경험치 배경이 포함된 완전 커스텀 바입니다.\nRetailUI: 블리자드 기본 바를 아틀라스 기반으로 리스킨한 버전입니다.\n\n스타일을 변경하면 UI 재설정이 필요합니다."
L["DragonflightUI"] = "용군단UI"
L["RetailUI"] = "본섭UI"
L["XP bar style changed to "] = "경험치 바 스타일 변경: "
L["A UI reload is required to apply this change."] = "이 변경 사항을 적용하려면 UI 재설정이 필요합니다."

-- Size & Scale
L["Size & Scale"] = "크기 및 비율"
L["Bar Height"] = "바 높이"
L["Height of the XP and Reputation bars (in pixels)."] = "경험치 및 평판 바의 높이(픽셀 단위)입니다."
L["Experience Bar Scale"] = "경험치 바 크기 비율"
L["Scale of the experience bar."] = "경험치 바의 크기 비율을 설정합니다."
L["Reputation Bar Scale"] = "평판 바 크기 비율"
L["Scale of the reputation bar."] = "평판 바의 크기 비율을 설정합니다."

-- Rested XP
L["Rested XP"] = "휴식 경험치"
L["Show Rested XP Background"] = "휴식 경험치 배경 표시"
L["Display a translucent bar showing the total available rested XP range.\n(DragonflightUI style only)"] = "획득 가능한 총 휴식 경험치 범위를 반투명한 바 형태로 표시합니다.\n(용군단UI 스타일 전용)"
L["Show Exhaustion Tick"] = "휴식 상태 구분선 표시"
L["Show the exhaustion tick indicator on the XP bar, marking where rested XP ends."] = "경험치 바에 휴식 경험치가 끝나는 지점을 표시하는 구분선(틱)을 보여줍니다."

-- Text Display
L["Text Display"] = "텍스트 표시"
L["Always Show Text"] = "항상 텍스트 표시"
L["Always display XP/Rep text instead of only on hover."] = "마우스를 올렸을 때뿐만 아니라 항상 경험치/평판 수치를 표시합니다."
L["Show XP Percentage"] = "경험치 백분율 표시"
L["Display XP percentage alongside the value text."] = "수치 텍스트와 함께 경험치 퍼센트(%)를 표시합니다."

-- ============================================================================
-- PROFILES TAB
-- ============================================================================

L["Database not available."] = "데이터베이스를 사용할 수 없습니다."
L["Save and switch between different configurations per character."] = "캐릭터별로 다양한 설정을 저장하거나 교체할 수 있습니다."
L["Current Profile"] = "현재 프로필"
L["Active: "] = "활성 프로필: "
L["Switch or Create Profile"] = "프로필 전환 및 생성"
L["Select Profile"] = "프로필 선택"
L["New Profile Name"] = "새 프로필 이름"
L["Copy From"] = "복사해오기"
L["Copies all settings from the selected profile into your current one."] = "선택한 프로필의 모든 설정을 현재 프로필로 복사합니다."
L["Copied profile: "] = "복사된 프로필: "
L["Delete Profile"] = "프로필 삭제"
L["Warning: Deleting a profile is permanent and cannot be undone."] = "경고: 프로필 삭제는 영구적이며 되돌릴 수 없습니다."
L["Delete"] = "삭제"
L["Deleted profile: "] = "삭제된 프로필: "
L["Reset Current Profile"] = "현재 프로필 초기화"
L["Restores the current profile to its defaults. This cannot be undone."] = "현재 프로필을 기본 설정으로 복구합니다. 이 작업은 되돌릴 수 없습니다."
L["Reset Profile"] = "프로필 초기화"
L["All changes will be lost and the UI will be reloaded.\nAre you sure you want to reset your profile?"] = "모든 변경 사항이 삭제되고 UI가 재설정됩니다.\n정말로 프로필을 초기화하시겠습니까?"
L["Profile reset to defaults."] = "프로필이 기본값으로 초기화되었습니다."

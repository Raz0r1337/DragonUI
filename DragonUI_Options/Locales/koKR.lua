--[[
================================================================================
 DragonUI_Options - 한국어 로케일 (koKR)
================================================================================
 ]]

local L = LibStub("AceLocale-3.0"):NewLocale("DragonUI_Options", "koKR")
if not L then return end

--================================================================================
--  [[  controls.lua  ]] - 확인
--================================================================================

L["|cFFFF0000[DragonUI_Options]|r Error: DragonUI addon not found!"] = "|cFFFF0000[DragonUI_Options]|r 오류: DragonUI 애드온을 찾을 수 없음!"
L["Changing this setting requires a UI reload to apply correctly."] = "이 설정을 적용하려면 UI 재시작(Reload) 필요"
L["Reload UI"] = "UI 리로드"
L["Not Now"] = "나중에"
L["Open DragonUI Settings"] = "DragonUI 설정 열기"
L["Open the DragonUI configuration panel."] = "DragonUI 설정 패널 열기"
L["Use /dragonui to open the full settings panel."] = "/dragonui 입력 시 전체 설정 패널 열기"

--================================================================================
--  [[  panel.lua  ]] - 확인
--================================================================================
-- CREATE FRAME
L["DragonUI"] = true
L["experimental"] = "실험적 기능"
L["Editor Mode"] = "편집 모드"
L["KeyBind Mode"] = "단축키 설정 모드"
L["Cannot open options during combat."] = "전투 중 옵션 사용 불가"

--================================================================================
--  [[  tab_actionbars.lua  ]] - 확인
--================================================================================
-- SUB-TAB DEFINITIONS
L["General"] = "일반"
L["Layout"] = "레이아웃"
L["Visibility"] = "표시 설정"

-- GENERAL SUB-TAB (existing action bar settings)
L["Action Bar Scales"] = "단축바 크기 비율"
L["Main Bar Scale"] = "주 단축바 크기"
L["Right Bar Scale"] = "우측 단축바 크기"
L["Left Bar Scale"] = "좌측 단축바 크기"
L["Bottom Left Bar Scale"] = "하단 좌측 단축바 크기"
L["Bottom Right Bar Scale"] = "하단 우측 단축바 크기"
L["Reset All Scales"] = "모든 크기 초기화"
L["All action bar scales reset to 0.9"] = "모든 단축바 크기 0.9로 초기화됨"

-- POSITIONS
L["Action Bar Positions"] = "단축바 위치"
L["Left Bar Horizontal"] = "좌측 바 가로 배치"
L["Make the left secondary bar horizontal instead of vertical."] = "좌측 보조 단축바를 세로 대신 가로로 배치"
L["Right Bar Horizontal"] = "우측 바 가로 배치"
L["Make the right secondary bar horizontal instead of vertical."] = "우측 보조 단축바를 세로 대신 가로로 배치"

-- BUTTON APPEARANCE
L["Button Appearance"] = "버튼 외형"
L["Main Bar Only Background"] = "주 단축바 배경만 표시"
L["Only the main action bar buttons will have a background."] = "주 단축바 버튼에만 배경 표시"
L["Hide Main Bar Background"] = "주 단축바 배경 숨기기"
L["Hide the background texture of the main action bar."] = "주 단축바 배경 텍스처 숨기기"

-- Text visibility sub-section
L["Text Visibility"] = "문자 표시 설정"
L["Show Count Text"] = "중첩 횟수 문자 표시"
L["Show Hotkey Text"] = "단축키 문자 표시"
L["Range Indicator"] = "거리 표시기"
L["Show range indicator dot on buttons."] = "버튼에 사거리 표시기 점 표시"
L["Show Macro Names"] = "매크로 이름 표시"
L["Show Page Numbers"] = "페이지 번호 표시"

-- Cooldown text
L["Cooldown Text"] = "쿨다운 문자"
L["Min Duration"] = "최소 지속 시간"
L["Minimum duration for cooldown text to appear."] = "재사용 대기시간 문자가 표시될 최소 지속시간 설정"
L["Font Size"] = "글꼴 크기"
L["Size of cooldown text."] = "재사용 대기시간 문자의 크기"
L["Cooldown Text Color"] = "재사용 대기시간 문자 색상"
L["Colors"] = "색상"
L["Macro Text Color"] = "매크로 문자 색상"
L["Hotkey Shadow Color"] = "단축키 그림자 색상"
L["Border Color"] = "테두리 색상"

-- GRYPHONS
L["Gryphons"] = "그리핀"
L["End-cap ornaments flanking the main action bar."] = "주 단축바 양 끝 장식 문양"
L["Style"] = "스타일"
L["Classic"] = "클래식"
L["Dragonflight"] = "용군단"
L["Dragonflight (Wyvern)"] = "용군단 (와이번)"
L["Dragonflight (Gryphon)"] = "용군단 (그리핀)"
L["Flying"] = "비행"
L["Hidden"] = "숨김"

-- LAYOUT SUB-TAB (grid layout: rows/columns/buttons per bar)
L["Main Bar Layout"] = "주 단축바 레이아웃"
L["Configure the main action bar grid layout. Rows are determined automatically from columns and buttons shown."] = "주 단축바 그리드 레이아웃 설정. 줄 수는 칸 수와 버튼 수에 따라 자동 결정"
L["Columns"] = "칸 수"
L["Buttons Shown"] = "표시될 버튼 수"
L["Bottom Left Bar Layout"] = "하단 좌측 단축바 레이아웃"
L["Bottom Right Bar Layout"] = "하단 우측 단축바 레이아웃"
L["Right Bar Layout"] = "우측 단축바 레이아웃"
L["Left Bar Layout"] = "좌측 단축바 레이아웃"
L["Quick Presets"] = "빠른 프리셋"
L["Apply layout presets to multiple bars at once."] = "여러 단축바에 레이아웃 프리셋 일괄 적용"
L["Both 1x12"] = "모두 1x12"
L["Both 2x6"] = "모두 2x6"
L["Reset All"] = "모두 초기화"
L["All bar layouts reset to defaults."] = "모든 단축바 레이아웃 기본값으로 초기화됨"

-- VISIBILITY SUB-TAB (hover/combat show/hide per bar)
L["Bar Visibility"] = "단축바 표시 설정"
L["Control when action bars are visible. Bars can show only on hover, only in combat, or both. When no option is checked the bar is always visible."] = "단축바 표시 조건 제어. 마우스 오버 시 또는 전투 중 표시 설정 가능. 미선택 시 항상 표시"
L["Enable / Disable Bars"] = "단축바 활성화 / 비활성화"
L["Bottom Left Bar"] = "하단 좌측 단축바"
L["Bottom Right Bar"] = "하단 우측 단축바"
L["Right Bar"] = "우측 단축바"
L["Left Bar"] = "좌측 단축바"
L["Main Bar"] = "주 단축바"
L["Show on Hover Only"] = "마우스 오버 시에만 표시"
L["Hide the main bar until you hover over it."] = "마우스 오버 시에만 주 단축바 표시"
L["Show in Combat Only"] = "전투 중에만 표시"
L["Hide the main bar until you enter combat."] = "전투 중일 때만 주 단축바 표시"

-- MAIN TAB BUILDER
L["Action Bars"] = "행동 단축바"

-- ============================================================================
--  [[  tab_additionalbars.lua  ]] - 확인
-- ============================================================================
-- ADDITIONAL BARS TAB BUILDER
L["Bars that appear based on your class and situation."] = "직업 및 상황에 따른 단축바 표시"

-- STANCE BAR
L["Stance Bar"] = "태세바"
L["Button Size"] = "버튼 크기"
L["Button Spacing"] = "버튼 간격"

-- PET BAR
L["Pet Bar"] = "소환수바"

    -- VEHICLE BAR
L["Show Empty Slots"] = "빈 슬롯 표시"
L["Vehicle Bar"] = "탈것바"
L["Blizzard Art Style"] = "블리자드 아트 스타일"
L["Use Blizzard vehicle bar art with health/power display. Requires reload."] = "생명력/자원이 표시되는 블리자드 기본 탈것바 스타일 사용(UI 재실행 필요)"

-- TOTEM BAR
L["Totem Bar (Shaman)"] = "토템바 (주술사)"
L["Additional Bars"] = "추가 단축바"

-- ============================================================================
--  [[  tab_auras.lua  ]] - 확인
-- ============================================================================
-- AURAS TAB BUILDER
L["Weapon Enchants"] = "무기 강화 효과"
L["Weapon enchant icons include rogue poisons, sharpening stones, wizard oils, and similar temporary weapon enhancements."] = "무기 강화 아이콘 구성: 도적의 독, 숫돌, 마법사 오일 및 기타 일시적 무기 강화 효과"
L["Separate Weapon Enchants"] = "무기 강화 효과 분리"

L["Detach weapon enchant icons (poisons, sharpening stones, etc.) from the buff bar into their own independently moveable frame. Position it freely using Editor Mode."] = "무기 강화 효과(독, 숫돌 등)를 분리하여 독립적인 프레임으로 생성. 편집 모드에서 자유롭게 이동 가능"
L["When enabled, a 'Weapon Enchants' mover appears in Editor Mode that you can drag to any position on screen."] = "활성화 시 편집 모드에 '무기 강화 효과' 이동 핸들 표시 및 자유로운 위치 이동 가능"

-- RESET POSITION
L["Positions"] = "위치"
L["Reset Weapon Enchant Position"] = "무기 강화 위치 초기화"
L["Weapon enchant position reset."] = "무기 강화 위치를 초기화"
L["Auras"] = "버프/디버프"

-- ============================================================================
--  [[  tab_bags.lua  ]] - 확인
-- ============================================================================
-- TAB BUILDER
L["Bags"] = "가방"
L["Configure Combuctor bag replacement settings."] = "통합가방(Combuctor) 대체 설정 구성"
L["Combuctor"] = "통합가방(Combuctor)"
L["Enable Combuctor"] = "통합가방(Combuctor) 활성화"
L["All-in-one bag replacement with item filtering, search, quality indicators, and bank integration."] = "아이템 필터링, 검색, 품질 표시 및 은행 통합 기능을 갖춘 올인원 가방 대체."

-- BAG SORT
L["Bag Sort"] = "가방 정렬"
L["Sort buttons for bags and bank. Sorts items by type, rarity, level, and name."] = "가방 및 은행 정렬 버튼. 아이템을 유형, 희귀도, 레벨, 이름순으로 정렬"
L["Enable Bag Sort"] = "가방 정렬 활성화"
L["Add sort buttons to bag and bank frames. Also enables /sort and /sortbank slash commands."] = "가방 및 은행 창에 정렬 버튼 추가. /sort 및 /sortbank 명령어 활성화"

-- INVENTORY CATEGORY TABS
L["Inventory Tabs"] = "소지품 탭"
L["Choose which category tabs appear on the inventory bag frame."] = "소지품 가방 프레임에 표시할 카테고리 탭 선택"
L["Show 'All' Tab"] = "'전체' 탭 표시"
L["Show the 'All' category tab that displays all items without filtering."] = "필터링 없이 모든 아이템을 보여주는 '전체' 카테고리 탭 표시"
L["Show Equipment Tab"] = "장비 탭 표시"
L["Show the Equipment category tab for armor and weapons."] = "방어구 및 무기용 장비 카테고리 탭 표시"
L["Show Usable Tab"] = "사용 가능 탭 표시"
L["Show the Usable category tab for consumables and devices."] = "소모품 및 장치용 사용 가능 카테고리 탭 표시"
L["Show Quest Tab"] = "퀘스트 탭 표시"
L["Show the Quest items category tab."] = "퀘스트 아이템 카테고리 탭 표시"
L["Show Trade Goods Tab"] = "전문기술 용품 탭 표시"
L["Show the Trade Goods category tab (includes gems and recipes)."] = "전문기술 용품(보석, 도안 포함) 카테고리 탭 표시"
L["Show Miscellaneous Tab"] = "기타 탭 표시"
L["Show the Miscellaneous items category tab."] = "기타 아이템 카테고리 탭 표시"

-- BANK CATEGORY TABS
L["Bank Tabs"] = "은행 탭"
L["Choose which category tabs appear on the bank frame."] = "은행 프레임에 표시할 카테고리 탭 선택"

-- SUBTABS (BOTTOM FILTER TABS)
L["Subtabs"] = "보조 탭"
L["Configure which bottom subtabs appear within each category tab. Applies to both inventory and bank."] = "각 카테고리 내 하단에 표시될 보조 탭 설정. 소지품과 은행 모두에 적용"
L["Normal"] = "일반"
L["Show the Normal bags subtab (non-profession bags)."] = "일반 가방(전문기술용 제외) 보조 탭 표시"
L["Trade Bags"] = "전문기술 가방"
L["Show the Trade bags subtab (profession bags)."] = "전문기술 가방 보조 탭 표시"
L["Show the Armor subtab."] = "방어구 보조 탭 표시"
L["Show the Weapon subtab."] = "무기 보조 탭 표시"
L["Show the Trinket subtab."] = "장신구 보조 탭 표시"
L["Show the Consumable subtab."] = "소모품 보조 탭 표시"
L["Show the Devices subtab."] = "장치 보조 탭 표시"
L["Show the Trade Goods subtab."] = "전문기술 용품 보조 탭 표시"
L["Show the Gem subtab."] = "보석 보조 탭 표시"
L["Show the Recipe subtab."] = "도안 보조 탭 표시"

-- DISPLAY OPTIONS
L["Display"] = "표시"
L["Left Side Tabs"] = "왼쪽 탭"
L["Inventory"] = "소지품"
L["Place category filter tabs on the left side of the bag frame instead of the right."] = "가방 프레임의 왼쪽에 카테고리 필터 탭을 배치."
L["Bank"] = "은행"
L["Place category filter tabs on the left side of the bank frame instead of the right."] = "은행 프레임의 왼쪽에 카테고리 필터 탭을 배치."

-- ============================================================================
--  [[  tab_castbars.lua  ]] - 확인
-- ============================================================================
-- SHARED VALUES
L["Simple (Name Only)"] = "단순형 (이름만 표시)"
L["Detailed (Name + Time)"] = "상세형 (이름 + 시간)"

-- ACTIVE SUB-TAB STATE
L["Player"] = "플레이어"
L["Target"] = "대상"
L["Focus"] = "주시 대상"

-- COMMON CONTROLS BUILDER
L["Width"] = "너비"
L["Height"] = "높이"
L["Scale"] = "크기 비율"
L["Show Icon"] = "아이콘 표시"
L["Icon Size"] = "아이콘 크기"
L["Text Mode"] = "문자 모드"
L["Time Precision"] = "시간 정밀도"
L["Decimal places for remaining time."] = "남은 시간 소수점 자릿수"
L["Max Time Precision"] = "최대 시간 정밀도"
L["Decimal places for total time."] = "전체 시간 소수점 자릿수"
L["Hold Time (Success)"] = "유지 시간 (성공)"
L["How long the bar stays after a successful cast."] = "시전 성공 후 바 유지 시간"
L["Hold Time (Interrupt)"] = "유지 시간 (차단)"
L["How long the bar stays after being interrupted."] = "시전 차단 후 바 유지 시간"
L["Auto-Adjust for Auras"] = "오라 자동 위치 조정"
L["Shift castbar when buff/debuff rows are showing."] = "버프/디버프 줄 표시 시 시전바 위치 이동"
L["Reset Position"] = "위치 초기화"

-- SUB-TAB BUILDERS
L["Player Castbar"] = "플레이어 시전바"
L["Player castbar position reset."] = "플레이어 시전바 위치 초기화됨"
L["Target Castbar"] = "대상 시전바"
L["Target castbar position reset."] = "대상 시전바 위치 초기화됨"
L["Focus Castbar"] = "주시 대상 시전바"
L["Focus castbar position reset."] = "주시 대상 시전바 위치 초기화됨"

-- MAIN TAB BUILDER
L["Cast Bars"] = "시전바"

-- ============================================================================
--  [[  tab_enhancements.lua  ]] - 확인
-- ============================================================================
-- TAB BUILDER
L["Enhancements"] = "강화 기능"
L["Visual enhancements that add Dragonflight-style polish to the UI. These are optional \226\128\148 disable any you don't want."]  = "UI에 용군단 스타일의 시각 강화 기능. 선택 사항이며 개별 비활성화 가능."

-- DARK MODE
L["Dark Mode"] = "다크 모드"
L["Darkens UI borders and chrome only: action bar borders, unit frame borders, minimap border, bag slot borders, micro menu, castbar borders, and decorative elements. Icons, portraits, and abilities are never affected."] = "UI 전체 테두리만 어둡게!. 아이콘, 초상화, 스킬 등은 제외."
L["Enable Dark Mode"] = "다크 모드 활성화"
L["Apply darker tinted textures to all UI elements."] = "모든 UI 요소에 어두운 틴트를 적용"
L["Intensity"] = "명암농도"
L["Light (subtle)"] = "밝게 (약함)"
L["Medium (balanced)"] = "중간 (보통)"
L["Dark (maximum)"] = "어둡게 (강함)"
L["Custom Color"] = "사용자 지정 색상"
L["Override presets with a custom tint color."] = "프리셋 대신 사용자가 지정한 색조를 적용"
L["Tint Color"] = "색조 선택"

-- RANGE INDICATOR
L["Tints action button icons based on range and usability: red = out of range, blue = not enough mana, gray = unusable."] = "사거리 및 사용 가능 여부에 따라 아이콘 색상 변경(빨강: 사거리 밖, 파랑: 마나 부족, 회색: 사용 불가)"
L["Enable Range Indicator"] = "거리 표시기 활성화"
L["Color action button icons when target is out of range or ability is unusable."] = "사거리 밖 또는 기술 사용 불가 시 단축바 아이콘에 색상 적용"

-- ITEM QUALITY BORDERS
L["Item Quality Borders"] = "아이템 품질 테두리"
L["Adds quality-colored glow borders to items in your bags, character panel, bank, merchant, and inspect frames: |cff1eff00green|r = uncommon, |cff0070ddblue|r = rare, |cffa335eepurple|r = epic, |cffff8000orange|r = legendary."] = "가방, 캐릭터 창, 은행, 상인 및 살펴보기 창의 아이템에 품질별 강조 테두리 추가: |cff1eff00녹색|r = 고급, |cff0070dd푸른색|r = 희귀, |cffa335ee보라색|r = 영웅, |cffff8000주황색|r = 전설"
L["Enable Item Quality Borders"] = "아이템 품질 테두리 활성화"
L["Show quality-colored borders on items in bags, character panel, bank, merchant, and inspect frames."] = "가방, 캐릭터 창, 은행, 상점 등의 아이템에 품질 색상 테두리를 표시합니다."
L["Minimum Quality"] = "최소 품질"
L["|cff9d9d9dPoor|r"] = "|cff9d9d9d하 급|r"
L["|cffffffffCommon|r"] = "|cffffffff일 반|r"
L["|cff1eff00Uncommon|r"] = "|cff1eff00고 급|r"
L["|cff0070ddRare|r"] = "|cff0070dd희 귀|r"
L["|cffa335eeEpic|r"] = "|cffa335ee영 웅|r"
L["|cffff8000Legendary|r"] = "|cffff8000전 설|r"

-- ENHANCED TOOLTIPS
L["Enhanced Tooltips"] = "강화된 툴팁"
L["Improves GameTooltip with class-colored borders, class-colored names, target-of-target info, and styled health bars."] = "게임 툴팁 개선: 직업 색상 테두리 및 이름, 대상의 대상 정보, 전용 생명력 바"
L["Enable Enhanced Tooltips"] = "강화된 툴팁 활성화"
L["Activate all tooltip improvements. Sub-options below control individual features."] = "모든 툴팁 개선 기능 활성화. 하단 옵션에서 개별 제어 가능"
L["Class-Colored Border"] = "직업 색상 테두리"
L["Color the tooltip border by the unit's class (players) or reaction (NPCs)."] = "유닛의 직업(플레이어) 또는 관계(NPC) 색상으로 툴팁 테두리 표시"
L["Class-Colored Name"] = "직업 색상 이름"
L["Color the unit name text in the tooltip by class color (players only)."] = "툴팁 내 유닛 이름을 직업 색상으로 표시(플레이어 전용)"
L["Target of Target"] = "대상의 대상"
L["Add a 'Targeting: <name>' line showing who the unit is targeting."] = "유닛이 현재 대상으로 잡고 있는 대상 정보 추가"
L["Styled Health Bar"] = "생명력 바 스타일"
L["Restyle the tooltip health bar with class/reaction colors and slimmer look."] = "툴팁 생명력 바를 직업/관계 색상 및 얇은 외형으로 변경"
L["Anchor to Cursor"] = "커서에 고정"
L["Make the tooltip follow the cursor position instead of the default anchor."] = "툴팁이 기본 위치 대신 커서를 따라다니도록 설정"

-- ============================================================================
-- [[  tab_general.lua  ]] - 확인
-- ============================================================================
-- ABOUT
L["About"] = "정보"
L["Dragonflight-inspired UI for WotLK 3.3.5a."] = "리치 왕의 분노(3.3.5a)용 용군단 스타일 UI"
L["Experimental Branch — This options panel is in early beta."] = "실험적 버전 — 초기 베타 단계의 옵션 패널"
L["Features may change or be incomplete. Report issues on GitHub."] = "기능 변경 및 미완성 가능성 있음. 문제는 GitHub에 제보"
L["Use /dragonui or /pi to toggle this panel."] = "/dragonui 또는 /pi 입력 시 설정창 표시"

-- QUICK ACTIONS
L["Quick Actions"] = "빠른 설정"

-- ============================================================================
-- [[  tip_micromenu.lua  ]] - 확인
-- ============================================================================
-- MICRO MENU
L["Micro Menu"] = "마이크로 메뉴"
L["Grayscale Icons"] = "회색조 아이콘"
L["Menu Scale"] = "메뉴 크기 비율"
L["Use grayscale icons instead of colored icons."] = "컬러 대신 회색조 아이콘 사용"
L["Icon Spacing"] = "아이콘 간격"
L["Hide on Vehicle"] = "탈것 탑승 시 숨기기"
L["Hide micromenu and bags while in a vehicle."] = "탈것 탑승 중 마이크로 메뉴 및 가방 숨김"
L["Show Latency Indicator"] = "지연 시간 표시기"
L["Show a colored bar below the Help button indicating connection quality (green/yellow/red). Requires UI reload."] = "도움말 버튼 아래 연결 상태 색상 바(녹색/황색/적색) 표시(UI 재실행 필요)"

-- BAGS
L["Bag Bar Scale"] = "가방 바 크기 비율"

-- ============================================================================
-- [[  tip_minimap.lua  ]] - 확인
-- ============================================================================
-- BASIC SETTINGS
L["Basic Settings"] = "기본 설정"
L["Border Alpha"] = "테두리 투명도"
L["Top border alpha (0 to hide)."] = "상단 테두리 투명도 (0으로 설정 시 숨김)."
L["Addon Button Skin"] = "애드온 버튼 스킨"
L["Apply DragonUI border styling to addon icons."] = "애드온 아이콘에 DragonUI 테두리 스타일 적용"
L["Addon Button Fade"] = "애드온 버튼 페이드"
L["Addon icons fade out when not hovered."] = "마우스 오버 시에만 애드온 아이콘 표시"
L["New Blip Style"] = "새로운 아이콘 스타일"
L["Use newer-style minimap blip icons."] = "새로운 스타일의 미니맵 아이콘 사용"
L["Player Arrow Size"] = "플레이어 화살표 크기"

-- TIME & CALENDAR
L["Time & Calendar"] = "시간 및 달력"
L["Show Clock"] = "시계 표시"
L["Show Calendar"] = "달력 표시"
L["Clock Font Size"] = "시계 글꼴 크기"

-- DISPLAY SETTINGS
L["Display Settings"] = "표시 설정"
L["Tracking Icons"] = "추적 아이콘"
L["Show current tracking icons (old style)."] = "현재 추적 아이콘 표시(구버전 방식)"
L["Zoom Buttons"] = "확대/축소 버튼"
L["Show zoom buttons (+/-)."] = "확대/축소 버튼(+/-) 표시"
L["Zone Text Font Size"] = "지역 문자 글꼴 크기"
L["Font size of the zone text above the minimap."] = "미니맵 상단 지역 문자 글꼴 크기 설정"

-- SEXYMAP COMPATIBILITY  (only when SexyMap is installed)
L["SexyMap Compatibility"] = "SexyMap 호환성"
L["Choose how DragonUI and SexyMap share the minimap."] = "DragonUI와 SexyMap의 미니맵 공유 방식 선택"
L["Minimap Mode"] = "미니맵 모드"
L["SexyMap"] = true
L["Uses SexyMap for the minimap."] = "SexyMap 미니맵 사용"
L["Uses DragonUI for the minimap."] = "DragonUI 미니맵 사용"
L["Hybrid"] = "하이브리드"
L["SexyMap visuals with DragonUI editor and positioning."] = "SexyMap 비주얼에 DragonUI 편집 및 위치 설정 적용"
L["Minimap"] = "미니맵"

-- ============================================================================
-- [[  tab_modules.lua  ]] - 확인
-- ============================================================================
-- MODULES TAB BUILDER
L["Modules"] = "모듈"
L["Toggle individual modules on or off. Disabled modules revert to the default Blizzard UI."] = "개별 모듈 활성/비활성 설정. 비활성화 시 기본 블리자드 UI 사용"
L["Enable DragonUI player castbar styling."] = "DragonUI 플레이어 시전바 스타일 적용"
L["Enable DragonUI target castbar styling."] = "DragonUI 대상 시전바 스타일 적용"
L["Enable DragonUI focus castbar styling."] = "DragonUI 주시 대상 시전바 스타일 적용"

-- ACTION BARS SYSTEM (unified toggle)
L["Action Bars System"] = "행동 단축바 시스템"
L["Includes main bars, vehicle, stance, pet, totem bars, and button styling."] = "기본 바, 탈것, 태세, 소환수, 토템 바 및 버튼 스타일 포함"
L["Enable All Action Bar Modules"] = "모든 단축바 모듈 활성화"
L["Master toggle for the complete action bars system."] = "단축바 시스템 통합 제어"

-- UI SYSTEMS
L["UI Systems"] = "UI 시스템"
L["Micro Menu & Bags"] = "마이크로 메뉴 및 가방"
L["Micro menu and bags styling."] = "마이크로 메뉴 및 가방 스타일"
L["Minimap System"] = "미니맵 시스템"
L["Minimap styling, tracking icons, and calendar."] = "미니맵 스타일, 추적 아이콘 및 달력"
L["Buff Frame System"] = "버프 프레임 시스템"
L["Buff frame styling and toggle button."] = "버프 프레임 스타일 및 토글 버튼"
L["Cooldown Timers"] = "재사용 대기시간 타이머"
L["Show cooldown timers on action buttons."] = "단축바에 쿨타임 숫자 표시"
L["Quest Tracker"] = "퀘스트 추적기"
L["DragonUI quest tracker positioning and styling."] = "DragonUI 퀘스트 추적기 위치 및 스타일 설정."
L["LibKeyBound integration for intuitive hover + key press binding."] = "마우스 오버 단축키 설정(LibKeyBound) 기능을 사용"

-- ADVANCED: Individual Module Control
L["Advanced - Individual Module Control"] = "고급 - 개별 모듈 제어"
L["Warning:"] = "경고:"
L["Individual overrides. The grouped toggles above take priority."] = "개별 설정보다 상단의 그룹 통합 설정이 우선함"
L["Enable/disable "] = "활성화/비활성화: "
L["Main Bars"] = "주 단축바"
L["Vehicle"] = "탈것"
L["Multicast"] = "멀티캐스트"
L["Buttons"] = "버튼"
-- L["Hide Blizzard Elements"] = "블리자드 기본 요소 숨기기" --  internal name, not localization 
L["Buffs"] = "버프"
L["KeyBinding"] = "단축키 설정"
L["Cooldowns"] = "재사용 대기시간"

-- ============================================================================
-- [[  tab_profiles.lua  ]] - 확인
-- ============================================================================
-- PROFILES TAB (프로필 탭)
L["Database not available."] = "데이터베이스를 사용할 수 없습니다."
L["Profiles"] = "프로필"
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
L["|cffFF6600Warning:|r Deleting a profile is permanent and cannot be undone."] = "|cffFF6600경고:|r 프로필 삭제 시 영구 제거 및 복구 불가"
L["Delete"] = "삭제"
L["Deleted profile: "] = "삭제된 프로필: "
L["Reset Current Profile"] = "현재 프로필 초기화"
L["Restores the current profile to its defaults. This cannot be undone."] = "현재 프로필을 기본 설정으로 복구합니다. 이 작업은 되돌릴 수 없습니다."
L["Reset Profile"] = "프로필 초기화"
L["All changes will be lost and the UI will be reloaded.\nAre you sure you want to reset your profile?"] = "모든 변경 사항이 삭제되고 UI가 재설정됩니다.\n정말로 프로필을 초기화하시겠습니까?"
L["Yes"] = "예"
L["No"] = "아니요"
L["Profile reset to defaults."] = "프로필이 기본값으로 초기화되었습니다."

-- ============================================================================
-- [[  tab_questtracker.lua ]] 
-- ============================================================================
-- QUEST TRACKER TAB BUILDER
L["Position and display settings for the objective tracker."] = "퀘스트 추적기 위치 및 표시 설정"
L["Show Header Background"] = "제목 배경 표시"
L["Show/hide the decorative header background texture."] = "장식용 제목 배경 텍스처 표시 여부 설정"
L["Font size for quest tracker text"] = "퀘스트 추적기 문자 글꼴 크기 설정"

-- ============================================================================
-- [[  tab_unitframes.lua @@  ]] - 확인
-- ============================================================================
-- SHARED VALUES
L["Current Value"] = "현재 수치"
L["Percentage"] = "백분율"
L["Both (Numbers + Percentage)"] = "모두 표시 (수치 + 백분율)"
L["Numbers + %"] = "수치 + %"
L["Current / Max"] = "현재 / 최대"
L["None"] = "없음"
L["Elite (Golden)"] = "정예 (황금)"
L["RareElite (Winged)"] = "희귀 정예 (날개)"
L["Percentage + Current/Max"] = "백분율 + 현재/최대 수치"
L["Vertical"] = "세로 방향"
L["Horizontal"] = "가로 방향"

-- ACTIVE SUB-TAB STATE
L["Pet"] = "소환수"
L["ToT / ToF"] = "대상의 대상 / 주시의 대상"
L["Party"] = "파티"

-- COMMON CONTROLS BUILDER
L["Class Color Health"] = "생명력 바 직업 색상"
L["Class Portrait"] = "직업 초상화"
L["Class icon instead of 3D model for players."] = "플레이어 초상화에 3D 모델 대신 직업 아이콘을 사용."
L["Text Format"] = "문자 형식"
L["Format Large Numbers"] = "큰 숫자 축약 표시"
L["Always Show Health Text"] = "생명력 수치 항상 표시"
L["Always Show Mana Text"] = "마나 수치 항상 표시"
L["Threat Glow"] = "위협 수준 반짝임"

-- SUB-TAB BUILDERS
L["Player Frame"] = "플레이어 프레임"
L["Dragon Decoration"] = "용 장식"

-- Glow Effects
L["Glow Effects"] = "반짝임 효과"
L["Show Rest Glow"] = "휴식 중 반짝임 표시"
L["Golden glow around the player frame when resting (inn or city). Works with all frame modes."] = "휴식 중(여관 또는 대도시)일 때 플레이어 프레임 주변에 황금색 반짝임을 표시합니다. 모든 프레임 모드에 적용됩니다."

-- Alternate mana (druid)
L["Alternate Mana (Druid)"] = "보조 마나 (드루이드)"
L["Always Show"] = "항상 표시"
L["Druid mana text visible at all times, not just on hover."] = "드루이드의 마나 수치를 마우스 오버 시뿐만 아니라 항상 표시합니다."

-- Fat Health Bar
L["Fat Health Bar"] = "두꺼운 생명력 바"
L["Enable"] = "활성화"
L["Full-width health bar. Auto-disabled in vehicles."] = "프레임 전체 너비 생명력 바입니다. 탈것 탑승 시 자동으로 비활성화됩니다."
L["Hide Mana Bar"] = "마나 바 숨기기"
L["Completely hide the mana bar when Fat Health Bar is active."] = "두꺼운 생명력 바가 활성화된 경우 마나 바를 완전히 숨깁니다."
L["Mana Bar Width"] = "마나 바 너비"
L["Mana Bar Height"] = "마나 바 높이"
L["Mana Bar Texture"] = "마나 바 텍스처"
L["Choose the texture style for the power/mana bar. Only applies in Fat Health Bar mode."] = "자원/마나 바의 텍스처 스타일을 선택하세요. 두꺼운 생명력 바 모드에서만 적용됩니다."
L["DragonUI (Default)"] = "DragonUI (기본값)"
L["Blizzard Classic"] = "블리자드 클래식"
L["Flat Solid"] = "플랫 솔리드 (단색)"
L["Smooth"] = "부드럽게"
L["Aluminium"] = "알루미늄"
L["LiteStep"] = "라이트스텝"

-- Power bar color pickers
L["Power Bar Colors"] = "마력 바 색상"
L["Mana"] = "마나"
L["Rage"] = "분노"
L["Energy"] = "기력"
L["Runic Power"] = "룬 마력"
L["Happiness"] = "만족도"
L["Runes"] = "룬"
L["Reset Colors to Default"] = "기본 색상으로 초기화"
L["Target Frame"] = "대상 프레임"
L["Show Name Background"] = "이름 배경 표시"
L["Show the colored name background behind the target name."] = "대상 이름 뒤의 색상 배경을 표시합니다."
L["Focus Frame"] = "주시 대상 프레임"
L["Override Position"] = "위치 수동 설정"
L["Pet Frame"] = "소환수 프레임"
L["Position"] = "위치"
L["Move the pet frame independently from the player frame."] = "소환수 프레임을 플레이어 프레임과 별개로 이동시킵니다."
L["X Position"] = "가로 위치"
L["Y Position"] = "세로 위치"
L["Follows the Target frame by default. Move it in Editor Mode (|cffffd700/dragonui edit|r) to detach and position freely."] = "기본적으로 대상 프레임을 따라다니며, 편집 모드(|cffffd700/dragonui edit|r)에서 이동 시 고정 해제 및 자유로운 배치 가능"
-- Attachment status indicator
L["|cff1784d1\226\151\143 Detached|r \226\128\148 positioned freely via Editor Mode"] = "|cff1784d1● 분리됨|r — 편집 모드에서 자유로운 배치 가능"
L["|cffaaaaaa\226\151\143 Attached|r \226\128\148 follows Target frame"] = "|cffaaaaaa● 부착됨|r — 대상 프레임 추적"

-- Re-attach button
L["Re-attach to Target"] = "대상 프레임에 다시 고정"

-- Target of Focus
L["Target of Focus"] = "주시 대상의 대상"
L["Follows the Focus frame by default. Move it in Editor Mode (|cffffd700/dragonui edit|r) to detach and position freely."] = "기본적으로 주시 대상 프레임을 따라다니며, 편집 모드(|cffffd700/dragonui edit|r)에서 이동 시 고정 해제 및 자유로운 배치 가능"

-- Attachment status indicator
L["|cffaaaaaa\226\151\143 Attached|r \226\128\148 follows Focus frame"] = "|cffaaaaaa● 부착됨|r — 주시 대상 프레임 추적"

-- Re-attach button (only useful when detached)
L["Re-attach to Focus"] = "주시 대상 프레임에 다시 고정"
L["Party Frames"] = "파티 프레임"
L["Orientation"] = "배치 방향"
L["Vertical Padding"] = "세로 간격"
L["Space between party frames in vertical mode."] = "세로 배치 시 프레임 간의 여백입니다."
L["Horizontal Padding"] = "가로 간격"
L["Space between party frames in horizontal mode."] = "가로 배치 시 프레임 간의 여백입니다."
L["Unit Frames"] = "유닛 프레임"

-- ============================================================================
-- [[  tab_xprepbars.lua  ]]  - 확인
-- ============================================================================
-- STYLE SELECTOR
L["Bar Style"] = "바 스타일"
L["XP / Rep Bar Style"] = "경험치 / 평판 바 스타일"
L["DragonflightUI: fully custom bars with rested XP background.\nRetailUI: atlas-based reskin of Blizzard bars.\n\nChanging style requires a UI reload."] = "DragonflightUI: 휴식 경험치 배경이 포함된 완전 커스텀 바입니다.\nRetailUI: 블리자드 기본 바를 아틀라스 기반으로 리스킨한 버전입니다.\n\n스타일을 변경하면 UI 재설정이 필요합니다."
L["DragonflightUI"] = "용군단UI"
L["RetailUI"] = "본섭UI"
L["XP bar style changed to "] = "경험치 바 스타일 변경: "
L["Reload Now"] = "지금 재설정"
L["Cancel"] = "취소"
L["A UI reload is required to apply this change."] = "변경 사항 적용을 위해 UI 재시작 필요"

-- BAR DIMENSIONS & SCALE
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
L["Text Display"] = "문자 표시"
L["Always Show Text"] = "항상 문자 표시"
L["Always display XP/Rep text instead of only on hover."] = "마우스를 올렸을 때뿐만 아니라 항상 경험치/평판 수치를 표시합니다."
L["Show XP Percentage"] = "경험치 백분율 표시"
L["Display XP percentage alongside the value text."] = "수치 문자와 함께 경험치 퍼센트(%)를 표시합니다."
L["XP & Rep Bars"] = "경험치 및 평판 바"

-- "cord - BagSortModule" 사용으로 번역되는 문구들
L["Action button styling and enhancements"] = "단축바 버튼 스타일 및 기능 강화" -- RegisterModule
L["All-in-one bag replacement with filtering and search"] = "필터 및 검색 기능을 포함한 통합 가방 시스템" -- RegisterModule
L["Buff Frame"] = "버프 프레임"  -- RegisterModule
L["Chat Mods"] = "채팅 모드" -- RegisterModule
L["Chat enhancements: hide buttons, editbox position, URL copy, chat copy, link hover, tell target"] = "채팅 강화: 버튼 숨기기, 입력창 위치, URL/대화 복사, 링크 마우스 오버, 대상에게 귓속말" -- RegisterModule
L["Color item borders by quality in bags, character panel, bank, and merchant"] = "가방, 캐릭터 창, 은행, 상점 아이템 테두리에 품질 색상 표시" -- RegisterModule
L["Custom buff frame styling, positioning and toggle button"] = "커스텀 버프 프레임 스타일, 위치 및 전환 버튼 설정" -- RegisterModule
L["Custom minimap styling, positioning, tracking icons and calendar"] = "미니맵 스타일, 위치, 추적 아이콘 및 달력 설정" -- RegisterModule
L["Enhanced tooltip styling with class colors and health bars"] = "직업 색상 및 생명력 바가 적용된 강화된 툴팁 스타일" -- RegisterModule
L["Hide Blizzard"] = "기본 요소 숨기기" -- RegisterModule
L["Hide default Blizzard UI elements"] = "기본 블리자드 UI 요소 숨기기" -- RegisterModule
L["Item Quality"] = "아이템 등급" -- RegisterModule
L["Key Binding"] = "단축키 설정" -- RegisterModule then
L["LibKeyBound integration for intuitive keybinding"] = "직관적인 단축키 설정을 위한 LibKeyBound 통합" -- RegisterModule then
L["Main action bars, status bars, scaling and positioning"] = "주 단축바, 상태 바 크기 및 위치 설정" -- RegisterModule
L["Micro menu and bags system styling and positioning"] = "마이크로 메뉴 및 가방 시스템 스타일/위치 설정" -- RegisterModule
L["Pet action bar positioning and styling"] = "소환수 단축바 위치 및 스타일 설정" -- RegisterModule
L["Quest tracker positioning and styling"] = "퀘스트 추적기 위치 및 스타일 설정" -- RegisterModule
L["Sort bags and bank items with buttons"] = "버튼으로 가방 및 은행 아이템 정렬" -- BagSortModule
L["Stance/shapeshift bar positioning and styling"] = "태세/변신 바 위치 및 스타일 설정" -- RegisterModule
L["Tooltip"] = "툴팁" -- RegisterModule
L["Vehicle interface enhancements"] = "탈것 인터페이스 기능 강화" -- RegisterModule

# 🐉 DragonUI for 3.3.5a

<div align="center">

![Interface Version](https://img.shields.io/badge/Interface-30300-blue)
![WoW Version](https://img.shields.io/badge/WoW-3.3.5a-orange)
![Version](https://img.shields.io/badge/Version-2.4.0-green)

**Bringing the retail WoW look to 3.3.5a, inspired by Dragonflight UI Classic**

Created and maintained by **Neticsoul**, with community contributions.

</div>

---

## 📌 Project Status

DragonUI is in active development. While already in an advanced state, occasional bugs may occur.

## ✨ Features

- 🧩 Modular system: enable or disable any major UI component independently.
- 🎯 Custom action bars with configurable grid layouts, visibility rules, and quick presets.
- 💚 Reworked unit frames for player, target, focus, party, pet, boss, ToT, and ToF, with elite dragon decoration and fat health bar modes.
- 🩹 Unit Frame Layers: heal prediction, absorb shields, and animated health loss overlays.
- 📊 XP & Reputation bars with Dragonflight and RetailUI styles, independently movable.
- 🎒 Auto-sort for bags and bank with slot locking, plus integrated Combuctor for unified inventory browsing.
- 🗺️ Custom minimap, micro menu, cast bars, buff frame, quest tracker, and more.
- ⌨️ Editor Mode: move and reposition nearly every UI element.
- 💬 Chat enhancements: moveable editbox, URL detection, chat copy, and `/tt` whisper command.
- 🌙 Dark mode with three intensity presets and custom color picker.
- 💎 Item quality borders, enhanced tooltips, range indicator, and latency indicator.
- ⌨️ Easy-to-use keybinding mode on supported buttons.
- ⚙️ Custom dark-themed configuration panel with profile support and per-module controls.
- 🌍 Localization for English, Spanish, Mexican Spanish, German, Korean, and Russian.

## 📦 Installation

1. Download the latest release archive.
2. Extract the archive.
3. Copy `DragonUI` and `DragonUI_Options` into your client's `Interface\AddOns\` folder.

> 💡 **Clean install:** delete `WTF\Account\<AccountName>\` to wipe all saved settings for all addons on that account.

## 🔧 Commands

| Command | Action |
|---|---|
| `/dragonui`, `/dui` or `/pi` | Opens the configuration UI |
| `/dragonui edit` | Toggles editor mode |
| `/dragonui help` | Shows available commands |
| `/sort` | Sorts your bags |
| `/tt <message>` | Whisper your current target |
| `/rl` | Reloads the UI |

## ⚠️ Known Issues

- Party and raid role icons (DPS, Healer, Tank) may be lost after reloading the UI during combat in dungeons joined via the Dungeon Finder.
- Party and raid scenarios still need broader real-world validation.
- Some compatibility paths with third-party addons may still require manual module disablement or extra cleanup.
- Found a bug or want to suggest a feature? Let me know in the [issues](https://github.com/NeticSoul/DragonUI/issues).

## 🙏 Credits And References

DragonUI combines original work with adapted ideas, ports, and implementation references from multiple addon authors and projects.

- [Dragonflight UI (Classic)](https://github.com/Karl-HeinzSchneider) by Karl-HeinzSchneider
- [pretty_actionbar and pretty_minimap](https://github.com/s0h2x) by s0h2x
- [RetailUI](https://github.com/a3st) by a3st (Dmitriy)
- [KPack](https://github.com/bkader/KPack) by bkader
- [Combuctor](https://github.com/Jaliborc) by Jaliborc
- [BankStack](https://github.com/kemayo/) by kemayo
- [UnitFrameLayers](https://github.com/RomanSpector) by RomanSpector
- [oGlow](https://github.com/haste) by haste
- [ElvUI-WotLK](https://github.com/ElvUI-WotLK/) as a pattern reference in selected areas.
- [CrimsonHollow](https://github.com/CrimsonHollow) for Fat Health Bar contribution
- [RovBot](https://github.com/RovxBot) for action bar grid/preset system
- [Raz0r](https://github.com/Raz0r1337) for German localization
- Did I forget you...? Please let me know opening an [issue](https://github.com/NeticSoul/DragonUI/issues).

## 💛 Special Thanks

- Everyone who tested early builds, reported bugs, and helped shape the addon into what it is today.
- Translators who contributed localizations and caught string issues across different clients: nadugi (Korean), [Raz0r](https://github.com/Raz0r1337) (German).
- The addon authors listed in Credits, whose open work made this project possible.
- Players who took the time to open issues, share screenshots, and suggest improvements.

## 📜 Legal And Licensing Summary

- DragonUI code is released under the [MIT License](LICENSE).
- Bundled third-party components have their own licenses. See [`THIRD_PARTY_NOTICES.md`](THIRD_PARTY_NOTICES.md) and [`LICENSES/`](LICENSES/).

## 📎 Disclaimer

DragonUI is a free, fan-made addon created for the community.

No content is sold and no in-game advantages are provided in exchange for money.

Donations, if any, are entirely voluntary and go towards supporting development and maintenance.

DragonUI is not affiliated with, endorsed by, or sponsored by Blizzard Entertainment. World of Warcraft and all related trademarks are the property of Blizzard Entertainment.

## ☕ Support The Project

DragonUI will remain free to use.

Support is voluntary and goes towards maintenance, testing, and continued development.

- [![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/W7W11WA4K6)

- 🪙 Bitcoin: `bc1q8yavz8857lzdfttas584892gf82y0u3wdfjz0a`


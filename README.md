# TadpolePlus

A [UE4SS](https://github.com/UE4SS-RE/RE-UE4SS) Lua mod for **Subnautica 2** that improves the Tadpole and its **Haul** and **ScoutRay** chassis: faster movement, sharper handling, larger cargo grids, and optional removal of chassis speed penalties.

## Features

- **Base Tadpole** — Configurable swim/walk speed, acceleration, braking, and turn responsiveness
- **Haul chassis** — More inventory slots, stronger acceleration, improved strafe/turn
- **ScoutRay chassis** — Expanded inventory and tuned handling
- **Save-friendly** — Patches new spawns and existing vehicles after world load
- **Fully tunable** — Edit `Scripts/config.lua`; no rebuild required

## Requirements

- Subnautica 2 (WinGDK / PC build supported by your UE4SS install)
- [UE4SS](https://github.com/UE4SS-RE/RE-UE4SS) installed and working for your game version

## Installation

1. Install and configure UE4SS for Subnautica 2.
2. Copy the entire `TadpolePlus` folder into your game's `ue4ss/Mods` directory, for example:

   ```
   …/ue4ss/Mods/TadpolePlus/
   └── Scripts/
       ├── main.lua
       └── config.lua
   ```

3. Enable the mod in your UE4SS mod configuration if required.
4. Launch the game and load a save. Check the UE4SS console for `[TadpolePlus]` messages to confirm hooks ran.

## Configuration

Edit **`Scripts/config.lua`** to change defaults. Restart the game (or reload the mod) after changing values.

| Setting | Component | Description |
|--------|-----------|-------------|
| `Speed` | Base Tadpole | Swim/walk speed |
| `Acceleration` | Base Tadpole / chassis | Movement acceleration |
| `TurnMultiplier` | Base Tadpole / chassis | Rotation and strafe scaling |
| `InventoryMaxItems` | Haul / ScoutRay | Total cargo slots |
| `InventoryColumns` | Haul / ScoutRay | Inventory grid width |
| `RemoveSpeedDebuff` | Haul / ScoutRay | Strip speed/slow debuff effects from chassis data |

### Default values

| | Base Tadpole | Haul | ScoutRay |
|--|--------------|------|----------|
| Speed | 1200 | — | — |
| Acceleration | 2000 | 3000 | 2300 |
| Turn multiplier | 1.0 | 1.5 | 1.0 |
| Inventory slots | — | 40 | 30 |
| Inventory columns | — | 5 | 5 |
| Remove speed debuff | — | false | false |

Vanilla Haul inventory is 30 slots; this mod defaults to 40. Set `RemoveSpeedDebuff = true` on a chassis if you want to remove the vanilla speed penalty effects entirely.

## How it works

- Hooks `BP_Tadpole`, `BP_Haul_TadpoleChassis`, and `BP_ScoutRay_TadpoleChassis` on spawn
- Buffs chassis data assets (`DA_Haul_TadpoleChassis`, `DA_ScoutRay_TadpoleChassis`) for acceleration and turning
- Applies inventory changes via `SetMaxItems` when an inventory component exists
- Re-applies base Tadpole speed periodically so transient chassis debuffs do not stick

ScoutRay may not always expose an inventory component; the mod skips that case without errors.

## Troubleshooting

- No effect in-game: confirm UE4SS is loading and the mod folder path is correct.
- Values seem ignored: edit `config.lua`, then fully restart the game.
- Look for `[TadpolePlus] Mod loaded.` in the UE4SS log to confirm the mod started.

## License

MIT — see [LICENSE](LICENSE). You are free to use, modify, and redistribute this code with attribution.

This license applies only to the mod scripts in this repository, not to Subnautica 2, UE4SS, or any game assets.

## Links

- **Repository:** [github.com/jonaelsasser/TadpolePlus](https://github.com/jonaelsasser/TadpolePlus)
- **UE4SS:** [github.com/UE4SS-RE/RE-UE4SS](https://github.com/UE4SS-RE/RE-UE4SS)

# The Forgotten (Roblox)

Starter source project for **The Forgotten**, a Roblox co-op horror game. The design plan is in [`GAME_DESIGN.md`](GAME_DESIGN.md). This repository uses a [Rojo](https://rojo.space/) layout so the Lua source can be synced into Roblox Studio.

## Starter features

- Server-side monster patrol pursuit using `PathfindingService`, vision checks, and configurable detection settings.
- Server-side key and objective prompts using `CollectionService` tags.
- A small client HUD that displays the current objective and pickup feedback.
- Server-authoritative state changes; clients do not award keys or complete objectives themselves.

## Project layout

```text
src/
  server/
    MonsterAI.server.lua
    ObjectiveService.server.lua
  client/
    ObjectiveHUD.client.lua
  shared/
    (shared modules go here)
default.project.json
```

## Requirements

- Roblox Studio
- [Rojo](https://rojo.space/) CLI (optional, for syncing source from this repository)

## Run in Studio

1. Open a new Roblox place in Studio.
2. Install Rojo and run `rojo serve` from this repository, then connect with the Rojo Studio plugin. Alternatively, copy the files from `src/` into matching `ServerScriptService`, `StarterPlayerScripts`, and `ReplicatedStorage` locations.
3. In `Workspace`, create a monster Model named `Monster` with a `Humanoid` and `HumanoidRootPart`. Set the model's `PrimaryPart` to `HumanoidRootPart`; make sure its parts are not anchored and its rig has a `Humanoid` that can use `MoveTo`.
4. Add a few navigable rooms and test that the monster can path between them. Roblox navigation requires walkable geometry and clear agent paths.
5. Add key objects and objective trigger parts as described below, then press **Play** to test with a server and client.

## Configure key pickups

For each key, select its `BasePart` (or a Model with a `PrimaryPart`) in Studio:

1. Add the CollectionService tag `KeyItem`.
2. Set the string attribute `KeyId` (for example, `ReceptionKey`).
3. Optionally set the string attribute `DisplayName` (for example, `Reception Key`).

The server adds a `ProximityPrompt`. When activated, the key is recorded on that player as the boolean attribute `HasKey_<KeyId>`. Keys are per-player in this starter; change the service if your design uses shared team inventory.

## Configure objective triggers

For each objective trigger, create a `BasePart` in the world and:

1. Add the CollectionService tag `ObjectiveTrigger`.
2. Set string attributes `ObjectiveId` and `ObjectiveText`.
3. Optionally set `RequiredKeyId` to a key ID that player must have first.

The server adds a prompt and marks `ObjectiveCompleted_<ObjectiveId>` for that player when activated. This is a starter interaction framework: connect completed objectives to doors, generators, and puzzle logic as your level is built.

## Monster settings

The monster script reads optional numeric attributes from the `Monster` model:

- `DetectionRange` (default 65 studs)
- `AttackRange` (default 4 studs)
- `RepathInterval` (default 1 second)
- `WalkSpeed` (default 12)
- `ChaseSpeed` (default 18)

It pursues the nearest living player it can see within range, and returns to its starting point when it has no target. The current prototype resets a caught player by reducing their Humanoid health to zero; replace this with a checkpoint or spectator flow if desired. Tune speeds and ranges in Studio and test with multiple players.

## Notes

This is a scaffold, not a finished game. It does not include production-ready animations, networking polish, saved progress, a complete inventory UI, or all puzzles and rooms. Keep critical gameplay decisions on the server, validate all prompts and object references, and test multiplayer behavior in Studio before publishing.

# The Forgotten — Game Design Plan

## High concept

**The Forgotten** is a cooperative-capable Roblox survival horror experience set in an abandoned institutional building. Players explore dark, decaying rooms, gather keys and clues, solve environmental puzzles, and open an escape route while being hunted by a towering, 10-foot creature. The building’s story is pieced together through objects and details in the environment rather than long exposition.

**Player goal:** Restore power to the exit systems, collect the required access items, and escape before the monster catches the team.

**Tone:** Tense, eerie, and suspenseful. Use darkness, sound, uncertainty, and pursuit to create fear; keep scares readable and avoid relying on constant loud jump scares.

## Core gameplay loop

1. Explore a new area and identify blocked routes, clues, and hiding places.
2. Search drawers, shelves, and environmental landmarks for a key or puzzle component.
3. Solve a room puzzle to restore power or unlock a route.
4. Listen and watch for signs of the monster; break line of sight and hide when it approaches.
5. Use newly opened passages to reach the next objective.
6. Complete the final power and access sequence, then make a dangerous run to the exit.

A first playthrough should take roughly 25–40 minutes. Checkpoints or short routes between major sections can reduce frustration without removing the threat.

## Setting and story

The building was once a private treatment and research facility called **Ashgrove House**. It was abruptly abandoned after a nighttime power failure and a sealed-wing incident. The player arrives looking for a way out after becoming trapped inside. Scattered notes, patient drawings, labels, and damaged recordings hint that staff tried to contain a creature created—or awakened—by the facility’s experiments. The truth is deliberately incomplete, leaving room for later chapters.

## The monster: The Warden

- **Silhouette:** A gaunt, roughly 10-foot-tall figure with a hunched posture, elongated arms, and a featureless, cracked mask. Its height and slow movement should read clearly in doorways and hallways.
- **Audio identity:** Distant dragging footsteps, a faint metallic rattle, and a low breath. Sounds grow clearer as it gets closer, giving attentive players a chance to react.
- **Behavior:** The Warden patrols connected areas, investigates loud actions and recently opened doors, and pursues players it sees. It searches nearby hiding places if it witnessed someone enter or heard a clear noise there, but should not automatically know every player’s location.
- **Counterplay:** Break line of sight, close doors to delay it, use alternate routes, and hide quietly. Sprinting helps create distance but makes more noise. Hiding buys time; it is not a guaranteed safe state.
- **Fairness:** Telegraph a chase with a distinct audio cue and a short reaction window. Avoid spawning the monster directly beside players or attacking through solid geometry. On defeat, show a brief, non-graphic recovery screen and resume at the last checkpoint.
- **Difficulty:** Increase patrol pressure and reduce recovery windows as objectives are completed, while retaining clear cues and viable escape routes.

## Areas, scares, and objectives

### 1. Reception and Lobby
A rain-streaked entrance, overturned chairs, a dead reception desk, and a locked security door establish the setting. A flickering ceiling light briefly reveals a tall silhouette at the far end of the hall. Players find a **Reception Key** in the desk after matching a name on a visitor log to a labeled cubby. This opens the records corridor.

### 2. Records Corridor and Archive
Tall filing shelves create narrow sightlines. A rolling cart moves slightly when no one is looking; papers rustle behind a closed drawer. Find three patient-file tabs and place them in the order indicated by dates on a wall calendar. The archive cabinet opens to reveal the **Boiler Room Key** and a staff note about the power system.

### 3. Dormitory Wing
Rows of empty beds, curtains, and personal belongings make the room feel inhabited despite its silence. A music box plays from one bedside table and stops when approached. Players search beds and lockers for a **Fuse** and a torn note containing a simple four-symbol sequence. A wardrobe and space beneath beds provide hiding spots; curtains obscure vision but do not fully conceal movement.

### 4. Boiler Room
Pipes clang, steam bursts intermittently, and the lights pulse as the generator struggles. Players use the fuse, then turn three valves in the order shown by colored pipe labels in the dormitory note. Correctly restoring power opens the east wing and lights a few safe navigation lamps. Incorrect valve order creates a loud hiss that can attract the Warden.

### 5. Examination Wing
Curtained exam bays and old equipment form a maze of short rooms. A heartbeat monitor clicks in an otherwise quiet room; its rhythm changes as the Warden approaches. Search the supply cabinets for the **East Wing Key**. To open the medicine cabinet, set three rotating dials to the symbols found on patient drawings. A service closet and curtained bays offer temporary concealment.

### 6. Chapel and Sealed Hall
A small abandoned chapel contains rows of chairs, a cracked stained-glass window, and a locked iron gate. Align four movable candle stands with the colored glass panels, following a clue in the archive. Completing the puzzle reveals a **Gate Handle**. The Warden may patrol the surrounding corridor, making the final approach to the handle a tense timing challenge.

### 7. Security Office and Exit Control
A monitor wall shows distorted views of rooms players have visited. A handwritten instruction explains the final sequence: insert the **East Wing Key**, engage the restored generator, then hold the exit release. The security-office cabinet contains the **Exit Key** after players enter a code assembled from numbers found on the visitor log, file dates, and a boiler gauge. This is the last safe planning area before the escape.

## Keys and important items

| Item | Location / method | Opens or enables |
|---|---|---|
| Reception Key | Reception desk; match visitor log to cubby label | Records corridor |
| Boiler Room Key | Archive cabinet after ordering patient-file tabs | Boiler Room |
| Fuse | Dormitory beds or lockers | Generator repair |
| East Wing Key | Examination-wing supply search and symbol-dial puzzle | East wing and exit-control sequence |
| Gate Handle | Chapel candle alignment puzzle | Sealed Hall gate |
| Exit Key | Security Office code puzzle | Main exit release |

Keep item prompts clear and avoid requiring pixel-perfect searching. In multiplayer, important quest items should be shared or automatically registered for the whole team so one player cannot accidentally soft-lock everyone.

## Hiding and evasion

- **Wardrobes:** Strong concealment when entered out of the Warden’s sight; opening and closing creates a small sound.
- **Under beds:** Quick to enter, but the monster can check nearby beds if it saw a player duck under one.
- **Curtains and exam bays:** Break sightlines but are unreliable if the player moves or makes noise.
- **Storage closets:** Useful cover near objectives; some have more than one exit to avoid trapping players.
- **Environmental loops:** Provide alternate routes around furniture and through connected rooms so players can evade rather than only hide.

Show a subtle prompt when a hiding place is usable. Prevent hiding while directly observed, and avoid long animations that remove player control during a chase.

## Escape ending

Once the generator is running and the Exit Key is used, players pull the release lever. The exit lights switch on, an alarm begins, and the Warden emits a roar from the sealed hall. Players must sprint through the now-lit lobby and reach the front doors while the creature pursues them. The doors open only after all surviving players reach the threshold (or after a brief solo-friendly delay in single-player).

**Ending beat:** Outside in the rain, the survivors see the building’s lights go dark behind them. A distant figure appears in an upper window, then vanishes. The final screen reads: **“You escaped Ashgrove House. It remembers you.”** A short post-credit clue—a marked map or a new message—can tease a future chapter without negating the escape.

## Roblox implementation and player experience notes

- Use Roblox lighting, carefully placed fog, flickering fixtures, and localized audio to guide mood while keeping routes navigable.
- Provide subtitles or visual sound indicators for important monster cues, plus adjustable audio and brightness options.
- Use readable objective prompts and a persistent objective tracker; keep puzzle clues discoverable in the relevant area.
- In multiplayer, scale patrol pressure modestly with player count and prevent a caught player from being eliminated for the entire session.
- Keep scares non-graphic and suitable for Roblox’s audience. Clearly communicate chase states, checkpoints, and interaction ranges.
- Test puzzles and routes with players unfamiliar with the layout; each critical clue should have a discoverable location and no key item should be missable permanently.

## Suggested build milestones

1. **Graybox:** Lobby, connected rooms, exits, hiding spots, and player movement.
2. **Core loop:** Interactions, key inventory/objective tracking, and one complete puzzle chain.
3. **Monster prototype:** Patrol, sound investigation, line-of-sight pursuit, and fair hiding checks.
4. **Vertical slice:** Reception through Boiler Room with lighting, audio cues, and a checkpoint.
5. **Full chapter:** Remaining areas, final chase, escape ending, multiplayer testing, and accessibility options.

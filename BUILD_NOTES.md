# Build notes: OStim Beast Form - TWO Edition

## 0.1 (first public release)
Built from the public OStim Beast Form Merged 0.5 plugin and files, re-targeted at TWO 4.1.

**Dropped from 0.5** (TWO provides the look): the `WerewolfBeastRace` override, the `NakedTorsoWerewolfBeast` redirect to `coronerra\bfa`, the BFA werewolf head parts 800-803, and every werewolf body / head / teeth / eye / SMP / texture file.

**Changed:**
- Masters: JS Emissive Eyes and Growl replaced by `Werewolves.esp` (TWO) and `MonsterLipSync1.esp` (MFA) in the same master slots.
- `DLC1VampireBeastRace`: JS Emissive Eyes spell removed (SPCT 5 → 4).
- `OBL_WerewolfAddonAA` points at TWO's `CreatureFramework\CanineRedHard.nif`; `OBL_Main.WerewolfMesh` set to the same path through VMAD.
- `OBF_MCM.pex` recompiled (Caprica 0.3.0) with the `BeastPie` property.
- Actor-property JSON `mod` = `OStim_Beast_Form_TWO.esp`; SkyrimNet manifests accept either plugin.

**Kept:** all quests, perks, globals, keyword, OCum Werewolf Shot records, scenes, hubs, HKX fallback idles, icons, Vampire Lord files, SkyrimNet/OStimNet bundles. Same local FormIDs as 0.5.

**Optional BFA add-on:** 3 HDPT overrides (NAM1 only) + `ExpHeadWerewolf_BFA.tri` (TWO TRI + 2 authored brow morphs; geometry and the original 36 morphs byte-identical).

**Static checks** (`Data/Docs/OStim Beast Form TWO/STATIC_CHECKS_TWO_0.1.txt`): ESL flag, masters, no werewolf race/body override, TRI geometry and morphs, TWO skeleton bones, CanineRedHard textures present in TWO Core, and no packaged file byte-identical to any TWO / Alternate Textures file.

**Packaging:** FOMOD zip, `00 Main` (required) + `10 BFA Heads` (optional). Release asset: `OStim_Beast_Form_TWO_0.1.zip`.

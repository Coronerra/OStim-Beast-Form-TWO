# AI_CONTEXT: how OStim Beast Form - TWO Edition works

For AI assistants, bots and modders who want to understand or extend this mod quickly. Everything written by That Guy (Coronerra) is MIT; third-party assets belong to their authors (see [LICENSE](LICENSE)). The design is the Growl edition ([OStim-Beast-Form-Merged](https://github.com/Coronerra/OStim-Beast-Form-Merged), read its AI_CONTEXT.md for the shared script and OStim details) re-targeted at **TWO - Total Werewolf Overhaul 4.1** (Frosferes).

## 1. Scope and sibling projects
- **This repo:** standalone edition for TWO users who do not need Growl. Plugin `OStim_Beast_Form_TWO.esp`.
- **[OStim-Beast-Form-Merged](https://github.com/Coronerra/OStim-Beast-Form-Merged):** the main Growl edition (`OStim_Beast_Form_Merged.esp`).
- **[OStim-Beast-Form-Merged-TWO-Patch](https://github.com/Coronerra/OStim-Beast-Form-Merged-TWO-Patch):** a small save-safe patch that puts TWO bodies on the Growl edition.
- The three setups are mutually exclusive. This edition and the Growl edition use the same script names and local FormIDs, so they must never both be enabled.
- This repo exists separately so it can be removed on request from Frosferes without touching the main project. Never add TWO files to it.

## 2. Repository layout
```
Data/                         mirrors the game Data folder (text sources only)
  Scripts/Source/*.psc         Papyrus sources (compiled .pex ship in the release zip)
  SKSE/Plugins/OStim/actor properties/   OBLWerewolfMale/Female, OBLVampireLordMale/Female ("mod": "OStim_Beast_Form_TWO.esp")
  SKSE/Plugins/OStim/scenes/   hub, idle, forwarding and pack scene JSON (same as 0.5)
  SKSE/Plugins/OStimNet/animationsDescriptions/   OStimNet scene descriptions
  SKSE/Plugins/SkyrimNet/external/coronerra.beastaware/         Beast Aware bundle (accepts either plugin)
  SKSE/Plugins/SkyrimNet/external/coronerra.beastform_ostimnet/ OStimNet bridge bundle (accepts either plugin)
  meshes/.../FNIS_OBFMerged_*_List.txt   behaviour lists for the fallback idles
  Docs/OStim Beast Form TWO/   packaged README, static checks, integration notes
fomod/                        ModuleConfig.xml + info.xml used by the release zip
BUILD_NOTES.md                record-level details and how the zip is laid out
```
Binaries (ESP, PEX, NIF, DDS, HKX, TRI) are in the release zip, not in git.

## 3. Release zip layout
- `00 Main` (required): `OStim_Beast_Form_TWO.esp`, `Scripts/*.pex` (+ `Scripts/Source`), OStim/OStimNet/SkyrimNet data, Vampire Lord meshes/textures and OCum urethra node (same files as public 0.5), hub icon, HKX fallback idles, docs.
- `10 BFA Heads` (optional): `OStim_Beast_Form_TWO - BFA Heads.esp` + `meshes/actors/werewolfbeast/character assets/coronerra/two/ExpHeadWerewolf_BFA.tri`.
- No file in the zip is at a TWO / TWO Alternate Textures path or byte-identical to a TWO file.

## 4. Plugin `OStim_Beast_Form_TWO.esp` (ESL, 25 records)
Masters: `Skyrim.esm`, `Update.esm`, `Dawnguard.esm`, `Dragonborn.esm`, `Werewolves.esp` (TWO), `MonsterLipSync1.esp` (MFA), `OStim.esp`, `OCum.esp`. The two TWO/MFA masters fill the slots that JS Emissive Eyes and Growl hold in 0.5, so every other master index and all self references match 0.5. No Growl, JS or OCreatures master.

| FormID (local) | Type | EditorID | Purpose |
|---|---|---|---|
| 804 | FLST | BFA_HeadPartsVampireLord | VL head part list |
| 805-808 | HDPT | BFA_Male/FemaleHead/Eyes VampireLord | Talking VL head parts (as 0.5) |
| 810-813 | PERK | OBL_{Werewolf,VampireLord}{Male,Female}Condition | Conditions for the OStim actor-property JSONs |
| 820 | QUST | OBF_BeastFormQuest | OBF_Main + OBF_MCM + OBF_PlayerAlias |
| 821 | QUST | BA_BeastAwareQuest | BA_Main + BA_MCM + BA_PlayerAlias |
| 822 | QUST | OCumBeastPieQuest | OCumBeastPie + OCumBeastPieAlias |
| 830 | ARMA | OCumUrethraNodeWerewolfAA | OCum urethra node on bone WWD 9 |
| 831 / 832 | GLOB | OBL_SwapEnabled / OBL_OCreaturesPresent | Aroused-swap switch / OCR detected |
| 833-836 | ARMA/ARMO | OBL_WerewolfAddon(AA), OBL_VampireLordAroused(AA) | Aroused WW mesh = TWO `CreatureFramework\CanineRedHard.nif` (slot 52); VL hard mesh |
| 837 | QUST | OBL_MainQuest | OBL_Main + OBL_PlayerAlias |
| 838 | KYWD | OBL_NoStrip | Keeps the swap item from being stripped |
| Override | RACE | DLC1VampireBeastRace | BFA VL HEAD parts; JS Emissive Eyes spell removed (no JS master) |
| Override | ARMA | DLC1NakedVampireLord | Headless VL body |
| Override | ARMO/ARMA | OCumUrethraNodeSOS(AA) (OCum.esp) | Werewolf Shot |

**Not** overridden (compared with 0.5): `WerewolfBeastRace` and `NakedTorsoWerewolfBeast`. TWO's `Werewolves.esp` / `WerewolvesGrowl.esp` / `WerewolvesMTSE.esp` keep the werewolf race, heads and body. No TWO record is overridden by the main plugin.

### BFA add-on `OStim_Beast_Form_TWO - BFA Heads.esp` (ESL, 3 records)
Masters `Skyrim.esm`, `MonsterLipSync1.esp`, `Werewolves.esp`. Overrides TWO's `MaleHeadWerewolf` (MFA 0x800 as TWO overrides it) and `FemaleHeadWerewolf` (TWO 0x805) to use `coronerra\two\ExpHeadWerewolf_BFA.tri`, and `FemaleMouthWerewolf` (TWO 0x806) to use TWO's own `ExpMouthWerewolf.tri` (TWO's record names a `.nif`). Only NAM1 changes. The TRI = TWO's TRI (1362 verts, 36 morphs, byte-identical) + `browupleft` / `browupright`.

## 5. Scripts (same as 0.5 except where noted)
`OBF_Main`, `OBF_MCM`, `OBF_PlayerAlias`, `OBF_OCRCompat`, `OBL_Main`, `OBL_PlayerAlias`, `BA_Main`, `BA_MCM`, `BA_PlayerAlias`, `OCumBeastPie`, `OCumBeastPieAlias`. See the Growl edition's AI_CONTEXT for what each does.
- `OBF_MCM`: has an `OCumBeastPie Property BeastPie` filled by the plugin's VMAD; `BL()` falls back to `GetFormFromFile(0x822, "OStim_Beast_Form_Merged.esp")`, so one source works for both editions.
- `OBL_Main.WerewolfMesh`: the source default is the 0.5 MNC path; the TWO plugin's VMAD sets it to TWO's `CanineRedHard.nif`. The swap checks the file with `MiscUtil.FileExists`, and steps aside when OCreatures is loaded.
- The timer guard pauses `PlayerWerewolfShiftBackTime` (Skyrim 0x2BA19); TWO Extras' replacement werewolf script still uses that global.

Compile with Caprica or the CK compiler. Imports: vanilla, SKSE, SkyUI SDK, OStim Standalone, OCum Ascended, PapyrusUtil, PO3 Papyrus Extender, RaceMenu/NiOverride, SkyrimNet API.

## 6. TWO facts the design relies on
- TWO's `Werewolves.esp` (ESL, masters Skyrim, Dawnguard, MonsterLipSync1) overrides vanilla `WerewolfBeastRace` 0xCDD84 (FaceGen on) and `NakedTorsoWerewolfBeast` 0xCDD87 (vanilla body paths that TWO / BodySlide fill). It does not touch Vampire Lord records. It shares its filename with HDT Werewolves, so the two are exclusive.
- TWO's skeleton already has WWD 1-9, WWLK/WWRK/WWLB/WWRB and the 3BA-style genital/anus bones. ABC / MNC / OCum meshes skinned to WWD bones work on it. No skeleton is shipped or edited.
- Wicked Werewolves skeleton changes proportions; unsupported.

## 7. Rules for contributors
- Never add TWO, TWO Alternate Textures, MFA or Growl files to this repo or its zips. Reference paths/records only.
- Keep FormIDs stable; renaming the plugin breaks saves.
- Credit: That Guy (Coronerra); Frosferes for TWO; TealEri (CinnaMewRoll) for MFA morphs.

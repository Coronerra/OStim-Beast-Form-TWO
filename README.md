# OStim Beast Form - TWO Edition 0.2

> **Download:** [v0.2 release](https://github.com/Coronerra/OStim-Beast-Form-TWO/releases/tag/v0.2) → `OStim_Beast_Form_TWO_0.2.zip` (MO2 / FOMOD installer).
> This repo holds the open-source parts (Papyrus sources, OStim JSON, SkyrimNet bundles, FOMOD, docs). AI assistants: start with **[AI_CONTEXT.md](AI_CONTEXT.md)**. Build details: [BUILD_NOTES.md](BUILD_NOTES.md). License: [MIT for That Guy (Coronerra)'s work; third-party assets belong to their authors](LICENSE).

**Skyrim SE / AE · OStim Standalone · ESL-flagged plugin · for TWO - Total Werewolf Overhaul 4.1 · by That Guy (Coronerra)**

---

## ⚠️ Which download is for you?

There are three related projects. **Use exactly one of them.**

| You use… | Get this |
|---|---|
| Growl + the HDT Werewolves / ABC look | **[OStim Beast Form Merged 0.6](https://github.com/Coronerra/OStim-Beast-Form-Merged)** (main Growl edition; [v0.6 release](https://github.com/Coronerra/OStim-Beast-Form-Merged/releases/tag/v0.6)) |
| **TWO 4.1, no Growl needed** | **This repo: OStim Beast Form - TWO Edition 0.2** ([v0.2 release](https://github.com/Coronerra/OStim-Beast-Form-TWO/releases/tag/v0.2)) |
| Growl + OStim Beast Form Merged (0.5 or 0.6) already, and you want TWO bodies **without losing your save** | **[OStim Beast Form Merged - TWO Patch 0.1](https://github.com/Coronerra/OStim-Beast-Form-Merged-TWO-Patch)** ([v0.1 release](https://github.com/Coronerra/OStim-Beast-Form-Merged-TWO-Patch/releases/tag/v0.1)) |

**Never use the TWO Edition together with the Merged TWO Patch, and never enable it together with OStim Beast Form Merged.** They share the same scripts.

A **new game is recommended** if your save ever ran the Growl edition (see [New game?](#new-game)).

---

## What this is

The same OStim Beast Form features as the Growl edition (OStim Beast Form Merged 0.6), built for people who use **TWO - Total Werewolf Overhaul 4.1** by **Frosferes**. TWO keeps its look: its bodies, heads, BodySlide builds, skeleton, SMP physics and textures (including TWO Alternate Textures) are not replaced or edited. This mod ships **no** werewolf body, head, skeleton or werewolf texture, and **no file from TWO**. You need your own copy of TWO 4.1.

### Carried over from the Growl edition
- Start OStim scenes while you are a werewolf (hotkey in the MCM), with the beast-form timer paused during scenes (`PlayerWerewolfShiftBackTime`).
- The werewolf / Vampire Lord hub menus, pack pages and the Lirael animation pack scene files, plus the built-in fallback idles (run Pandora).
- **Beast Aware + SkyrimNet:** NPCs know you are a werewolf / werebear / Vampire Lord; the OStimNet bridge prompt lets NPCs pick you as a partner.
- **Beast Load** (OCum climax handling) and **OCum Werewolf Shot** (the OCum shot comes from the werewolf tip, bone `WWD 9`, which TWO's skeleton already has).
- Vampire Lord support, same as the Growl edition (talking VL heads, headless VL bodies, VL aroused swap).
- OCreatures Reforged stays optional (not a master).

### Different from the Growl edition
- **Werewolf look = TWO.** The Growl edition's ABC / HDT Werewolves bodies and MFA/BFA heads are not included.
- **Aroused cock during scenes (male werewolves):** Beast Form swaps in TWO's own hard canine mesh (`actors\werewolfbeast\character assets\CreatureFramework\CanineRedHard.nif`, part of TWO Core, with TWO's genital SMP), not the GT Softbody / MNC one. Nothing is shipped for it; it uses your TWO copy.
- Outside scenes, the male werewolf's genitals are whatever you chose in TWO's installer (Creature Framework, HCOS, SOS or None). TWO's body has no sheath of its own.
- **No Growl and no JS Emissive Eyes requirement.** TWO's own eyes are used for werewolves. Vampire Lords lose the JS Emissive Eyes glow if you use that mod, because this plugin's Vampire Lord race record wins.
- The werewolf race record is **not edited at all**, so TWO's `Werewolves.esp` (or TWO's Growl / Moonlight Tales patch) keeps control of it.
- Better Facial Animations (BFA) support is an optional add-on (see [BFA heads](#optional-bfa-heads)).

### Female werewolf scenes
Female werewolf scenes are **not bundled**. Since 0.2 the experimental WWF_OnTop female cowgirl test scenes are gone. Separate, optional female-werewolf scene packs (for example, an OStim conversion of **Dayelyte's** female werewolf animations) add their own button to the female werewolf hubs. Without one, the female werewolf + man hub is an idle with no buttons.

---

## Changelog

**0.2**
- Removed the experimental WWF_OnTop female cowgirl test scenes (`WWFCowgirl1-1` to `1-5`) and their "WW Female Cowgirl 1 (TEST)" button on the female werewolf + man hub (`OBFWerewolfIdleMF`), plus their OStimNet descriptions. Same change as OStim Beast Form Merged 0.6.
- Female werewolf scenes come from separate, optional packs (not bundled).
- Docs and the "Which download is for you?" table now point at Merged 0.6 and the Merged TWO Patch 0.1.
- Plugins, FormIDs, masters, scripts, meshes and HKX are byte-identical to 0.1. Saves stay compatible. No Pandora run needed.
- **Updating from 0.1:** reinstall with the FOMOD as a clean replacement (MO2: "Replace"), or delete the old `SKSE/Plugins/OStim/scenes/WWF_OnTop` folder in the mod first.

**0.1** — first public release.

---

## Requirements

**Required**
- **TWO - Total Werewolf Overhaul 4.1** (Frosferes, LoversLab). *Not included.*
- **Monster Facial Animation / Monster Lipsync SE** (`MonsterLipSync1.esp`). **Hard master:** TWO and this plugin both list it as a master. The game will not load with this plugin enabled if it is missing.
- Faster HDT-SMP (for TWO's physics).
- OStim Standalone, OCum Ascended, SkyUI, PapyrusUtil, powerofthree's Papyrus Extender, Pandora (or Nemesis/FNIS) — the same as the Growl edition.
- **Animations:** OStim packs with werewolf / Vampire Lord scenes, for example Lirael Atelier's converted packs ([LoversLab account: Lauffey](https://www.loverslab.com/profile/6654496-lauffey/content/?type=downloads_file)). No animations are included.

**Optional** (same as the Growl edition): SkyrimNet, OStimNet, OCreatures Reforged, OCum Tull/Liquid patch, Better Facial Animations, TWO Alternate Textures 4.0, BodySlide.

**Not needed:** Growl, JS Emissive Eyes, HDT Werewolves, ABC, Creature Framework, HCOS, SexLab.

Plugin masters: `Skyrim.esm`, `Update.esm`, `Dawnguard.esm`, `Dragonborn.esm`, `Werewolves.esp` (TWO), `MonsterLipSync1.esp` (MFA), `OStim.esp`, `OCum.esp`.

---

## Install (Mod Organizer 2)

0. **Back up** your profile (`plugins.txt`, `loadorder.txt`, `modlist.txt`). If you are switching an existing character: change back to human form, leave any scene and make a new save first (but read [New game?](#new-game)).
1. **Disable** OStim Beast Form Merged (Growl edition) and the Merged TWO Patch if you have them.
2. **Disable HDT Werewolves SMP.** TWO replaces it; both plugins are named `Werewolves.esp`, so they cannot run side by side.
3. **Install TWO 4.1** with its FOMOD:
   - **Core:** yes (required)
   - **Genitals:** your choice. CF Standalone needs Creature Framework, HCOS needs Horny Creatures of Skyrim, SOS needs Schlongs of Skyrim. **None** is fine too; scenes still get TWO's hard canine.
   - **Wicked Werewolves skeleton: OFF.** It changes proportions and OStim animations will not line up.
   - **Misc patches:** Growl only if you use Growl; Moonlight Tales only if you use Moonlight Tales (turn off its skin system).
4. *(Optional)* Install **TWO Alternate Textures 4.0** after TWO, as usual.
5. *(Optional)* **BodySlide.** You do **not** have to build anything: TWO already ships default bodies and heads. Only build if you want TWO's sliders/presets. If you do, send the output to its **own mod** and put it **below TWO** in the left pane. If it lands in an older BodySlide output mod higher up, TWO still wins and you keep seeing TWO's defaults.
6. **Install this zip** ("Install a new mod from archive"). Tick **"BFA brow morphs for TWO heads"** only if you use Better Facial Animations.
7. **Left pane** (lower wins): put this mod after OStim, OCum and TWO (and after your TWO BodySlide output). It does not overwrite any TWO file. TWO must still win every werewolf body, head and skeleton conflict against anything else (ABC, XPMSE, OCreatures, HCOS…).
8. **Run Pandora** (or Nemesis/FNIS) and keep its output last.
9. **Right pane** (plugins), in this order, late in the list:
   ```
   MonsterLipSync1.esp
   OCreatures.esp                          (optional)
   Werewolves.esp                          (TWO)
   WerewolvesGrowl.esp / WerewolvesMTSE.esp / other Werewolves*.esp (if any)
   OStim_Beast_Form_TWO.esp
   OStim_Beast_Form_TWO - BFA Heads.esp    (optional)
   ```
   `Werewolves.esp` must load after `OCreatures.esp` and any other mod that edits the werewolf race, or TWO's heads go missing. Beast Form restores the OCR race keywords at runtime, so OCR scenes still work.
10. Start the game, open the **OStim Beast Form** MCM and set your hotkey.

### New game?
A new game, or a save that never ran the Growl edition, is recommended. This edition uses a different plugin name (`OStim_Beast_Form_TWO.esp`) than the Growl edition, so a save made with the Growl edition loses that plugin's forms and settings, and the aroused swap may keep looking for the old Growl-edition mesh. **If you want TWO bodies on an existing Growl-edition save, use the [Merged TWO Patch](https://github.com/Coronerra/OStim-Beast-Form-Merged-TWO-Patch) instead.**

### Creature Framework / HCOS / SOS users
- During OStim scenes Beast Form's aroused mesh uses slot 52, the same slot as Creature Framework's and SOS's werewolf genitals, so you should only see one set. If CF swaps its own mesh back in during a scene (it does this on its own timer), either disable werewolves in the Creature Framework MCM or turn off Beast Form's aroused swap: open the console, type `set OBL_SwapEnabled to 0`, then save and load that save (the swap re-reads it on load).
- If you see double genitals with SOS, disable werewolves in the SOS MCM (TWO's own advice).
- With OCreatures installed, OCR owns the aroused swap and Beast Form steps aside; OCR's own (non-TWO) werewolf cock is then used in scenes.

### Optional: BFA heads
TWO's werewolf heads already talk and emote through MFA morphs. Better Facial Animations also needs two brow-raise morphs that TWO's head TRI does not have (`browupleft` / `browupright`). The add-on:
- uses `coronerra\two\ExpHeadWerewolf_BFA.tri`: a copy of TWO's `ExpHeadWerewolf.tri` with only those two morphs added. TWO's 36 morphs and the vertex data are kept byte-for-byte. Male and female TWO heads both use it (same 1362-vertex mesh), so BodySlide head builds keep working.
- points TWO's `MaleHeadWerewolf` / `FemaleHeadWerewolf` head parts at that TRI.
- points TWO's `FemaleMouthWerewolf` at TWO's own `ExpMouthWerewolf.tri`. TWO's record names `ExpMouthWerewolf.nif`, a file TWO does not ship, so female mouths do not move with speech in TWO by itself. The female and male mouth meshes are identical, so the male mouth TRI fits.

Uninstalling the add-on puts everything back to TWO's own records.

### Uninstall
Change back to human form and leave any scene, save, quit, then untick `OStim_Beast_Form_TWO.esp` (and the BFA add-on). TWO itself is unaffected.

---

## Please check (test list for 0.1)

0.1 has passed static checks (plugin records, masters, file paths, TRI geometry; see `Data/Docs/OStim Beast Form TWO/STATIC_CHECKS_TWO_0.1.txt`) but has not had wide in-game testing yet. If something here looks wrong, please [open an issue](https://github.com/Coronerra/OStim-Beast-Form-TWO/issues).

- [ ] Transform (male and female): the TWO body/head/fur/eyes look exactly as before, with SMP working.
- [ ] Start a scene with the hotkey; check the hub, a pack page, an animation.
- [ ] Male werewolf scene: TWO hard canine appears (one set only) and disappears at scene end. OCum climax: the shot comes from the tip.
- [ ] Beast timer pauses during the scene and resumes after.
- [ ] SkyrimNet: NPC reaction to the werewolf, OStimNet partner prompt.
- [ ] Vampire Lord: transform, talking head, scene.
- [ ] With the BFA add-on: `BetterFacialAnimations.log` shows a fitted head for the werewolf instead of "no BrowUpLeft morph".

---

## Permissions

- **This repository and its release ship none of TWO's meshes, textures, plugins or skeleton.** You must already own TWO 4.1 (Frosferes, LoversLab). The plugins only point at TWO's file paths; the optional BFA plugin overrides three TWO head-part records (expression-file path only), as any compatibility patch does.
- **Permission was sought from Frosferes** before publishing. Frosferes has been unreachable since 2023. This edition is kept in **its own repository** so that, if Frosferes objects, it can be removed without affecting the main [OStim Beast Form Merged](https://github.com/Coronerra/OStim-Beast-Form-Merged) project.
- **Optional BFA heads:** `ExpHeadWerewolf_BFA.tri` is a modified copy of TWO's expression TRI (TWO bases it on MFA morphs by **TealEri**, aka CinnaMewRoll), with only `browupleft` / `browupright` added; TWO's 36 morphs and vertex data are kept. Credit to Frosferes and TealEri. The same takedown applies to it.
- Everything written by That Guy (Coronerra) — plugin, Papyrus scripts, scene JSON, SkyrimNet prompts, docs — is MIT (see [LICENSE](LICENSE)). The Vampire Lord, Billyy fallback-pose and OCum files are the same as in the already-public Growl edition 0.5 and carry the same permissions. Nothing from TWO, TWO Alternate Textures, ABC, GT Softbody or MNC is included.

## Credits

- **Frosferes:** TWO - Total Werewolf Overhaul (bodies, heads, skeleton, SMP, genital meshes this edition points at).
- **TealEri (aka CinnaMewRoll):** Monster Facial Animation and Expressive Werebeasts, the base of TWO's expressive heads.
- **KrittaKitty, Fiszy and Brevi:** Moonlight Tales skins used by TWO Alternate Textures.
- **VectorPlexus** (Mighty Beasts), **jacques00** (original HDT Werewolves), **BakaFactory** (ABC assets used by TWO), **MadMansGun**, **olebronkosrak**, as credited by TWO.
- Everyone credited in the [Growl edition README](https://github.com/Coronerra/OStim-Beast-Form-Merged) (OStim, OCum, Billyy, Lirael Atelier / Lauffey and the pack authors, Better Facial Animations, SkyrimNet, OStimNet…).
- **That Guy (Coronerra):** OStim Beast Form, Beast Aware, Beast Load, the TWO edition plugin and the BFA brow morphs.

OStim Beast Form - TWO Edition 0.2 (Skyrim SE / AE)
by That Guy (Coronerra)
https://github.com/Coronerra/OStim-Beast-Form-TWO

WHICH DOWNLOAD IS FOR YOU?
--------------------------
There are three related downloads. Use exactly ONE of them:
- OStim Beast Form Merged 0.6 (Growl edition): you use Growl and the HDT
  Werewolves / ABC look.  https://github.com/Coronerra/OStim-Beast-Form-Merged
- OStim Beast Form - TWO Edition 0.2 (THIS ONE): you use TWO - Total Werewolf
  Overhaul 4.1 and you do NOT need Growl.
- OStim Beast Form Merged - TWO Patch 0.1: you already play OStim Beast Form
  Merged (0.5 or 0.6) with Growl and want TWO's bodies without losing your save.
  https://github.com/Coronerra/OStim-Beast-Form-Merged-TWO-Patch
The TWO Edition and the TWO Patch must NEVER be used together, and the TWO
Edition must never be enabled together with OStim Beast Form Merged.

0.2 CHANGELOG
-------------
- Removed the experimental WWF_OnTop female cowgirl test scenes
  (SKSE/Plugins/OStim/scenes/WWF_OnTop/WWFCowgirl1-1..5.json) and their
  "WW Female Cowgirl 1 (TEST)" button on the female werewolf + man hub
  (OBFWerewolfIdleMF), plus their five OStimNet descriptions. Same change
  as OStim Beast Form Merged 0.6.
- Female werewolf scenes are not bundled. They come from separate, optional
  female-werewolf scene packs (for example an OStim conversion of Dayelyte's
  female werewolf animations), which add their own button to the female
  werewolf hubs. Without one, the female werewolf + man hub is an idle with
  no buttons.
- Docs and the "which download is for you?" list point at Merged 0.6 and the
  Merged TWO Patch 0.1.
- Plugins, FormIDs, masters, scripts, meshes and HKX are byte-identical to
  0.1. Saves stay compatible. No Pandora run needed for this update.
UPDATING FROM 0.1: reinstall with the FOMOD as a clean replacement (MO2:
"Replace"), or delete the old SKSE/Plugins/OStim/scenes/WWF_OnTop folder in
the mod before installing 0.2 over it.

WHAT THIS IS
------------
The same OStim Beast Form features as the Growl edition (OStim Beast Form
Merged 0.6), built for people who use TWO - Total Werewolf Overhaul 4.1 by
Frosferes. TWO keeps its look: its bodies, heads, BodySlide builds, skeleton,
SMP physics and textures (including TWO Alternate Textures) are not replaced
or edited. This mod ships no werewolf body, head, skeleton or werewolf
texture, and no file from TWO. You need your own copy of TWO 4.1.

What carries over from the Growl edition:
- Start OStim scenes while you are a werewolf (hotkey in the MCM), with the
  beast-form timer paused during scenes (PlayerWerewolfShiftBackTime).
- The werewolf / Vampire Lord hub menus, pack pages and the Lirael animation
  pack scene files, plus the built-in fallback idles (run Pandora).
- Beast Aware + SkyrimNet: NPCs know you are a werewolf / werebear / Vampire
  Lord; the OStimNet bridge prompt lets NPCs pick you as a partner.
- Beast Load (OCum climax handling) and OCum Werewolf Shot (the OCum shot comes
  from the werewolf tip, bone WWD 9, which TWO's skeleton already has).
- Vampire Lord support, same as the Growl edition (talking VL heads, headless
  VL bodies, VL aroused swap).
- OCreatures Reforged stays optional (not a master).

What is different from the Growl edition:
- Werewolf look = TWO. The Growl edition's ABC / HDT Werewolves bodies and
  MFA/BFA heads are NOT included.
- Aroused cock during scenes (male werewolves): Beast Form swaps in TWO's own
  hard canine mesh (actors\werewolfbeast\character assets\CreatureFramework\
  CanineRedHard.nif, part of TWO's Core files, with TWO's genital SMP), not
  the GT Softbody / MNC one. Nothing is shipped for it; it uses your TWO copy.
- Outside scenes, the male werewolf's genitals are whatever you chose in TWO's
  installer (Creature Framework, HCOS, SOS or None). TWO's body has no sheath
  of its own.
- No Growl and no JS Emissive Eyes requirement. TWO's own eyes are used for
  werewolves. Vampire Lords lose the JS Emissive Eyes glow effect if you use
  that mod, because this plugin's Vampire Lord race record wins.
- The werewolf race record is NOT edited at all, so TWO's Werewolves.esp, or
  TWO's Growl / Moonlight Tales patch, keeps control of it.
- Better Facial Animations (BFA) support is an optional add-on (see below).

REQUIREMENTS
------------
- TWO - Total Werewolf Overhaul 4.1 (Frosferes, LoversLab). Not included.
- Monster Facial Animation / Monster Lipsync SE (MonsterLipSync1.esp).
  REQUIRED: TWO and this plugin both list it as a master. The game will not
  start with this plugin enabled if MonsterLipSync1.esp is missing.
- Faster HDT-SMP (for TWO's physics). BodySlide is optional (see below).
- OStim Standalone, OCum Ascended, SkyUI, PapyrusUtil, powerofthree's Papyrus
  Extender, Pandora (or Nemesis/FNIS), same as the Growl edition.
- Animations: OStim packs with werewolf / Vampire Lord scenes, for example
  Lirael Atelier's converted packs (LoversLab account: Lauffey). No animations
  are included.
- Optional, same as the Growl edition: SkyrimNet, OStimNet, OCreatures
  Reforged, OCum Tull/Liquid patch, Better Facial Animations.
- NOT needed: Growl, JS Emissive Eyes, HDT Werewolves, ABC, Creature
  Framework, HCOS, SexLab.
Plugin masters: Skyrim, Update, Dawnguard, Dragonborn, Werewolves.esp (TWO),
MonsterLipSync1.esp (MFA), OStim.esp, OCum.esp.

INSTALL (MO2)
-------------
0. Back up your profile (plugins.txt, loadorder.txt, modlist.txt). If you
   are switching an existing character, change back to human form, leave any
   scene and make a new save first (but see "NEW GAME?" below).
1. Disable the Growl edition (OStim Beast Form Merged) and the Merged TWO
   Patch if you have them. They use the same scripts as this edition and must
   never be enabled together with it.
2. Disable HDT Werewolves SMP: TWO replaces it (both plugins are named
   Werewolves.esp, so they cannot run side by side).
3. Install TWO 4.1 with its FOMOD:
     Core: yes (required)
     Genitals: your choice. CF Standalone needs Creature Framework, HCOS
               needs Horny Creatures of Skyrim, SOS needs Schlongs of Skyrim.
               "None" is fine too; scenes still get TWO's hard canine.
     Wicked Werewolves skeleton: OFF. It changes proportions and OStim
               animations will not line up.
     Misc patches: Growl only if you use Growl; Moonlight Tales only if you
               use Moonlight Tales (turn off its skin system).
4. (Optional) Install TWO Alternate Textures 4.0 after TWO, as usual.
5. (Optional) BodySlide. You do NOT have to build anything: TWO already ships
   default bodies and heads. Only build if you want TWO's sliders/presets.
   If you do, send the output to its OWN mod and put it BELOW TWO in the left
   pane. If the output lands in an older, higher-up BodySlide output mod, TWO
   still wins and you keep seeing TWO's defaults.
6. Install this zip ("Install a new mod from archive"). Tick
   "BFA brow morphs for TWO heads" only if you use Better Facial Animations.
7. Left pane (lower wins): put this mod after OStim, OCum and TWO (and after
   your TWO BodySlide output). It does not overwrite any TWO file. TWO must
   still win every werewolf body, head and skeleton conflict against anything
   else (ABC, XPMSE, OCreatures, HCOS...).
8. Run Pandora (or Nemesis/FNIS) and keep its output last.
9. Right pane (plugins), in this order, late in the list:
     MonsterLipSync1.esp
     OCreatures.esp                          (optional)
     Werewolves.esp                          (TWO)
     WerewolvesGrowl.esp / WerewolvesMTSE.esp / other Werewolves*.esp (if any)
     OStim_Beast_Form_TWO.esp
     OStim_Beast_Form_TWO - BFA Heads.esp    (optional)
   Werewolves.esp must load after OCreatures.esp and any other mod that edits
   the werewolf race, or TWO's heads go missing. Beast Form restores the OCR
   race keywords at runtime, so OCR scenes still work.
10. Start the game, open the "OStim Beast Form" MCM and set your hotkey.

NEW GAME?
---------
A new game, or a save that never ran the Growl edition, is recommended. This
edition uses a different plugin name (OStim_Beast_Form_TWO.esp) than the
Growl edition, so a save made with the Growl edition will lose that plugin's
forms and settings, and the aroused swap may keep looking for the old
Growl-edition mesh. If you want TWO bodies on an existing Growl-edition save,
use the Merged TWO Patch instead.

CREATURE FRAMEWORK / HCOS / SOS USERS
-------------------------------------
- During OStim scenes Beast Form's aroused mesh uses slot 52, the same slot as
  Creature Framework's and SOS's werewolf genitals, so you should only see one
  set. If CF swaps its own mesh back in during a scene (it does this on its own
  timer), either disable werewolves in the Creature Framework MCM or turn off
  Beast Form's aroused swap: open the console, type
      set OBL_SwapEnabled to 0
  then save and load that save (the swap re-reads it on load).
- If you see double genitals with SOS, disable werewolves in the SOS MCM
  (TWO's own advice).
- With OCreatures installed, OCR owns the aroused swap and Beast Form steps
  aside; OCR's own (non-TWO) werewolf cock is then used in scenes.

OPTIONAL: BFA HEADS
-------------------
TWO's werewolf heads already talk and emote through MFA morphs. Better Facial
Animations also needs two brow-raise morphs that TWO's head TRI does not have
(browupleft / browupright). The add-on:
- uses coronerra\two\ExpHeadWerewolf_BFA.tri: a copy of TWO's
  ExpHeadWerewolf.tri with only those two morphs added. TWO's 36 morphs and
  the vertex data are kept byte-for-byte. Male and female TWO heads both use
  it (same 1362-vertex mesh), so BodySlide head builds keep working.
- points TWO's MaleHeadWerewolf / FemaleHeadWerewolf head parts at that TRI.
- points TWO's FemaleMouthWerewolf at TWO's own ExpMouthWerewolf.tri. TWO's
  record names ExpMouthWerewolf.nif, a file TWO does not ship, so female mouths
  do not move with speech in TWO by itself. The female and male mouth meshes
  are identical, so the male mouth TRI fits.
Uninstalling the add-on puts everything back to TWO's own records.

UNINSTALL
---------
Change back to human form and leave any scene, save, quit, then untick
OStim_Beast_Form_TWO.esp (and the BFA add-on). TWO itself is unaffected.

PLEASE CHECK (test list for 0.1)
--------------------------------
0.1 has passed static checks (plugin records, masters, paths, TRI) but has not
had wide in-game testing yet. If something below looks wrong, please open an
issue on GitHub.
- Transform (male and female): the TWO body/head/fur/eyes look exactly as
  before, with SMP working.
- Start a scene with the hotkey; check the hub, a pack page, an animation.
- Male werewolf scene: TWO hard canine appears (one set only), disappears at
  scene end. OCum climax: the shot comes from the tip.
- Beast timer pauses during the scene and resumes after.
- SkyrimNet: NPC reaction to the werewolf, OStimNet partner prompt.
- Vampire Lord: transform, talking head, scene.
- With the BFA add-on: BetterFacialAnimations.log should show a fitted head
  for the werewolf instead of "no BrowUpLeft morph".

PERMISSIONS
-----------
- This download contains NONE of TWO's meshes, textures, plugins or skeleton.
  You must already own TWO 4.1 (Frosferes, LoversLab). The plugins only point
  at TWO's file paths, and the optional BFA plugin overrides three TWO head-part
  records (expression file path only), as any compatibility patch does.
- Permission was sought from Frosferes before publishing. Frosferes has been
  unreachable since 2023. This edition is kept in its own repository so that,
  if Frosferes objects, it can be removed without affecting the main OStim
  Beast Form Merged project.
- Optional BFA heads: ExpHeadWerewolf_BFA.tri is a modified copy of TWO's
  expression TRI (TWO bases it on MFA morphs by TealEri, aka CinnaMewRoll),
  with only browupleft / browupright added; TWO's 36 morphs and vertex data are
  kept. Credit to Frosferes and TealEri. The same takedown applies to it.
- Main part: plugin, scripts, scene JSON, SkyrimNet prompts and docs are by
  That Guy (Coronerra) (MIT, see the GitHub repository). Vampire Lord,
  Billyy fallback-pose and OCum files are the same as in the public Growl
  edition 0.5 and carry the same permissions. Nothing from TWO, TWO Alternate
  Textures, ABC, GT Softbody or MNC is included.

CREDITS
-------
- Frosferes: TWO - Total Werewolf Overhaul (bodies, heads, skeleton, SMP,
  genital meshes this edition points at).
- TealEri (aka CinnaMewRoll): Monster Facial Animation and Expressive
  Werebeasts, the base of TWO's expressive heads.
- KrittaKitty, Fiszy and Brevi: Moonlight Tales skins used by TWO Alternate
  Textures.
- VectorPlexus (Mighty Beasts), jacques00 (original HDT Werewolves),
  BakaFactory (ABC assets used by TWO), MadMansGun, olebronkosrak, as credited
  by TWO.
- Everyone credited in the Growl edition README (OStim, OCum, Billyy, Lirael
  Atelier / Lauffey and the pack authors, Better Facial Animations, SkyrimNet,
  OStimNet...).
- That Guy (Coronerra): OStim Beast Form, Beast Aware, Beast Load, the TWO
  edition plugin and the BFA brow morphs.

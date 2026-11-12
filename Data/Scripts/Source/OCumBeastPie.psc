Scriptname OCumBeastPie extends Quest
{OCum Beast Pie + Beast Load - That Guy (Coronerra).
1) Beast Pie (0.1): keeps the Tull/Liquid pie through a partner's beast form.
2) Beast Load (0.5): when a male werewolf, werebear or Vampire Lord climaxes in any OStim scene (player or NPC-only), OCum's own
   handler still runs, and this adds the cum OCum skips for creature scenes (their metadata only says
   vaginalsex/analsex/blowjob, so footjobs, handjobs and "aircum" scenes get nothing, and vaginal/anal
   overlays and meshes are off by default in OCum). Decals go through OCum's own functions, so OCum's
   cleanup timer and bathing still clear them. Tull/Liquid meshes are worn as long as OCum's decals last.
No OCumMaleScript.pex replacement, no new records.}

Race WerewolfRace
Race WerebearRace
Race VampireLordRace

; ---- Beast Load settings (new in 0.5; defaults apply to existing saves) ----
bool Property BeastLoadEnabled = true Auto Hidden
bool Property HugeLoad = true Auto Hidden          ; max layers on every area + full mesh set + refill
bool Property BeastMeshes = true Auto Hidden       ; Tull/Liquid meshes even when OCum's meshes are off
bool Property ExtraCumShot = true Auto Hidden      ; OCum cum-shot spurts for footjob/handjob/aircum scenes
bool Property StackRounds = true Auto Hidden       ; each climax in the same session adds layers + meshes
int Property MaxRounds = 5 Auto Hidden             ; rounds after which coverage stops growing

OCumMaleScript OCumMale
OCumScript OCumMain
Keyword AppliedCumKeyword
Faction ChestStage
Faction ChestSlot
Faction ButtStage
Faction ButtSlot
Faction BellyStage
Faction BellySlot

Event OnInit()
	Setup()
EndEvent

Function Setup()
	WerewolfRace = Game.GetFormFromFile(0x000CDD84, "Skyrim.esm") As Race
	WerebearRace = Game.GetFormFromFile(0x0001E17B, "Dragonborn.esm") As Race
	VampireLordRace = Game.GetFormFromFile(0x0000283A, "Dawnguard.esm") As Race
	OCumMale = Game.GetFormFromFile(0x00000F38, "OCum.esp") As OCumMaleScript
	OCumMain = Game.GetFormFromFile(0x00000800, "OCum.esp") As OCumScript
	AppliedCumKeyword = Game.GetFormFromFile(0x00000F16, "OCum.esp") As Keyword
	ChestStage = Game.GetFormFromFile(0x00000F3C, "OCum.esp") As Faction
	ChestSlot = Game.GetFormFromFile(0x00000F3D, "OCum.esp") As Faction
	ButtStage = Game.GetFormFromFile(0x00000F3E, "OCum.esp") As Faction
	ButtSlot = Game.GetFormFromFile(0x00000F3F, "OCum.esp") As Faction
	BellyStage = Game.GetFormFromFile(0x00000F40, "OCum.esp") As Faction
	BellySlot = Game.GetFormFromFile(0x00000F41, "OCum.esp") As Faction
	UnregisterForAllModEvents()
	RegisterForModEvent("ocumtl_pie", "OnPie")
	RegisterForModEvent("ostim_actor_orgasm", "OnBeastOrgasm")
	RegisterForModEvent("obf_beastload_mesh", "OnBeastLoadMesh")
EndFunction

bool Function IsBeast(Actor act)
	Race r = act.GetRace()
	return r && (r == WerewolfRace || r == WerebearRace || r == VampireLordRace)
EndFunction

float Function PieSeconds()
	return 60.0
EndFunction

; ======================= 1) Beast Pie (unchanged from 0.1) =======================

Event OnPie(string eventName, string strArg, float numArg, Form sender)
	Actor act = sender As Actor
	if !act
		return
	endif

	int kind = numArg As int
	string key = "OCumBP_Stamp" + kind
	int stamp = StorageUtil.GetIntValue(act, key, 0) + 1
	StorageUtil.SetIntValue(act, key, stamp)

	float waited = 0.0
	bool beast = IsBeast(act)
	while !beast && waited < PieSeconds()
		Utility.Wait(2.0)
		waited += 2.0
		if StorageUtil.GetIntValue(act, key, 0) != stamp
			return
		endif
		beast = IsBeast(act)
	endwhile

	if !beast
		return
	endif

	Debug.Trace("[OCumBeastPie] kind " + kind + ": " + act.GetDisplayName() + " is in beast form, holding the pie")

	while IsBeast(act) || !act.Is3DLoaded()
		Utility.Wait(3.0)
		if StorageUtil.GetIntValue(act, key, 0) != stamp || act.IsDead() || act.IsDeleted()
			return
		endif
	endwhile

	Utility.Wait(2.0)
	if StorageUtil.GetIntValue(act, key, 0) != stamp
		return
	endif

	if !NiOverride.HasOverlays(act)
		NiOverride.AddOverlays(act)
		Utility.Wait(0.1)
	endif
	NiOverride.ApplyNodeOverrides(act)

	Debug.Trace("[OCumBeastPie] kind " + kind + ": " + act.GetDisplayName() + " reverted, pie restarted for 60 s")
	act.SendModEvent("ocumtl_pie", "", kind As float)
EndEvent

; ======================= 2) Beast Load =======================
; finish bits: 1 vaginal/anal pie, 2 oral/face, 4 body glaze; ItemMask() turns them (+ round) into item bits

Event OnBeastOrgasm(string eventName, string strArg, float numArg, Form sender)
	; cheap exit for every non-beast orgasm (keeps the VM light)
	Actor orgasmer = sender As Actor
	if !BeastLoadEnabled || !orgasmer || !IsBeast(orgasmer) || !OCumMale || !OCumMain
		return
	endif

	if orgasmer.GetLeveledActorBase().GetSex() != 0
		return ; female beasts (WWF) don't cum on anyone
	endif

	; every thread, also NPC-only scenes (independent of OCum's NPC scene option)
	int tid = numArg As int

	string sid = strArg
	if sid == ""
		sid = OThread.GetScene(tid)
	endif
	int pos = OThread.GetActorPosition(tid, orgasmer)

	; creature packs tag their scenes better than they fill in actions, so read both
	bool oral = OMetadata.HasAnySceneTagCSV(sid, "blowjob,oral,cuminmouth,facefuck,facial,facecum,deepthroat") || OMetadata.FindAnyActionForActorCSV(sid, pos, "blowjob,deepthroating,penilelicking,rubbingpenisagainstface,facial") != -1 || OMetadata.FindAnyActionCSV(sid, "blowjob,deepthroating") != -1
	bool anal = OMetadata.HasAnySceneTagCSV(sid, "anal,analcreampie") || OMetadata.FindAnyActionForActorCSV(sid, pos, "analsex") != -1
	bool vag = OMetadata.HasAnySceneTagCSV(sid, "vaginal,creampie,knotted") || OMetadata.FindAnyActionForActorCSV(sid, pos, "vaginalsex,wwfvaginalsex") != -1
	bool foot = OMetadata.HasSceneTag(sid, "footjob") || OMetadata.FindAnyActionCSV(sid, "footjob") != -1
	bool hand = OMetadata.HasAnySceneTagCSV(sid, "handjob,masturbation") || OMetadata.FindAnyActionCSV(sid, "handjob,malemasturbation") != -1
	bool outside = foot || hand || OMetadata.HasAnySceneTagCSV(sid, "aircum,cumonbody,chestcum,boobjob,titjob,wastedcum,cumshot,pullout")

	; a scene tagged footjob/aircum that only lists vaginalsex is really an outside finish
	if outside && !OMetadata.HasAnySceneTagCSV(sid, "creampie,knotted,analcreampie")
		vag = false
		anal = false
	endif
	if !oral && !anal && !vag && !outside
		outside = true ; unknown metadata ("default", none, lickingvagina): treat as a finish on her body
	endif

	Debug.Trace("[OBF BeastLoad] " + orgasmer.GetDisplayName() + " climax, thread " + tid + ", scene " + sid + ", oral " + oral + " vaginal " + vag + " anal " + anal + " outside " + outside)

	int intensity = 3
	int layers = 1
	if HugeLoad
		intensity = 4
		layers = 3
	endif

	Utility.Wait(1.0) ; let OCum's own handler pick its overlay slots first (no double-booked slots)
	Actor[] acts = OThread.GetActors(tid)
	int i = acts.Length
	while i > 0
		i -= 1
		Actor t = acts[i]
		if t && t != orgasmer && !IsBeast(t)
			PrepTarget(t)
			GlazeActor(orgasmer, t, tid, sid, intensity, layers, oral, vag, anal, foot, hand, outside)
		endif
	endwhile

	if ExtraCumShot && tid == 0 && outside && !OCumMain.disableCumShot
		; OCum skips its spurts when the scene lists vaginalsex/blowjob; an empty scene id bypasses that check
		orgasmer.SendModEvent("ocum_play_cum_shoot_effect", "", 1.0)
		if HugeLoad
			orgasmer.SendModEvent("ocum_play_cum_shoot_effect", "", 1.0)
		endif
	endif

	if HugeLoad
		; beasts don't run dry: top the store back up after OCum has drained it
		Utility.Wait(3.0)
		float mx = OCumMain.GetMaxCumStoragePossible(orgasmer)
		OCumMain.AdjustStoredCumAmount(orgasmer, mx, 0.0)
	endif
EndEvent

Function PrepTarget(Actor t)
	; NPC-only threads: OCum may not have prepared her (its NPC scene option is off by default)
	if !NiOverride.HasOverlays(t)
		NiOverride.AddOverlays(t)
	endif
	; multi-round stacking: a session ends when she is clean, or OCum's timer has passed since the last round
	float now = Utility.GetCurrentRealTime()
	float last = StorageUtil.GetFloatValue(t, "OBF_BL_Last", -1.0)
	bool clean = AppliedCumKeyword && !OCumMain.disableCumDecal && !t.HasMagicEffectWithKeyword(AppliedCumKeyword)
	if clean || last < 0.0 || now < last || now - last > OCumMain.cumCleanupTimer * 60.0 + 30.0
		StorageUtil.SetIntValue(t, "OBF_BL_Round", 0)
		StorageUtil.UnsetIntValue(t, "OBF_BL_Set") ; new session: start the mesh set fresh
	endif
	StorageUtil.SetFloatValue(t, "OBF_BL_Last", now)
	; OCum's own cleanup timer is left alone (re-casting its spell can make OCumEffect loop while in a scene)
	if ChestStage && clean
		; clean body: restart OCum's layer stages so belly/chest/butt climb again (NPC threads never reset them)
		t.SetFactionRank(ChestStage, 0)
		t.SetFactionRank(ButtStage, 0)
		t.SetFactionRank(BellyStage, 0)
		t.SetFactionRank(ChestSlot, -1)
		t.SetFactionRank(ButtSlot, -1)
		t.SetFactionRank(BellySlot, -1)
	endif
EndFunction

Function GlazeActor(Actor orgasmer, Actor t, int tid, string sid, int intensity, int layers, bool oral, bool vag, bool anal, bool foot, bool hand, bool outside)
	int meshSet = 0
	int n = 0
	int rnd = 1
	if StackRounds
		rnd = StorageUtil.GetIntValue(t, "OBF_BL_Round", 0) + 1
		if rnd > MaxRounds
			rnd = MaxRounds
		endif
		StorageUtil.SetIntValue(t, "OBF_BL_Round", rnd)
	endif
	; every extra round adds a layer per region (OCum's stage textures cap themselves at their heaviest)
	layers = layers + rnd - 1
	if layers > 6
		layers = 6
	endif
	int heavy = 3 + rnd
	if heavy > 6
		heavy = 6
	endif

	if vag
		OCumMale.SendCumAppliedEvents(tid, orgasmer, t, 30.0, "vagina", sid)
		OCumMale.CumOntoArea(t, "VaginalCreampie" + Utility.RandomInt(heavy - 2, heavy), "Body") ; OCum only does this when its vag/anal overlay option is on
		OCumMale.ApplyCumThighs(t, -1)
		meshSet = Math.LogicalOr(meshSet, 1)
	endif
	if anal
		OCumMale.SendCumAppliedEvents(tid, orgasmer, t, 30.0, "rectum", sid)
		if rnd > 1
			OCumMale.CumOntoArea(t, "Anal" + Utility.RandomInt(3, 4), "Body")
		endif
		OCumMale.CumOntoArea(t, "Anal" + Utility.RandomInt(3, 4), "Body")
		meshSet = Math.LogicalOr(meshSet, 1)
	endif
	if oral
		; Design: a beast does not get swallowed - face, mouth, neck and chest, dripping
		OCumMale.SendCumAppliedEvents(tid, orgasmer, t, 30.0, "face", sid)
		n = 0
		while n < layers
			OCumMale.ApplyCumFacial(t, 4, -1)
			OCumMale.ApplyCumBoob(t, intensity, -1)
			n += 1
		endwhile
		OCumMale.ApplyCumMouth(t, 4, -1)
		if rnd > 1
			OCumMale.ApplyCumMouth(t, 4, -1)
		endif
		OCumMale.CumOntoArea(t, "BreastFace" + Utility.RandomInt(1, 2), "Face")
		meshSet = Math.LogicalOr(meshSet, 2)
	endif
	if outside
		OCumMale.SendCumAppliedEvents(tid, orgasmer, t, 30.0, "chest", sid)
		if foot
			OCumMale.ApplyCumFeet(t, 4, -1)
		endif
		if hand
			OCumMale.ApplyCumHands(t, -1)
		endif
		n = 0
		while n < layers
			OCumMale.ApplyCumBelly(t, intensity, -1)
			OCumMale.ApplyCumBoob(t, intensity, -1)
			n += 1
		endwhile
		OCumMale.ApplyCumThighs(t, -1)
		if HugeLoad
			OCumMale.ApplyCumFacial(t, 4, -1)
		endif
		meshSet = Math.LogicalOr(meshSet, 4)
	endif

	if HugeLoad
		; a beast-sized load runs everywhere: belly, chest and butt stages climb toward OCum's heaviest textures
		n = 0
		while n < layers
			OCumMale.ApplyCumBelly(t, 4, -1)
			OCumMale.ApplyCumButt(t, 4, -1)
			n += 1
		endwhile
		meshSet = Math.LogicalOr(meshSet, 4)
	endif

	if BeastMeshes && t.GetLeveledActorBase().GetSex() == 1
		t.SendModEvent("obf_beastload_mesh", "", ItemMask(meshSet, rnd) As float)
	endif
EndFunction

; ---- meshes: own loop per actor (mod event = own thread), lives as long as OCum's decals ----

Form[] Function MeshItems()
	; looked up once per climax. No two share a slot: Tull 0x807 and 0x803 are both slot 59, so only one is used.
	Form[] f = new Form[8]
	if Game.IsPluginInstalled("TullAnimatedCreampie.esp")
		f[0] = Game.GetFormFromFile(0x807, "TullAnimatedCreampie.esp")        ; 59 creampie
		f[1] = Game.GetFormFromFile(0x809, "TullAnimatedCreampie.esp")        ; 60 creampie drip
		f[4] = Game.GetFormFromFile(0x803, "TullAnimatedCreampie.esp")        ; 59 oral (only without 0x807)
	endif
	if Game.IsPluginInstalled("[Predator] Liquid Pack v2.esp")
		f[2] = Game.GetFormFromFile(0x803, "[Predator] Liquid Pack v2.esp")   ; 47 bottom
		f[3] = Game.GetFormFromFile(0x808, "[Predator] Liquid Pack v2.esp")   ; 43 bottom SMP
		f[5] = Game.GetFormFromFile(0x804, "[Predator] Liquid Pack v2.esp")   ; 55 face
		f[6] = Game.GetFormFromFile(0x809, "[Predator] Liquid Pack v2.esp")   ; 57 face SMP
		f[7] = Game.GetFormFromFile(0xD63, "[Predator] Liquid Pack v2.esp")   ; 36 torso
	endif
	return f
EndFunction

int Function ItemMask(int meshSet, int rnd)
	; item bits (see MeshItems): 0 Tull807/59  1 Tull809/60  2 LP803/47  3 LP808/43  4 Tull803/59  5 LP804/55  6 LP809/57  7 LPD63/36
	bool pie = Math.LogicalAnd(meshSet, 1) != 0
	bool face = Math.LogicalAnd(meshSet, 2) != 0
	bool body = Math.LogicalAnd(meshSet, 4) != 0
	int m = 0
	if pie
		m = Math.LogicalOr(m, 7)          ; 0,1,2
		if HugeLoad
			m = Math.LogicalOr(m, 8)      ; 3
		endif
	endif
	if face
		m = Math.LogicalOr(m, 96)         ; 5,6
		if !pie
			m = Math.LogicalOr(m, 16)     ; 4 (slot 59 only when the creampie item is not used)
		endif
		if HugeLoad
			m = Math.LogicalOr(m, 128)    ; 7
		endif
	endif
	if body
		m = Math.LogicalOr(m, 132)        ; 2,7
		if HugeLoad
			m = Math.LogicalOr(m, 32)     ; 5
		endif
	endif
	; stacking: each round after the first adds two more items in this order of least-contested slots
	; 60 (misc), 47, 55, 57, 36, 43; then whichever slot-59 item fits
	int extra = (rnd - 1) * 2
	int k = 0
	while extra > 0 && k < 7
		int bit = 0
		if k == 0
			bit = 2
		elseif k == 1
			bit = 4
		elseif k == 2
			bit = 32
		elseif k == 3
			bit = 64
		elseif k == 4
			bit = 128
		elseif k == 5
			bit = 8
		elseif Math.LogicalAnd(m, 17) == 0
			bit = 1
		endif
		if bit && Math.LogicalAnd(m, bit) == 0
			m = Math.LogicalOr(m, bit)
			extra -= 1
		endif
		k += 1
	endwhile
	return m
EndFunction

bool Function MeshWanted(int idx, int mask)
	if idx == 4 && Math.LogicalAnd(mask, 1) != 0
		return false ; slot 59 is taken by the creampie item
	endif
	return Math.LogicalAnd(mask, Math.LeftShift(1, idx)) != 0
EndFunction

Event OnBeastLoadMesh(string eventName, string strArg, float numArg, Form sender)
	Actor act = sender As Actor
	if !act
		return
	endif
	if !Game.IsPluginInstalled("TullAnimatedCreampie.esp") && !Game.IsPluginInstalled("[Predator] Liquid Pack v2.esp")
		return ; neither mesh mod installed: decals only, no log spam
	endif

	; merge with a set that is already running on her, and take over from older loops
	int meshSet = Math.LogicalOr(StorageUtil.GetIntValue(act, "OBF_BL_Set", 0), numArg As int)
	StorageUtil.SetIntValue(act, "OBF_BL_Set", meshSet)
	int stamp = StorageUtil.GetIntValue(act, "OBF_BL_Stamp", 0) + 1
	StorageUtil.SetIntValue(act, "OBF_BL_Stamp", stamp)

	Form[] items = MeshItems()
	Utility.Wait(1.0) ; let OCum/OCumTL finish their own equips first
	float cap = 600.0
	if OCumMain.cumCleanupTimer > 0.0
		cap = OCumMain.cumCleanupTimer * 60.0 + 30.0
	endif
	float waited = 0.0
	float afterScene = 0.0
	bool alive = true
	bool followDecals = AppliedCumKeyword && !OCumMain.disableCumDecal

	while alive
		if StorageUtil.GetIntValue(act, "OBF_BL_Stamp", 0) != stamp
			return ; a newer climax on her owns the meshes now
		endif
		; stop OCumTL's own 60 s removal (and its slot-59 fight) while we hold the set
		StorageUtil.AdjustIntValue(act, "OCumTL_Stamp0", 1)
		StorageUtil.AdjustIntValue(act, "OCumTL_Stamp1", 1)

		bool inScene = OActor.IsInOStim(act)
		; re-equip during the scene (OStim strips at scene changes); after it only while she is naked,
		; so her own armor is never fought over
		if inScene || !act.GetWornForm(0x00000004)
			EquipSet(act, meshSet, items)
		endif

		float step = 2.0
		if !inScene && afterScene >= 10.0
			step = 10.0
		endif
		Utility.Wait(step)
		waited += step
		if !inScene
			afterScene += step
		endif

		if act.IsDead() || act.IsDeleted()
			alive = false
		elseif !inScene && afterScene > 4.0 && followDecals && !act.HasMagicEffectWithKeyword(AppliedCumKeyword)
			alive = false ; OCum's decals are gone (timer ran out or she bathed)
		elseif !inScene && !followDecals && act.IsSwimming()
			alive = false ; OCum decals are off: the meshes still wash off in water
		elseif !inScene && afterScene > cap
			alive = false
		endif
	endwhile

	if StorageUtil.GetIntValue(act, "OBF_BL_Stamp", 0) != stamp
		return
	endif
	int i = 0
	while i < 8
		Form it = items[i]
		if it
			act.UnequipItem(it, false, true)
			act.RemoveItem(it, 99, true, None)
		endif
		i += 1
	endwhile
	StorageUtil.UnsetIntValue(act, "OBF_BL_Set")
	StorageUtil.UnsetIntValue(act, "OBF_BL_Round")
	Debug.Trace("[OBF BeastLoad] meshes removed from " + act.GetDisplayName())
EndEvent

Function EquipSet(Actor act, int meshSet, Form[] items)
	int i = 0
	while i < 8
		if MeshWanted(i, meshSet)
			Form it = items[i]
			if it && !act.IsEquipped(it)
				act.EquipItem(it, false, true)
			endif
		endif
		i += 1
	endwhile
EndFunction

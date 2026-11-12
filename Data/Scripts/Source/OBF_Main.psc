Scriptname OBF_Main extends Quest
{OStim Beast Form - lets the player start OStim scenes in vanilla werewolf beast form and freezes the beast-form timer during scenes. By coronerra.}

; ---------- settings (changed from the MCM) ----------
int Property StartKey = 0 Auto Hidden          ; 0 = unbound
bool Property GuardAllScenes = true Auto Hidden ; also freeze timer for scenes started by others (OStimNet/SkyrimNet, OStim hotkey)
bool Property StopCombatOnStart = false Auto Hidden
float Property SearchRadius = 200.0 Auto Hidden
bool Property DebugMessages = false Auto Hidden

; ---------- runtime ----------
Race WerewolfBeastRace
GlobalVariable ShiftBackTime
Keyword ActorTypeNPC
bool guardActive = false
float savedRemaining = 0.0
int guardedThread = -1
bool busy = false
bool ourPending = false

Event OnInit()
	Maintenance()
EndEvent

Function Maintenance()
	WerewolfBeastRace = Game.GetFormFromFile(0x000CDD84, "Skyrim.esm") as Race
	ShiftBackTime = Game.GetFormFromFile(0x0002BA19, "Skyrim.esm") as GlobalVariable
	ActorTypeNPC = Game.GetFormFromFile(0x00013794, "Skyrim.esm") as Keyword
	UnregisterForAllKeys()
	if StartKey > 0
		RegisterForKey(StartKey)
	endif
	RegisterForModEvent("ostim_thread_start", "OnOStimThreadStart")
	RegisterForModEvent("ostim_thread_end", "OnOStimThreadEnd")
	; a save made mid-scene: make sure we never leave the timer frozen
	if guardActive && !OActor.IsInOStim(Game.GetPlayer())
		EndGuard()
	endif
EndFunction

Function SetStartKey(int newKey)
	if StartKey > 0
		UnregisterForKey(StartKey)
	endif
	StartKey = newKey
	if StartKey > 0
		RegisterForKey(StartKey)
	endif
EndFunction

bool Function IsPlayerBeast()
	Actor player = Game.GetPlayer()
	return WerewolfBeastRace && player.GetRace() == WerewolfBeastRace
EndFunction

Function Note(string msg)
	Debug.Notification("Beast Form: " + msg)
EndFunction

; ---------- hotkey ----------
Event OnKeyDown(int keyCode)
	if keyCode != StartKey || busy || Utility.IsInMenuMode()
		return
	endif
	busy = true
	TryStart()
	busy = false
EndEvent

Function TryStart()
	Actor player = Game.GetPlayer()
	if !IsPlayerBeast()
		return ; key does nothing outside beast form
	endif
	if OActor.IsInOStim(player)
		Note("already in a scene.")
		return
	endif
	if player.IsInCombat()
		if StopCombatOnStart
			player.StopCombat()
			Utility.Wait(0.5)
		endif
		if player.IsInCombat()
			Note("can't start while in combat.")
			return
		endif
	endif

	Actor target = FindTarget()
	if !target
		Note("no valid partner in front of you.")
		return
	endif
	string why = RefuseReason(target)
	if why != ""
		Note(why)
		return
	endif

	Actor[] actors = new Actor[2]
	actors[0] = player
	actors[1] = target
	if !OActor.VerifyActors(actors)
		Note("OStim says " + target.GetDisplayName() + " can't be used.")
		return
	endif
	string sceneID = OLibrary.GetRandomScene(actors)
	if sceneID == ""
		Note("no werewolf scene installed for you and " + target.GetDisplayName() + ".")
		return
	endif

	int builder = OThreadBuilder.Create(actors)
	if builder < 0
		Note("OStim could not create the scene.")
		return
	endif
	Actor[] doms = new Actor[1]
	doms[0] = player
	OThreadBuilder.SetDominantActors(builder, doms)
	OThreadBuilder.SetStartingAnimation(builder, sceneID)
	OThreadBuilder.NoFurniture(builder)
	ourPending = true
	int tid = OThreadBuilder.Start(builder)
	if tid < 0
		ourPending = false
		Note("OStim refused to start the scene.")
	elseif DebugMessages
		Note("started " + sceneID)
	endif
EndFunction

Actor Function FindTarget()
	Actor player = Game.GetPlayer()
	Actor cross = Game.GetCurrentCrosshairRef() as Actor
	if cross && cross != player
		return cross
	endif
	; fallback: nearest candidate in front of the player
	Actor best = None
	float bestDist = SearchRadius + 1.0
	int i = 0
	while i < 12
		Actor a = Game.FindRandomActorFromRef(player, SearchRadius)
		if a && a != player && RefuseReason(a) == ""
			float h = player.GetHeadingAngle(a)
			if h > -60.0 && h < 60.0
				float d = player.GetDistance(a)
				if d < bestDist
					best = a
					bestDist = d
				endif
			endif
		endif
		i += 1
	endwhile
	return best
EndFunction

; returns "" if the target is allowed, else the reason
string Function RefuseReason(Actor a)
	if !a
		return "no target."
	endif
	; never minors: vanilla flag + OStim's own child check (race/name contains "Child")
	if a.IsChild() || OUtils.IsChild(a)
		return "not allowed."
	endif
	if a.IsDead()
		return a.GetDisplayName() + " is dead."
	endif
	if a.IsDisabled() || a.IsDeleted()
		return "no valid target."
	endif
	if ActorTypeNPC && !a.HasKeyword(ActorTypeNPC)
		return a.GetDisplayName() + " isn't a humanoid NPC."
	endif
	if a.IsInCombat()
		return a.GetDisplayName() + " is in combat."
	endif
	if OActor.IsInOStim(a)
		return a.GetDisplayName() + " is already in a scene."
	endif
	return ""
EndFunction

; ---------- beast-form timer guard ----------
Event OnOStimThreadStart(string eventName, string strArg, float numArg, Form sender)
	int tid = numArg as int
	if tid != 0 || guardActive
		ourPending = false
		return ; thread 0 is always the player thread
	endif
	if !IsPlayerBeast() || !GuardAllScenes && !ourPending
		return
	endif
	ourPending = false
	BeginGuard(tid)
EndEvent


Event OnOStimThreadEnd(string eventName, string json, float numArg, Form sender)
	if guardActive && (numArg as int) == guardedThread
		EndGuard()
	endif
EndEvent

Function BeginGuard(int tid)
	if !ShiftBackTime
		return
	endif
	float now = Utility.GetCurrentGameTime()
	savedRemaining = ShiftBackTime.GetValue() - now
	if savedRemaining < 0.01
		savedRemaining = 0.01 ; ~15 game minutes so we never revert the instant the scene ends
	endif
	guardActive = true
	guardedThread = tid
	PushTimer()
	RegisterForSingleUpdate(5.0)
	if DebugMessages
		Note("beast timer paused.")
	endif
EndFunction

Function PushTimer()
	; same mechanism as feeding: move the shift-back time forward
	ShiftBackTime.SetValue(Utility.GetCurrentGameTime() + savedRemaining + 0.0417) ; + 1 game hour margin
EndFunction

Event OnUpdate()
	if !guardActive
		return
	endif
	if !OThread.IsRunning(guardedThread) || !OActor.IsInOStim(Game.GetPlayer())
		EndGuard()
		return
	endif
	if IsPlayerBeast()
		PushTimer()
	endif
	RegisterForSingleUpdate(5.0)
EndEvent

Function EndGuard()
	if guardActive && ShiftBackTime && IsPlayerBeast()
		ShiftBackTime.SetValue(Utility.GetCurrentGameTime() + savedRemaining)
	endif
	guardActive = false
	guardedThread = -1
	if DebugMessages
		Note("beast timer resumed.")
	endif
EndFunction

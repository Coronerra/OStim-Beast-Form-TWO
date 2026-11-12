Scriptname OBF_MCM extends SKI_ConfigBase

OBF_Main Property Main Auto

int oidKey
int oidGuardAll
int oidStopCombat
int oidRadius
int oidDebug
int oidBL
int oidHuge
int oidMesh
int oidShot
int oidStack
int oidRounds

; Filled by the plugin (TWO edition). Growl edition leaves it empty and falls back to its own plugin name.
OCumBeastPie Property BeastPie Auto

OCumBeastPie Function BL()
	if !BeastPie
		BeastPie = Game.GetFormFromFile(0x822, "OStim_Beast_Form_Merged.esp") As OCumBeastPie
	endif
	return BeastPie
EndFunction

Event OnConfigInit()
	ModName = "OStim Beast Form"
	Pages = new string[1]
	Pages[0] = "Settings"
EndEvent

OBF_Main Function M()
	if !Main
		Main = (Self as Quest) as OBF_Main
	endif
	return Main
EndFunction

Event OnPageReset(string page)
	SetCursorFillMode(TOP_TO_BOTTOM)
	AddHeaderOption("Beast form scenes")
	oidKey = AddKeyMapOption("Start scene hotkey", M().StartKey, OPTION_FLAG_WITH_UNMAP)
	oidRadius = AddSliderOption("Fallback search radius", M().SearchRadius, "{0} units")
	oidStopCombat = AddToggleOption("Try StopCombat before starting", M().StopCombatOnStart)
	AddHeaderOption("Timer guard")
	oidGuardAll = AddToggleOption("Pause beast timer for ANY OStim scene", M().GuardAllScenes)
	oidDebug = AddToggleOption("Debug notifications", M().DebugMessages)
	AddHeaderOption("Beast climax (OCum)")
	OCumBeastPie b = BL()
	if b
		oidBL = AddToggleOption("Werewolf/VL cum on partner", b.BeastLoadEnabled)
		oidHuge = AddToggleOption("Huge load", b.HugeLoad)
		oidMesh = AddToggleOption("Tull/Liquid meshes", b.BeastMeshes)
		oidShot = AddToggleOption("Spurts on outside finishes", b.ExtraCumShot)
		oidStack = AddToggleOption("Stack cum across rounds", b.StackRounds)
		oidRounds = AddSliderOption("Max stacked rounds", b.MaxRounds as float, "{0}")
	endif
EndEvent

Event OnOptionKeyMapChange(int option, int keyCode, string conflictControl, string conflictName)
	if option == oidKey
		if conflictControl != ""
			if !ShowMessage("This key is already used by " + conflictControl + " (" + conflictName + "). Use it anyway?", true, "Yes", "No")
				return
			endif
		endif
		M().SetStartKey(keyCode)
		SetKeyMapOptionValue(oidKey, keyCode)
	endif
EndEvent

Event OnOptionDefault(int option)
	if option == oidKey
		M().SetStartKey(0)
		SetKeyMapOptionValue(oidKey, -1)
	endif
EndEvent

Event OnOptionSelect(int option)
	if option == oidGuardAll
		M().GuardAllScenes = !M().GuardAllScenes
		SetToggleOptionValue(option, M().GuardAllScenes)
	elseif option == oidStopCombat
		M().StopCombatOnStart = !M().StopCombatOnStart
		SetToggleOptionValue(option, M().StopCombatOnStart)
	elseif option == oidDebug
		M().DebugMessages = !M().DebugMessages
		SetToggleOptionValue(option, M().DebugMessages)
	elseif option == oidBL
		BL().BeastLoadEnabled = !BL().BeastLoadEnabled
		SetToggleOptionValue(option, BL().BeastLoadEnabled)
	elseif option == oidHuge
		BL().HugeLoad = !BL().HugeLoad
		SetToggleOptionValue(option, BL().HugeLoad)
	elseif option == oidMesh
		BL().BeastMeshes = !BL().BeastMeshes
		SetToggleOptionValue(option, BL().BeastMeshes)
	elseif option == oidShot
		BL().ExtraCumShot = !BL().ExtraCumShot
		SetToggleOptionValue(option, BL().ExtraCumShot)
	elseif option == oidStack
		BL().StackRounds = !BL().StackRounds
		SetToggleOptionValue(option, BL().StackRounds)
	endif
EndEvent

Event OnOptionSliderOpen(int option)
	if option == oidRounds
		SetSliderDialogStartValue(BL().MaxRounds as float)
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(1.0, 10.0)
		SetSliderDialogInterval(1.0)
	elseif option == oidRadius
		SetSliderDialogStartValue(M().SearchRadius)
		SetSliderDialogDefaultValue(200.0)
		SetSliderDialogRange(100.0, 500.0)
		SetSliderDialogInterval(25.0)
	endif
EndEvent

Event OnOptionSliderAccept(int option, float value)
	if option == oidRounds
		BL().MaxRounds = value as int
		SetSliderOptionValue(option, value, "{0}")
	elseif option == oidRadius
		M().SearchRadius = value
		SetSliderOptionValue(option, value, "{0} units")
	endif
EndEvent

Event OnOptionHighlight(int option)
	if option == oidKey
		SetInfoText("In werewolf beast form, out of combat: aim at an adult NPC and press this to start an OStim scene. Unbound by default.")
	elseif option == oidGuardAll
		SetInfoText("Also pause the beast-form timer when a scene is started some other way (OStim key, OStimNet/SkyrimNet) while you're a werewolf. Hotkey scenes are always guarded.")
	elseif option == oidStopCombat
		SetInfoText("If you're flagged in combat (common in beast form), try to clear it first. Scenes still refuse if combat continues.")
	elseif option == oidBL
		SetInfoText("When you climax as a werewolf or Vampire Lord, add the cum OCum skips for creature scenes (footjobs, handjobs, outside finishes, vaginal/anal overlays). Uses OCum's own textures and cleanup timer.")
	elseif option == oidHuge
		SetInfoText("Beast-sized loads: heaviest textures on face, chest, belly, butt and legs, full Tull/Liquid set, and the beast never runs dry.")
	elseif option == oidMesh
		SetInfoText("Wear Tull Animated Creampie / Liquid Pack meshes for as long as OCum's cum textures last, even if OCum's own meshes are off.")
	elseif option == oidStack
		SetInfoText("If the scene keeps going after he cums, every climax adds more: heavier layers on each area and more Tull/Liquid meshes, up to the max rounds. Cleared together by OCum's timer or a bath.")
	elseif option == oidRounds
		SetInfoText("How many climaxes keep adding coverage. After this it stays at full.")
	elseif option == oidShot
		SetInfoText("Play OCum's cum-shot spurts on footjob, handjob and outside finishes, which OCum skips when a creature scene is tagged as sex.")
	elseif option == oidRadius
		SetInfoText("If nothing is under the crosshair, pick the nearest valid NPC in front of you within this distance.")
	endif
EndEvent

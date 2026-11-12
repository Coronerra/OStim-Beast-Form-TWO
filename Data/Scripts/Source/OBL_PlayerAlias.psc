Scriptname OBL_PlayerAlias extends ReferenceAlias
Event OnPlayerLoadGame()
	(GetOwningQuest() as OBL_Main).Setup()
EndEvent

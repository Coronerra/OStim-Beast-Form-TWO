Scriptname OBF_PlayerAlias extends ReferenceAlias

; New quest/new game and each save reload (including upgrades from 0.1).
Event OnInit()
    OBF_OCRCompat.RestoreKeywords()
EndEvent

Event OnPlayerLoadGame()
    OBF_OCRCompat.RestoreKeywords()
    (GetOwningQuest() as OBF_Main).Maintenance()
EndEvent

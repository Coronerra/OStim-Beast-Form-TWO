Scriptname OCumBeastPieAlias extends ReferenceAlias
{Re-registers OCumBeastPie's mod event on every game load. That Guy (Coronerra)}
Event OnPlayerLoadGame()
	(GetOwningQuest() As OCumBeastPie).Setup()
EndEvent

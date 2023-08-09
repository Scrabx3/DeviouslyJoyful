Scriptname JFDDPlayerScr extends ReferenceAlias

JFDDMCM Property MCM Auto
JFDDKeyInv Property Chest Auto

Message Property LookingForKeysMsg Auto
Keyword Property LocTypeDungeon Auto

Event OnPlayerLoadGame()
  (GetOwningQuest() as JFDDMain).Maintenance()
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
  If MCM.bKHEnabled && (!akNewLoc || akNewLoc.HasKeyword(LocTypeDungeon)) && JoyfulFollowers.GetFollower()
    Chest.RegisterForSingleUpdateGameTime(MCM.fKHFreq)
    LookingForKeysMsg.Show()
  EndIf
EndEvent

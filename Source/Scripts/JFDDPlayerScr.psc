Scriptname JFDDPlayerScr extends ReferenceAlias

; ----------------------------------- Property
JFDDKeyInv Property Chest Auto

; ----------------------------------- Variables
Event OnLocationChange(Location akOldLoc, Location akNewLoc)
  If((MCM.bKHFind) && ((LocType == "Dungeon") || (LocType == "Wilderness")) && (GetOwningQuest().GetStage() >= 100))
    Chest.RegisterForSingleUpdateGameTime(MCM.fKHFreq)
    If(MCM.bDeNo == true)
      Debug.Notification("Follower is now looking for keys")
    EndIf
  EndIf
EndEvent

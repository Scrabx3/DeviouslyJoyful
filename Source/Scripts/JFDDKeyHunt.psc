Scriptname JFDDKeyHunt extends Quest

JFMain Property Main Auto
JFDDMain Property DDMain Auto
ReferenceAlias Property RestraintKey Auto

Actor Property PlayerRef Auto
ObjectReference Property Storage Auto

Message Property KeyHuntIntro Auto

Faction Property HelperFaction Auto
Actor[] Helpers

; --------------------------------------- Functions
Event OnStoryScript(Keyword akKeyword, Location akLocation, ObjectReference akRef1, ObjectReference akRef2, int aiValue1, int aiValue2)
  Main.FadeToBlack()
  JoyfulFollowers.LockTimeout()
  (akRef1 as Actor).SetAV("WaitingForPlayer", 1)
  PlayerRef.RemoveAllItems(Storage, true)
  Helpers = new Actor[128]
  DDMain.KeyHuntingStart()
  KeyHuntIntro.Show()
  Main.FadeBack()
  SetStage(5)
EndEvent

Function KeyHuntClose(bool abUnlockedSelf = false)
  PlayerRef.RemoveItem(RestraintKey.GetReference())
  If(!abUnlockedSelf)
    DDMain.KeyHuntingEnd()
  EndIf
  Storage.RemoveAllItems(PlayerRef)
  SetStage(40)
EndFunction


; NOTE: FormList doesnt work. Apparently the IsInlist() condition doesnt recognize script-added forms
Function Helped(Actor akActor)
  Helpers[Helpers.Find(none)] = akActor
  akActor.AddToFaction(HelperFaction)
EndFunction

Function Stop()
  Debug.Trace("[DJF] Stop on Key Hunter Quest")
  int i = 0
  While(i < Helpers.Length)
    If(Helpers[i])
      Helpers[i].RemoveFromFaction(HelperFaction)
      i += 1
    Else
      i = Helpers.Length
    EndIf
  EndWhile
  JoyfulFollowers.GetFollower().SetAV("WaitingForPlayer", 1)
  JoyfulFollowers.AddAffection(2)
  JoyfulFollowers.UnlockTimeout(true)
  return Parent.Stop()
EndFunction

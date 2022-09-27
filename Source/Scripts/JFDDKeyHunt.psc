Scriptname JFDDKeyHunt extends Quest

JFMain Property Main Auto
JFDDMain Property DDMain Auto
ReferenceAlias Property RestraintKey Auto

Actor Property PlayerRef Auto
ObjectReference Property Storage Auto
Message Property KeyHuntIntro Auto
Topic Property InfoTopic Auto
Topic Property ScamTopic Auto
Topic Property HandoverTopic Auto
Topic Property DropKeyTopic Auto

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
  RegisterForModEvent("HookAnimationEnd_KeyHunter", "KeyHunterAftexSex")
  RegisterForModEvent("HookAnimationEnd_KeyHunterKey", "KeyHunterAftexSexKey")
  SetStage(5)
EndEvent

; NOTE: FormList doesnt work. Apparently the IsInlist() condition doesnt recognize script-added forms
Function Helped(Actor akActor)
  Helpers[Helpers.Find(none)] = akActor
  akActor.AddToFaction(HelperFaction)
EndFunction

Function HandOverKey(Actor akKeyHolder, bool abDrop = false)
  If(abDrop)
    akKeyHolder.DropObject(RestraintKey.GetReference())
  Else
    akKeyHolder.RemoveItem(RestraintKey.GetReference(), akOtherContainer = Game.GetPlayer())
  EndIf
EndFunction

Event KeyHunterAftexSex(int tid, bool HasPlayer)
  Actor[] positions = JFAnimStarter.GetSceneActors(tid)
  int where = 1 - positions.Find(Game.GetPlayer())
  If(Utility.RandomInt(0, 99) < 33)
    positions[where].Say(ScamTopic)
  Else
    positions[where].Say(InfoTopic)
  EndIf
EndEvent

Event KeyHunterAftexSexKey(int tid, bool HasPlayer)
  Actor[] positions = JFAnimStarter.GetSceneActors(tid)
  int where = 1 - positions.Find(Game.GetPlayer())
  positions[where].Say(HandoverTopic)
  bool drop = Utility.RandomInt(0, 99) < 25
  If(!drop)
    positions[where].Say(HandoverTopic)
  Else
    positions[where].Say(DropKeyTopic)
  EndIf
  Utility.Wait(1)
  HandOverKey(positions[where], drop)
EndEvent

Function KeyHuntClose(bool abUnlockedSelf = false)
  PlayerRef.RemoveItem(RestraintKey.GetReference())
  If(!abUnlockedSelf)
    DDMain.KeyHuntingEnd()
  EndIf
  Storage.RemoveAllItems(PlayerRef)
  SetStage(40)
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

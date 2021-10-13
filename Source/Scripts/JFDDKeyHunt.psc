Scriptname JFDDKeyHunt extends Quest

; --------------------------------------- Property
JFMCM Property MCM Auto
JFCore Property Core Auto
JFDDCore Property DDCore Auto

Actor Property PlayerRef Auto
ObjectReference Property Storage Auto
Message Property KeyHuntIntro Auto
Faction Property KeyHunterHepled Auto

Key Property JF_KeyHunting_Key Auto

Location Property WhiterunLocation Auto
Location Property SolitudeLocation Auto
Location Property MarkarthLocation Auto
Location Property RiftenLocation Auto
Location Property WindhelmLocation Auto
Location Property DawnstarLocation Auto
Location Property MorthalLocation Auto
Location Property FalkreathLocation Auto

Quest[] Property ScanQuests Auto
ReferenceAlias[] Property ScanAlias Auto
;0 - Dawn, 1 - Falk, 2 - Mark, 3 - Rift, 4 - Sol, 5 - Whit, 6 - Wind
ReferenceAlias Property KeyHolder Auto
; --------------------------------------- Variables
Actor[] Helpers
int helperLength = 0

; --------------------------------------- Functions
Event OnStoryScript(Keyword akKeyword, Location akLocation, ObjectReference akRef1, ObjectReference akRef2, int aiValue1, int aiValue2)
  int toScan = KeyHuntingArea()
  If(toScan > 6)
    Stop()
    return
  else
    If(ScanQuests[toScan].Start())
      Actor oneToHold = ScanAlias[toScan].GetReference() as Actor
      KeyHolder.ForceRefTo(oneToHold)
      oneToHold.AddItem(JF_KeyHunting_Key)
      If(MCM.bDeNo)
        Debug.Notification("Keyholder: " + oneToHold.GetLeveledActorBase().GetName())
      EndIf
    Else
      Stop()
      return
    EndIf
  EndIf
  ; Found a Keyholder, starting the Game
  Core.FadeBlack()
  MCM.bCooldown = false
  Core.JoyFolRef.GetActorReference().SetAV("WaitingForPlayer", 1)
  PlayerRef.RemoveAllItems(Storage, true)
  DDCore.TieItUp()
  KeyHuntIntro.Show()
  ; Faction to store all Actors that have helped the Player once, to avoid them helping the Player more than once
  Helpers = new Actor[10]
  Core.FadeBlackBack()
EndEvent

int Function KeyHuntingArea()
	If(PlayerRef.IsInLocation(DawnstarLocation))
		return 0
	ElseIf(PlayerRef.IsInLocation(FalkreathLocation))
		return 1
	ElseIf(PlayerRef.IsInLocation(MarkarthLocation))
		return 2
	ElseIf(PlayerRef.IsInLocation(RiftenLocation))
		return 3
	ElseIf(PlayerRef.IsInLocation(SolitudeLocation))
		return 4
	ElseIf(PlayerRef.IsInLocation(WhiterunLocation))
		return 5
	ElseIf(PlayerRef.IsInLocation(WindhelmLocation))
		return 6
	Else ;Not in a valid Location
		return 13
	EndIf
EndFunction

Function AddFaction(Actor toAdd)
  If(helperLength >= 10)
    PapyrusUtil.PushActor(Helpers, toAdd)
  else
    Helpers[helperLength] = toAdd
  EndIf
  Helpers[helperLength].AddToFaction(KeyHunterHepled)
  helperLength += 1
endFunction

Function KeyHuntClose(bool UnlockSelf = false)
  PlayerRef.RemoveItem(JF_KeyHunting_Key)
  If(UnlockSelf != true)
    DDCore.UntieIt()
  EndIf
  Storage.RemoveAllItems(PlayerRef)
EndFunction

Function KeyHuntStop()
  While(helperLength)
    helperLength -= 1
    Helpers[helperLength].RemoveFromFaction(KeyHunterHepled)
  EndWhile
  Core.GainAffection()
  MCM.Cooldown()
  Stop()
endFunction

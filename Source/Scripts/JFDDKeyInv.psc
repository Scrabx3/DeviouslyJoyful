Scriptname JFDDKeyInv extends ObjectReference
; -------------------------- Properties
JFMCM Property MCM Auto
JFPlayerScr Property PlayerScr Auto

Key Property ChastKey Auto
Key Property RestKey Auto
Key Property PiercKey Auto

; -------------------------- Variables
;Need them in JoyFol Script
int Property RestKeyCount Auto Hidden
int Property ChastKeyCount Auto Hidden
int Property PiercKeyCount Auto Hidden

; -------------------------- Code
;Remove/Add Keys // 1 - ChastKey ; 2 - RestKey ; 3 - PiercKey
Function RemKey(int type, int amount)
  If(type == 1)
    RemoveItem(ChastKey, amount)
  ElseIf(type == 2)
    RemoveItem(RestKey, amount)
  ElseIf(type == 3)
    RemoveItem(PiercKey, amount)
  EndIf
EndFunction

Function AddKey(int type, int amount = 1)
  If(type == 1)
    AddItem(ChastKey, amount)
  ElseIf(type == 2)
    AddItem(RestKey, amount)
  ElseIf(type == 3)
    AddItem(PiercKey, amount)
  EndIf
EndFunction


; Only allowing DD Keys here
Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
  If(akBaseItem != ChastKey && akBaseItem != RestKey && akBaseItem != PiercKey)
    RemoveItem(akItemReference, aiItemCount, false, akSourceContainer)
  EndIf
endEvent


; Key searching cycle
Event OnUpdateGameTime()
  SearchKey()
EndEvent

Function SearchKey()
  If(PlayerScr.LocType == "Wilderness" || PlayerScr.LocType == "Dungeon")
    RegisterForSingleUpdateGameTime(MCM.fKHFreq)
  EndIf
  If(CountKeys() >= MCM.iMaxKeyAllowed)
    return
  EndIf
  if (MCM.iKHChance >= Utility.RandomInt(1, 100))
    If(MCM.bKHFiNo == true)
      Debug.Notification("Your follower found a key!")
    EndIf
    int KeyChance = Utility.RandomInt(1, 100)
    if (MCM.iKHChast >= KeyChance)
      AddItem(ChastKey, 1, true)
    ElseIf((MCM.iKHChast < KeyChance) && (MCM.iKHRest >= KeyChance))
      AddItem(RestKey, 1, true)
    Else
      Additem(PiercKey, 1, true)
    endIf
  endif
EndFunction

;Count keys
int Function CountKeys()
  RestKeyCount = (GetItemCount(RestKey))
  ChastKeyCount = (GetItemCount(ChastKey))
  PiercKeyCount = (GetItemCount(PiercKey))
  return RestKeyCount + ChastKeyCount + PiercKeyCount
EndFunction

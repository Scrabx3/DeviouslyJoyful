Scriptname JFDDKeyInv extends ObjectReference
; -------------------------- Properties
JFDDMCM Property MCM Auto

Keyword Property LocTypeDungeon Auto
Message Property FoundKeyMsg  Auto

Key[] Property DDKeys Auto

; -------------------------- Variables
int Property ChastityKeyIdx   = 0 AutoReadOnly
int Property RestraintsKeyIdx = 1 AutoReadOnly
int Property PiercingKeyIdx   = 2 AutoReadOnly

; -------------------------- Code
Function RemoveKey(int aiType, int aiAmount = 1)
  RemoveItem(DDKeys[aiType], aiAmount)
EndFunction

Function AddKey(int aiType, int aiAmount = 1)
  AddItem(DDKeys[aiType], aiAmount)
EndFunction

; Only allowing DD Keys here
Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
  If(DDKeys.Find(akBaseItem as Key) == -1)
    RemoveItem(akItemReference, aiItemCount, false, akSourceContainer)
  EndIf
endEvent

Event OnUpdateGameTime()
  If(!MCM.bKHEnabled)
    return
  EndIf
  Location playerloc = Game.GetPlayer().GetCurrentLocation()
  If(!playerloc || playerloc.HasKeyword(LocTypeDungeon))
    RegisterForSingleUpdateGameTime(MCM.fKHFreq)
  EndIf
  If(GetNumItems() > MCM.iKHMaxKeys)  ; Can only store Keys in here
    return
  ElseIf(Utility.RandomFloat(0, 99.5) >= MCM.fKHChance)
    return
  EndIf
  int draw = JFMain.GetFromWeight(MCM.iKHTypes)
  If(draw == 0)
    return
  EndIf
  AddItem(DDKeys[draw - 1])
  If(MCM.bKHNotify)
    FoundKeyMsg.Show()
  EndIf
EndEvent

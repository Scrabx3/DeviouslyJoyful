Scriptname JFDDJoyFolScr extends JFJoyFolScr

; ------------------------------------- Property
JFDDKeyInv Property Chest Auto

; ------------------------------------- Events
Function LoseKEys()
  ;Chest.RestKeyCount
  ;Chest.ChastKeyCount
  ;Chest.PiercKeyCount
  if(MCM.iLoseKeys >= Utility.RandomInt(1, 100))
    Chest.CountKeys()
    int type = Utility.RandomInt(0, 1)
    int amount = Utility.RandomInt(0, 2)
    If(type == 1 && Chest.RestKeyCount != 0)
      Chest.RemKey(1, amount)
      If(Chest.RestKeyCount < amount)
        amount -= Chest.RestKeyCount
        type = Utility.RandomInt(2, 3)
        If(type == 2 && Chest.ChastKeyCount != 0)
          Chest.RemKey(2, amount)
        Else
          Chest.RemKey(3, amount)
        EndIf
      EndIf
    Else
      type = Utility.RandomInt(2, 3)
      If(type == 2 && Chest.ChastKeyCount != 0)
        Chest.RemKey(2, amount)
        If(Chest.ChastKeyCount < amount)
          amount -= Chest.ChastKeyCount
          Chest.RemKey(3, amount)
        EndIf
      Else
        Chest.RemKey(3, amount)
      EndIf
    EndIf
  EndIf
EndFunction

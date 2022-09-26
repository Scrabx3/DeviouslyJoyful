Scriptname JFDDMain extends Quest Conditional

zadLibs Property Lib0 Auto
zadxLibs Property Lib1 Auto
zadxLibs2 Property Lib2 Auto

JFDDKeyInv Property KeyInventory Auto

; =========================================================
; ==================   Devious Devices  ===================
; =========================================================
int Property BlindfoldIdx    = 0 AutoReadOnly
int Property HeavyBondageIdx = 1 AutoReadOnly
int Property GagIdx          = 2 AutoReadOnly
int Property BootsIdx        = 3 AutoReadOnly
int Property GlovesIdx       = 4 AutoReadOnly
int Property HobbleSkirtIdx  = 5 AutoReadOnly

bool Property PunishmentBlindfold     = false Auto Hidden Conditional
bool Property PunishmentHeavyBondage  = false Auto Hidden Conditional
bool Property PunishmentGag           = false Auto Hidden Conditional
bool Property PunishmentBoots         = false Auto Hidden Conditional
bool Property PunishmentGloves        = false Auto Hidden Conditional

; -------------------- Generic
Function RemoveDD(Actor akTarget, int aiType)
  If(aiType == BlindfoldIdx)
    Lib0.UnlockDeviceByKeyword(akTarget, Lib0.zad_DeviousBlindfold)
  ElseIf(aiType == HeavyBondageIdx)
    Lib0.UnlockDeviceByKeyword(akTarget, Lib0.zad_DeviousHeavyBondage)
  ElseIf(aiType == GagIdx)
    Lib0.UnlockDeviceByKeyword(akTarget, Lib0.zad_DeviousGag)
  ElseIf(aiType == BootsIdx)
    Lib0.UnlockDeviceByKeyword(akTarget, Lib0.zad_DeviousBoots)
  ElseIf(aiType == GlovesIdx)
    Lib0.UnlockDeviceByKeyword(akTarget, Lib0.zad_DeviousGloves)
	ElseIf(aiType == HobbleSkirtIdx)
    Lib0.UnlockDeviceByKeyword(akTarget, Lib0.zad_DeviousHobbleSkirt)
  EndIf
endFunction

; -------------------- Events
; -------- Shopping Post - Rubber Suit
Function RubberSuit(Actor akTarget, int aiColor = -1)
  If(aiColor < 0)
    aiColor = Utility.RandomInt(0, 3)
  EndIf
	If(aiColor == 0 || akTarget == Game.GetPlayer() && JFMainEvents.Singleton().Humiliation) ;trapsnarent
		Lib0.LockDevice(akTarget, Lib1.zadx_catsuit_transparent_Inventory)
	ElseIf(aiColor == 1) ;black
		Lib0.LockDevice(akTarget, Lib1.zadx_catsuit_black_Inventory)
	ElseIf(aiColor == 2) ;white
		Lib0.LockDevice(akTarget, Lib1.zadx_catsuit_white_Inventory)
	Else ;pink
		Lib0.LockDevice(akTarget, Lib1.zadx_catsuit_pink_Inventory)
	EndIf
EndFunction

Function AddRubberSuit()
  int colour = Utility.RandomInt(0, 3)
  If(Colour == 0 || JFMainEvents.Singleton().Humiliation) ;transparent
		Game.GetPlayer().AddItem(Lib1.zadx_catsuit_transparent_Inventory)
	ElseIf(Colour == 1) ;black
		Game.GetPlayer().AddItem(Lib1.zadx_catsuit_black_Inventory)
	ElseIf(Colour == 2) ;white
		Game.GetPlayer().AddItem(Lib1.zadx_catsuit_white_Inventory)
	Else ;pink
		Game.GetPlayer().AddItem(Lib1.zadx_catsuit_pink_Inventory)
	EndIf
EndFunction

; -------- Game - Shut Up
Function HarnessGagBig(Actor akTarget, bool abEquip)
  If(abEquip)
    Lib0.LockDevice(akTarget, Lib1.zadx_GagEboniteHarnessBallBig_Inventory, true)
  Else
    Lib0.UnlockDevice(akTarget, Lib1.zadx_GagEboniteHarnessBallBig_Inventory, none, Lib0.zad_DeviousGag, true)
  EndIf
EndFunction

; -------- Game - Pet Collar
Function PetCollar(Actor akTarget, bool abEquip)
  Armor PetCollarInv = Game.GetFormFromFile(0x7929, "PetCollar.esp") as Armor
  If(abEquip)
    Lib0.LockDevice(akTarget, PetCollarInv, true)
  Else
    Lib0.RemoveDevice(akTarget, PetCollarInv, none, Lib0.zad_DeviousCollar, true)
  EndIf
EndFunction

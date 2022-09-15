Scriptname JFDDMain extends Quest  

zadLibs Property Lib0 Auto
zadxLibs Property Lib1 Auto
zadxLibs2 Property Lib2 Auto


; =========================================================
; ==================   Devious Devices  ===================
; =========================================================
; -------------------- Generic
; 0 - Blindfold | 1 - Heavy Bondage | 2 - Gag | 3 - Boots | 4 - Gloves | 5 - HobbleSkirt
Function RemoveDD(actor target, int type)
  If(type == 0)
    Lib0.UnlockDeviceByKeyword(target, Lib0.zad_DeviousBlindfold)
  ElseIf(type == 1)
    Lib0.UnlockDeviceByKeyword(target, Lib0.zad_DeviousHeavyBondage)
  ElseIf(type == 2)
    Lib0.UnlockDeviceByKeyword(target, Lib0.zad_DeviousGag)
  ElseIf(type == 3)
    Lib0.UnlockDeviceByKeyword(target, Lib0.zad_DeviousBoots)
  ElseIf(type == 4)
    Lib0.UnlockDeviceByKeyword(target, Lib0.zad_DeviousGloves)
	ElseIf(type == 5)
    Lib0.UnlockDeviceByKeyword(target, Lib0.zad_DeviousHobbleSkirt)
  EndIf
endFunction

; -------------------- Events
; -------- Shopping Post - Rubber Suit
Function RubberSuit(actor target)
	int colour = Utility.RandomInt(0, 3)
	If(Colour == 0 || JFMainEvents.Singleton().Humiliation) ;trapsnarent
		Lib0.LockDevice(Target, Lib1.zadx_catsuit_transparent_Inventory)
	ElseIf(Colour == 1) ;black
		Lib0.LockDevice(Target, Lib1.zadx_catsuit_black_Inventory)
	ElseIf(Colour == 2) ;white
		Lib0.LockDevice(Target, Lib1.zadx_catsuit_white_Inventory)
	Else ;pink
		Lib0.LockDevice(Target, Lib1.zadx_catsuit_pink_Inventory)
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
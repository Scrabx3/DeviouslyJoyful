Scriptname JFDDCore extends JFCore  Conditional

; ------------------------------------- Property
JFDDKeyInv Property KeyInv Auto ;Pointing at Keyholders Chest

Quest Property DDChainEvents Auto
Quest Property DDManualScript Auto
; -- Custom Devices
; Armor Property JF_Util_DogCollar_Inv Auto <- Stored in Parent
Armor Property JF_Util_DogCollar_Ren Auto
Keyword Property JF_Util_DogCollar Auto

Message Property JFDD_Core_JamLock Auto

; -- Key Hunter
ReferenceAlias Property KH_Giver Auto
Scene Property KH_Paid Auto ; tipp
Scene Property KH_Served Auto ; key
; -- Libs
zadLibs Property Lib0 Auto
zadxLibs Property Lib1 Auto
zadxLibs2 Property Lib2 Auto
; ------------------------------------- Variables
; ------- PetCollar MCM Settings
bool StoredService
int StoredArousal
int StoredArmorType

; ------------------------------------- Code
; =========================================================
; ========================	Public	=======================
; =========================================================


; =========================================================
; ==================   Devious Devices  ===================
; =========================================================
; -------------------- Generic
; Just a wrapper to easily remove DD Items since almost every Script points at this one here anyway...
; 0 - Blindfold /// 1 - Heavy Bondage /// 2 - Gag
; 3 - Boots /// 5 - Gloves /// 5 - HobbleSkirt
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
; -------- Rubber Suit
Function RubberSuit(actor target)
	int colour = Utility.RandomInt(0, 3)
	If(Colour == 0 || Util.FPublicHumiliation) ;trapsnarent
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
  If(Colour == 0 || Util.FPublicHumiliation) ;transparent
		PlayerRef.AddItem(Lib1.zadx_catsuit_transparent_Inventory)
	ElseIf(Colour == 1) ;black
		PlayerRef.AddItem(Lib1.zadx_catsuit_black_Inventory)
	ElseIf(Colour == 2) ;white
		PlayerRef.AddItem(Lib1.zadx_catsuit_white_Inventory)
	Else ;pink
		PlayerRef.AddItem(Lib1.zadx_catsuit_pink_Inventory)
	EndIf
EndFunction


; -------------------- Generic Punishments
; Function to start Generic punishments
; If you are not using this Function to start a Generic punishment, make sure to manually set the Flag in "JFEventStorage" to let the Follower know that they arent unequipping Devices in the specific Slot
; --------- Parameter
; Loops: The Punishment to apply. If 0, its random, otherwise:
; 1 - Blindfold /// 2 - Gag /// 3 - Heavy Bondage
; 4 - Rubber Gloves /// 5 - Rubber Boots /// 6 - Cuffs (Arm)
; 7 - Cuffs (Legs) /// 8 - Ankle Shackles /// 9 - Corset
Function Punishment(int Loops = 0)
  ;Ill rewrite this though unfortunately I didnt find Sources of any other Weight Slider Scripts so Im going to do my own in the most complicated fashion I can think of. YAY, IDIOCITY AT WORK
  ;Getting a random, not already worn device
  If(Loops == 0)
    ;This entire block is for the default (random) scenario
    int AdditiveChance = 0
    If(!PlayerRef.WornHasKeyword(Lib0.zad_DeviousBlindfold))
      AdditiveChance += MCM.iBlindEnab
    EndIf
    If(!PlayerRef.WornHasKeyword(Lib0.zad_DeviousGag))
      AdditiveChance += MCM.iGagEnab
    EndIf
    If(!PlayerRef.WornHasKeyword(Lib0.zad_DeviousHeavyBondage))
      AdditiveChance += MCM.iHeavyBonEnab
    EndIf
    If(!PlayerRef.WornHasKeyword(Lib0.zad_DeviousGloves))
      AdditiveChance += MCM.iGagEnab
    EndIf
    If(!PlayerRef.WornHasKeyword(Lib0.zad_DeviousBoots))
      AdditiveChance += MCM.iGagEnab
    EndIf
    If(!PlayerRef.WornHasKeyword(Lib0.zad_DeviousArmCuffs))
      AdditiveChance += MCM.iGagEnab
    EndIf
    If(!PlayerRef.WornHasKeyword(Lib0.zad_deviousLegCuffs))
      AdditiveChance += MCM.iGagEnab
    EndIf
    If(!PlayerRef.WornHasKeyword(Lib0.zad_DeviousAnkleShackles))
      AdditiveChance += MCM.iGagEnab
    EndIf
    If(!PlayerRef.WornHasKeyword(Lib0.zad_DeviousCorset))
      AdditiveChance += MCM.iGagEnab
    EndIf
    int Consequence = Utility.RandomInt(1, AdditiveChance)
    int CurrentRoom = 0
    While(CurrentRoom < Consequence)
      If(Loops == 0)
        CurrentRoom = MCM.iBlindEnab
      ElseIf(Loops == 1)
        CurrentRoom += MCM.iGagEnab
      ElseIf(Loops == 2)
        CurrentRoom += MCM.iHeavyBonEnab
      ElseIf(Loops == 3)
        CurrentRoom += MCM.iRubberGlovEnab
      ElseIf(Loops == 4)
        CurrentRoom += MCM.iRubberBootEnab
      ElseIf(Loops == 5)
        CurrentRoom += MCM.iCuffArmEnab
      ElseIf(Loops == 6)
        CurrentRoom += MCM.iCuffLegEnab
      ElseIf(Loops == 7)
        CurrentRoom += MCM.iAnkleShackEnab
      ElseIf(Loops == 8)
        CurrentRoom += MCM.iCorsetEnab
      Else
        Debug.MessageBox("Scrabs a potato and cant do math. No punishment today, thank you.")
        Return
      EndIf
      Loops += 1
    EndWhile
  EndIf
  ;Get Colour/Material
  int Mode = MCM.PunishColourOption
  If(Mode == 6)
    Mode = Utility.RandomInt(0, 5)
  EndIf
  If(Loops == 1 ) ; Blindfold
    If(Mode == 0)
      Lib0.LockDevice(PlayerRef, Lib1.eboniteHarnessBody)
    ElseIf(Mode == 1)
      Lib0.LockDevice(PlayerRef, Lib1.wtEboniteHarnessBody)
    ElseIf(Mode == 2)
      Lib0.LockDevice(PlayerRef, Lib1.rdEboniteHarnessBody)
    ElseIf(Mode == 3)
      Lib0.LockDevice(PlayerRef, Lib0.harnessBody)
    ElseIf(Mode == 4)
      Lib0.LockDevice(PlayerRef, Lib1.wtLeatherHarnessBody)
    ElseIf(Mode == 5)
      Lib0.LockDevice(PlayerRef, Lib1.rdLeatherHarnessBody)
    Else
      Debug.Notification("Invalid argument passed")
    EndIf
    Util.DBlindfoldPunishment = true
  ElseIf(Loops == 2) ; Gag
    If(Mode == 0)
      Lib0.LockDevice(PlayerRef, Lib1.zadx_dud_Pony_BitGag_Simple_Ebonite_BlackInventory)
    ElseIf(Mode == 1)
      Lib0.LockDevice(PlayerRef, Lib1.zadx_dud_Pony_BitGag_Simple_White_Ebonite_Inventory)
    ElseIf(Mode == 2)
      Lib0.LockDevice(PlayerRef, Lib1.zadx_dud_Pony_BitGag_Simple_Red_Ebonite_Inventory)
    ElseIf(Mode == 3)
      Lib0.LockDevice(PlayerRef, Lib1.zadx_dud_Pony_BitGag_Simple_Leather_BlackInventory)
    ElseIf(Mode == 4)
      Lib0.LockDevice(PlayerRef, Lib1.zadx_dud_Pony_BitGag_Simple_White_Leather_Inventory)
    ElseIf(Mode == 5)
      Lib0.LockDevice(PlayerRef, Lib1.zadx_dud_Pony_BitGag_Simple_Red_Leather_Inventory)
    Else
      Debug.Notification("Invalid argument passed")
    EndIf
    Util.DGagPunishment = true
  ElseIf(Loops == 3) ; Heavy Bondage
    If(Mode == 0)
      Lib0.LockDevice(PlayerRef, Lib1.eboniteArmbinder)
    ElseIf(Mode == 1)
      Lib0.LockDevice(PlayerRef, Lib1.wtEboniteArmbinder)
    ElseIf(Mode == 2)
      Lib0.LockDevice(PlayerRef, Lib1.rdEboniteArmbinder)
    ElseIf(Mode == 3)
      Lib0.LockDevice(PlayerRef, Lib0.armbinder)
    ElseIf(Mode == 4)
      Lib0.LockDevice(PlayerRef, Lib1.wtLeatherArmbinder)
    ElseIf(Mode == 5)
      Lib0.LockDevice(PlayerRef, Lib1.rdLeatherArmbinder)
    EndIf
  ElseIf(Loops == 4) ; Rubber Gloves
    If(Mode == 0)
      Lib0.LockDevice(PlayerRef, Lib1.EbRestrictiveGloves)
    ElseIf(Mode == 1)
      Lib0.LockDevice(PlayerRef, Lib1.WTErestrictiveGloves)
    ElseIf(Mode == 2)
      Lib0.LockDevice(PlayerRef, Lib1.RDErestrictiveGloves)
    ElseIf(Mode == 3)
      Lib0.LockDevice(PlayerRef, Lib0.glovesRestrictive)
    ElseIf(Mode == 4)
      Lib0.LockDevice(PlayerRef, Lib1.WTLrestrictiveGloves)
    ElseIf(Mode == 5)
      Lib0.LockDevice(PlayerRef, Lib1.RDLrestrictiveGloves)
    Else
      Debug.Notification("Invalid argument passed")
    EndIf
    Util.DGlovesPunishment = true
  ElseIf(Loops == 5) ; Rubber Boots
    If(Mode == 0)
      Lib0.LockDevice(PlayerRef, Lib1.EbRestrictiveBoots)
    ElseIf(Mode == 1)
      Lib0.LockDevice(PlayerRef, Lib1.WTErestrictiveBoots)
    ElseIf(Mode == 2)
      Lib0.LockDevice(PlayerRef, Lib1.RDErestrictiveBoots)
    ElseIf(Mode == 3)
      Lib0.LockDevice(PlayerRef, Lib1.restrictiveBoots)
    ElseIf(Mode == 4)
      Lib0.LockDevice(PlayerRef, Lib1.WTLrestrictiveBoots)
    ElseIf(Mode == 5)
      Lib0.LockDevice(PlayerRef, Lib1.RDLrestrictiveBoots)
    Else
      Debug.Notification("Invalid argument passed")
    EndIf
    Util.DBootsPunishment = true
  ElseIf(Loops == 6) ; Cuffs (Arm)
    If(Mode == 0)
      Lib0.LockDevice(PlayerRef, Lib1.cuffsEboniteArms)
    ElseIf(Mode == 1)
      Lib0.LockDevice(PlayerRef, Lib1.cuffsWTEboniteArms)
    ElseIf(Mode == 2)
      Lib0.LockDevice(PlayerRef, Lib1.cuffsRDEboniteArms)
    ElseIf(Mode == 3)
      Lib0.LockDevice(PlayerRef, Lib0.cuffsLeatherArms)
    ElseIf(Mode == 4)
      Lib0.LockDevice(PlayerRef, Lib1.cuffsWTLeatherArms)
    ElseIf(Mode == 5)
      Lib0.LockDevice(PlayerRef, Lib1.cuffsRDLeatherArms)
    Else
      Debug.Notification("Invalid argument passed")
    EndIf
    If(MCM.bCuffBoth)
      Punishment(7)
    EndIf
  ElseIf(Loops == 7) ; Cuufs (Legs)
    If(Mode == 0)
      Lib0.LockDevice(PlayerRef, Lib1.cuffsEboniteLegs)
    ElseIf(Mode == 1)
      Lib0.LockDevice(PlayerRef, Lib1.cuffsWTEboniteLegs)
    ElseIf(Mode == 2)
      Lib0.LockDevice(PlayerRef, Lib1.cuffsRDEboniteLegs)
    ElseIf(Mode == 3)
      Lib0.LockDevice(PlayerRef, Lib0.cuffsLeatherLegs)
    ElseIf(Mode == 4)
      Lib0.LockDevice(PlayerRef, Lib1.cuffsWTLeatherLegs)
    ElseIf(Mode == 5)
      Lib0.LockDevice(PlayerRef, Lib1.cuffsRDLeatherLegs)
    Else
      Debug.Notification("Invalid argument passed")
    EndIf
    If(MCM.bCuffBoth)
      Punishment(6)
    EndIf
  ElseIf(Loops == 8) ; Ankle Shackles
    Lib0.LockDevice(PlayerRef, Lib1.zadx_AnkleShackles_Black_Inventory)
  ElseIf(Loops == 9) ; Corset
    If(Mode == 0)
      Lib0.LockDevice(PlayerRef, Lib1.EbRestrictiveCorset)
    ElseIf(Mode == 1)
      Lib0.LockDevice(PlayerRef, Lib1.WTErestrictiveCorset)
    ElseIf(Mode == 2)
      Lib0.LockDevice(PlayerRef, Lib1.RDErestrictiveCorset)
    ElseIf(Mode == 3)
      Lib0.LockDevice(PlayerRef, Lib0.corset)
    ElseIf(Mode == 4)
      Lib0.LockDevice(PlayerRef, Lib1.WTLrestrictiveCorset)
    ElseIf(Mode == 5)
      Lib0.LockDevice(PlayerRef, Lib1.RDLrestrictiveCorset)
    Else
      Debug.Notification("Invalid argument passed")
    EndIf
  EndIf
EndFunction

; =========================================================
; =====================   Internals  ======================
; =========================================================
Function Sleep(int TimeSlept)
  float LesPoints = Fatigue.value
	If(PlayerRef.WornHasKeyword(Lib0.zad_DeviousHeavyBondage) || PlayerRef.WornHasKeyword(Lib0.zad_DeviousBelt))
		LesPoints -= (-1.0+(1.3*(Math.pow(2, (0.4*TimeSlept)))))*0.75
	Else
		LesPoints -= (-1.0+(1.3*(Math.pow(2, (0.4*TimeSlept)))))
	EndIf
  If(LesPoints < 0)
    LesPoints = 0
  EndIf
	Fatigue.SetValue(LesPoints)
	;Applying debuf perks..
	GetSleepStage()
endFunction

Bool Function AssignNewJoyFol(Actor newJF, int Lv = 1, int favGem = 77)
  ; just starting some JFDD owned Quests here..
  DDChainEvents.Start()
  DDManualScript.Start()
  Parent.AssignNewJoyFol(newJF, Lv, favGem)
endFunction

Function DismissJoyFol()
  ; closing the JFDD owned Quests agane..!
  DDChainEvents.Stop()
  DDManualScript.Stop()
  Parent.DismissJoyFol()
endFunction

; =========================================================
; ==================   Devious Devices  ===================
; =========================================================
; -------------------- Generic Punishments
;Checking if the Player is still wearing any punishment Devices and if not, let the mod know that the player got rid of it
Function ConsequenceCheck()
    If(Util.DBlindfoldPunishment == true && !PlayerRef.WornHasKeyword(Lib0.zad_DeviousBlindfold))
      Util.DBlindfoldPunishment = false
    ElseIf(Util.DGagPunishment == true && !PlayerRef.WornHasKeyword(Lib0.zad_DeviousGag))
      Util.DGagPunishment = false
    ElseIf(Util.DHeavyBondagePunishment == true && !PlayerRef.WornHasKeyword(Lib0.zad_DeviousHeavyBondage))
      Util.DHeavyBondagePunishment = false
    ElseIf(Util.DGlovesPunishment == true && !PlayerRef.WornHasKeyword(Lib0.zad_DeviousGloves))
      Util.DGlovesPunishment = false
    ElseIf(Util.DBootsPunishment == true && !PlayerRef.WornHasKeyword(Lib0.zad_DeviousBoots))
      Util.DBootsPunishment = false
    EndIf
EndFunction

; -------------------- KeyHolder
; 0 - Blindfold // 1 - Arm Restraints (Heavy bondage) // 2 - Gag //
; 3 - Boots // 4 - Gloves // 5 - Hobble
Function DDUnequip(int type)
  KeyInv.RemKey(2, 1)
	If(Stress.value >= 32 && Utility.RandomInt(1, 100) <= 45)
		If(type == 0)
	    Lib0.JamLock(PlayerRef, Lib0.zad_DeviousBlindfold)
	  ElseIf(type == 1)
	    Lib0.JamLock(PlayerRef, Lib0.zad_DeviousHeavyBondage)
	  ElseIf(type == 2)
	    Lib0.JamLock(PlayerRef, Lib0.zad_DeviousGag)
	  ElseIf(type == 3)
	    Lib0.JamLock(PlayerRef, Lib0.zad_DeviousBoots)
	  ElseIf(type == 4)
	    Lib0.JamLock(PlayerRef, Lib0.zad_DeviousGloves)
		ElseIf(type == 5)
			Keyword this = Lib0.GetDeviceKeyword(Lib0.GetWornDeviceFuzzyMatch(PlayerRef, Lib0.zad_EffectForcedWalk))
			Lib0.JamLock(PlayerRef, this)
	  EndIf
		JFDD_Core_JamLock.Show()
	ElseIf(type == 0)
    Lib0.UnlockDeviceByKeyword(PlayerRef, Lib0.zad_DeviousBlindfold)
  ElseIf(type == 1)
    Lib0.UnlockDeviceByKeyword(PlayerRef, Lib0.zad_DeviousHeavyBondage)
  ElseIf(type == 2)
    Lib0.UnlockDeviceByKeyword(PlayerRef, Lib0.zad_DeviousGag)
  ElseIf(type == 3)
    Lib0.UnlockDeviceByKeyword(PlayerRef, Lib0.zad_DeviousBoots)
  ElseIf(type == 4)
    Lib0.UnlockDeviceByKeyword(PlayerRef, Lib0.zad_DeviousGloves)
	ElseIf(type == 5)
    Lib0.UnlockDeviceByKeyword(PlayerRef, Lib0.zad_DeviousHobbleSkirt)
  EndIf
EndFunction

; -------------------- KeyHunting
Function TieItUp()
  ;Having a loop cycling, with each cycle a new device is equipped
  int Current = 0
  int Mode = MCM.KHColourOption
  If(Mode == 6)
    Mode = Utility.RandomInt(0, 5)
  EndIf
  While(Current < 7)
    If(MCM.KHColourOption == 7)
      Mode = Utility.RandomInt(0, 5)
    EndIf
    If(Current == 0) ;Harness Body
      If(Mode == 0)
        Lib0.LockDevice(PlayerRef, Lib1.eboniteHarnessBody)
      ElseIf(Mode == 1)
        Lib0.LockDevice(PlayerRef, Lib1.wtEboniteHarnessBody)
      ElseIf(Mode == 2)
        Lib0.LockDevice(PlayerRef, Lib1.rdEboniteHarnessBody)
      ElseIf(Mode == 3)
        Lib0.LockDevice(PlayerRef, Lib0.harnessBody)
      ElseIf(Mode == 4)
        Lib0.LockDevice(PlayerRef, Lib1.wtLeatherHarnessBody)
      ElseIf(Mode == 5)
        Lib0.LockDevice(PlayerRef, Lib1.rdLeatherHarnessBody)
      EndIf
    ElseIf(Current == 1) ;Harness Collar
      If(Mode == 0)
        Lib0.LockDevice(PlayerRef, Lib1.eboniteHarnessCollar)
      ElseIf(Mode == 1)
        Lib0.LockDevice(PlayerRef, Lib1.wtEboniteHarnessCollar)
      ElseIf(Mode == 2)
        Lib0.LockDevice(PlayerRef, Lib1.rdEboniteHarnessCollar)
      ElseIf(Mode == 3)
        Lib0.LockDevice(PlayerRef, Lib0.harnessCollar)
      ElseIf(Mode == 4)
        Lib0.LockDevice(PlayerRef, Lib1.wtLeatherHarnessCollar)
      ElseIf(Mode == 5)
        Lib0.LockDevice(PlayerRef, Lib1.rdLeatherHarnessCollar)
      EndIf
    ElseIf(Current == 2) ;Armbinder
      If(Mode == 0)
        Lib0.LockDevice(PlayerRef, Lib1.eboniteArmbinder)
      ElseIf(Mode == 1)
        Lib0.LockDevice(PlayerRef, Lib1.wtEboniteArmbinder)
      ElseIf(Mode == 2)
        Lib0.LockDevice(PlayerRef, Lib1.rdEboniteArmbinder)
      ElseIf(Mode == 3)
        Lib0.LockDevice(PlayerRef, Lib0.armbinder)
      ElseIf(Mode == 4)
        Lib0.LockDevice(PlayerRef, Lib1.wtLeatherArmbinder)
      ElseIf(Mode == 5)
        Lib0.LockDevice(PlayerRef, Lib1.rdLeatherArmbinder)
      EndIf
    ElseIf(Current == 3) ;Harness Ring Gag
      If(Mode == 0)
        Lib0.LockDevice(PlayerRef, Lib1.gagEboniteRing)
      ElseIf(Mode == 1)
        Lib0.LockDevice(PlayerRef, Lib1.gagWTEboniteRing)
      ElseIf(Mode == 2)
        Lib0.LockDevice(PlayerRef, Lib1.gagRDEboniteRing)
      ElseIf(Mode == 3)
        Lib0.LockDevice(PlayerRef, Lib0.gagRing)
      ElseIf(Mode == 4)
        Lib0.LockDevice(PlayerRef, Lib1.gagWTLeatherRing)
      ElseIf(Mode == 5)
        Lib0.LockDevice(PlayerRef, Lib1.gagRDLeatherRing)
      EndIf
    ElseIf(Current == 4) ;Blindfold
      If(Mode == 0)
        Lib0.LockDevice(PlayerRef, Lib1.EbblindfoldBlocking)
      ElseIf(Mode == 1)
        Lib0.LockDevice(PlayerRef, Lib1.WTEblindfoldBlocking)
      ElseIf(Mode == 2)
        Lib0.LockDevice(PlayerRef, Lib1.RDEblindfoldBlocking)
      ElseIf(Mode == 3)
        Lib0.LockDevice(PlayerRef, Lib1.blindfoldBlocking)
      ElseIf(Mode == 4)
        Lib0.LockDevice(PlayerRef, Lib1.WTLblindfoldBlocking)
      ElseIf(Mode == 5)
        Lib0.LockDevice(PlayerRef, Lib1.RDLblindfoldBlocking)
      EndIf
    ElseIf(Current == 5) ;Pony Boots
      If(Mode == 0)
        Lib0.LockDevice(PlayerRef, Lib1.EbonitePonyBoots)
      ElseIf(Mode == 1)
        Lib0.LockDevice(PlayerRef, Lib1.WTEbonitePonyBoots)
      ElseIf(Mode == 2)
        Lib0.LockDevice(PlayerRef, Lib1.RDEbonitePonyBoots)
      ElseIf(Mode == 3)
        Lib0.LockDevice(PlayerRef, Lib1.PonyBoots)
      ElseIf(Mode == 4)
        Lib0.LockDevice(PlayerRef, Lib1.WTLeatherPonyBoots)
      ElseIf(Mode == 5)
        Lib0.LockDevice(PlayerRef, Lib1.RDLeatherPonyBoots)
      EndIf
    Else ;Tail
      int P = Utility.RandomInt(0, 1)
      If(P == 0)
        Lib0.LockDevice(PlayerRef, Lib1.zadx_HR_PlugPonyTail01Inventory)
      Else
        Lib0.LockDevice(PlayerRef, Lib1.zadx_HR_PlugPonyTail03Inventory)
      EndIf
    EndIf
    Current += 1
  EndWhile
EndFunction

Function UntieIt()
  Lib0.UnlockDeviceByKeyword(PlayerRef, Lib0.zad_DeviousHarness, true)
  Lib0.UnlockDeviceByKeyword(PlayerRef, Lib0.zad_DeviousCollar, true)
  Lib0.UnlockDeviceByKeyword(PlayerRef, Lib0.zad_DeviousHeavyBondage, true)
  Lib0.UnlockDeviceByKeyword(PlayerRef, Lib0.zad_DeviousGag, true)
  Lib0.UnlockDeviceByKeyword(PlayerRef, Lib0.zad_DeviousBlindfold, true)
  Lib0.UnlockDeviceByKeyword(PlayerRef, Lib0.zad_DeviousBoots, true)
  Lib0.UnlockDeviceByKeyword(PlayerRef, Lib0.zad_DeviousPlugAnal, true)
EndFunction

; -------------------- Punishment Games
; -------- ShutUp
Function ShutUp(bool Starting)
  If(Starting == true)
    Lib0.LockDevice(PlayerRef, Lib1.zadx_GagEboniteHarnessBallBig_Inventory, true)
  Else
    Lib0.UnlockDevice(PlayerRef, Lib1.zadx_GagEboniteHarnessBallBig_Inventory, none, Lib0.zad_DeviousGag, true)
  EndIf
EndFunction

; -------- PetCollar
Function PetCollar(bool Starting, Actor Vic)
  ;Armor PetCollarRen = Game.GetFormFromFile(0x00021D62, "PetCollar.esp") as Armor
  Armor PetCollarInv = Game.GetFormFromFile(0x00007929, "PetCollar.esp") as Armor
  If(Starting == true)
    Lib0.LockDevice(Vic, PetCollarInv, true)
  Else
    Lib0.RemoveDevice(Vic, PetCollarInv, none, Lib0.zad_DeviousCollar, true)
  EndIf
EndFunction

Function PCMService(int Variant)
  PetCollarConfigScript PCM = Quest.GetQuest("PetCollarConfig") as PetCollarConfigScript
  ;Storing original variable
  StoredArmorType = PCM.armorRestrictionType
  StoredService = PCM.teammatesAllowPublicService
  StoredArousal = PCM.arousalThreshold
  ;Armor Restriction
  PCM.armorRestrictionType = 3
  If(Variant == 0) ;Public Service
    PCM.teammatesAllowPublicService = true
    If(PCM.arousalThreshold == -1)
      PCM.arousalThreshold = MCM.JFArousal.GetValue() as int
    EndIf
  ElseIf(Variant == 1) ;JoyFol only
    PCM.teammatesAllowPublicService = false
    If(PCM.arousalThreshold == -1)
      PCM.arousalThreshold = MCM.JFArousal.GetValue() as int
    EndIf
  ElseIf(Variant == 2) ;No one
    PCM.arousalThreshold = -1
  EndIf
EndFunction

Function PCMReset()
  PetCollarConfigScript PCM = Quest.GetQuest("PetCollarConfig") as PetCollarConfigScript

  PCM.teammatesAllowPublicService = StoredService
  PCM.arousalThreshold = StoredArousal
  PCM.armorRestrictionType = StoredArmorType
EndFunction

; ------------------- Misc
Function Moan()
  Lib0.Moan(PlayerRef)
EndFunction

; =========================================================
; =======================   SexLab  =======================
; =========================================================
; Overriding all SL Calls and use DDs Anim Filter instead .. sigh
; --------- SL StartSex Follower / Player
; Consensual
Function StartSexPF(string tags)
  bool aggressive = false
  Actor[] JP = new Actor[2]
  If(SL.GetGender(PlayerRef) == 1)
    JP[0] = PlayerRef
    JP[1] = JoyFol
  Else
    JP[0] = JoyFol
    JP[1] = PlayerRef
  EndIf
	If (SL.GetGender(PlayerRef) == 1) && (SL.GetGender(JoyFol) == 1)
    If(!Lib0.StartValidDDAnimation(JP, includetag = tags + "ff"))
      sslBaseAnimation[] PFAnims = Lib0.SelectValidDDAnimations(JP, 2)
      SL.StartSex(JP, PFAnims)
    endIf
  Else
    If(!Lib0.StartValidDDAnimation(JP, includetag = tags))
      sslBaseAnimation[] PFAnims = Lib0.SelectValidDDAnimations(JP, 2)
      SL.StartSex(JP, PFAnims)
    endIf
  EndIf
EndFunction

; Function to start Oral animations only
Function StartOralPF(bool PlayerIsTaker, actor victim = none)
  Actor[] JP = new Actor[2]
	If(PlayerIsTaker == true)
    JP[0] = PlayerRef
    JP[1] = JoyFol
  Else
    JP[0] = JoyFol
    JP[1] = PlayerRef
  EndIf
  If (SL.GetGender(PlayerRef) == 1) && (SL.GetGender(JoyFol) == 1)
    If(!Lib0.StartValidDDAnimation(JP, includetag = "oral, ff", suppresstag = "anal, vaginal"))
      sslBaseAnimation[] PFAnims = Lib0.SelectValidDDAnimations(JP, 2)
      SL.StartSex(JP, PFAnims)
    endIf
  Else
    If(!Lib0.StartValidDDAnimation(JP, includetag = "oral", suppresstag = "anal, vaginal"))
      sslBaseAnimation[] PFAnims = Lib0.SelectValidDDAnimations(JP, 2)
      SL.StartSex(JP, PFAnims)
    endIf
  endIf
EndFunction

; True = Player  // Start Rape between Follower & player
Function StartSexForcedPF(bool PlayerVic, string Tags = "")
  Actor[] JP = new Actor[2]
  Actor Victim
  If(PlayerVic == true)
    JP[0] = PlayerRef
    JP[1] = JoyFol
    Victim = PlayerRef
  Else
    JP[0] = JoyFol
    JP[1] = PlayerRef
    Victim = JoyFol
  EndIf
  If(!Lib0.StartValidDDAnimation(JP, true, tags, Victim = Victim))
    sslBaseAnimation[] PFAnims = Lib0.SelectValidDDAnimations(JP, 2)
    SL.StartSex(JP, PFAnims, Victim = Victim)
  endIf
EndFunction

; ---------- "Searching in the Wild" Sex Scenes
Function StartSexStolen(Actor Partner, string Tags = "")
	Actor[] JP = New Actor[2]
	JP[0] = PlayerRef
	JP[1] = Partner
  If(!Lib0.StartValidDDAnimation(JP, includetag = tags, hook = "StolenSex"))
    sslBaseAnimation[] PFAnims = Lib0.SelectValidDDAnimations(JP, 2)
    SL.StartSex(JP, PFAnims, Hook = "StolenSex")
  endIf
	RegisterForModEvent("HookAnimationEnding_StolenSex", "StolenAfterSex")
EndFunction

; ---------- KeyHunting
Function StartSexKeyHunter(Actor Giver, int Consent = 0)
	Actor[] JP = New Actor[2]
	JP[0] = PlayerRef
	JP[1] = Giver
	If(Consent == 0) ;Consent for Info
    If(!Lib0.StartValidDDAnimation(JP, false, Hook = "KeyHunter"))
      sslBaseAnimation[] PFAnims = Lib0.SelectValidDDAnimations(JP, 2)
      SL.StartSex(JP, PFAnims, Hook = "KeyHunter")
    endIf
		RegisterForModEvent("HookAnimationEnding_KeyHunter", "KeyHuntAfterSex")
	ElseIf(Consent == 1) ;Consent for Key
    If(!Lib0.StartValidDDAnimation(JP, false, Hook = "KeyHunter"))
      sslBaseAnimation[] PFAnims = Lib0.SelectValidDDAnimations(JP, 2)
      SL.StartSex(JP, PFAnims, Hook = "KeyHunter")
    endIf
		RegisterForModEvent("HookAnimationEnding_KeyHunter", "KeyHuntClose")
	Else ;Rape
    If(!Lib0.StartValidDDAnimation(JP, false, Victim = PlayerRef))
      sslBaseAnimation[] PFAnims = Lib0.SelectValidDDAnimations(JP, 2)
      SL.StartSex(JP, PFAnims, Victim = PlayerRef)
    endIf
	EndIf
EndFunction

;Consent for Info
Event KeyHuntAfterSex(int tid, bool HasPlayer)
	sslThreadController Thread = SL.GetController(tid)
	Actor[] Acteurs = Thread.Positions
	If(Acteurs[1] != PlayerRef)
		KH_Giver.ForceRefTo(Acteurs[1])
	Else
		KH_Giver.ForceRefTo(Acteurs[0])
	EndIf
	Utility.Wait(2)
	KH_Paid.Start()
	UnregisterForModEvent("HookAnimationEnding_KeyHunter")
EndEvent

;Consent for Key
Event KeyHuntClose(int tid, bool HasPlayer)
	Utility.Wait(2)
	KH_Served.Start()
	UnregisterForModEvent("HookAnimationEnding_KeyHunter")
EndEvent

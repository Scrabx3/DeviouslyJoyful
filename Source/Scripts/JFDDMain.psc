Scriptname JFDDMain extends Quest Conditional

JFDDMCM Property MCM Auto

zadLibs Property Lib0 Auto
zadxLibs Property Lib1 Auto
zadxLibs2 Property Lib2 Auto

JFDDKeyInv Property KeyInventory Auto

JFDDMain Function Get() global
  return Quest.GetQuest("JFDD_Main") as JFDDMain
EndFunction

; =========================================================
; ==================   Devious Devices  ===================
; =========================================================
int Property BlindfoldIdx     = 0 AutoReadOnly
int Property HeavyBondageIdx  = 1 AutoReadOnly
int Property GagIdx           = 2 AutoReadOnly
int Property GlovesIdx        = 3 AutoReadOnly
int Property BootsIdx         = 4 AutoReadOnly
int Property HobbleSkirtIdx   = 5 AutoReadOnly
int Property CuffsArmidx      = 6 AutoReadOnly
int Property CuffsLegIdx      = 7 AutoReadOnly
int Property AnkleShacklesIdx = 8 AutoReadOnly
int Property CorsetIdx        = 9 AutoReadOnly

bool Property PunishmentBlindfold     = false Auto Hidden Conditional
bool Property PunishmentHeavyBondage  = false Auto Hidden Conditional
bool Property PunishmentGag           = false Auto Hidden Conditional
bool Property PunishmentGloves        = false Auto Hidden Conditional
bool Property PunishmentBoots         = false Auto Hidden Conditional

; -------------------- Generic
Keyword Function GetDDKeywordByType(int aiType)
  Keyword[] k = new Keyword[10]
  k[0] = Lib0.zad_DeviousBlindfold
  k[1] = Lib0.zad_DeviousHeavyBondage
  k[2] = Lib0.zad_DeviousGag
  k[3] = Lib0.zad_DeviousBoots
  k[4] = Lib0.zad_DeviousGloves
  k[5] = Lib0.zad_DeviousHobbleSkirt
  k[6] = Lib0.zad_DeviousLegCuffs
  k[7] = Lib0.zad_DeviousArmCuffs
  k[8] = Lib0.zad_DeviousAnkleShackles
  k[9] = Lib0.zad_DeviousCorset
  return k[aiType]
EndFunction

Function RemoveDD(Actor akTarget, int aiType)
  Lib0.UnlockDeviceByKeyword(akTarget, GetDDKeywordByType(aiType))
EndFunction

; This used to be a 200 line function \o/
Function CreatePunishment(int aiType = -1)
  If(aiType == -1)
    aiType = JFMain.GetFromWeight(MCM.iDeviceWeights)
    If(aiType < HobbleSkirtIdx)
      aiType -= 1
    EndIf
  EndIf
  Armor device = Lib0.GetGenericDeviceByKeyword(GetDDKeywordByType(aiType))
  Lib0.LockDevice(Game.GetPlayer(), device)
  If(aiType == BlindfoldIdx)
    PunishmentBlindfold = true
  ElseIf(aiType == HeavyBondageIdx)
    PunishmentHeavyBondage = true
  ElseIf(aiType == GagIdx)
    PunishmentGag = true
  ElseIf(aiType == GlovesIdx)
    PunishmentGloves = true
  ElseIf(aiType == BootsIdx)
    PunishmentBoots = true
  EndIf
EndFunction

; -------------------- Events
; -------- Shopping Post - Rubber Suit
Function EquipRubberSuit(Actor akTarget, int aiColor = -1)
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

; -------- Event - Key Hunting
Function KeyHuntingStart()
  Actor Player = Game.GetPlayer()
  Armor[] devices = new Armor[36]
  devices[0] = Lib1.eboniteHarnessBody
  devices[1] = Lib1.wtEboniteHarnessBody
  devices[2] = Lib1.rdEboniteHarnessBody
  devices[3] = Lib0.harnessBody
  devices[4] = Lib1.wtLeatherHarnessBody
  devices[5] = Lib1.rdLeatherHarnessBody

  devices[6] = Lib1.eboniteHarnessCollar
  devices[7] = Lib1.wtEboniteHarnessCollar
  devices[8] = Lib1.rdEboniteHarnessCollar
  devices[9] = Lib0.harnessCollar
  devices[10] = Lib1.wtLeatherHarnessCollar
  devices[11] = Lib1.rdLeatherHarnessCollar

  devices[12] = Lib1.eboniteArmbinder
  devices[13] = Lib1.wtEboniteArmbinder
  devices[14] = Lib1.rdEboniteArmbinder
  devices[15] = Lib0.armbinder
  devices[16] = Lib1.wtLeatherArmbinder
  devices[17] = Lib1.rdLeatherArmbinder

  devices[18] = Lib1.gagEboniteRing
  devices[19] = Lib1.gagWTEboniteRing
  devices[20] = Lib1.gagRDEboniteRing
  devices[21] = Lib0.gagRing
  devices[22] = Lib1.gagWTLeatherRing
  devices[23] = Lib1.gagRDLeatherRing

  devices[24] = Lib1.EbblindfoldBlocking
  devices[25] = Lib1.WTEblindfoldBlocking
  devices[26] = Lib1.RDEblindfoldBlocking
  devices[27] = Lib1.blindfoldBlocking
  devices[28] = Lib1.WTLblindfoldBlocking
  devices[29] = Lib1.RDLblindfoldBlocking

  devices[30] = Lib1.EbonitePonyBoots
  devices[31] = Lib1.WTEbonitePonyBoots
  devices[32] = Lib1.RDEbonitePonyBoots
  devices[33] = Lib1.PonyBoots
  devices[34] = Lib1.WTLeatherPonyBoots
  devices[35] = Lib1.RDLeatherPonyBoots

  int color = MCM.iPrefDeviceColor
  If(color == 6)
    color = Utility.RandomInt(0, 5)
  EndIf
  int i = 0
  While(i < 6)
    If(MCM.iPrefDeviceColor == 7)
      color = Utility.RandomInt(0, 5)
    EndIf
    Lib0.LockDevice(Player, devices[i * 6 + color])
    i += 1
  EndWhile
  int tail = Utility.RandomInt(0, 2)
  If(tail == 0)
    Lib0.LockDevice(Player, Lib1.zadx_HR_PlugPonyTail01Inventory)
  ElseIf(tail == 2)
    Lib0.LockDevice(Player, Lib1.zadx_HR_PlugPonyTail03Inventory)
  EndIf
EndFunction

Function KeyHuntingEnd()
  Actor PlayerRef = Game.GetPlayer()
  Lib0.UnlockDeviceByKeyword(PlayerRef, Lib0.zad_DeviousHarness, true)
  Lib0.UnlockDeviceByKeyword(PlayerRef, Lib0.zad_DeviousCollar, true)
  Lib0.UnlockDeviceByKeyword(PlayerRef, Lib0.zad_DeviousHeavyBondage, true)
  Lib0.UnlockDeviceByKeyword(PlayerRef, Lib0.zad_DeviousGag, true)
  Lib0.UnlockDeviceByKeyword(PlayerRef, Lib0.zad_DeviousBlindfold, true)
  Lib0.UnlockDeviceByKeyword(PlayerRef, Lib0.zad_DeviousBoots, true)
  Lib0.UnlockDeviceByKeyword(PlayerRef, Lib0.zad_DeviousPlugAnal, true)
EndFunction

; =========================================================
; =======================   SEXLAB  =======================
; =========================================================

Actor[] Function ActorArray(Actor akPos1, Actor akPos2 = none, Actor akPos3 = none, Actor akPos4 = none, Actor akPos5 = none) global
  Actor[] ret = new Actor[5]
  ret[0] = akPos1
  ret[1] = akPos2
  ret[2] = akPos3
  ret[3] = akPos4
  ret[4] = akPos5
  return PapyrusUtil.RemoveActor(ret, none)
EndFunction

bool Function StartSexDD(Actor[] array, String asTags = "", String asTagSuppress = "", Actor akVictim = none, String asHook = "") global
  Debug.Trace("[JFDD] Scene called with Actors " + array + " >> hook = " + asHook)
  int v = JFAnimStarter.ValidateArray(array)
  If(v > -1)
    Debug.Trace("[JF] Actor at " + v + "(" + array[v] + ") is invalid, aborting", 2)
    return -1
  EndIf
  SexLabFramework SL = SexLabUtil.GetAPI()
  If(array.Length == 2)
    ; add ff tag if a consent lesbian animation
    If(!akVictim && SL.GetGender(array[0]) == 1 && SL.GetGender(array[1]) == 1)
      asTags += "ff"
    EndIf
  EndIf
  return Get().Lib0.StartValidDDAnimation(array, akVictim != none, asTags, asTagSuppress, akVictim, akVictim == none, asHook)
EndFunction

Scriptname JFDDMCM extends JFMCMPage

; ---------------------------- Vars

string[] DeviceColors
int Property iPrefDeviceColor = 6 Auto Hidden
; -- Punishments
int[] Property iDeviceWeights Auto Hidden
{Blindfold | Gag | Heavy Bond. | Cuffs Arm | Cuffs Leg | Ankle | Corset | Rubber Gloves | Rubber Boots}
; -- Games
GlobalVariable Property ShutUp_Var Auto ; Shut Up Event Duration
bool Property bPetCollarEnab = false Auto Hidden Conditional
GlobalVariable Property PetCollar_Var Auto  ; Pet Collar Event Duration
; -- Key Holder
bool Property bKHEnabled = true Auto Hidden
float Property fKHFreq = 1.0 Auto Hidden
float Property fKHChance = 15.0 Auto Hidden
int Property iKHMaxKeys = 4 Auto Hidden
bool Property bKHNotify = false Auto Hidden
int[] Property iKHTypes Auto Hidden
{Restraint | Chastity | Piercing}

; ------ Internal
bool bPetCollarLoaded = false

; ---------------------------- Menu
Function OnGameLoad()
	If(Quest.GetQuest("PetCollarConfig") != none)
		bPetCollarLoaded = true
	else
		bPetCollarLoaded = false
		bPetCollarEnab = false
	endIf
EndFunction

Function InitializePage()
	_PageName = "Deviously Joyful"

	DeviceColors = new string[8]
	DeviceColors[0] = "$DeviceColor_0"
	DeviceColors[1] = "$DeviceColor_1"
	DeviceColors[2] = "$DeviceColor_2"
	DeviceColors[3] = "$DeviceColor_3"
	DeviceColors[4] = "$DeviceColor_4"
	DeviceColors[5] = "$DeviceColor_5"
	DeviceColors[6] = "$DeviceColor_6"
	DeviceColors[7] = "$DeviceColor_7"

  iDeviceWeights = new int[9]
  iDeviceWeights[0] = 50  ; Blindfold
  iDeviceWeights[1] = 20  ; HeavyBondage
  iDeviceWeights[2] = 50  ; Gag
  iDeviceWeights[3] = 65  ; Gloves
  iDeviceWeights[4] = 65  ; Boots
  iDeviceWeights[5] = 75  ; CuffsArm
  iDeviceWeights[6] = 75  ; CuffsLeg
  iDeviceWeights[7] = 30  ; AnkleShackles
  iDeviceWeights[8] = 40  ; Corset

  iKHTypes = new int[3]
  iKHTypes[0] = 85
  iKHTypes[1] = 40
  iKHTypes[2] = 25
EndFunction

Function OnPageReset()
  AddHeaderOption("$DJF_General")
  AddMenuOptionST("djfprefcolor", "$DJF_PrefDeviceColor", DeviceColors[iPrefDeviceColor])
  AddEmptyOption()
  int i = 0
  While(i < iDeviceWeights.Length)
    AddSliderOptionST("device_" + i, "$DJF_DeviceType_" + i, iDeviceWeights[i], "{0}")
    i += 1
  EndWhile

  AddHeaderOption("$JDF_MiscEvents")
  AddSliderOptionST("shutupdur", "$DJF_ShutUpDuration", ShutUp_Var.Value, "{1}h")
  AddEmptyOption()
  AddToggleOptionST("petcollarenab", "$DJF_PetCollarEnab", bPetCollarEnab, getFlag(bPetCollarLoaded))
  AddSliderOptionST("petcollardur", "$DJF_PetCollarDuration", PetCollar_Var.Value, "{1}h", getFlag(bPetCollarLoaded))

  SetCursorPosition(1)
  AddHeaderOption("$DJF_KeyHolder")
  AddToggleOptionST("khenabled", "$DJF_KHEnabled", bKHEnabled)
  AddSliderOptionST("khfrequency", "$DJF_KHFrequency", fKHFreq, "{2}h")
  AddSliderOptionST("khchance", "$DJF_KHChance", fKHChance, "{1}%")
  AddSliderOptionST("khmaxkeys", "$DJF_KHMaxKeys", iKHMaxKeys, "{0}")
  AddToggleOptionST("khnotify", "$DJF_KHNotify", bKHNotify)
  AddEmptyOption()
  int n = 0
  While(n < iKHTypes.Length)
    AddSliderOptionST("khtype_" + n, "$DJF_KHType_" + n, iKHTypes[n], "{0}")
    n += 1
  EndWhile
EndFunction

Event OnSelectST()
	String[] op = PapyrusUtil.StringSplit(GetState(), "_")
	If(op[0] == "petcollarenab")
    bPetCollarEnab = !bPetCollarEnab
    SetToggleOptionValueST(bPetCollarEnab)
  ElseIf(op[0] == "khenabled")
    bKHEnabled = !bKHEnabled
    SetToggleOptionValueST(bKHEnabled)
  ElseIf(op[0] == "khnotify")
    bKHNotify = !bKHNotify
    SetToggleOptionValueST(bKHNotify)
  EndIf
EndEvent

Event OnSliderOpenST()
	String[] op = PapyrusUtil.StringSplit(GetState(), "_")
  If(op[0] == "device")
    int i = op[1] as int
		SetSliderDialogStartValue(iDeviceWeights[i])
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(5)
	ElseIf(op[0] == "shutupdur")
		SetSliderDialogStartValue(ShutUp_Var.Value)
		SetSliderDialogDefaultValue(12)
		SetSliderDialogRange(6, 48)
		SetSliderDialogInterval(0.5)
  ElseIf(op[0] == "petcollardur")
		SetSliderDialogStartValue(PetCollar_Var.Value)
		SetSliderDialogDefaultValue(12)
		SetSliderDialogRange(6, 48)
		SetSliderDialogInterval(0.5)
  ElseIf(op[0] == "khfrequency")
		SetSliderDialogStartValue(fKHFreq)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(0.25, 6)
		SetSliderDialogInterval(0.25)
  ElseIf(op[0] == "khchance")
		SetSliderDialogStartValue(fKHChance)
		SetSliderDialogDefaultValue(15)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(0.5)
  ElseIf(op[0] == "khmaxkeys")
		SetSliderDialogStartValue(iKHMaxKeys)
		SetSliderDialogDefaultValue(4)
		SetSliderDialogRange(0, 9)
		SetSliderDialogInterval(1)
  ElseIf(op[0] == "khtype")
    int i = op[1] as int
		SetSliderDialogStartValue(iKHTypes[i])
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(5)
  EndIf
EndEvent

Event OnSliderAcceptST(Float afValue)
	String[] op = PapyrusUtil.StringSplit(GetState(), "_")
  If(op[0] == "device")
    int i = op[1] as int
		iDeviceWeights[i] = afValue as int
		SetSliderOptionValueST(afValue, "{0ß}")
	ElseIf(op[0] == "shutupdur")
		ShutUp_Var.Value = afValue
		SetSliderOptionValueST(afValue, "{1}h")
	ElseIf(op[0] == "petcollardur")
		PetCollar_Var.Value = afValue
		SetSliderOptionValueST(afValue, "{1}h")
	ElseIf(op[0] == "khfrequency")
		fKHFreq = afValue
		SetSliderOptionValueST(afValue, "{2}h")
	ElseIf(op[0] == "khchance")
		fKHChance = afValue
		SetSliderOptionValueST(afValue, "{1}%")
	ElseIf(op[0] == "khmaxkeys")
		iKHMaxKeys = afValue as int
		SetSliderOptionValueST(afValue, "{0}")
	ElseIf(op[0] == "khtype")
    int i = op[1] as int
		iKHTypes[i] = afValue as int
		SetSliderOptionValueST(afValue, "{0}")
  EndIf
EndEvent

Event OnMenuOpenST()
	String[] op = PapyrusUtil.StringSplit(GetState(), "_")
	If(op[0] == "djfprefcolor")
		SetMenuDialogStartIndex(iPrefDeviceColor)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(DeviceColors)
	EndIf
EndEvent

Event OnMenuAcceptST(Int aiIndex)
	String[] op = PapyrusUtil.StringSplit(GetState(), "_")
	If(op[0] == "djfprefcolor")
		iPrefDeviceColor = aiIndex
		SetMenuOptionValueST(DeviceColors[iPrefDeviceColor])
	EndIf
EndEvent

Event OnHighlightST()
	String[] op = PapyrusUtil.StringSplit(GetState(), "_")
  If(op[0] == "device")
    SetInfoText("$DJF_DeviceTypeHighlight")
	ElseIf(op[0] == "shutupdur")
		SetInfoText("$DJF_ShutUpDurationHighlight")
	ElseIf(op[0] == "petcollarenab")
		SetInfoText("$DJF_PetCollarEnabHighlight")
	ElseIf(op[0] == "petcollardur")
		SetInfoText("$DJF_PetCollarDurationHighlight")
	ElseIf(op[0] == "khenabled")
		SetInfoText("$DJF_KHEnabledHighlight")
	ElseIf(op[0] == "khfrequency")
		SetInfoText("$DJF_KHFrequencyHighlight")
	ElseIf(op[0] == "khchance")
		SetInfoText("$DJF_KHChanceHighlight")
	ElseIf(op[0] == "khmaxkeys")
		SetInfoText("$DJF_KHMaxKeysHighlight")
	ElseIf(op[0] == "khnotify")
		SetInfoText("$DJF_KHNotifyHighlight")
	ElseIf(op[0] == "khtype_")
    int i = op[1] as int
		SetInfoText("$DJF_KHTypeHighlight_" + i)
  EndIf
EndEvent

; -----

int Function getFlag(bool option)
	If(option)
		return OPTION_FLAG_NONE
  Else
		return OPTION_FLAG_DISABLED
	EndIf
endFunction

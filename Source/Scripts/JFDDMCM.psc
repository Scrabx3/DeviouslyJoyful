Scriptname JFDDMCM extends jfmcmaddonpage  

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
bool Function OnGameLoad()
	If(Quest.GetQuest("PetCollarConfig") != none)
		bPetCollarLoaded = true
	else
		bPetCollarLoaded = false
		bPetCollarEnab = false
	endIf
  return Parent.OnGameLoad()
EndFunction

Function InitializePage()
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
  iDeviceWeights[1] = 50  ; Gag
  iDeviceWeights[2] = 20  ; Heavy
  iDeviceWeights[3] = 80  ; Cuffs Arm
  iDeviceWeights[4] = 80  ; Cuffs Leg
  iDeviceWeights[5] = 70  ; Ankle
  iDeviceWeights[6] = 70  ; Corset
  iDeviceWeights[7] = 40  ; Rubber Gloves
  iDeviceWeights[8] = 40  ; Rubber Boots

  iKHTypes = new int[3]
  iKHTypes[0] = 85
  iKHTypes[1] = 40
  iKHTypes[2] = 25
EndFunction

Function OnPageCalled()
  _JFMCM.AddHeaderOption("$DJF_General")
  _JFMCM.AddMenuOptionST("djfprefcolor", "$DJF_PrefDeviceColor", DeviceColors[iPrefDeviceColor])
  _JFMCM.AddEmptyOption()
  int i = 0
  While(i < iDeviceWeights.Length)
    _JFMCM.AddSliderOptionST("device_" + i, "$DJF_DeviceType_" + i, iDeviceWeights[i], "{0}")
    i += 1
  EndWhile

  _JFMCM.AddHeaderOption("$JDF_MiscEvents")
  _JFMCM.AddSliderOptionST("shutupdur", "$DJF_ShutUpDuration", ShutUp_Var.Value, "{1}h")
  _JFMCM.AddEmptyOption()
  _JFMCM.AddToggleOptionST("petcollarenab", "$DJF_PetCollarEnab", bPetCollarEnab, getFlag(bPetCollarLoaded))
  _JFMCM.AddSliderOptionST("petcollardur", "$DJF_PetCollarDuration", PetCollar_Var.Value, "{1}h", getFlag(bPetCollarLoaded))

  _JFMCM.SetCursorPosition(1)
  _JFMCM.AddHeaderOption("$DJF_KeyHolder")
  _JFMCM.AddToggleOptionST("khenabled", "$DJF_KHEnabled", bKHEnabled)
  _JFMCM.AddSliderOptionST("khfrequency", "$DJF_KHFrequency", fKHFreq, "{2}h")
  _JFMCM.AddSliderOptionST("khchance", "$DJF_KHChance", fKHChance, "{1}%")
  _JFMCM.AddSliderOptionST("khmaxkeys", "$DJF_KHMaxKeys", iKHMaxKeys, "{0}")
  _JFMCM.AddToggleOptionST("khnotify", "$DJF_KHNotify", bKHNotify)
  _JFMCM.AddEmptyOption()
  int n = 0
  While(n < iKHTypes.Length)
    _JFMCM.AddSliderOptionST("khtype_" + i, "$DJF_KHType_" + i, iKHTypes[i], "{0}")
    n += 1
  EndWhile
EndFunction

Event OnSelectST()
	String[] op = PapyrusUtil.StringSplit(GetState(), "_")
	If(op[0] == "petcollarenab")
    bPetCollarEnab != bPetCollarEnab
    _JFMCM.SetToggleOptionValueST(bPetCollarEnab)
  ElseIf(op[0] == "khenabled")
    bKHEnabled != bKHEnabled
    _JFMCM.SetToggleOptionValueST(bKHEnabled)
  ElseIf(op[0] == "khnotify")
    bKHNotify != bKHNotify
    _JFMCM.SetToggleOptionValueST(bKHNotify)
  EndIf
EndEvent

Event OnSliderOpenST()
	String[] op = PapyrusUtil.StringSplit(GetState(), "_")
  If(op[0] == "device")
    int i = op[1] as int
		_JFMCM.SetSliderDialogStartValue(iDeviceWeights[i])
		_JFMCM.SetSliderDialogDefaultValue(50)
		_JFMCM.SetSliderDialogRange(0, 100)
		_JFMCM.SetSliderDialogInterval(5)
	ElseIf(op[0] == "shutupdur")
		_JFMCM.SetSliderDialogStartValue(ShutUp_Var.Value)
		_JFMCM.SetSliderDialogDefaultValue(12)
		_JFMCM.SetSliderDialogRange(6, 48)
		_JFMCM.SetSliderDialogInterval(0.5)
  ElseIf(op[0] == "petcollardur")
		_JFMCM.SetSliderDialogStartValue(PetCollar_Var.Value)
		_JFMCM.SetSliderDialogDefaultValue(12)
		_JFMCM.SetSliderDialogRange(6, 48)
		_JFMCM.SetSliderDialogInterval(0.5)
  ElseIf(op[0] == "khfrequency")
		_JFMCM.SetSliderDialogStartValue(fKHFreq)
		_JFMCM.SetSliderDialogDefaultValue(1)
		_JFMCM.SetSliderDialogRange(0.25, 4)
		_JFMCM.SetSliderDialogInterval(0.25)
  ElseIf(op[0] == "khchance")
		_JFMCM.SetSliderDialogStartValue(fKHChance)
		_JFMCM.SetSliderDialogDefaultValue(15)
		_JFMCM.SetSliderDialogRange(0, 100)
		_JFMCM.SetSliderDialogInterval(0.5)
  ElseIf(op[0] == "khmaxkeys")
		_JFMCM.SetSliderDialogStartValue(iKHMaxKeys)
		_JFMCM.SetSliderDialogDefaultValue(4)
		_JFMCM.SetSliderDialogRange(0, 9)
		_JFMCM.SetSliderDialogInterval(1)
  ElseIf(op[0] == "khtype")
    int i = op[1] as int
		_JFMCM.SetSliderDialogStartValue(iKHTypes[i])
		_JFMCM.SetSliderDialogDefaultValue(50)
		_JFMCM.SetSliderDialogRange(0, 100)
		_JFMCM.SetSliderDialogInterval(5)
  EndIf
EndEvent

Event OnSliderAcceptST(Float afValue)
	String[] op = PapyrusUtil.StringSplit(GetState(), "_")
  If(op[0] == "device")
    int i = op[1] as int
		iDeviceWeights[i] = afValue as int
		_JFMCM.SetSliderOptionValueST(afValue, "{1}h")
	ElseIf(op[0] == "shutupdur")
		ShutUp_Var.Value = afValue
		_JFMCM.SetSliderOptionValueST(afValue, "{1}h")
	ElseIf(op[0] == "petcollardur")
		PetCollar_Var.Value = afValue
		_JFMCM.SetSliderOptionValueST(afValue, "{1}h")
	ElseIf(op[0] == "khfrequency")
		fKHFreq = afValue
		_JFMCM.SetSliderOptionValueST(afValue, "{2}h")
	ElseIf(op[0] == "khchance")
		fKHChance = afValue
		_JFMCM.SetSliderOptionValueST(afValue, "{1}%")
	ElseIf(op[0] == "khmaxkeys")
		iKHMaxKeys = afValue as int
		_JFMCM.SetSliderOptionValueST(afValue, "{0}")
	ElseIf(op[0] == "khtype")
    int i = op[1] as int
		iKHTypes[i] = afValue as int
		_JFMCM.SetSliderOptionValueST(afValue, "{0}")
  EndIf
EndEvent

Event OnHighlightST()
	String[] op = PapyrusUtil.StringSplit(GetState(), "_")
  If(op[0] == "device")
    _JFMCM.SetInfoText("$DJF_DeviceTypeHighlight")
	ElseIf(op[0] == "shutupdur")
		_JFMCM.SetInfoText("$DJF_ShutUpDurationHighlight")
	ElseIf(op[0] == "petcollarenab")
		_JFMCM.SetInfoText("$DJF_PetCollarEnabHighlight")
	ElseIf(op[0] == "petcollardur")
		_JFMCM.SetInfoText("$DJF_PetCollarDurationHighlight")
	ElseIf(op[0] == "khenabled")
		_JFMCM.SetInfoText("$DJF_KHEnabled")
	ElseIf(op[0] == "khfrequency")
		_JFMCM.SetInfoText("$DJF_KHFrequency")
	ElseIf(op[0] == "khchance")
		_JFMCM.SetInfoText("$DJF_KHChance")
	ElseIf(op[0] == "khmaxkeys")
		_JFMCM.SetInfoText("$DJF_KHMaxKeys")
	ElseIf(op[0] == "khnotify")
		_JFMCM.SetInfoText("$DJF_KHNotify")
	ElseIf(op[0] == "khtype_")
    int i = op[1] as int
		_JFMCM.SetInfoText("$DJF_KHTypeHighlight_" + i)
  EndIf
EndEvent

; -----

int Function getFlag(bool option)
	If(option)
		return _JFMCM.OPTION_FLAG_NONE
  Else
		return _JFMCM.OPTION_FLAG_DISABLED
	EndIf
endFunction

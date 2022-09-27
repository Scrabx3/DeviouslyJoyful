;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF_DJF_ChainRubber1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
chest.AddKey(chest.RestraintsKeyIdx, 1)

JFMain.Get().FadeBack()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
JFMain.Get().FadeToBlack()
If(JFDD_EventChains_RubberSuit.Show() == 1)
  JFDD_EventChains_RubberSuit1.Show()
EndIf
main.EquipRubberSuit(Game.GetPlayer())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Message Property JFDD_EventChains_RubberSuit  Auto

Message Property JFDD_EventChains_RubberSuit1  Auto

jfddmain Property main  Auto

JFDDKeyInv Property chest  Auto

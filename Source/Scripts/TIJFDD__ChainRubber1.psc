;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIJFDD__ChainRubber1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(KeyChest as JFDDKeyInv).AddKey(2)
DDCore.FadeBlackBack()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
DDCore.FadeBlack()
Utility.Wait(0.3)
If(JFDD_EventChains_RubberSuit.Show() == 1)
  JFDD_EventChains_RubberSuit1.Show()
EndIf
DDCore.RubberSuit(DDCore.PlayerRef)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Message Property JFDD_EventChains_RubberSuit  Auto

Message Property JFDD_EventChains_RubberSuit1  Auto

JFDDCore Property DDCore  Auto

ObjectReference Property KeyChest  Auto

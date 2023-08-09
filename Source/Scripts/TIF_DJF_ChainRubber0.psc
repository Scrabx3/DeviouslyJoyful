;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF_DJF_ChainRubber0 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
JoyfulFollowers.DamageAffection()

JFMain main = JFMain.Get()
main.FadeToBlack()

int c  = JFDD_EventChains_RubberSuit2.Show()
JFMainEvents.Submit(c == 0)
If c == 1
	ddmain.AddRubberSuit()
	JFMainEvents.Singleton().FIsCruel = true
ElseIf c == 2
	ddmain.EquipRubberSuit(Game.GetPlayer())
EndIf

main.FadeBack()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

JFDDMain Property DDMain Auto

Message Property JFDD_EventChains_RubberSuit2  Auto

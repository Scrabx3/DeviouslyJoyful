;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIJFDD__ChainRubber0 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Core.FadeBlack()
Utility.Wait(0.3)
int Choice = JFDD_EventChains_RubberSuit2.Show()
If(Choice == 0)
	Core.LoseAffection()
	Util.FIsCruel = true
	Util.TLeaveToken += 1
ElseIf(Choice == 1)
	Core.AddRubberSuit()
	Util.FIsCruel = false
	Core.GainAffection()
Else
	Core.RubberSuit(Core.PlayerRef)
	Util.FIsCruel = false
	Core.GainAffection(true)
EndIf
Core.FadeBlackBack()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Message Property JFDD_EventChains_RubberSuit2  Auto

JFDDCore Property Core  Auto

JFEventStorage Property Util  Auto

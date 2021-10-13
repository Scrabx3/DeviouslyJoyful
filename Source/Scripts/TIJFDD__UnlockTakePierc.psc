;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIJFDD__UnlockTakePierc Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
JFDDCore Core = (GetOwningQuest() as JFDDCore)

Key PiercKey = Core.Lib0.piercingKey

PlayerRef.RemoveItem(PiercKey, PlayerRef.GetItemCount(PiercKey), false, Chest)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property chest  Auto  

Actor Property PlayerRef  Auto  

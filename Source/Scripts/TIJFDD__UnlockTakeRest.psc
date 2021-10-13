;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIJFDD__UnlockTakeRest Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
JFDDCore Core = (GetOwningQuest() as JFDDCore)

Key RestKey = Core.Lib0.restraintsKey

PlayerRef.RemoveItem(RestKey, PlayerRef.GetItemCount(RestKey), false, Chest)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property Chest  Auto  

Actor Property PlayerRef  Auto  

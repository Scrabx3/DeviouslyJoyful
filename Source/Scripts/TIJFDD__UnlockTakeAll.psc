;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIJFDD__UnlockTakeAll Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
JFDDCore Core = (GetOwningQuest() as JFDDCore)

Key RestKey = Core.Lib0.restraintsKey
Key ChastKey = Core.Lib0.chastityKey
Key PiercKey = Core.Lib0.piercingKey

PlayerRef.RemoveItem(RestKey, PlayerRef.GetItemCount(RestKey), false, Chest)
PlayerRef.RemoveItem(ChastKey, PlayerRef.GetItemCount(ChastKey), false, Chest)
PlayerRef.RemoveItem(PiercKey, PlayerRef.GetItemCount(PiercKey), false, Chest)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property chest  Auto  

Actor Property PlayerRef Auto

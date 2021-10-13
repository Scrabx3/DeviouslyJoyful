;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIJFDD__KeyHuntKeyMsg Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
If(KeyMsg.Show() == 0)
  akSpeaker.RemoveItem(JF_KeyHunting_Key, 1, false, PlayerRef)
endIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Message Property KeyMsg  Auto  

Key Property JF_KeyHunting_Key  Auto  

Actor Property PlayerRef  Auto  

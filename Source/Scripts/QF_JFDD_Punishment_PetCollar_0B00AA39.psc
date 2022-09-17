;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname QF_JFDD_Punishment_PetCollar_0B00AA39 Extends Quest Hidden

;BEGIN ALIAS PROPERTY JoyFol
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_JoyFol Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
; Game ended, trigger notify forcegreet
NotifyScene.start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
; Player said the enjoyed it :)
JFMainEvents events = JFMainEvents.Singleton()
events.Bondage = true
events.Humiliation = true

JoyfulFollowers.AddAffection(3)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
; game over, player wants to be released

SetStage(100)
JoyfulFollowers.AddAffection(2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
main.PetCollar(Game.GetPlayer(), false)
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
; Game started
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Scene Property NotifyScene  Auto  

JFDDMain Property main  Auto  

Scriptname JFDDJoyFolScr extends ReferenceAlias

JFDDMCM Property MCM Auto
JFDDKeyInv Property Chest Auto

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
  If(Utility.RandomInt(0, 99) < 5 && IsHostileHit(akSource))
    LoseKeys()
  EndIf
EndEvent
bool Function IsHostileHit(Form akSource)
  If(akSource as Weapon && (akSource as Weapon).GetBaseDamage() < 3)
    return false
  EndIf
  Spell sp = akSource as Spell
  Enchantment ench = akSource as Enchantment
  return sp && sp.IsHostile() || ench && ench.IsHostile()
EndFunction

Event OnEnterBleedout()
  LoseKeys()
EndEvent

Function LoseKeys()
  Form[] keys = chest.GetContainerForms()
  int lose = Utility.RandomInt(0, keys.Length)
  If(lose > 4)
    lose = 4
  EndIf
  int l = 0
  While(l < lose)
    int where = Utility.RandomInt(0, keys.Length)
    If(keys[where])
      chest.RemoveItem(keys[where])
    EndIf
    l += 1
  EndWhile
EndFunction

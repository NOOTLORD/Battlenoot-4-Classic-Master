//=============================================================================
// Melee_M763Shotgun.
//
// The M763 Shotgun for melee only mode
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Melee_M763Shotgun extends M763Shotgun HideDropDown CacheExempt;

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	if (AIController(Instigator.Controller) == None)
		return 0.8;
	return 0.4 + 0.6 * (AIController(Instigator.Controller).Skill / 7);
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
    return -0.5;
}

defaultproperties
{
     ManualLines(1)="Prepares a bludgeoning attack,耠which will be executed upon release. The damage of the attack increases the longer altfire is held, up to 1.5 seconds for maximum damage output. As a blunt attack, has lower base damage compared to bayonets but inflicts a short-duration blinding effect when striking. This attack inflicts more damage from behind."
     CockSound=(Volume=0.500000)
     ClipOutSound=(Volume=0.500000)
     ClipInSound=(Volume=0.500000)
     AimAdjustTime=0.500000
     AimDamageThreshold=100.000000
     FireModeClass(0)=Class'BallisticProV55.M763MeleeFire'
     FireModeClass(1)=Class'BallisticProV55.M763SecondaryFire'
     bCanThrow=True
     AmmoClass(0)=None
     AmmoClass(1)=None
     Priority=9
     PickupClass=Class'BallisticProV55.Melee_M763Pickup'
     AttachmentClass=Class'BallisticProV55.Melee_M763Attachment'
     ItemName="Unfireable M763 Shotgun"
     AmbientGlow=12
     bSelected=False
}

//=============================================================================
// Weapon class for the X4 Knife
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD  					   
//=============================================================================
class X4Knife extends BallisticMeleeWeapon;

// AI Interface =====					 
// choose between regular or alt-fire

function byte BestMode()
{
	local Bot B;
	local float Result;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (VSize(B.Enemy.Location - Instigator.Location) > FireMode[0].MaxRange()*1.5)
		return 1;
	Result = FRand();
	if (vector(B.Enemy.Rotation) dot Normal(Instigator.Location - B.Enemy.Location) < 0.0)
		Result += 0.3;
	else
		Result -= 0.3;

	if (Result > 0.5)
		return 1;
	return 0;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	return 1;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	return -1;
}

// End AI Stuff =====

defaultproperties
{
     PlayerSpeedFactor=1.100000
     PlayerJumpFactor=1.100000	
     BigIconMaterial=Texture'BallisticUI.Icons.X4.BigIcon_X4'
     BigIconCoords=(Y2=240)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     SpecialInfo(0)=(Info="180.0;6.0;-999.0;-1.0;-999.0;-999.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.Knife.KnifePullOut',Volume=0.325000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     PutDownSound=(Sound=Sound'BallisticSounds2.Knife.KnifePutaway',Volume=0.325000,Radius=32.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
     MagAmmo=1
     bNoMag=True
     GunLength=0.000000
     bAimDisabled=True					   								
     FireModeClass(0)=Class'BallisticProV55.X4PrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.X4SecondaryFire'
     SelectAnimRate=1.250000
     PutDownTime=0.200000
     BringUpTime=0.200000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.700000
     CurrentRating=0.700000
     bMeleeWeapon=True
     AmmoClass(0)=Class'BallisticProV55.Ammo_X4_Knife'
     AmmoClass(1)=Class'BallisticProV55.Ammo_X4_Knife'	 
     Description="Knife"
     Priority=13
     HudColor=(B=255,G=200,R=200)
     CenteredOffsetY=7.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=3
     PlayerViewOffset=(X=16.000000,Y=8.000000,Z=-10.000000)
     AttachmentClass=Class'BallisticProV55.X4Attachment'
     IconMaterial=Texture'BallisticUI.Icons.X4.SmallIcon_X4
     IconCoords=(X2=128,Y2=32)
     ItemName="X4"
     Mesh=SkeletalMesh'BallisticAnims1.X4_FP'
     DrawScale=0.300000	 
	 Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
     Skins(1)=Texture'BallisticWeapons1.X4.X4_Main'	 
}

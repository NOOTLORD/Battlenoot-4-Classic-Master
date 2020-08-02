//=============================================================================
// Weapon class for the L8 Ammo Pack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class L8GIAmmoPack extends BallisticHandGrenade;

var() float HealAmount;
var() Sound HealSound;

// AI Interface =====

function byte BestMode()
{
	local Bot B;
	local float Dist, Height, result;
	local Vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);
	Height = B.Enemy.Location.Z - Instigator.Location.Z;
	result = 0.5;

	if (Dist > 500)
		result -= 0.4;
	else
		result += 0.4;
	if (Abs(Height) > 32)
		result -= Height / Dist;
	if (result > 0.5)
		return 1;
	return 0;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.2;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.5;	}

// End AI Stuff =====

defaultproperties
{

     HealSound=Sound'BallisticSounds2.Ammo.AmmoPackPickup'
     GrenadeSmokeClass=Class'BallisticProV55.NRP57Trail'
     ClipReleaseSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-ClipOut',Volume=0.000000,Radius=0.000000,Pitch=1.000000,bAtten=True)	 
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_AmmoPack'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'	 
     bWT_Grenade=True	 
     SpecialInfo(0)=(Info="0.0;5.0;-999.0;25.0;-999.0;0.0;0.5")
     BringUpSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-Putaway')
     FireModeClass(0)=Class'BWBPRecolorsPro.L8GIPrimaryFire'
     FireModeClass(1)=Class'BWBPRecolorsPro.L8GIPrimaryFire'
     WeaponModes(0)=(bUnavailable=True)
     WeaponModes(1)=(bUnavailable=True)
	 WeaponModes(2)=(ModeName="Short Throw",ModeID="WM_None",Value=2.000000)
     CurrentWeaponMode=2	 
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.400000
     CurrentRating=0.400000	 
     AmmoClass(0)=Class'BWBPRecolorsPro.Ammo_L8GI'
     AmmoClass(1)=Class'BWBPRecolorsPro.Ammo_L8GI'
     Description="Ammunition Pack"
     HudColor=(B=255,G=200,R=200)   
	 Priority=20
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=0
     PickupClass=Class'BWBPRecolorsPro.L8GIPickup'	 
     PlayerViewOffset=(X=8.000000,Y=10.000000,Z=-12.000000)
     PlayerViewPivot=(Pitch=1024,Yaw=-1024)
     AttachmentClass=Class'BWBPRecolorsPro.L8GIAttachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_AmmoPack'
     IconCoords=(X2=127,Y2=31)
     ItemName="Ammunition Pack"
     Mesh=SkeletalMesh'BallisticRecolorsAnims.AmmoPack_FP'
     DrawScale=0.400000
	 AmbientGlow=5
}

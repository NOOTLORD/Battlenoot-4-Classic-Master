//=============================================================================
// Weapon class for NRP57 Grenade
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class NRP57Grenade extends BallisticHandGrenade;

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
	 bCookable=True
     HeldDamage=100
     HeldRadius=350
     HeldMomentum=75000
     HeldDamageType=Class'BallisticProV55.DT_NRP57Held'
     GrenadeSmokeClass=Class'BallisticProV55.NRP57Trail'
     ClipReleaseSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-ClipOut',Volume=0.325000,Radius=48.000000,Pitch=1.000000,bAtten=True)
     PinPullSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-PinOut',Volume=0.325000,Radius=48.000000,Pitch=1.000000,bAtten=True)
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_NRP57'
     BigIconCoords=(Y1=16,Y2=245)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Hazardous=True
     bWT_Splash=True
     bWT_Grenade=True
     SpecialInfo(0)=(Info="60.0;5.0;0.25;30.0;0.0;0.0;0.4")
     BringUpSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-Pullout',Volume=0.325000)
     PutDownSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-Putaway',Volume=0.325000)
     WeaponModes(0)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=1
     AimAdjustTime=100.000000
     AimDamageThreshold=0.000000
     FireModeClass(0)=Class'BallisticProV55.NRP57PrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.NRP57SecondaryFire'
     SelectAnimRate=2.250000
     PutDownAnimRate=2.000000
     PutDownTime=0.700000
     BringUpTime=0.750000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.850000
     CurrentRating=0.850000
     bShowChargingBar=False
     AmmoClass(0)=Class'BallisticProV55.Ammo_NRP57_Grenade'
     AmmoClass(1)=Class'BallisticProV55.Ammo_NRP57_Grenade'	 
     Description="NRP57 Grenade"
     Priority=7
     HudColor=(B=255,G=200,R=200)	 
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=4
     PlayerViewOffset=(X=16.000000,Y=10.000000,Z=-12.000000)
     PlayerViewPivot=(Pitch=1024,Yaw=-1024)
     AttachmentClass=Class'BallisticProV55.NRP57Attachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_NRP57'
     IconCoords=(X2=127,Y2=31)
     ItemName="NRP57 Grenade"
     Mesh=SkeletalMesh'BallisticAnims2.NRP57_FP'
     DrawScale=0.400000
     AmbientGlow=5
	 Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticWeapons2.NRP57.Grenade'
	 Skins(2)=Texture'BallisticWeapons2.NRP57.Grenade'
}

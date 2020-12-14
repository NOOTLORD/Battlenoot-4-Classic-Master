//=============================================================================
// Primaryfire class for the LK-05 Carbine
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class LK05PrimaryFire extends BallisticRangeAttenFire;

//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		AimedFireAnim = 'OpenSightFire';
		FireAnim = 'OpenFire';
	}
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';
		AimedFireAnim = 'SightFire';
		FireAnim = 'Fire';
	}
	super.PlayFiring();
}

defaultproperties
{
     CutOffDistance=3072.000000
     CutOffStartRange=1792.000000
     TraceRange=(Min=9000.000000,Max=11000.000000)
     MaxWaterTraceRange=128	
     RangeAtten=0.400000
     WaterRangeAtten=0.700000
     PDamageFactor=0.700000
     WallPDamageFactor=0.950000 	 
     WallPenetrationForce=16.000000  
     KickForce=0
     PenetrateForce=0
     bPenetrate=False 	 
     Damage=25.000000
     DamageHead=50.000000
     DamageLimb=25.000000
     DamageType=Class'BWBPRecolorsPro.DT_LK05Assault'
     DamageTypeHead=Class'BWBPRecolorsPro.DT_LK05AssaultHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DT_LK05Assault'
     DryFireSound=(Sound=Sound'BallisticSounds2.Misc.DryRifle',Volume=0.750000)		 
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     FlashScaleFactor=0.400000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassOffset=(X=-22.500000,Y=2.000000,Z=-3.250000)
     RecoilPerShot=160.000000
     VelocityRecoil=0.000000 	 
     FireChaos=0.035000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=48.000000
     YInaccuracy=48.000000
     BallisticFireSound=(Sound=Sound'BallisticProRecolorsSounds.LK05.LK05-Fire',Volume=0.975000,Slot=SLOT_Interact,bNoOverride=False)
     FireRate=0.095000
     bPawnRapidFireAnim=True
     AmmoClass=Class'BWBPRecolorsPro.Ammo_LK05_Rifle'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     WarnTargetPct=0.200000	 
     aimerror=750.000000
}

//=============================================================================
// M30PrimaryFire.
//
//[11:09:19 PM] Captain Xavious: make sure its noted to be an assault rifle
//[11:09:26 PM] Marc Moylan: lol Calypto
//[11:09:28 PM] Matteo 'Azarael': mp40 effective range
//[11:09:29 PM] Matteo 'Azarael': miles
//=============================================================================
class FMPPrimaryFire extends BallisticRangeAttenFire;


//Do the spread on the client side
function PlayFiring()
{
    	if (FMPMachinePistol(Weapon).bScopeView)
		FireAnim = 'SightFire';
	else
		FireAnim = 'Fire';
	super.PlayFiring();
}

defaultproperties
{
     CutOffDistance=2560.000000
     CutOffStartRange=1024.000000
     WaterRangeFactor=0.500000
     MaxWallSize=24.000000
     MaxWalls=1
     Damage=25.000000
     DamageHead=50.000000
     DamageLimb=25.000000
     RangeAtten=0.400000
     WaterRangeAtten=0.700000
     DamageType=Class'BWBPRecolorsPro.DT_FMPMachinePistol'
     DamageTypeHead=Class'BWBPRecolorsPro.DT_FMPMachinePistolHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DT_FMPMachinePistol'
     DryFireSound=(Sound=Sound'BallisticSounds2.D49.D49-DryFire',Volume=0.700000)	 
     KickForce=0
     PenetrateForce=0
     bPenetrate=False 
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashScaleFactor=0.300000
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassBone="tip"
     BrassOffset=(X=-52.500000,Y=2.000000)
     AimedFireAnim="SightFire"
     RecoilPerShot=98.000000
     FireChaos=0.050000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.240000,OutVal=1),(InVal=0.350000,OutVal=1.500000),(InVal=0.660000,OutVal=2.250000),(InVal=1.000000,OutVal=3.500000)))
     XInaccuracy=48.000000
     YInaccuracy=48.000000
     BallisticFireSound=(Sound=Sound'BallisticRecolorsSounds.MP40.MP40-Fire',Volume=1.200000)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.120000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_FMPMachinePistol'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     aimerror=750.000000
}

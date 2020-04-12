//=============================================================================
// Primaryfire class for FP7 Grenade
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class FP7PrimaryFire extends BallisticProGrenadeFire;

//Accessor for stats
static function FireModeStats GetStats() 
{
	local FireModeStats FS;

	FS.DamageInt = class'FP7FireControl'.default.Damage;
	FS.Damage = String(FS.DamageInt)@"+"@class'FP7FireControl'.default.BaseDamage@"initial";
	FS.DPS = FS.DamageInt / 0.2;
	FS.TTK = 0.2 * (Ceil(175/FS.DamageInt ) - 1);
	FS.RPM = 5@"checks/second";
	FS.RPShot = 0;
	FS.RPS = 0;
	FS.FCPShot = 0;
	FS.FCPS = 0;
	FS.Range = "-";
	
	return FS;
}

defaultproperties
{
     NoClipPreFireAnim="ThrowNoClip"
     SpawnOffset=(X=25.000000,Y=10.000000,Z=2.000000)
     BrassClass=Class'BallisticProV55.Brass_FP7Clip'
     BrassBone="tip"
     BrassOffset=(X=-20.000000,Z=-2.000000)
     BallisticFireSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-Throw',Radius=32.000000,bAtten=True)
     PreFireAnim="PrepThrow"
     FireAnim="Throw"
     AmmoClass=Class'BallisticProV55.Ammo_FP7Grenades'
     ShakeRotMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotRate=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeRotTime=0.000000
     ShakeOffsetMag=(X=0.000000,Y=0.000000,Z=0.000000)
     ShakeOffsetRate=(X=0.000000,Y=0.000000,Z=0.000000)
	 ShakeOffsetTime=0.000000
     ProjectileClass=Class'BallisticProV55.FP7Thrown'
	 WarnTargetPct=0.9
}

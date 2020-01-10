//=============================================================================
// Melee attack for AH2xx family
//=============================================================================
class AH208MeleeFire extends BallisticMeleeFire;

simulated function ModeHoldFire()
{
	Super.ModeHoldFire();
	BW.GunLength=1;
}

simulated event ModeDoFire()
{
	super.ModeDoFire();
	BW.GunLength = BW.default.GunLength;
}

simulated function bool HasAmmo()
{
	return true;
}

//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo == 0)
	{
		PreFireAnim = 'OpenPrepPistolWhip';
		FireAnim = 'OpenPistolWhip';
	}
	else
	{
		PreFireAnim = 'PrepPistolWhip';
		FireAnim = 'PistolWhip';
	}
	super.PlayFiring();
}

// Get aim then run trace...
function DoFireEffect()
{
    local Vector StartTrace;
    local Rotator Aim, PointAim;
    local int i;

	Aim = GetFireAim(StartTrace);
	Aim = Rotator(GetFireSpread() >> Aim);

	// Do trace for each point
	for(i=0;i<NumSwipePoints;i++)
	{
		if (SwipePoints[i].Weight < 0)
			continue;
		PointAim = Rotator(Vector(SwipePoints[i].Offset) >> Aim);
		MeleeDoTrace(StartTrace, PointAim, i==WallHitPoint, SwipePoints[i].Weight);
	}
	// Do damage for each victim
	for (i=0;i<SwipeHits.length;i++)
		DoDamage(SwipeHits[i].Victim, SwipeHits[i].HitLoc, StartTrace, SwipeHits[i].HitDir, 0, 0);
	SwipeHits.Length = 0;
	Super(BallisticFire).DoFireEffect();
}

defaultproperties
{
     SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=4000))
     SwipePoints(1)=(offset=(Pitch=4500,Yaw=3000))
     SwipePoints(2)=(Weight=4,offset=(Pitch=3000,Yaw=2000))
     SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
     SwipePoints(4)=(offset=(Yaw=0))
     SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-1500))
     SwipePoints(6)=(offset=(Pitch=-3000))
     WallHitPoint=4
     TraceRange=(Min=136.000000,Max=136.000000)
     Damage=70.000000
     DamageHead=70.000000
     DamageLimb=70.000000
     DamageType=Class'BWBPRecolorsPro.DTEagleMelee'
     DamageTypeHead=Class'BWBPRecolorsPro.DTEagleMeleeHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DTEagleMelee'
     bUseWeaponMag=False
     bReleaseFireOnDie=False
     bIgnoreReload=True
     ScopeDownOn=SDO_PreFire
     BallisticFireSound=(Sound=Sound'BallisticSounds3.M763.M763Swing',Radius=32.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="PrepPistolWhip"
     FireAnim="PistolWhip"
     TweenTime=0.000000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_44Gold'
     AmmoPerFire=0
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.050000
}

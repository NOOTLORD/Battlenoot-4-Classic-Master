class XMV850TW_PrimaryFire extends XMV850MinigunPrimaryFire;

// ModeDoFire from WeaponFire.uc, but with a few changes
simulated event ModeDoFire()
{
    if (!AllowFire() || XMV850Minigun(BW).BarrelSpeed < XMV850Minigun(BW).DesiredSpeed)
        return;

	BW.bPreventReload=true;
	BW.FireCount++;

	if (BW.ReloadState != RS_None)
		BW.ReloadState = RS_None;

    // server
    if (Weapon.Role == ROLE_Authority)
    {
        DoFireEffect();
        if ( (Instigator == None) || (Instigator.Controller == None) )
			return;
        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
        Instigator.DeactivateSpawnProtection();
		if(Instigator != None  && class'Mut_Ballistic'.static.GetBPRI(Instigator.PlayerReplicationInfo) != None)
			class'Mut_Ballistic'.static.GetBPRI(Instigator.PlayerReplicationInfo).AddFireStat(load, BW.InventoryGroup);
    }
	
	BW.LastFireTime = Level.TimeSeconds;

    // client
    if (Instigator.IsLocallyControlled())
    {
        ShakeView();
        PlayFiring();
        FlashMuzzleFlash();
        StartMuzzleSmoke();
    }
    else // server
        ServerPlayFiring();

	NextFireTime += FireRate;
	NextFireTime = FMax(NextFireTime, Level.TimeSeconds);

    Load = AmmoPerFire;
    HoldTime = 0;

    if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
    {
        bIsFiring = false;
        Weapon.PutDown();
    }

	BW.bNeedReload = BW.MayNeedReload(ThisModeNum, ConsumedLoad);
}

defaultproperties
{
     MaxWalls=2
     Damage=25.000000
     DamageHead=50.000000
     DamageLimb=25.000000
     DamageType=Class'BallisticProV55.DTXMV850MGDeploy'
     DamageTypeHead=Class'BallisticProV55.DTXMV850MGDeployHead'
     DamageTypeArm=Class'BallisticProV55.DTXMV850MGDeploy'
     KickForce=1000
     PenetrateForce=150
     bPenetrate=True
     FlashScaleFactor=0.800000
     BrassOffset=(X=-50.000000)
     RecoilPerShot=48.000000
     VelocityRecoil=0.000000
     FireChaos=0.080000
     ShakeRotTime=2.000000
     ShakeOffsetTime=1.500000
}

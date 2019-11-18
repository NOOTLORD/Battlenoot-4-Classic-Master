class X82TW_PrimaryFire extends X82PrimaryFire;

simulated function ModeDoFire ()
{
	Super.ModeDoFire();
		if(Instigator != None  && class'Mut_Ballistic'.static.GetBPRI(Instigator.PlayerReplicationInfo) != None)
			class'Mut_Ballistic'.static.GetBPRI(Instigator.PlayerReplicationInfo).AddFireStat(load, BW.InventoryGroup);
}

defaultproperties
{
     MaxWalls=4
     Damage=120.000000
     DamageHead=175.000000
     DamageLimb=120.000000
     KickForce=25000
     PenetrateForce=450
     bPenetrate=True
     FlashScaleFactor=0.500000
     BrassOffset=(X=-30.000000,Y=0.000000)
     VelocityRecoil=0.000000
     FireChaos=0.500000
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.X82.X82-Fire4',Volume=10.000000,Radius=750.000000)
     FireRate=0.530000
     ShakeRotTime=2.500000
     ShakeOffsetTime=2.250000
}

//=============================================================================
// Damage type class for SRS-600 Rifle headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_SRS600RifleHead extends DT_BWBullet;

// HeadShot stuff from old sniper damage ------------------
static function IncrementKills(Controller Killer)
{
	local xPlayerReplicationInfo xPRI;

	if ( PlayerController(Killer) == None )
		return;

	PlayerController(Killer).ReceiveLocalizedMessage( Class'XGame.SpecialKillMessage', 0, Killer.PlayerReplicationInfo, None, None );
	xPRI = xPlayerReplicationInfo(Killer.PlayerReplicationInfo);
	if ( xPRI != None )
	{
		xPRI.headcount++;
		if ( (xPRI.headcount == 15) && (UnrealPlayer(Killer) != None) )
			UnrealPlayer(Killer).ClientDelayedAnnouncementNamed('HeadHunter',15);
	}
}
// --------------------------------------------------------

defaultproperties
{
     DeathStrings(0)="%o's cranium was liberated by %k's battle rifle."
     DeathStrings(1)="%o's head was ruptured by a round from %k's SRS-600."
     DeathStrings(2)="%k's SRS-600 round found its way to %o's shifty eyeballs."
     DeathStrings(3)="%k collapsed %o's potato head with %kh battle rifle."
     DeathStrings(4)="%k sunk a round into %o's tangled bush of hair."
     bHeaddie=True
     DamageIdent="Assault"
     bDisplaceAim=False
     bUseMotionBlur=False
     WeaponClass=Class'BallisticProV55.SRS600Rifle'
     DeathString="%k assasinated %o's head with %kh SRS-600."
     FemaleSuicide="%o saw a bullet coming up the barrel of her SRS-600."
     MaleSuicide="%o saw a bullet coming up the barrel of his SRS-600."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000	 
}

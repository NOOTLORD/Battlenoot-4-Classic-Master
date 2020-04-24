//=============================================================================
// Damage type class for AK47 Assault Rifle headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved..
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_AK47AssaultHead extends DT_BWBullet;

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
     DeathStrings(0)="%o's face was rearranged by Comrade %k's AK490."
     DeathStrings(1)="%k executed a rebellious %o with an AK headshot."
     DeathStrings(2)="%k blew the Borscht out of %o's head with an AK490."
     bHeaddie=True
     DamageIdent="Assault"
     bDisplaceAim=False
     bUseMotionBlur=False
     WeaponClass=Class'BWBPRecolorsPro.AK47AssaultRifle'
     DeathString="%o's face was rearranged by Comrade %k's AK490."
     FemaleSuicide="%o shot heads with bullets."
     MaleSuicide="%o exploded in a shower of laser."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.500000
	 InvasionDamageScaling=1.000000
}

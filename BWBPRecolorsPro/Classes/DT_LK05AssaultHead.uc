//=============================================================================
// DT_LK05AssaultHead.
//
// DamageType for LK05 headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Edited by (NL)NOOTLORD 
//=============================================================================
class DT_LK05AssaultHead extends DT_BWBullet;

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
     DeathStrings(0)="%k got a clean LK05 headshot on %o."
     DeathStrings(1)="%k's LK05 headshot reduced %o to a statistic."
     DeathStrings(2)="%k's LK05 turned %o's head into a pink mist."
     bHeaddie=True
     DamageIdent="Assault"
     AimDisplacementDamageThreshold=0.000000
     AimDisplacementDuration=0.000000
     bUseMotionBlur=False	
     WeaponClass=Class'BWBPRecolorsPro.LK05Carbine'
     DeathString="%o had %vh brain shredded by %k's MJ51."
     FemaleSuicide="%o took the easy way out."
     MaleSuicide="%o took the easy way out."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
	 VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000	 
}

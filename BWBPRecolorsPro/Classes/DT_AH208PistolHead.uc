//=============================================================================
// Damage type class for AH208 Pistol headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_AH208PistolHead extends DT_BWBullet;

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
     DeathStrings(0)="%k blasted away at %o's skull with %kh AH208."
     DeathStrings(1)="%k shot out %o's eye with %kh AH208."
     DeathStrings(2)="%o swallowed %k's AH208 Eagle round whole."
     DeathStrings(3)="%k gave a new meaning of 'Eagle Eye' to %o."
     bHeaddie=True
     DamageIdent="Killstreak"
     AimDisplacementDamageThreshold=0.000000
     AimDisplacementDuration=0.000000
     bUseMotionBlur=False	
     WeaponClass=Class'BWBPRecolorsPro.AH208Pistol'
     DeathString="%k blasted away at %o's skull with %kh AH208."
     FemaleSuicide="%o killed herself with the AH208."
     MaleSuicide="%o killed himself with the AH208."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'	
     VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000
}
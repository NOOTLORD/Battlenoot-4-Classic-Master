//=============================================================================
// Damage type for MARS-3 Assault Rifle headshot
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_F2000AssaultHead extends DT_BWBullet;

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
     DeathStrings(0)="%o's brain shut down under %k's MARS-3 fire."
     DeathStrings(1)="%k terminated a fleeing %o with a MARS-3 headshot."
     DeathStrings(2)="%k tactically disabled %o with a MARS-3 bullet to the head."
     bHeaddie=True
     DamageIdent="Assault"
     AimDisplacementDamageThreshold=0.000000
     AimDisplacementDuration=0.000000
     bUseMotionBlur=False	
     WeaponClass=Class'BWBPRecolorsPro.F2000AssaultRifle'
     DeathString="%o's brain shut down under %k's MARS-3 fire."
     FemaleSuicide="%o HEADSHOT SELF?!"
     MaleSuicide="%o HEADSHOT SELF?!"
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
	 VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000
}
//=============================================================================
// Damage type class for RS04 Pistol headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_RS04PistolHead extends DT_BWBullet;

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
     DeathStrings(0)="%o was force fed %k's RS04 bullets."
     DeathStrings(1)="%k's lodged some RS04 bullets in %o's head."
     DeathStrings(2)="%o took %k's RS04 round right in the eye."
     DeathStrings(3)="%k removed %o's head with a .45 RS04 bullet."
     bHeaddie=True
     DamageIdent="Pistol"
     bDisplaceAim=False
     bUseMotionBlur=False	
     WeaponClass=Class'BallisticProV55.RS04Pistol'
     DeathString="%o's brain shut down under %k's RS04 fire."
     FemaleSuicide="%o HEADSHOT SELF?!"
     MaleSuicide="%o HEADSHOT SELF?!"
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
	 VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000
}

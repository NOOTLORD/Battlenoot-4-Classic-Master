//=============================================================================
// Damage type class for M925 Machinegun headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_M925MGHead extends DT_BWBullet;

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
     DeathStrings(0)="%k's M925 turned %o's head into mist."
     DeathStrings(1)="%k put a 50 cal through %o's idiotic face."
     DeathStrings(2)="%o's head was completely ruined by %k's speeding M925 rounds."
     DeathStrings(3)="%o's head was sanctified by %k's M925."
     bHeaddie=True
     DamageIdent="Machinegun"
     bDisplaceAim=False
     bUseMotionBlur=False
     WeaponClass=Class'BallisticProV55.M925Machinegun'
     DeathString="%k's M925 turned %o's head into mist."
     FemaleSuicide="%o caught her face in the belt feed of her M925."
     MaleSuicide="%o caught his face in the belt feed of his M925."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
     VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000	 
}

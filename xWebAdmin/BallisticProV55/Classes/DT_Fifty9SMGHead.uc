//=============================================================================
// Damage type class for Fifty-9 MachinePistol headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DT_Fifty9SMGHead extends DT_BWBullet;

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
     DeathStrings(0)="%k Fifty-9ed %o's head."
     DeathStrings(1)="%o's head was put aside by %k's Fifty-9."
     DeathStrings(2)="%k's Fifty-9 shoved lead into %o's terrified face."
     DeathStrings(3)="%o got a faceful of %k's Fifty-9 light show."
     EffectChance=0.500000
     bHeaddie=True
     DamageIdent="SMG"
     bDisplaceAim=False
     bUseMotionBlur=False
     WeaponClass=Class'BallisticProV55.Fifty9MachinePistol'
     DeathString="%k Fifty-9ed %o's head."
     FemaleSuicide="%o Fifty-9ed her head off."
     MaleSuicide="%o Fifty-9ed his head off."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     VehicleDamageScaling=0.500000
     InvasionDamageScaling=1.000000
}

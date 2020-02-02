//=============================================================================
// Damage type class for GRS-9 Pistol headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DTGRS9PistolHead extends DT_BWBullet;

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
     DeathStrings(0)="%o's head was objected to by %k's GRS-9."
     DeathStrings(1)="%k's GRS-9 liquidated %o's head."
     DeathStrings(2)="%o's head was struck off the role by %k's GRS-9."
     DeathStrings(3)="%k litigated %o's head off."
     bHeaddie=True
     DamageIdent="Pistol"
     bDisplaceAim=False
     bUseMotionBlur=False
     WeaponClass=Class'BallisticProV55.GRS9Pistol'
     DeathString="%k litigated %o's head off."
     FemaleSuicide="%o litigated her own head off."
     MaleSuicide="%o litigated his own head off."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
     FlashScale=0.300000
     VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000	 
}

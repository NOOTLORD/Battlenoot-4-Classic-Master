//=============================================================================
// Damage type class for M46 Assault Rifle headshots
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DTM46AssaultQSHead extends DT_BWBullet;

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
     DeathStrings(0)="%o's head was ripped off by %k's Jackal rifle."
     DeathStrings(1)="%k pulled out %kh M46 and %o's head fell off in terror."
     DeathStrings(2)="%o got %vh head blown clean off by %k's M46 assault rifle."
     bHeaddie=True
     DamageIdent="Assault"
     bDisplaceAim=False
     bUseMotionBlur=False
     WeaponClass=Class'BallisticProV55.M46AssaultRifleQS'
     DeathString="%o's head was ripped of by %k's Jackal rifle."
     FemaleSuicide="%o looked down the mouth of her Jackal."
     MaleSuicide="%o looked down the mouth of his Jackal."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
     FlashScale=0.300000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000

}

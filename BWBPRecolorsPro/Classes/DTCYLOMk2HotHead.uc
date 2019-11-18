//=============================================================================
// DTCYLOMk2HotHead.
//
// Damage type for hot CYLO headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTCYLOMk2HotHead extends DT_BWMiscDamage;

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
     DeathStrings(0)="%k's flaming Firestorm roasted %o's head off."
     DeathStrings(1)="%k headshotted %o with his torching Firestorm."
     DeathStrings(2)="%k scalded %o's brain with his melting Firestorm."
     EffectChance=1.000000
     BloodManagerName="BallisticProV55.BloodMan_GRS9Laser"
     bIgniteFires=True
     bHeaddie=True
     InvasionDamageScaling=2.000000
     DamageIdent="Assault"
     DamageDescription=",Bullet,Flame,Hazard,"
     MinMotionBlurDamage=5.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=3.000000
     bUseMotionBlur=True
     WeaponClass=Class'BWBPRecolorsPro.CYLOAssaultWeapon'
     DeathString="%k's overheating Firestorm roasted %o's head off."
     FemaleSuicide="%o routed herself."
     MaleSuicide="%o routed himself."
     bFastInstantHit=True
     bAlwaysSevers=True
     bFlaming=True
     GibModifier=1.200000
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     bSelected=False
}

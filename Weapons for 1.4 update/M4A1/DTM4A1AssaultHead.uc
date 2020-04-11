//=============================================================================
// DTM4A1AssaultHead.
//
// DamageType for MJ51 headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_M4A1AssaultHead extends DT_BWBullet;

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
     DeathStrings(0)="%o got %vh brain shredded by %k's M4A1."
     DeathStrings(1)="%o lost his head thanks to %k's M4A1."
     DeathStrings(2)="%k's M4A1 lifted %o's head off %vh shoulders."
     bHeaddie=True
     DamageIdent="Assault"
     bDisplaceAim=False
     bUseMotionBlur=False
     WeaponClass=Class'BWBPRecolorsPro.M4A1Carbine'
     DeathString="%o had %vh brain shredded by %k's M4A1."
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

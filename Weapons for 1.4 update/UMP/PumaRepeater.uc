//=============================================================================
// PumaRepeater.
//
// Automatic GL. Light grenades. Energy. Airburst. Combat Effective. Simon.
// Alt fire activates a shielding system.
//
// Shield will block 200 damage. (100 HP) Dmg > 50 will bleed through.
// Shield can be used to shield jump by firing a grenade into it.
// A shield jump with an intact shield will cost 30 hp and will propell player.
// A shield jump with a damaged shield will not protect or propell the player.
// Intact shields will either be turned off or damaged.
// Damaged shields will be completely destroyed.
//
// If the shield goes below -40 hp it gets destroyed. Heavy weapons and close
// range dets are the best way to accomplish this.
//
// Grenades can be proximity airburst at a slow RoF, or dumb/timer det at high RoF.
// Gun has a working range finder.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class PUMARepeater extends BallisticWeapon;

// AI Interface =====
// choose between regular or alt-fire

function byte BestMode()	{	return 0;	}

function float GetAIRating()
{
	local Bot B;
	local float Dist;
	local float Rating;
	
	B = Bot(Instigator.Controller);
	if ( B == None )
		return AIRating;

	Rating = Super.GetAIRating();

	if (B.Enemy == None)
		return Rating;

    Dist = VSize(B.Enemy.Location - Instigator.Location);

	return class'BUtil'.static.DistanceAtten(Rating, 0.6, Dist, BallisticRangeAttenFire(BFireMode[0]).CutOffStartRange, BallisticRangeAttenFire(BFireMode[0]).CutOffDistance);
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.6;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.6;	}

// End AI Stuff =====

defaultproperties
{
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_PUMA'
     bWT_Bullet=True
     bWT_Machinegun=True
     SpecialInfo(0)=(Info="300.0;30.0;0.5;60.0;0.0;1.0;0.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M763.M763Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M763.M763Putaway')
     MagAmmo=25
     CockSound=(Sound=Sound'BallisticRecolorsSounds.PUMA.PUMA-Cock',Volume=1.100000)
     ClipOutSound=(Sound=Sound'BallisticRecolorsSounds.PUMA.PUMA-MagOut',Volume=1.000000)
     ClipInSound=(Sound=Sound'BallisticRecolorsSounds.PUMA.PUMA-MagIn',Volume=1.000000)
	 bCockOnEmpty=True 
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
     ReloadEmptyAnim="Reload"	 	 
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
     SightPivot=(Yaw=-46)
     SightOffset=(Y=0.050000,Z=13.090000)
     GunLength=48.000000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
     JumpOffSet=(Pitch=1000,Yaw=-3000)
     JumpChaos=0.700000
     ViewAimFactor=0.00000
     ViewRecoilFactor=1.000000
	 FireChaos=0
     AimSpread=128
	 ChaosAimSpread=2048
	 RecoilDeclineDelay=0.200000
	 ChaosDeclineTime=2.00000
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
     RecoilYCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
     RecoilYawFactor=0.000000
     RecoilXFactor=0.400000
     RecoilYFactor=0.400000
     RecoilMax=4096.000000
     RecoilDeclineTime=1.500000
     FireModeClass(0)=Class'BWBPRecolorsPro.PumaPrimaryFire'
	 FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     PutDownTime=0.800000
     BringUpTime=1.000000
     AIRating=0.600000
     CurrentRating=0.600000
     bShowChargingBar=False
     bCanThrow=False
     AmmoClass(0)=Class'BWBPRecolorsPro.Ammo_Puma'	 	 
     Description="PUMA-77 Repeating Pulse Rifle||Manufacturer: Majestic Firearms 12|Primary: Programmable Smart Round|Secondary: Shield Projector||The Type-77 RPR, a well known pulse weapon used during the Skrith wars, is one of the more recognizable light grenade launchers on the market. It was used extensively by the UTC as the PUMA-77 before their widespread adoption of the SRAC-21/G as the automatic grenade launcher of choice. This powerful weapon differs from other conventional grenade launchers in that it utilizes specialized fission batteries as ammunition, which both power and act as the carrier of the projectile. The projectiles themselves can be programmed by the side-mounted rangefinding module and allow soldiers to selectively airburst the rounds to hit targets behind cover. The PUMA-77s seen here are equipped with Frontier Tech's lightweight X57 shield projector, which is a scaled down version of the heavy portable shields used during the first Skrith war."
     Priority=245
     HudColor=(B=255,G=200,R=200)	 
     CustomCrossHairScale=1.000000	 
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=8
	 InventorySize=12
     PlayerViewOffset=(X=-4.000000,Y=6.000000,Z=-11.000000)
     AttachmentClass=Class'BWBPRecolorsPro.PumaAttachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_PUMA'
     IconCoords=(X2=127,Y2=35)
     ItemName="PUMA-Repeater"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=25
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BallisticRecolorsAnims.PUMA_FP'
     DrawScale=0.350000
}

//=============================================================================
// Weapon class for the M353 Machinegun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class M353Machinegun extends BallisticMachinegun;

simulated function TickAim(float DT)
{
	Super(BallisticWeapon).TickAim(DT);
}

simulated function PlayReload()
{
	PlayAnim('ReloadHold', ReloadAnimRate, , 0.25);
}

simulated function Notify_M353FlapOpenedReload ()
{
	super.PlayReload();
}

// Animation notify to make gun cock after reload
simulated function Notify_CockAfterReload()
{
	if (bNeedCock && MagAmmo > 0)
		CommonCockGun(2);
	else
		PlayAnim('ReloadFinishHold', ReloadAnimRate, 0.2);
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim('ReloadEndCock'))
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

simulated function PositionSights ()
{
	super.PositionSights();
	if (SightingPhase <= 0.0)
		SetBoneRotation('TopHandle', rot(0,0,0));
	else if (SightingPhase >= 1.0 )
		SetBoneRotation('TopHandle', rot(0,0,-8192));
	else
		SetBoneRotation('TopHandle', class'BUtil'.static.RSmerp(SightingPhase, rot(0,0,0), rot(0,0,-8192)));
}

simulated function SetScopeBehavior()
{
	bUseNetAim = default.bUseNetAim || bScopeView;
		
	if (bScopeView)
	{
		ViewAimFactor = 1.0;
		ViewRecoilFactor = 1.0;
		AimAdjustTime *= 2;
		AimSpread = 0;
		ChaosAimSpread *= SightAimFactor;
		ChaosDeclineTime *= 2.0;
		ChaosSpeedThreshold *= 0.5;
	}
	else
	{
		//PositionSights will handle this for clients
		if(Level.NetMode == NM_DedicatedServer)
		{
			ViewAimFactor = default.ViewAimFactor;
			ViewRecoilFactor = default.ViewRecoilFactor;
		}

		AimAdjustTime = default.AimAdjustTime;
		AimSpread = default.AimSpread;
		AimSpread *= BCRepClass.default.AccuracyScale;
		ChaosAimSpread = default.ChaosAimSpread;
		ChaosAimSpread *= BCRepClass.default.AccuracyScale;
		ChaosDeclineTime = default.ChaosDeclineTime;
		ChaosSpeedThreshold = default.ChaosSpeedThreshold;
	}
}

// AI Interface =====
// choose between regular or alt-fire

function byte BestMode()	{	return 0;	}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}

// End AI Stuff =====	
										
defaultproperties

     BoxOnSound=(Sound=Sound'BallisticSounds2.M353.M353-BoxOn',Volume=0.750000)
     BoxOffSound=(Sound=Sound'BallisticSounds2.M353.M353-BoxOff',Volume=0.750000)
     FlapUpSound=(Sound=Sound'BallisticSounds2.M353.M353-FlapUp',Volume=0.750000)
     FlapDownSound=(Sound=Sound'BallisticSounds2.M353.M353-FlapDown',Volume=0.750000)
     PlayerSpeedFactor=0.900000
     PlayerJumpFactor=0.900000
     AIReloadTime=4.000000
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_M353'
     BigIconCoords=(Y1=50,Y2=240)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     SightFXClass=Class'BallisticProV55.M353SightLEDs'	 
     bWT_Bullet=True
     bWT_Machinegun=True
     SpecialInfo(0)=(Info="300.0;25.0;0.7;-1.0;0.4;0.4;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M353.M353-Pullout',Volume=0.395000)
     PutDownSound=(Sound=Sound'BallisticSounds2.M353.M353-Putaway',Volume=0.395000)
     MagAmmo=100
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'BallisticSounds2.M353.M353-Cock',Volume=0.800000)
     ReloadAnim="ReloadStart"
     ReloadAnimRate=1.450000
     ClipOutSound=(Sound=Sound'BallisticSounds2.M353.M353-ShellOut',Volume=0.800000)
     ClipInSound=(Sound=Sound'BallisticSounds2.M353.M353-ShellIn',Volume=0.800000)
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)	 
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
     SightPivot=(Pitch=128)
     SightOffset=(X=-6.000000,Z=5.350000)
     SightingTime=0.550000
     SightAimFactor=0.700000
     SprintOffSet=(Pitch=-6000,Yaw=-8000)
     AimAdjustTime=100.000000
     AimSpread=384
     AimDamageThreshold=0.000000
	 ViewRecoilFactor=1.000000
     ChaosDeclineTime=1.600000
     ChaosAimSpread=3072
     RecoilXCurve=(Points=(,(InVal=0.070000,OutVal=-0.050000),(InVal=0.100000,OutVal=-0.085000),(InVal=0.180000,OutVal=0.060000),(InVal=0.300000,OutVal=-0.100000),(InVal=0.500000,OutVal=0.200000),(InVal=0.650000,OutVal=0.300000),(InVal=0.700000,OutVal=-0.100000),(InVal=0.850000,OutVal=0.400000),(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.050000,OutVal=0.070000),(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.400000),(InVal=0.550000,OutVal=0.650000),(InVal=0.650000,OutVal=0.450000),(InVal=0.800000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilMax=12288.000000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.150000
     FireModeClass(0)=Class'BallisticProV55.M353PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     SelectAnimRate=1.350000
     PutDownTime=0.550000
     BringUpTime=0.700000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.7500000
     CurrentRating=0.7500000
     AmmoClass(0)=Class'BallisticProV55.Ammo_M353_MG'
     AmmoClass(1)=Class'BallisticProV55.Ammo_M353_MG'	 
     DisplayFOV=50.000000
     Description="M353 Light Machine Gun"	 
     Priority=43
     HudColor=(B=255,G=200,R=200)
     CustomCrossHairScale=0.000000
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=3
     PlayerViewOffset=(X=4.000000,Y=3.000000,Z=-4.000000)
     AttachmentClass=Class'BallisticProV55.M353Attachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_M353'
     IconCoords=(X2=127,Y2=31)
     ItemName="M353 Light Machine Gun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BallisticAnims2.M353_FP'
     DrawScale=0.350000
     AmbientGlow=5
	 Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	 Skins(1)=Texture'BallisticWeapons2.M353.M353_Skin1'
	 Skins(2)=Texture'BallisticWeapons2.M353.M353_Skin2'
	 Skins(3)=Texture'BallisticWeapons2.M353.M353_Ammo'
}

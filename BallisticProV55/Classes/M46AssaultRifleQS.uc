//=============================================================================
// M46AssaultRifleQS.
// 
// Red dot M46.
//=============================================================================
class M46AssaultRifleQS extends M46AssaultRifle;

simulated event RenderOverlays (Canvas C)
{
	Super(BallisticWeapon).RenderOverlays(C);
}

defaultproperties
{
     InventorySize=255
     bWT_Machinegun=False
     CockSound=(Volume=0.800000)
     ClipHitSound=(Volume=0.800000)
     ClipOutSound=(Volume=0.800000)
     ClipInSound=(Volume=0.800000)
     bCockOnEmpty=True
     WeaponModes(1)=(bUnavailable=True)
     CurrentWeaponMode=0
     ZoomType=ZT_Irons
     ZoomInAnim=
     ZoomOutAnim=
     ScopeViewTex=None
     ZoomInSound=(Sound=None,Volume=0.000000)
     ZoomOutSound=(Sound=None,Volume=0.000000)
     FullZoomFOV=80.000000
     bNoMeshInScope=False
     SightPivot=(Pitch=-300,Roll=0)
     SightOffset=(X=-10.000000,Y=0.000000,Z=11.550000)
     SightDisplayFOV=35.000000
     SightingTime=0.350000
     SightAimFactor=0.200000
     AimAdjustTime=100.000000
     AimDamageThreshold=0.000000
     ChaosSpeedThreshold=15000.000000
     FireModeClass(0)=Class'BallisticProV55.M46PrimaryFireQS'
     FireModeClass(1)=Class'BallisticProV55.M46SecondaryFireQS'
     bCanThrow=False
     AmmoClass(0)=Class'BCoreProV55.BallisticAmmo'
     AmmoClass(1)=Class'BCoreProV55.BallisticAmmo'
     Priority=54
     CustomCrossHairScale=0.000000
     GroupOffset=2
     PickupClass=Class'BallisticProV55.M46PickupQS'
     AttachmentClass=Class'BallisticProV55.M46AttachmentQS'
     ItemName="M46 Red Dot Sight"
     Mesh=SkeletalMesh'BallisticProAnims.OA-AR-RDS'
     AmbientGlow=0
     bSelected=True
}

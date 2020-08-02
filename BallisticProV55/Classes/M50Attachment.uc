//=============================================================================
// 3rd person weapon class for the M50 Assault Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class M50Attachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     FlashMode=MU_Primary 
     FlashScale=1.000000	 
     LightMode=MU_Primary	 
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassMode=MU_Primary
     InstantMode=MU_Primary
     TrackAnimMode=MU_None	 
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     TracerMode=MU_Primary	 
     TracerChance=1.000000
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Primary	 
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     FlyByMode=MU_Primary
     ReloadAnim="Reload_AR"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.250000
     CockAnimRate=1.400000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticAnims2.M50_TP'
     DrawScale=0.160000
	 Skins(0)=Texture'BallisticWeapons2.M50.M50SkinA'
	 Skins(1)=Texture'BallisticWeapons2.M50.M50SkinB'
	 Skins(2)=Texture'BN4misc.Albedo.Placeholder_albedo
	 Skins(3)=Texture'BallisticWeapons2.M50.M50Laser'
	 Skins(4)=Texture'BallisticWeapons2.M50.M50Gren'
}

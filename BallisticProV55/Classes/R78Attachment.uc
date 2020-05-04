//=============================================================================
// 3rd person weapon class for R78 Sniper Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class R78Attachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
     FlashMode=MU_Primary  
     FlashScale=0.900000
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
     FlyBySound=(Sound=Sound'BallisticRecolorsSounds.X82.X82-FlyBy',Volume=1.500000)
     FlyByMode=MU_Primary	 
     ReloadAnim="Reload_AR"
     CockingAnim="Cock_RearPull"
     CockAnimRate=1.100000
     Mesh=SkeletalMesh'BallisticAnims2.R78_TP'
     DrawScale=0.200000
	 Skins(0)=Texture'BallisticWeapons2.R78.RifleSkin'
	 Skins(1)=Texture'BallisticWeapons2.R78.ScopeSkin'
}

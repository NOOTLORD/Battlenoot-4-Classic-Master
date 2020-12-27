//=============================================================================
// 3rd person weapon class for the R78 Sniper Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class R78A1Attachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.R78A1FlashEmitter'
     FlashScale=0.900000	 
     ImpactManager=Class'BallisticProV55.IM_Bullet'	 
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     FlyBySound=(Sound=Sound'BallisticProRecolorsSounds.X82.X82-FlyBy',Volume=1.500000) 
     ReloadAnim="Reload_AR"
     CockingAnim="Cock_RearPull"
     CockAnimRate=1.100000
     Mesh=SkeletalMesh'BallisticProAnims.R78A1_TP'
     DrawScale=0.200000
	 Skins(0)=Texture'BallisticProTex.R78A1.R78A1-Main'
	 Skins(1)=Texture'BallisticProTex.R78A1.R78A1-Scope'
}

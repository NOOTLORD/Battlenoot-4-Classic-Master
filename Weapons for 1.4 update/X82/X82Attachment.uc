//=============================================================================
// 3rd person weapon class for the X82 Sniper Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class X82Attachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
     FlashMode=MU_Primary
     FlashScale=1.000000	 
     LightMode=MU_Primary		 
     ImpactManager=Class'BallisticProV55.IM_Bullet' 
     BrassClass=Class'BWBPRecolorsPro.Brass_X82_Sniper'
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
     ReloadAnimRate=0.800000
     Mesh=SkeletalMesh'BallisticRecolorsAnims.X82_TP'
     RelativeLocation=(X=-17.000000,Z=-1.000000)
     RelativeRotation=(Pitch=32768)
     DrawScale=0.250000
	 Skins(0)=Texture'BallisticRecolorsTex.X82.X82Skin'
}

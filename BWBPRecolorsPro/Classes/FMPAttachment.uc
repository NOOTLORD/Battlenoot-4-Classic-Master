//=============================================================================
// FMP Attachment
//
// FMP-2012's 3rd
//=============================================================================
class FMPAttachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter' 
     FlashMode=MU_Primary
     FlashScale=0.200000	 
     LightMode=MU_Primary	 
     FlashBone="Tip"
     ImpactManager=Class'BallisticProV55.IM_Bullet'	 
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassMode=MU_Primary
     InstantMode=MU_Primary	
     TrackAnimMode=MU_None
     TracerClass=Class'BallisticProV55.TraceEmitter_Pistol'
     TracerMode=MU_Primary	 
     TracerChance=0.500000
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Primary	
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     FlyByMode=MU_Primary
     ReloadAnim="Reload_AR"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.250000
     CockAnimRate=0.900000
     bRapidFire=True
     bAltRapidFire=True
     Mesh=SkeletalMesh'BallisticRecolorsAnims.TP_MP40'
     RelativeRotation=(Yaw=32768,Roll=-16384)	 
     DrawScale=0.425000
}

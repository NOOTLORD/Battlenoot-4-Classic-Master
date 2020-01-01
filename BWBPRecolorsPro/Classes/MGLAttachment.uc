//=============================================================================
// MGLAttachment
//
// Modified by (NL)NOOTLORD
//=============================================================================
class MGLAttachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     FlashMode=MU_Primary 
     FlashScale=0.900000	 
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     InstantMode=MU_Primary
     LightMode=MU_Primary
     TrackAnimMode=MU_None
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     TracerMode=MU_Primary
     TracerChance=1.000000	 
     TracerMix=-3
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Primary
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     FlyByMode=MU_Primary	 
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.500000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticRecolors4AnimProExp.Conqueror_TP'
     RelativeRotation=(Pitch=32768)
     DrawScale=0.300000
}

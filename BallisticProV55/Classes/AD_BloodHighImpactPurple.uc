//-----------------------------------------------------------
//AD_BloodHighImpactPurple
//-----------------------------------------------------------
class AD_BloodHighImpactPurple extends AD_BloodHighImpact;

defaultproperties
{
     DecalTextures(0)=Texture'BallisticBloodPro.Bot.Bot-HighImpact1'
     DecalTextures(1)=Texture'BallisticBloodPro.Bot.Bot-HighImpact2'
     DecalTextures(2)=Texture'BallisticBloodPro.Bot.Bot-HighImpact3'
     MaterialBlendingOp=PB_None
     FrameBufferBlendingOp=PB_AlphaBlend
     bProjectBSP=True
     bProjectTerrain=True
     bProjectStaticMesh=True
     bProjectParticles=True
     bClipBSP=True
     bClipStaticMesh=True
     bProjectOnAlpha=True
     bSelected=False
}

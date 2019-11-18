//-----------------------------------------------------------
//AD_BloodPoolPurple
//-----------------------------------------------------------
class AD_BloodPoolPurple extends AD_BloodPool;

defaultproperties
{
     DecalTextures(0)=Texture'BallisticBloodPro.Bot.Bot-BloodPool1'
     DecalTextures(1)=Texture'BallisticBloodPro.Bot.Bot-BloodPool2'
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

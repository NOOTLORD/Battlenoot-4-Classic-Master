//-----------------------------------------------------------
//AD_BloodPoolGreen
//-----------------------------------------------------------
class AD_BloodPoolGreen extends AD_BloodPool;

defaultproperties
{
     DecalTextures(0)=Texture'BallisticBloodPro.Alien.Alien-BloodPool1'
     DecalTextures(1)=Texture'BallisticBloodPro.Alien.Alien-BloodPool2'
     FrameBufferBlendingOp=PB_Add
     bProjectBSP=True
     bProjectTerrain=True
     bProjectStaticMesh=True
     bProjectParticles=True
     bClipBSP=True
     bClipStaticMesh=True
     bProjectOnAlpha=True
     bSelected=False
}

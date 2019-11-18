//-----------------------------------------------------------
//AD_BloodLowImpactGreen
//-----------------------------------------------------------
class AD_BloodLowImpactGreen extends AD_BloodLowImpact;

defaultproperties
{
     DecalTextures(0)=Texture'BallisticBloodPro.Alien.Alien-LowImpact1'
     DecalTextures(1)=Texture'BallisticBloodPro.Alien.Alien-LowImpact2'
     DecalTextures(2)=Texture'BallisticBloodPro.Alien.Alien-LowImpact3'
     DecalTextures(3)=Texture'BallisticBloodPro.Alien.Alien-LowImpact4'
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

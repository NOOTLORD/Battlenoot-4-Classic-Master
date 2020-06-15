class DWLightningEmitter extends Emitter
    notplaceable;

#exec OBJ LOAD FILE="..\Textures\UltimateMappingTools_Tex.utx"

defaultproperties
{
     Emitters(0)=BeamEmitter'UltimateMappingTools.DWLightning.BeamEmitter3'

     Emitters(1)=BeamEmitter'UltimateMappingTools.DWLightning.BeamEmitter4'

     Emitters(2)=BeamEmitter'UltimateMappingTools.DWLightning.BeamEmitter5'

     Emitters(3)=SpriteEmitter'UltimateMappingTools.DWLightning.SpriteEmitter1'

     AutoDestroy=True
     bNoDelete=False
     LifeSpan=2.000000
}

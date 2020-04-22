//-----------------------------------------------------------
//
//-----------------------------------------------------------
class DECO_BreakablePost extends DECO_Smashable;

#exec OBJ LOAD FILE=..\StaticMeshes\ONS-BPJW1.usx

defaultproperties
{
     bNeedsSingleShot=True
     EffectWhenDestroyed=Class'OnslaughtBP.fxSignBreak'
     Health=40
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'ONS-BPJW1.Meshes.RoadSignMesh'
     PrePivot=(Z=80.000000)
     AmbientGlow=48
     CollisionRadius=8.000000
     CollisionHeight=80.000000
}

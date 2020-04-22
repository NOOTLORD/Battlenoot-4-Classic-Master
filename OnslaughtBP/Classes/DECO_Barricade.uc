//-----------------------------------------------------------
//
//-----------------------------------------------------------
class DECO_Barricade extends DECO_Smashable;

#exec OBJ LOAD FILE=..\StaticMeshes\ONS-BPJW1.usx

defaultproperties
{
     bImperviusToPlayer=False
     EffectWhenDestroyed=Class'OnslaughtBP.fxBarricadeBreak'
     Health=50
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'ONS-BPJW1.Meshes.BarricadeMesh'
     PrePivot=(Z=40.000000)
     AmbientGlow=48
     CollisionRadius=48.000000
     CollisionHeight=40.000000
}

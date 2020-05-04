class InvasionProCylinderActor extends Actor placeable;

function Tick(float DeltaTime)
{
	if(Owner != None)
	{
		SetRotation(Owner.Rotation);
	}
}

defaultproperties
{
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'InvasionProv1_7.EditCylinderMesh'
     RemoteRole=ROLE_None
     Skins(0)=Texture'UCGeneric.SolidColours.Red'
     AmbientGlow=60
     bUnlit=True
     bHardAttach=True
}

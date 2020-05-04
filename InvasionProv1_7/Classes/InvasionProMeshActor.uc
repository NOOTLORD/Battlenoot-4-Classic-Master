///================================================================
//Mesh Loader Actor, Copyright 2009 Shaun Goeppinger
//This basically displays the meshes to be used one after another
//and hides them behind an invisible texture. They must actually
//be seen by the player to register in memory as far as I know.
//Simply setting bHidden will make them not render at all, if the
//player turns around they wont render, so the location is
//constantly updated.
///================================================================
class InvasionProMeshActor extends Actor;

//to manually iterate through the mesh list allowing complete control of the speed
//I like to give the meshes a "few seconds" of screen time
var() int MeshNumber;
var() int MeshCount;
var() Controller OwnerController;

//Pawn Owner changes when player enters or leaves vehicle and preload is interrupted
//saving controller to get Controller.Pawn location whilst keeping it only relevant to Pawn Owner
simulated function Tick(float DeltaTime)
{
	local vector X, Y, Z;

	if(Controller(Owner) != None && Controller(Owner).Pawn != None)
	{
		OwnerController = Controller(Owner);
		SetOwner(Controller(Owner).Pawn);
	}
	else if(Pawn(Owner) != None)
	{
		//constantly update the location of this actor relative to the players view rotation and location
		GetAxes(Pawn(Owner).GetViewRotation(),X,Y,Z);
		SetLocation( ( Pawn(Owner).Location + vect(0,0,25) ) + 75 * X);
	}
}

Auto State Preloading
{
	simulated function BeginState()
	{
		MeshCount = class'InvasionProMonsterTable'.default.MonsterTable.Length;
		SetDrawType(DT_Mesh);
	}

	simulated function SwapMesh()
	{
		local class<Monster> M;
		local Mesh MMesh;

		if(MeshNumber < MeshCount)
		{
			if(class'InvasionProMonsterTable'.default.MonsterTable[MeshNumber].MonsterClassName != "" && class'InvasionProMonsterTable'.default.MonsterTable[MeshNumber].MonsterClassName != "None")
			{
				M = class<Monster>(DynamicLoadObject(class'InvasionProMonsterTable'.default.MonsterTable[MeshNumber].MonsterClassName, class'class',true));

				if(M != None)
				{
					MMesh = Mesh(DynamicLoadObject(string(M.default.Mesh), class'Mesh',true));
					if(MMesh != None)
					{
						LinkMesh(MMesh);
					}
				}
			}

			MeshNumber++;
		}
		else
		{
			Disable('Tick');
			Destroy();
		}
	}

Begin:
	//slight pause before it all starts
	Sleep(1.5);
	GoTo('Initialize');

Initialize:

	SwapMesh();
	Sleep(0.175);
	GoTo('Initialize');
}

defaultproperties
{
     DrawType=DT_StaticMesh
     bOnlyOwnerSee=True
     bAcceptsProjectors=False
     LifeSpan=60.000000
     DrawScale=0.250000
     Skins(0)=Texture'InvasionProTexturesv1_4.GUI.InvisTex'
     Skins(1)=Texture'InvasionProTexturesv1_4.GUI.InvisTex'
     Skins(2)=Texture'InvasionProTexturesv1_4.GUI.InvisTex'
     Skins(3)=Texture'InvasionProTexturesv1_4.GUI.InvisTex'
     Skins(4)=Texture'InvasionProTexturesv1_4.GUI.InvisTex'
     Skins(5)=Texture'InvasionProTexturesv1_4.GUI.InvisTex'
     Skins(6)=Texture'InvasionProTexturesv1_4.GUI.InvisTex'
     Skins(7)=Texture'InvasionProTexturesv1_4.GUI.InvisTex'
     Skins(8)=Texture'InvasionProTexturesv1_4.GUI.InvisTex'
     bUnlit=True
     bHardAttach=True
     CollisionRadius=0.000000
     CollisionHeight=0.000000
     bBlockZeroExtentTraces=False
     bBlockNonZeroExtentTraces=False
}

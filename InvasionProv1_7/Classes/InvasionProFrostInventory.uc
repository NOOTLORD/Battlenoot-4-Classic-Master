class InvasionProFrostInventory extends Inventory;

var() Monster MyMonster;
var() float MonsterGroundSpeed;
var() float MonsterAirSpeed;
var() float MonsterWaterSpeed;
var() float MonsterJumpZ;

function Timer()
{
	if(MyMonster != None)
	{
		MyMonster.GroundSpeed = MonsterGroundSpeed;
		MyMonster.AirSpeed = MonsterAirSpeed;
		MyMonster.WaterSpeed = MonsterWaterSpeed;
		MyMonster.JumpZ = MonsterJumpZ;

		if(MyMonster.Controller != None)
		{
			MyMonster.Controller.Destination = MyMonster.Location;
		}
	}

	Destroy();
}

function GiveTo(Pawn Other, optional Pickup Pickup)
{
	if( Monster(Other) != None)
	{
		MyMonster = Monster(Other);
		SetTimer(3,true);
		Super.GiveTo(Other);
	}
}

defaultproperties
{
     ItemName="FrostInv"
     bOnlyRelevantToOwner=False
     bAlwaysRelevant=True
}

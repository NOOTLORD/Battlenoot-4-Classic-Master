class InvasionProPetMinionInventory extends Inventory;

var() Pawn MyOwner;
var() Inventory Master;
var() Emitter ResurrectFX;

function Destroyed()
{
	if(MyOwner != None)
	{
		Spawn(class'InvasionProPetResurrectDeathFX',MyOwner,,MyOwner.Location);
	}

	if(ResurrectFX != None)
	{
		ResurrectFX.Kill();
	}

	Super.Destroyed();
}

function GiveTo(Pawn Other, optional Pickup Pickup)
{
	if( Other != None)
	{
		MyOwner = Other;
		SpawnResurrectTrail();
		Super.GiveTo(Other);
	}
}

function SpawnResurrectTrail()
{
	if(MyOwner != None)
	{
		ResurrectFX = Spawn(class'InvasionProPetResurrectFX',MyOwner,,MyOwner.Location,Rot(0,0,0));
		if(ResurrectFX != None)
		{
			ResurrectFX.SetBase(MyOwner);
		}
	}
}

defaultproperties
{
     ItemName="MinionTag"
}

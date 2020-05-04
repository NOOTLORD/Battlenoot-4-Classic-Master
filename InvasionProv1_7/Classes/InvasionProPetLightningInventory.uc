class InvasionProPetLightningInventory extends Inventory;

var() int LightningDamage;
var() float BounceRange;
var() int BounceLimit;
var() int BounceCount;
var() Pawn MyOwner;
var() Pawn ChainPawn;

function Destroyed()
{
	Super.Destroyed();
}

function GiveTo(Pawn Other, optional Pickup Pickup)
{
	local Inventory Inv;
	local Pawn P;
	local xEmitter Beam;

	if( Other != None)
	{

		if(MyOwner == None)
		{
			Destroy();
			return;
		}

		Other.PlaySound(Sound'WeaponSounds.LightningGun.LightningGunImpact',Slot_Misc);
		Other.TakeDamage(LightningDamage, MyOwner, Other.Location, vect(0,0,0), class'DamType_PetAuraLightning');
		Spawn(class'InvasionProPetLightningHitFX ',Other,,Other.Location);

		if(BounceCount >= BounceLimit)
		{
			Destroy();
			return;
		}

		foreach VisibleCollidingActors(class'Pawn',P,BounceRange,Other.Location)
		{
			if(Monster(P) != None && P.Health > 0 && P != Other && P != MyOwner && P.Controller != None && FriendlyMonsterController(MyOwner.Controller) != None && !FriendlyMonsterController(MyOwner.Controller).IsFriend(P.Controller))
			{
				if(ChainPawn == None || ChainPawn != P)
				{
					Inv = P.FindInventoryType(class'InvasionProPetLightningInventory');
					if(InvasionProPetLightningInventory(Inv) == None)	//pawn wasnt recently hit with lightning
					{
						Inv = Spawn(class'InvasionProPetLightningInventory',P);
						if(InvasionProPetLightningInventory(Inv) != None)
						{
							Beam = Spawn(class'InvasionProPetChainLightningFX',Other,,Other.Location);
							if(Beam != None)
							{
								Beam.mSpawnVecA = P.Location;
							}

							InvasionProPetLightningInventory(Inv).ChainPawn = Other;
							InvasionProPetLightningInventory(Inv).MyOwner = MyOwner;
							InvasionProPetLightningInventory(Inv).BounceLimit = BounceLimit;
							InvasionProPetLightningInventory(Inv).LightningDamage = LightningDamage;
							InvasionProPetLightningInventory(Inv).BounceRange = BounceRange;
							InvasionProPetLightningInventory(Inv).BounceCount = (BounceCount + 1);
							InvasionProPetLightningInventory(Inv).GiveTo(P);
							break;
						}
					}
				}
			}
		}

		Super.GiveTo(Other);
	}
}

defaultproperties
{
     BounceLimit=3
     ItemName="PetChainLightningInv"
     LifeSpan=3.000000
}

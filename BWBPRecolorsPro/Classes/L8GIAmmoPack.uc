//=============================================================================
// A51Grenade
// Skrith Acid Grenade
//=============================================================================
class L8GIAmmoPack extends BallisticHandGrenade;

var() float HealAmount;
var() Sound HealSound;

/*
function DoExplosionEffects()
{
}
*/
function DoExplosion()
{

}


/*simulated*/ function Notify_SupplySelf()
{


	PlaySound(HealSound, SLOT_Interact );
	//Instigator.Controller.AwardAdrenaline(AdrenalineAmount);
	//xPawn(Owner).GiveAmmo(xPawn(Owner),vect(0,0,0),vect(0,0,0),vect(0,0,0),0,0);
	xPawn(Owner).GiveHealth(HealAmount,xPawn(Owner).SuperHealthMax);
	//if (Role == ROLE_Authority)
	//	L8GISecondaryFire(BFireMode[1]).NotifiedDoFireEffect();
	GotoState('GiveAmmoSelf');
	Ammo[0].UseAmmo (1, True);
}

state GiveAmmoSelf
{
	function SupplySelf(Actor InvOwner)//xPawn Owner
	{

		local Inventory Inv, GW;
		local int Count;
		local Weapon W;
		local bool bGetIt;
		local Ammunition A;

		Count = 0;
		// First go through our inventory and revive all the ghosts
		for (Inv=InvOwner.Inventory; Inv!=None && /*!Inv.IsA('L8GIAmmoPack') &&*/ Count < 1000; Count++)
		{
			if (!Inv.IsA('L8GIAmmoPack'))
			{
				// If our grenades ran out, this should bring them back...
				if (BCGhostWeapon(Inv) != None && BCGhostWeapon(Inv).MyWeaponClass != class'L8GIAmmoPack')
				{
					GW = Inv;
					Inv = Inv.Inventory;
					BCGhostWeapon(GW).ReviveWeapon();
				}
				else
					Inv=Inv.Inventory;
			}
		}
		Count = 0;
		// Now give all weapons some ammo
		for (Inv=InvOwner.Inventory; Inv!=None /*&& !Inv.IsA('L8GIAmmoPack')*/ && Count < 1000; Inv=Inv.Inventory)
		{
			A = Ammunition(Inv);
			if (A != None && !A.IsA('Ammo_L8GI'))
			{
				if (A.AmmoAmount < A.MaxAmmo)
				{
					A.AddAmmo(A.InitialAmount);
					BGetIt=true;
				}
			}
			else
			{
				W = Weapon(Inv);
				if (W != None && !W.IsA('L8GIAmmoPack'))
				{
					if (W.bNoAmmoInstances)
					{
						if ( !W.AmmoMaxed(0) && W.GetAmmoClass(0) != None)
						{
							W.AddAmmo(W.GetAmmoClass(0).default.InitialAmount, 0);
							BGetIt=true;
						}
						if ( W.GetAmmoClass(1) != None && W.GetAmmoClass(1) != W.GetAmmoClass(0) && (!W.AmmoMaxed(1)) )
						{
							BGetIt=true;
							W.AddAmmo(W.GetAmmoClass(1).default.InitialAmount, 1);
						}
					}
				}
			}

			Count++;
		}
		//Instigator.GiveAm
		//Ammo[0].UseAmmo (1, True);
	
	}
	
	Begin:
		SupplySelf(xPawn(Owner));
}

simulated function Notify_HealOther()
{
	PlaySound(HealSound, SLOT_Interact );
	if (Role == ROLE_Authority)
		L8GISecondaryFire(BFireMode[1]).NotifiedDoFireEffect();
	Ammo[0].UseAmmo (1, True);
}

simulated function ClientStartReload(optional byte i)
{
}

// Reload releases clip
function ServerStartReload (optional byte i)
{
}

// Weapon special releases clip
//simulated function DoWeaponSpecial(optional byte i)
exec simulated function WeaponSpecial(optional byte i)
{
}
defaultproperties
{
     HealAmount=5.000000
     HealSound=Sound'BallisticSounds2.Ammo.AmmoPackPickup'
     HeldDamage=200
     HeldRadius=250
     HeldMomentum=55000
     GrenadeSmokeClass=Class'BallisticProV55.NRP57Trail'
     ClipReleaseSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-ClipOut',Volume=0.500000,Radius=48.000000,Pitch=1.000000,bAtten=True)
     PlayerSpeedFactor=0.750000
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny',SkinNum=15)
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_AmmoPack'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'	 
     bWT_Grenade=True
     SpecialInfo(0)=(Info="0.0;5.0;-999.0;25.0;-999.0;0.0;0.5")
     BringUpSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-Putaway')
     FireModeClass(0)=Class'BWBPRecolorsPro.L8GIPrimaryFire'
     FireModeClass(1)=Class'BWBPRecolorsPro.L8GISecondaryFire'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.400000
     CurrentRating=0.400000
     bShowChargingBar=False
     bCanThrow=False
     AmmoClass(0)=Class'BWBPRecolorsPro.Ammo_L8GI'	 
     Description="L8 GI Ammunition Pack||Manufacturer: Various|Primary: Throw|Secondary: Supply Self||UTC soldiers are trained to use a wide variety of weaponry, and, as such, are often in need of supplies. The L8 GI ammo pack is filled with ammunition and will supply every gun in the user's inventory."
     Priority=20
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=0
     PickupClass=Class'BWBPRecolorsPro.L8GIPickup'	 
     PlayerViewOffset=(X=8.000000,Y=10.000000,Z=-12.000000)
     PlayerViewPivot=(Pitch=1024,Yaw=-1024)
     BobDamping=1.000000
     AttachmentClass=Class'BWBPRecolorsPro.L8GIAttachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_AmmoPack'
     IconCoords=(X2=127,Y2=31)
     ItemName="L8 GI Ammunition Pack"
     Mesh=SkeletalMesh'BallisticRecolorsAnims.AmmoPack_FP'
     DrawScale=0.400000
     Skins(0)=Texture'BallisticRecolorsTex.AmmoPack.L8GISkin'
}

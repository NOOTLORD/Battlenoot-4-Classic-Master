//=============================================================================
// Damage type class for Unarmed G5
//
// Modified by (NL)NOOTLORD
//=============================================================================
class DTG5Unarmed extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%o was knocked into next week by %k's unarmed G5."
     SimpleKillString="G5 Bazooka Impact"
     DamageIdent="Ordnance"
     bDisplaceAim=False
     bUseMotionBlur=False	 
     WeaponClass=Class'BallisticProV55.G5Bazooka'
     DeathString="%o was knocked into next week by %k's unarmed G5."
     FemaleSuicide="%o somehow managed to hit herself with her own G5 rocket."
     MaleSuicide="%o somehow managed to hit himself with his own G5 rocket."
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=25000.000000
     VehicleDamageScaling=0.000000
     InvasionDamageScaling=1.000000
}

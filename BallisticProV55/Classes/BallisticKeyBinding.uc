// ====================================================================
// BallisticKeyBinding.
//
// Adds some new keys.
// ====================================================================
class BallisticKeyBinding extends GUIUserKeyBinding;

defaultproperties
{
     KeyData(0)=(KeyLabel="Ballistic Weapons",bIsSection=True)
     KeyData(1)=(Alias="Reload|OnRelease ReloadRelease",KeyLabel="Reload")
     KeyData(2)=(Alias="WeaponSpecial|OnRelease WeaponSpecialRelease",KeyLabel="Weapon Special")
     KeyData(3)=(Alias="ScopeView|OnRelease ScopeViewRelease",KeyLabel="Use Sights")
     KeyData(4)=(Alias="Mutate Loadout",KeyLabel="Loadout Menu")
     KeyData(5)=(Alias="Mutate BStartSprint|OnRelease Mutate BStopSprint",KeyLabel="Sprint")
	 KeyData(6)=(Alias="BWStats",KeyLabel="Ballistic Weapons Stats/Manual")
}

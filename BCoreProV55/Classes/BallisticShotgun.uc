class BallisticShotgun extends BallisticWeapon
	abstract
	HideDropDown
	CacheExempt;

simulated function SetScopeBehavior()
{
	Super.SetScopeBehavior();

	if (Role == ROLE_Authority)
		BallisticShotgunAttachment(ThirdPersonActor).bScoped = bScopeView;
}

defaultproperties
{
     bWT_Shotgun=True
}

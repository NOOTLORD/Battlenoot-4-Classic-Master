//=============================================================================
// foxPlayerInput ~fox
// Lazily hijacks PlayerInput to provide mod-independent FOV scaling for both PlayerController and Weapon
// Based off foxMod UT3 Code :)
// Based off and may contain code provided by and Copyright 1998-2015 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class foxPlayerInput extends PlayerInput within PlayerController
	config(User)
	transient;

var bool bShouldSave;
var float CachedFOV;

var globalconfig float Desired43FOV;
var globalconfig float DesiredRatioX;
var globalconfig float DesiredRatioY;
var globalconfig float Desired43MouseSensitivity;

//fox: Hijack this to force FOV per current aspect ratio - done every frame as a lazy catch-all since we're only hooking clientside PlayerInput
event PlayerInput(float DeltaTime)
{
	Super.PlayerInput(DeltaTime);

	//Possibly SaveConfig to create new entries in User.ini - only do this once to save cycles
	//This will also set our CachedFOV so we don't recalculate it every frame
	if (bShouldSave) {
		bShouldSave = false;
		CachedFOV = GetHorPlusFOV(Desired43FOV, 4 / 3.f);
		SaveConfig();
	}

	//Set our FOV if we're not zooming - like FixFOV function but using CachedFOV instead of explicit defaults
	//Note: Older version just called FOV but that actually calls SaveConfig every run! Oops
	if (!bZooming && FOVAngle == DefaultFOV) {
		FOVAngle = CachedFOV;
		DesiredFOV = CachedFOV;
		DefaultFOV = CachedFOV;
	}
}

//fox: Convert vFOV to hFOV (and vice versa)
function float hFOV(float FOV, float AspectRatio)
{
	FOV = FOV * (Pi / 180.0);
	return (180 / Pi) * (2 * ATan(Tan(FOV / 2) * AspectRatio, 1));
}
function float vFOV(float FOV, float AspectRatio)
{
	FOV = FOV * (Pi / 180.0);
	return (180 / Pi) * (2 * ATan(Tan(FOV / 2) * 1/AspectRatio, 1));
}

//fox: Use aspect ratio to auto-generate a Hor+ FOV
function float GetHorPlusFOV(float BaseFOV, float BaseAspectRatio)
{
	if (DesiredRatioY == 0)
		return BaseFOV;
	return hFOV(vFOV(BaseFOV, BaseAspectRatio), DesiredRatioX / DesiredRatioY);
}

//fox: In-game set functions
exec function SetFOV(float FOV)
{
	Desired43FOV = FOV;
	bShouldSave = true;
}
exec function SetRatio(string Ratio)
{
	local array<string> R;

	Split(Ratio, "x", R);
	DesiredRatioX = float(R[0]);
	DesiredRatioY = float(R[1]);
	bShouldSave = true;
}

//fox: Fix options menu not saving
exec function foxPlayerInputApplyDoubleClickTime()
{
	//Hack - DoubleClickTime setting doesn't apply mid-game, so fix it here
	//Note that foxUT2K4Tab_IForceSettings GUI override must be active for this to fire
	//So we'll include it in the other updates too just in-case
	DoubleClickTime = class'PlayerInput'.default.DoubleClickTime;
}
function UpdateSensitivity(float F)
{
	Super.UpdateSensitivity(F);
	class'PlayerInput'.default.MouseSensitivity = MouseSensitivity;
	class'PlayerInput'.static.StaticSaveConfig();
	foxPlayerInputApplyDoubleClickTime();

	Desired43MouseSensitivity = F;
	SaveConfig();
}
function UpdateAccel(float F)
{
	Super.UpdateAccel(F);
	class'PlayerInput'.default.MouseAccelThreshold = MouseAccelThreshold;
	class'PlayerInput'.static.StaticSaveConfig();
	foxPlayerInputApplyDoubleClickTime();
}
function UpdateSmoothing(int Mode)
{
	Super.UpdateSmoothing(Mode);
	class'PlayerInput'.default.MouseSmoothingMode = MouseSmoothingMode;
	class'PlayerInput'.static.StaticSaveConfig();
	foxPlayerInputApplyDoubleClickTime();
}
exec function SetSmoothingStrength(float F)
{
	Super.SetSmoothingStrength(F);
	class'PlayerInput'.default.MouseSmoothingStrength = MouseSmoothingStrength;
	class'PlayerInput'.static.StaticSaveConfig();
	foxPlayerInputApplyDoubleClickTime();
}
function InvertMouse(optional string Invert)
{
	Super.InvertMouse(Invert);
	class'PlayerInput'.default.bInvertMouse = bInvertMouse;
	class'PlayerInput'.static.StaticSaveConfig();
	foxPlayerInputApplyDoubleClickTime();
}

defaultproperties
{
	bShouldSave=true
	CachedFOV=90.0
	Desired43FOV=90.0
	DesiredRatioX=4.0
	DesiredRatioY=3.0
	Desired43MouseSensitivity=-1f
}

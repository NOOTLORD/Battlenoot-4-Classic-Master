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

defaultproperties
{
     bAdjustSampling=True
     MouseSmoothingMode=1
     MouseSmoothingStrength=0.000000
     MouseSensitivity=0.300000
     MouseSamplingTime=0.001000
     DoubleClickTime=0.250000
     bEnableDodging=False
	 bShouldSave=true
	 CachedFOV=90.0
	 Desired43FOV=90.0
	 DesiredRatioX=16.0
	 DesiredRatioY=9.0
}

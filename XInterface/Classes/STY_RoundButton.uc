// ====================================================================
//  Written by Joe Wilcox
//  (c) 2002, Epic Games, Inc.  All Rights Reserved
//
//  Normal push buttons (OK, Cancel, Apply)
// ====================================================================

class STY_RoundButton extends GUIStyles;

defaultproperties
{
     KeyName="RoundButton"
     FontNames(5)="UT2SmallHeaderFont"
     FontNames(6)="UT2SmallHeaderFont"
     FontNames(7)="UT2SmallHeaderFont"
     FontNames(8)="UT2SmallHeaderFont"
     FontNames(9)="UT2SmallHeaderFont"
     FontNames(10)="UT2HeaderFont"
     FontNames(11)="UT2HeaderFont"
     FontNames(12)="UT2HeaderFont"
     FontNames(13)="UT2HeaderFont"
     FontNames(14)="UT2HeaderFont"
     FontColors(0)=(B=255,G=255,R=255)
     FontColors(1)=(B=255,G=255,R=255)
     FontColors(2)=(B=0,G=200,R=230)
     FontColors(3)=(B=0,G=0,R=0)
     Images(0)=Texture'InterfaceContent.Menu.BorderBoxD'
     Images(1)=Texture'InterfaceContent.Menu.ButtonWatched'
     Images(2)=FinalBlend'InterfaceContent.Menu.ButtonBigPulse'
     Images(3)=FinalBlend'InterfaceContent.Menu.fbPlayerHighlight'
     Images(4)=Texture'InterfaceContent.Menu.BorderBoxD'
}
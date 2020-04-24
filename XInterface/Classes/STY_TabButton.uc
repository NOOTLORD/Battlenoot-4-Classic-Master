// ====================================================================
//  Written by Joe Wilcox
//  (c) 2002, Epic Games, Inc.  All Rights Reserved
//
//	Style content for all GUI tabs
// ====================================================================

class STY_TabButton extends GUIStyles;

defaultproperties
{
     KeyName="TabButton"
     FontNames(0)="UT2SmallHeaderFont"
     FontNames(1)="UT2SmallHeaderFont"
     FontNames(2)="UT2SmallHeaderFont"
     FontNames(3)="UT2SmallHeaderFont"
     FontNames(4)="UT2SmallHeaderFont"
     FontColors(0)=(B=255,G=255,R=255)
     FontColors(1)=(B=255,G=255,R=255)
     FontColors(2)=(B=0,G=200,R=230)
     FontColors(3)=(B=0,G=200,R=230)
     Images(0)=Texture'InterfaceContent.Menu.BoxTab'
     Images(1)=Texture'InterfaceContent.Menu.BoxTabWatched'
     Images(2)=FinalBlend'InterfaceContent.Menu.BoxTabPulse'
     Images(3)=FinalBlend'InterfaceContent.Menu.BoxTabPulse2'
}
class UT2k4NewMousePointer extends GUIController;  // UT2K4GUIController;

/* function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super.InitComponent(MyController, MyOwner);

        log("*** MOUSE POINTER ***");
} */

#exec OBJ LOAD FILE=InterfaceContent.utx
#exec OBJ LOAD FIlE=Cat2K4Menus.utx

var int NullVal;
// var editinline   Array<Material>     MouseCursors;

defaultproperties
{
     MouseCursors(0)=Texture'Cat2K4Menus.Cursors.Pointer'
}

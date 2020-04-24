class InventoryAttachment extends Actor
	native
	nativereplication;

cpptext
{
	INT* GetOptimizedRepList( BYTE* Recent, FPropertyRetirement* Retire, INT* Ptr, UPackageMap* Map, UActorChannel* Channel );
}

var bool bFastAttachmentReplication; // only replicates the subset of actor properties needed by basic attachments whose 
									 // common properties don't vary from their defaults
var int inventoryattachment_dummy; // packing for hammer. disregard.  --ryan.

function InitFor(Inventory I)
{
	Instigator = I.Instigator;
}
		
defaultproperties
{
     bFastAttachmentReplication=True
     DrawType=DT_Mesh
     bOnlyDrawIfAttached=True
     bOnlyDirtyReplication=True
     RemoteRole=ROLE_SimulatedProxy
     NetUpdateFrequency=10.000000
     AttachmentBone="righthand"
     bUseLightingFromBase=True
}
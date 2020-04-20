class ShadowBitmapMaterial extends BitmapMaterial
	native;

#exec Texture Import file=Textures\blobshadow.dds Name=BlobTexture Mips=On UCLAMPMODE=CLAMP VCLAMPMODE=CLAMP DXT=3

var const transient pointer TextureInterfaces[2];

var Actor	ShadowActor;
var vector	LightDirection;
var float	LightDistance,
			LightFOV;
var bool	Dirty,
			Invalid,
			bBlobShadow;
var float   CullDistance;
var byte	ShadowDarkness;

var BitmapMaterial	BlobShadow;

cpptext
{
	virtual void Destroy();

	virtual FBaseTexture* GetRenderInterface();
	virtual UBitmapMaterial* Get(FTime Time,UViewport* Viewport);
}

//
//	Default properties
//

defaultproperties
{
     Dirty=True
     ShadowDarkness=255
     BlobShadow=Texture'Engine.BlobTexture'
     Format=TEXF_RGBA8
     UClampMode=TC_Clamp
     VClampMode=TC_Clamp
     UBits=7
     VBits=7
     USize=128
     VSize=128
     UClamp=128
     VClamp=128
}
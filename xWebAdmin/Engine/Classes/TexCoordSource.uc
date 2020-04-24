class TexCoordSource extends TexModifier
	native
	editinlinenew
	collapsecategories;

var() int	SourceChannel;

cpptext
{
	void PostEditChange();
}

defaultproperties
{
     TexCoordSource=TCS_Stream0
}
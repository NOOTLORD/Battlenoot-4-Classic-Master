//----------------------------------------------------------------------------//
// Map Specific LoadingScreen 16:9 ratio
//          by J-Rts
//----------------------------------------------------------------------------//
class UT2k4MapSpecificServerLoading extends UT2K4LoadingPageBase;


var string LoadingScreenPath;


simulated function Material GetLoadingScreen(String mapname)
{
    local material Mat;
    local string texStr;
   	local float random;

    random = FRand();

    texStr = LoadingScreenPath $ "." $ mapname;

    Mat = DLOTexture(texStr);

    // default loading screen
    if (Mat == none && random < 0.25)
    {
        texStr = LoadingScreenPath $ ".Default01";
        Mat = DLOTexture(texStr);
    }
    else if (Mat == none && random < 0.5)
    {
        texStr = LoadingScreenPath $ ".Default02";
        Mat = DLOTexture(texStr);
    }
    else if (Mat == none && random < 0.75)
    {
        texStr = LoadingScreenPath $ ".Default03";
        Mat = DLOTexture(texStr);
    }
    else if (Mat == none)
    {
        texStr = LoadingScreenPath $ ".Default04";
        Mat = DLOTexture(texStr);
    }


    return Mat;
}

simulated event Init()
{
    Super.Init();

	SetImage();
	SetText();
}

simulated function SetImage( )
{
	local material mat;

	mat = Material'MenuBlack';
	DrawOpImage(Operations[0]).Image = mat;

	mat = GetLoadingScreen(MapName);
	DrawOpImage(Operations[0]).Image = mat;
}

simulated function string StripMap(string s)
{
	local int p;

	p = len(s);
	while (p>0)
	{
		if ( mid(s,p,1) == "." )
		{
			s = left(s,p);
			break;
		}
		else
		 p--;
	}

	p = len(s);
	while (p>0)
	{
		if ( mid(s,p,1) == "\\" || mid(s,p,1) == "/" || mid(s,p,1) == ":" )
			return Right(s,len(s)-p-1);
		else
		 p--;
	}

	return s;
}

simulated function SetText()
{
	local DrawOpText HintOp;

	DrawOpText(Operations[2]).Text = StripMap(MapName);

	if (Level.IsSoftwareRendering())
		return;

	HintOp = DrawOpText(Operations[3]);
	if ( HintOp == None )
		return;

    HintOp.Text = ""$GameClass.default.GameName;
}

defaultproperties
{
     LoadingScreenPath="UT2k4MapSpecificLoadingScreens_16-9T"
     Operations(0)=DrawOpImage'GUI2K4.UT2K4LoadingPageBase.OpBackground'
     Operations(1)=DrawOpText'GUI2K4.UT2K4LoadingPageBase.OpLoading'
     Operations(2)=DrawOpText'GUI2K4.UT2K4LoadingPageBase.OpMapname'
	 Operations(3)=DrawOpText'GUI2K4.UT2K4LoadingPageBase.HintOp
}

//changelog:
//version 00226db - mirzi1
//added the ability to change the explorer sideview background
//from windows 2000 to 98, more to come from beta builds

//version ecd05bc - 0x5066
//added general support for anything http, included an inside joke

//version a761cde - 0x5066
//extended to add discord, adding support for youtu.be

//version f334083 - 0x5066 & mirzi1
//added metadata detection (didnt work in previous commit) 
//for internet streams (youtube, soundcloud)

//version 2b8528f - 0x5066
//even more icons, detection is now forced to be lowercase 
//(i.e. MOD is turned into mod, matching what is wanted)

//version dca7a02 - 0x5066
//more icons

//version eae4ef2 - mirzi1
//added actual detection for extensions

//version b22096a - 0x5066
//initial release

//script to change the text objects and layer accordingly
//feel free to steal

#include "lib/std.mi"

Global Container containerPL;
Global Layout layoutPLNormal;
Global Layer ext;
Global Layer coolgraph, coolline;

Global PopUpMenu winmenu;

Global group WasabiFrameGroup;

Global text filenamedisplay, filetypedisplay, hz, kbps;

Function changeIconBasedOnTitle();
Function changeIcon();
Function changeCoolgraph(int preset);

System.onScriptLoaded() {
	containerPL = System.getContainer("PLEdit");

	layoutPLNormal = containerPL.getLayout("normalpl");

	WasabiFrameGroup = layoutPLNormal.findObject("pldir");

	ext = WasabiFrameGroup.getObject("exticon");
	filenamedisplay = WasabiFrameGroup.getObject("filename");
	filetypedisplay = WasabiFrameGroup.getObject("filetype");
	hz = WasabiFrameGroup.getObject("samplerate");
	kbps = WasabiFrameGroup.getObject("bitrate");

	coolgraph = WasabiFrameGroup.getObject("coolgraph");
	coolline = WasabiFrameGroup.getObject("coolline");

	changeIconBasedOnTitle();
	changeCoolgraph(getPrivateInt(getSkinName(), "coolgraph", 1));
}

System.onTitleChange(String newtitle) {
	changeIconBasedOnTitle();		
}

changeIcon(){
	//get file extension
	String extension = System.strlower(System.getExtension(System.removePath(System.getPlayItemString())));

	//change icon according to file extension
	if(extension == "flac"){
		ext.setXmlParam("image", "pl.icon.flac");
	}
	else if(extension == "mp3")
	{
		ext.setXmlParam("image", "pl.icon.mp3");
	}
	else if(extension == "wav")
	{
		ext.setXmlParam("image", "pl.icon.wav");
	}
	else if(extension == "mid" || extension == "midi")
	{
		ext.setXmlParam("image", "pl.icon.midi");
	}
	else if(extension == "mp4" || extension == "avi")
	{
		ext.setXmlParam("image", "pl.icon.video");
	}
	else if(extension == "sid")
	{
		ext.setXmlParam("image", "pl.icon.sid");
	}
	else if(extension == "it")
	{
		ext.setXmlParam("image", "pl.icon.it");
	}
	else if(extension == "xm")
	{
		ext.setXmlParam("image", "pl.icon.xm");
	}
	else if(extension == "s3m")
	{
		ext.setXmlParam("image", "pl.icon.s3m");
	}
	else if(extension == "mod")
	{
		ext.setXmlParam("image", "pl.icon.mod");
	}
	else if(extension == "spc")
	{
		ext.setXmlParam("image", "pl.icon.spc");
	}
	else if(extension == "nsf")
	{
		ext.setXmlParam("image", "pl.icon.nsf");
	}
	else if(extension == "m4a")
	{
		ext.setXmlParam("image", "pl.icon.m4a");
	}
	else if(extension == "opus")
	{
		ext.setXmlParam("image", "pl.icon.opus");
	}
	else if(extension == "ogg")
	{
		ext.setXmlParam("image", "pl.icon.ogg");
	}
	else if(extension == "cda")
	{
		ext.setXmlParam("image", "pl.icon.cda");
	}
	else if(extension == "mptm")
	{
		ext.setXmlParam("image", "pl.icon.mptm");
	}
	else
	{
		ext.setXmlParam("image", "pl.icon.generic");
	}
}

coolgraph.onRightButtonUp (int x, int y)
{
	int currentPreset = getPrivateInt(getSkinName(), "coolgraph", 1);

	winmenu = new PopUpMenu;

	winmenu.addCommand("Presets:", 0, 0, 1);

	winmenu.addSeparator();	

	winmenu.addcommand("Windows 2000", 1, currentPreset == 1,0);
	winmenu.addcommand("Windows 98", 2, currentPreset == 2,0);
	winmenu.addcommand("Windows ME Build 2332", 3, currentPreset == 3,0);
	winmenu.addcommand("Windows ME", 8, currentPreset == 8,0);
	winmenu.addcommand("Windows 2000 Build 1743", 4, currentPreset == 4,0);
	winmenu.addcommand("Windows 2000 Build 1796", 5, currentPreset == 5,0);
	winmenu.addcommand("Windows 2000 Build 1835", 6, currentPreset == 6,0);
	winmenu.addcommand("Windows 2000 Build 1946", 7, currentPreset == 7,0);
	
	int result = winmenu.popAtMouse();

	changeCoolgraph(result);
	
	complete;
}

changeCoolgraph(int preset){
		if(preset>=1 && preset<=8){
			if(preset == 1){
				//default
				//change size
				coolgraph.setXmlParam("w", "127");
				coolgraph.setXmlParam("h", "56");
				coolline.setXmlParam("w", "184");
				coolline.setXmlParam("h", "2");
			}else if(preset == 2){
				//windows 98
				coolgraph.setXmlParam("w", "182");
				coolgraph.setXmlParam("h", "237");
				coolline.setXmlParam("w", "184");
				coolline.setXmlParam("h", "1");
			}else if(preset == 3){
				//Windows ME Build 2332
				coolgraph.setXmlParam("w", "127");
				coolgraph.setXmlParam("h", "56");
				coolline.setXmlParam("w", "184");
				coolline.setXmlParam("h", "2");
			}else if(preset == 4){
				//Windows 2000 Build 1743
				coolgraph.setXmlParam("w", "161");
				coolgraph.setXmlParam("h", "78");
				coolline.setXmlParam("w", "184");
				coolline.setXmlParam("h", "3");
			}else if(preset == 5){
				//Windows 2000 Build 1796
				coolgraph.setXmlParam("w", "151");
				coolgraph.setXmlParam("h", "69");
				coolline.setXmlParam("w", "184");
				coolline.setXmlParam("h", "3");
			}else if(preset == 6){
				//Windows 2000 Build 1835
				coolgraph.setXmlParam("w", "118");
				coolgraph.setXmlParam("h", "48");
				coolline.setXmlParam("w", "184");
				coolline.setXmlParam("h", "2");
			}else if(preset == 7){
				//Windows 2000 Build 1946
				coolgraph.setXmlParam("w", "118");
				coolgraph.setXmlParam("h", "48");
				coolline.setXmlParam("w", "184");
				coolline.setXmlParam("h", "2");
			}else if(preset == 8){
				//Windows ME 
				coolgraph.setXmlParam("w", "150");
				coolgraph.setXmlParam("h", "56");
				coolline.setXmlParam("w", "184");
				coolline.setXmlParam("h", "2");
			}

		//change image
		coolgraph.setXmlParam("image", "explorerleft"+integerToString(preset));
		coolline.setXmlParam("image", "explorerline"+integerToString(preset));
		//set private int
		setPrivateInt(getSkinName(), "coolgraph", preset);
	}
}

changeIconBasedOnTitle(){
	
	filenamedisplay.setXmlParam("text", System.removePath(System.getPlayItemString())); //set filename
	filetypedisplay.setXmlParam("text", system.getDecoderName(system.getPlayItemString())); //set decoder name

	//get title
	String streamtitle = System.strlower(System.getPlayItemString());

	//change icon according to the title
	if(System.strsearch(streamtitle, "youtube") != -1){
		ext.setXmlParam("image", "pl.icon.yt");
	}
	else if(System.strsearch(streamtitle, "youtu.be") != -1){
		ext.setXmlParam("image", "pl.icon.yt");
	}
	else if(System.strsearch(streamtitle, "linein://") != -1){
		ext.setXmlParam("image", "pl.icon.sound");
	}
	else if(System.strsearch(streamtitle, "soundcloud") != -1){
		ext.setXmlParam("image", "pl.icon.soundcloud");
	}
	else if(System.strsearch(streamtitle, "cdn.discordapp.com") != -1){
		ext.setXmlParam("image", "pl.icon.dicksword");
	}
	else if(System.strsearch(streamtitle, "media.discordapp.net") != -1){
		ext.setXmlParam("image", "pl.icon.dicksword");
	}
	else if(System.strsearch(streamtitle, "http") != -1){
		ext.setXmlParam("image", "pl.icon.ie");
	}
	else{
		changeIcon();
	}
}

//script to change the text objects and layer accordingly
//feel free to steal

#include "lib/std.mi"

Global Container containerPL;
Global Layout layoutPLNormal;
Global Layer ext;
Global Layer coolgraph, coolline;

Global PopUpMenu visMenu;

Global group WasabiFrameGroup;

global text filenamedisplay, filetypedisplay, hz, kbps;

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

  	visMenu = new PopUpMenu;

  	visMenu.addCommand("Presets:", 0, 0, 1);

	vismenu.addSeparator();	
  	  
	vismenu.addcommand("Windows 2000", 1, currentPreset == 1,0);
	vismenu.addcommand("Windows 98", 2, currentPreset == 2,0);
	vismenu.addcommand("um", 3, currentPreset == 3,0);
  	
	int result = vismenu.popAtMouse();
 
	changeCoolgraph(result);

	setPrivateInt(getSkinName(), "coolgraph", result);
	
	complete;
}

changeCoolgraph(int preset){
	if(preset == 1){
		//default
		//change size
		coolgraph.setXmlParam("w", "127");
		coolgraph.setXmlParam("h", "56");
		coolline.setXmlParam("w", "152");
		coolline.setXmlParam("h", "2");
		//change image
		coolgraph.setXmlParam("image", "explorerleft"+integerToString(preset));
		coolline.setXmlParam("image", "explorerline"+integerToString(preset));
	}else if(preset == 2){
		//windows 98
		coolgraph.setXmlParam("w", "182");
		coolgraph.setXmlParam("h", "237");
		coolline.setXmlParam("w", "168");
		coolline.setXmlParam("h", "1");

		coolgraph.setXmlParam("image", "explorerleft"+integerToString(preset));
		coolline.setXmlParam("image", "explorerline"+integerToString(preset));
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
	else if(System.strsearch(streamtitle, "blumenkranz") != -1){
		ext.setXmlParam("image", "pl.icon.blumenkranz");
		filenamedisplay.setXmlParam("text", "Milf Music");
		filetypedisplay.setXmlParam("text", "Nullsoft Milf Music Decoder v4.20.69");
	}
	else{
		changeIcon();
	}
}
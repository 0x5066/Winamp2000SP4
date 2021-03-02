//script to change the text objects accordingly
//feel free to steal

#include "lib/std.mi"

Global Container containerPL;
Global Layout layoutPLNormal;
Global Layer ext;

Global group WasabiFrameGroup;

global text filenamedisplay, filetypedisplay, hz, kbps;

Function refreshPlInfo();

System.onScriptLoaded() {
  containerPL = System.getContainer("PLEdit");

	layoutPLNormal = containerPL.getLayout("normalpl");

	WasabiFrameGroup = layoutPLNormal.findObject("pldir");

	ext = WasabiFrameGroup.getObject("exticon");
	filenamedisplay = WasabiFrameGroup.getObject("filename");
	filetypedisplay = WasabiFrameGroup.getObject("filetype");
	hz = WasabiFrameGroup.getObject("samplerate");
	kbps = WasabiFrameGroup.getObject("bitrate");

	refreshPlInfo();
}

System.onTitleChange(String newtitle) {
	refreshPlInfo();		
}

refreshPlInfo(){
	filenamedisplay.setXmlParam("text", System.removePath(System.getPlayItemString()));
	filetypedisplay.setXmlParam("text", system.getDecoderName(system.getPlayItemString()));
	//hz.setXmlParam("text", "Samplerate: "+System.getPlayItemMetaDataString("srate")+ "hz");
	//kbps.setXmlParam("text", "Bitrate: "+System.getPlayItemMetaDataString("vbr")+"kbps");

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
	else
	{
		ext.setXmlParam("image", "pl.icon.generic");
	}
}

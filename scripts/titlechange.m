//script to change the text objects accordingly
//feel free to steal

#include "lib/std.mi"

Global Container containerPL;
Global Layout layoutPLNormal;
Global Layer ext;

Global group WasabiFrameGroup;

global text filenamedisplay, filetypedisplay, hz, kbps;

System.onScriptLoaded() {
  containerPL = System.getContainer("PLEdit");

	layoutPLNormal = containerPL.getLayout("normalpl");

	WasabiFrameGroup = layoutPLNormal.findObject("pldir");

	ext = WasabiFrameGroup.getObject("exticon");
	filenamedisplay = WasabiFrameGroup.getObject("filename");
	filetypedisplay = WasabiFrameGroup.getObject("filetype");
	hz = WasabiFrameGroup.getObject("samplerate");
	kbps = WasabiFrameGroup.getObject("bitrate");

		filenamedisplay.setXmlParam("text", System.removePath(System.getPlayItemString()));
		filetypedisplay.setXmlParam("text", system.getDecoderName(system.getPlayItemString()));
		//hz.setXmlParam("text", "Samplerate: "+System.getPlayItemMetaDataString("srate")+ "hz");
		//kbps.setXmlParam("text", "Bitrate: "+System.getPlayItemMetaDataString("vbr")+"kbps");
}

System.onTitleChange(String newtitle) {
		filenamedisplay.setXmlParam("text", System.removePath(System.getPlayItemString()));
		filetypedisplay.setXmlParam("text", system.getDecoderName(system.getPlayItemString()));
		//hz.setXmlParam("text", "Samplerate: "+System.getPlayItemMetaDataString("srate")+ "hz");
		//kbps.setXmlParam("text", "Bitrate: "+System.getPlayItemMetaDataString("vbr")+"kbps");
}

/* doesnt work unfortunately :(
if(System.getExtension("flac"))
{
	ext.setXmlParam("image", "flac");
}
*/
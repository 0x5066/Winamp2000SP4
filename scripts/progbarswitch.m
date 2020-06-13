#include "lib/std.mi"

Function setVis (int mode);
Function changeIEBARmode(int add);
//Function ProcessMenuResult (int a);

Global Layout layoutPLNormal;
Global Container containerPL;
Global Group PLGroupMain;
Global GuiObject IEBAR;
Global AnimatedLayer VUBAR_L, VUBAR_R;

Global Int newCurrentMode;
Global layer NewTrigger;

System.onScriptLoaded()
{ 
  	containerPL = System.getContainer("PLEdit");
	layoutPLNormal = containerPL.getLayout("normalpl");
	PLGroupMain = layoutPLNormal.findObject("some.complex.stuff");

	NewTrigger = PLGroupMain.findObject("bar.switcher");
	VUBAR_L = PLGroupMain.findObject("vguivis.animatedlayerL");
	VUBAR_R = PLGroupMain.findObject("vguivis.animatedlayerR");
	IEBAR = PLGroupMain.findObject("IEBAR");

	newCurrentMode = getPrivateInt(getSkinName(), "IEBAR mode", newCurrentMode);
	changeIEBARmode(0);
}

system.onScriptUnloading ()
{
	setPrivateInt(getSkinName(), "IEBAR mode", newCurrentMode);
}

NewTrigger.onLeftButtonDown (int x, int y)
{
	changeIEBARmode(1);
}

changeIEBARmode(int add){
	if(add==1){
		newCurrentMode++;
		//increase when add==1
		//if 0 then keep value
	}

	if (newCurrentMode >= 3)
	{
		newCurrentMode = 0;
	}

	//this mess
	//why does maki not have switch case i swear to god
	if (newCurrentMode == 0)
	{
		IEBAR.setXmlParam("visible", "1");
		VUBAR_L.setXmlParam("visible", "0");
		VUBAR_R.setXmlParam("visible", "0");
	}
	else if (newCurrentMode == 1)
	{
		IEBAR.setXmlParam("visible", "0");
		VUBAR_L.setXmlParam("visible", "1");
		VUBAR_R.setXmlParam("visible", "1");
	}
	else if (newCurrentMode == 2)
	{
		IEBAR.setXmlParam("visible", "0");
		VUBAR_L.setXmlParam("visible", "0");
		VUBAR_R.setXmlParam("visible", "0");
	}

	/*
	setVis	(newCurrentMode);		//  ¯\_(ツ)_/¯
	complete;
	*/
}


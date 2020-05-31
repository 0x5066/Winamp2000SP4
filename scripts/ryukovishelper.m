#include "lib/std.mi"

Function refreshVisSettings();
Function setVis (int mode);
//Function ProcessMenuResult (int a);

Global Layout layoutMainNormal;
Global Container containerMain;
Global Group NormalGroupMain;
Global Vis visualizertl, visualizertr, visualizerbl, visualizerbr;

Global PopUpMenu visMenu;

Global Int currentMode;
Global layer Trigger;

System.onScriptLoaded()
{ 
  containerMain = System.getContainer("ryuko");
	layoutMainNormal = containerMain.getLayout("normal");
	NormalGroupMain = layoutMainNormal.findObject("ryukovis");
	Trigger = NormalGroupMain.findObject("ryuko.vis.trigger");

	visualizertl = NormalGroupMain.findObject("topleft.vis");
	visualizertr = NormalGroupMain.findObject("topright.vis");
	visualizerbl = NormalGroupMain.findObject("bottomleft.vis");
	visualizerbr = NormalGroupMain.findObject("bottomright.vis");

	refreshVisSettings ();
}

refreshVisSettings ()
{
	currentMode = getPrivateInt(getSkinName(), "Visualizer Mode", 1);
	
	setVis (currentMode);
}

Trigger.onLeftButtonDown (int x, int y)
{
	currentMode++;

	if (currentMode == 3)
	{
		currentMode = 0;
	}

	setVis	(currentMode);
	complete;
}

Trigger.onRightButtonUp (int x, int y)
{
	visMenu = new PopUpMenu;

	visMenu.addCommand("No Visualization", 100, currentMode == 0, 0);
	visMenu.addCommand("Oscilloscope", 101, currentMode == 1, 0);
	visMenu.addCommand("Spectrum Analyzer", 102, currentMode == 2, 0);

	//ProcessMenuResult (visMenu.popAtMouse());

	delete visMenu;

	complete;	
}

setVis (int mode)
{
	setPrivateInt(getSkinName(), "Visualizer Mode", mode);
	if (mode == 0)
	{
		visualizertl.setMode(0);
		visualizertr.setMode(0);
		visualizerbl.setMode(0);
		visualizerbr.setMode(0);
	}
	else if (mode == 1)
	{
		visualizertl.setMode(1);
		visualizertr.setMode(1);
		visualizerbl.setMode(1);
		visualizerbr.setMode(1);
	}
	else if (mode == 2)
	{
		visualizertl.setMode(2);
		visualizertr.setMode(2);
		visualizerbl.setMode(2);
		visualizerbr.setMode(2);
	}
	currentMode = mode;
}

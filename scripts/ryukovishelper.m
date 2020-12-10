#include "lib/std.mi"

Function refreshVisSettings();
Function setVis (int mode);
Function ProcessMenuResult (int a);

Global Layout layoutMainNormal;
Global Container containerMain;
Global Group NormalGroupMain;
Global Vis visualizertl, visualizertr, visualizerbl, visualizerbr;

Global Int newCurrentMode;
Global layer NewTrigger;

System.onScriptLoaded()
{ 
  containerMain = System.getContainer("ryuko");
	layoutMainNormal = containerMain.getLayout("stupidassworkaround");
	NormalGroupMain = layoutMainNormal.findObject("ryukovis");
	NewTrigger = NormalGroupMain.findObject("ryuko.vis.trigger");

	visualizertl = NormalGroupMain.findObject("topleft");
	visualizertr = NormalGroupMain.findObject("topright");
	visualizerbl = NormalGroupMain.findObject("bottomleft");
	visualizerbr = NormalGroupMain.findObject("bottomright");

	refreshVisSettings ();
}

refreshVisSettings ()
{
	newCurrentMode = getPrivateInt(getSkinName(), "New Visualizer Mode", 1);
	
	setVis (newCurrentMode);
}

NewTrigger.onLeftButtonDown (int x, int y)
{
	newCurrentMode++;

	if (newCurrentMode == 3)
	{
		newCurrentMode = 0;
	}

	setVis	(newCurrentMode);
	complete;
}

NewTrigger.onRightButtonDown (int x, int y)
{
	PopUpMenu newVisMenu = new PopUpMenu;

	newVisMenu.addCommand("No Visualization", 100, newCurrentMode == 0, 0);
	newVisMenu.addCommand("Spectrum Analyzer", 101, newCurrentMode == 1, 0);
	newVisMenu.addCommand("Oscilloscope", 102, newCurrentMode == 2, 0);

	ProcessMenuResult (newVisMenu.popAtMouse());
	complete;
}

ProcessMenuResult (int a)
{
	if (a < 1) return;

	if (a > 0 && a <= 2 || a == 100)
	{
		if (a == 100) a = 0;
		setVis(a);
	}

}
setVis (int mode)
{
	setPrivateInt(getSkinName(), "New Visualizer Mode", mode);
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
	newCurrentMode = mode;
}

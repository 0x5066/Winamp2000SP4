#include "lib/std.mi"

Function setVis (int mode);
//Function ProcessMenuResult (int a);

Global Layout layoutPLNormal;
Global Container containerPL;
Global Group PLGroupMain;
Global ProgressGrid IEBAR;
Global AnimatedLayer VUBAR_L, VUBAR_L;

Global Int newCurrentMode;
Global layer NewTrigger;

System.onScriptLoaded()
{ 
  containerPL = System.getContainer("normalpl");
	layoutPLNormal = containerPL.getLayout("normalpl");
	PLGroupMain = layoutPLNormal.findObject("some.complex.stuff");
	NewTrigger = PLGroupMain.findObject("bar.switcher");

	VUBAR_L = NormalGroupMain.findObject("topleft");
	VUBAR_L = NormalGroupMain.findObject("topright");

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


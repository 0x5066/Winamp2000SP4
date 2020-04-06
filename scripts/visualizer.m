#include "lib/std.mi"

Function refreshVisSettings();
Function setVis (int mode);
Function ProcessMenuResult (int a);

Global Container containerMain;
Global Container containerPL;
Global Layout layoutPL, layoutMainNormal, layoutMainShade;
Global Group NormalGroupMain, NormalGroupDisplay, ShadeGroupMain, ShadeGroupDisplay;
Global Vis visualizer, visualizershade, visualizerpl;
Global Button OAIDUBtnUE1, OAIDUBtnUE2, OAIDUBtnUE3;

Global PopUpMenu visMenu;
Global PopUpMenu specmenu;
Global PopUpMenu oscmenu;
Global PopUpMenu pksmenu;
Global PopUpMenu anamenu;
Global PopUpMenu stylemenu;
Global PopUpMenu fpsmenu;
Global PopUpMenu colmenu;

Global Int currentMode, a_falloffspeed, p_falloffspeed, a_coloring, v_fps, v_color;
Global Boolean show_peaks;
Global layer Trigger, HideForVic, TriggerBlocker, TriggerBlockerShade;



System.onScriptLoaded()
{ 
  containerMain = System.getContainer("main");
	layoutMainNormal = containerMain.getLayout("normal");
	NormalGroupMain = layoutMainNormal.findObject("player.normal.group.main");
	NormalGroupDisplay = NormalGroupMain.findObject("player.normal.group.display");
	OAIDUBtnUE1 = NormalGroupDisplay.findObject("OAIDU.buttons.U.menuentry1");
  OAIDUBtnUE2 = NormalGroupDisplay.findObject("OAIDU.buttons.U.menuentry2");
  OAIDUBtnUE3 = NormalGroupDisplay.findObject("OAIDU.buttons.U.menuentry3");

	visualizer = NormalGroupDisplay.findObject("player.vis");

	layoutMainShade = containerMain.getLayout("shade");
	ShadeGroupMain = layoutMainShade.findObject("player.shade.group.main");
	ShadeGroupDisplay = ShadeGroupMain.findObject("player.shade.group.display");
	visualizershade = ShadeGroupDisplay.findObject("shade.vis");
		
  containerPL = System.getContainer("PLEdit");
  layoutPL = containerPL.getLayout("normalpl");
	visualizerpl = layoutPL.findObject("shade.vis");


	Trigger = NormalGroupDisplay.findObject("player.vis.trigger");
	TriggerBlocker = layoutPL.findObject("player.vis.blocker");
	TriggerBlockerShade = ShadeGroupDisplay.findObject("player.vis.blocker");
	HideForVic = NormalGroupDisplay.findObject("hide.for.vic");

	visualizer.setXmlParam("peaks", integerToString(show_peaks));
	visualizer.setXmlParam("peakfalloff", integerToString(p_falloffspeed));
	visualizer.setXmlParam("falloff", integerToString(a_falloffspeed));
	visualizer.setXmlParam("fps", integerToString(v_fps));
	visualizer.setXmlParam("ColorBand1", integerToString(v_color));
	visualizer.setXmlParam("ColorBand2", integerToString(v_color));
	visualizer.setXmlParam("ColorBand3", integerToString(v_color));
	visualizer.setXmlParam("ColorBand4", integerToString(v_color));
	visualizer.setXmlParam("ColorBand5", integerToString(v_color));
	visualizer.setXmlParam("ColorBand6", integerToString(v_color));
	visualizer.setXmlParam("ColorBand7", integerToString(v_color));
	visualizer.setXmlParam("ColorBand8", integerToString(v_color));
	visualizer.setXmlParam("ColorBand9", integerToString(v_color));
	visualizer.setXmlParam("ColorBand10", integerToString(v_color));
	visualizer.setXmlParam("ColorBand11", integerToString(v_color));
	visualizer.setXmlParam("ColorBand12", integerToString(v_color));
	visualizer.setXmlParam("ColorBand13", integerToString(v_color));
	visualizer.setXmlParam("ColorBand14", integerToString(v_color));
	visualizer.setXmlParam("ColorBand15", integerToString(v_color));
	visualizer.setXmlParam("ColorBand16", integerToString(v_color));
	visualizer.setXmlParam("colorbandpeak", integerToString(v_color));
	visualizer.setXmlParam("colorosc1", integerToString(v_color));
	visualizer.setXmlParam("colorosc2", integerToString(v_color));
	visualizer.setXmlParam("colorosc3", integerToString(v_color));
	visualizer.setXmlParam("colorosc4", integerToString(v_color));
	visualizer.setXmlParam("colorosc5", integerToString(v_color));
	visualizer.setXmlParam("colorallbands", integerToString(v_color));

	visualizershade.setXmlParam("peaks", integerToString(show_peaks));
	visualizershade.setXmlParam("peakfalloff", integerToString(p_falloffspeed));
	visualizershade.setXmlParam("falloff", integerToString(a_falloffspeed));

	visualizerpl.setXmlParam("peaks", integerToString(show_peaks));
	visualizerpl.setXmlParam("peakfalloff", integerToString(p_falloffspeed));
	visualizerpl.setXmlParam("falloff", integerToString(a_falloffspeed));
	

	refreshVisSettings ();
}

visualizerpl.onSetVisible(int on) {
	if (on) refreshVisSettings ();
}

visualizershade.onSetVisible(int on) {
	if (on) refreshVisSettings ();
}

refreshVisSettings ()
{
	currentMode = getPrivateInt(getSkinName(), "Visualizer Mode", 1);
	show_peaks = getPrivateInt(getSkinName(), "Visualizer show Peaks", 1);
	a_falloffspeed = getPrivateInt(getSkinName(), "Visualizer analyzer falloff", 3);
	p_falloffspeed = getPrivateInt(getSkinName(), "Visualizer peaks falloff", 2);
	a_coloring = getPrivateInt(getSkinName(), "Visualizer analyzer coloring", 0);
	v_fps = getPrivateInt(getSkinName(), "Visualizer FPS", 4);
	v_color = getPrivateInt(getSkinName(), "Visualizer Color themes", 5);

	visualizer.setXmlParam("peaks", integerToString(show_peaks));
	visualizer.setXmlParam("peakfalloff", integerToString(p_falloffspeed));
	visualizer.setXmlParam("falloff", integerToString(a_falloffspeed));
	visualizer.setXmlParam("fps", integerToString(v_fps));
	visualizer.setXmlParam("ColorBand1", integerToString(v_color));
	visualizer.setXmlParam("ColorBand2", integerToString(v_color));
	visualizer.setXmlParam("ColorBand3", integerToString(v_color));
	visualizer.setXmlParam("ColorBand4", integerToString(v_color));
	visualizer.setXmlParam("ColorBand5", integerToString(v_color));
	visualizer.setXmlParam("ColorBand6", integerToString(v_color));
	visualizer.setXmlParam("ColorBand7", integerToString(v_color));
	visualizer.setXmlParam("ColorBand8", integerToString(v_color));
	visualizer.setXmlParam("ColorBand9", integerToString(v_color));
	visualizer.setXmlParam("ColorBand10", integerToString(v_color));
	visualizer.setXmlParam("ColorBand11", integerToString(v_color));
	visualizer.setXmlParam("ColorBand12", integerToString(v_color));
	visualizer.setXmlParam("ColorBand13", integerToString(v_color));
	visualizer.setXmlParam("ColorBand14", integerToString(v_color));
	visualizer.setXmlParam("ColorBand15", integerToString(v_color));
	visualizer.setXmlParam("ColorBand16", integerToString(v_color));
	visualizer.setXmlParam("colorbandpeak", integerToString(v_color));
	visualizer.setXmlParam("colorosc1", integerToString(v_color));
	visualizer.setXmlParam("colorosc2", integerToString(v_color));
	visualizer.setXmlParam("colorosc3", integerToString(v_color));
	visualizer.setXmlParam("colorosc4", integerToString(v_color));
	visualizer.setXmlParam("colorosc5", integerToString(v_color));
	visualizer.setXmlParam("colorallbands", integerToString(v_color));

	visualizershade.setXmlParam("peaks", integerToString(show_peaks));
	visualizershade.setXmlParam("peakfalloff", integerToString(p_falloffspeed));
	visualizershade.setXmlParam("falloff", integerToString(a_falloffspeed));	

	visualizerpl.setXmlParam("peaks", integerToString(show_peaks));
	visualizerpl.setXmlParam("peakfalloff", integerToString(p_falloffspeed));
	visualizerpl.setXmlParam("falloff", integerToString(a_falloffspeed));

	if (a_coloring == 0)
	{
		visualizer.setXmlParam("coloring", "Normal");
		visualizershade.setXmlParam("coloring", "Normal");
		visualizerpl.setXmlParam("coloring", "Normal");
	}
	else if (a_coloring == 1)
	{
		visualizer.setXmlParam("coloring", "Normal");
		visualizershade.setXmlParam("coloring", "Normal");
		visualizerpl.setXmlParam("coloring", "Normal");
	}
	else if (a_coloring == 2)
	{
		visualizer.setXmlParam("coloring", "Fire");
		visualizershade.setXmlParam("coloring", "Fire");
		visualizerpl.setXmlParam("coloring", "Fire");
	}
	else if (a_coloring == 3)
	{
		visualizer.setXmlParam("coloring", "Line");
		visualizershade.setXmlParam("coloring", "Line");
		visualizerpl.setXmlParam("coloring", "Line");
	}
	
	if (v_fps == 0)
	{
		visualizer.setXmlParam("fps", "30");
	}
	else if (v_fps == 1)
	{
		visualizer.setXmlParam("fps", "30");
	}
	else if (v_fps == 2)
	{
		visualizer.setXmlParam("fps", "60");
	}
	else if (v_fps == 3)
	{
		visualizer.setXmlParam("fps", "75");
	}
	else if (v_fps == 4)
	{
		visualizer.setXmlParam("fps", "512");
	}
	if (v_color == 0)
		{
			visualizer.setXmlParam("ColorBand1", "22,131,7");
			visualizer.setXmlParam("ColorBand2", "39,147,0");
			visualizer.setXmlParam("ColorBand3", "47,155,7");
			visualizer.setXmlParam("ColorBand4", "55,180,15");
			visualizer.setXmlParam("ColorBand5", "48,189,15");
			visualizer.setXmlParam("ColorBand6", "39,205,15");
			visualizer.setXmlParam("ColorBand7", "146,221,32");
			visualizer.setXmlParam("ColorBand8", "187,221,40");
			visualizer.setXmlParam("ColorBand9", "212,180,32");
			visualizer.setXmlParam("ColorBand10", "220,164,23");
			visualizer.setXmlParam("ColorBand11", "197,122,7");
			visualizer.setXmlParam("ColorBand12", "213,114,0");
			visualizer.setXmlParam("ColorBand13", "213,101,0");
			visualizer.setXmlParam("ColorBand14", "213,89,0");
			visualizer.setXmlParam("ColorBand15", "205,40,15");
			visualizer.setXmlParam("ColorBand16", "238,48,15");
			visualizer.setXmlParam("colorbandpeak", "150,150,150");
			visualizer.setXmlParam("colorosc1", "255,255,255");
			visualizer.setXmlParam("colorosc2", "214,214,222");
			visualizer.setXmlParam("colorosc3", "181,189,189");
			visualizer.setXmlParam("colorosc4", "160,170,175");
			visualizer.setXmlParam("colorosc5", "148,156,165");
		}
		else if (v_color == 1)
		{
			visualizer.setXmlParam("ColorBand1", "22,131,7");
			visualizer.setXmlParam("ColorBand2", "39,147,0");
			visualizer.setXmlParam("ColorBand3", "47,155,7");
			visualizer.setXmlParam("ColorBand4", "55,180,15");
			visualizer.setXmlParam("ColorBand5", "48,189,15");
			visualizer.setXmlParam("ColorBand6", "39,205,15");
			visualizer.setXmlParam("ColorBand7", "146,221,32");
			visualizer.setXmlParam("ColorBand8", "187,221,40");
			visualizer.setXmlParam("ColorBand9", "212,180,32");
			visualizer.setXmlParam("ColorBand10", "220,164,23");
			visualizer.setXmlParam("ColorBand11", "197,122,7");
			visualizer.setXmlParam("ColorBand12", "213,114,0");
			visualizer.setXmlParam("ColorBand13", "213,101,0");
			visualizer.setXmlParam("ColorBand14", "213,89,0");
			visualizer.setXmlParam("ColorBand15", "205,40,15");
			visualizer.setXmlParam("ColorBand16", "238,48,15");
			visualizer.setXmlParam("colorbandpeak", "150,150,150");
			visualizer.setXmlParam("colorosc1", "255,255,255");
			visualizer.setXmlParam("colorosc2", "214,214,222");
			visualizer.setXmlParam("colorosc3", "181,189,189");
			visualizer.setXmlParam("colorosc4", "160,170,175");
			visualizer.setXmlParam("colorosc5", "148,156,165");
		}
		else if (v_color == 2)
		{
			visualizer.setXmlParam("colorallbands", "0,176,32");
			visualizer.setXmlParam("colorbandpeak", "32,32,255");
			visualizer.setXmlParam("colorosc1", "160,255,160");
			visualizer.setXmlParam("colorosc2", "160,255,160");
			visualizer.setXmlParam("colorosc3", "160,255,160");
			visualizer.setXmlParam("colorosc4", "160,255,160");
			visualizer.setXmlParam("colorosc5", "160,255,160");
		}
		else if (v_color == 3)
		{
			visualizer.setXmlParam("colorallbands", "0,0,255");
			visualizer.setXmlParam("colorbandpeak", "255,255,255");
			visualizer.setXmlParam("colorosc1", "160,255,160");
			visualizer.setXmlParam("colorosc2", "160,255,160");
			visualizer.setXmlParam("colorosc3", "160,255,160");
			visualizer.setXmlParam("colorosc4", "160,255,160");
			visualizer.setXmlParam("colorosc5", "160,255,160");
		}
		else if (v_color == 4)
		{
			visualizer.setXmlParam("colorallbands", "255,165,0");
			visualizer.setXmlParam("colorbandpeak", "255,0,0");
			visualizer.setXmlParam("colorosc1", "160,255,160");
			visualizer.setXmlParam("colorosc2", "160,255,160");
			visualizer.setXmlParam("colorosc3", "160,255,160");
			visualizer.setXmlParam("colorosc4", "160,255,160");
			visualizer.setXmlParam("colorosc5", "160,255,160");
		}
		else if (v_color == 5)
		{
			visualizer.setXmlParam("ColorBand1", "242,244,247");
			visualizer.setXmlParam("ColorBand2", "172,185,209");
			visualizer.setXmlParam("ColorBand3", "242,244,247");
			visualizer.setXmlParam("ColorBand4", "172,185,209");
			visualizer.setXmlParam("ColorBand5", "242,244,247");
			visualizer.setXmlParam("ColorBand6", "172,185,209");
			visualizer.setXmlParam("ColorBand7", "242,244,247");
			visualizer.setXmlParam("ColorBand8", "172,185,209");
			visualizer.setXmlParam("ColorBand9", "242,244,247");
			visualizer.setXmlParam("ColorBand10", "172,185,209");
			visualizer.setXmlParam("ColorBand11", "242,244,247");
			visualizer.setXmlParam("ColorBand12", "172,185,209");
			visualizer.setXmlParam("ColorBand13", "242,244,247");
			visualizer.setXmlParam("ColorBand14", "172,185,209");
			visualizer.setXmlParam("ColorBand15", "242,244,247");
			visualizer.setXmlParam("ColorBand16", "172,185,209");
			visualizer.setXmlParam("colorbandpeak", "242,244,247");
			visualizer.setXmlParam("colorosc1", "242,244,247");
			visualizer.setXmlParam("colorosc2", "242,244,247");
			visualizer.setXmlParam("colorosc3", "242,244,247");
			visualizer.setXmlParam("colorosc4", "242,244,247");
			visualizer.setXmlParam("colorosc5", "242,244,247");
		}
		else if (v_color == 6)
		{
			visualizer.setXmlParam("ColorBand1", "82,97,102");
			visualizer.setXmlParam("ColorBand2", "74,88,93");
			visualizer.setXmlParam("ColorBand3", "78,92,97");
			visualizer.setXmlParam("ColorBand4", "83,97,104");
			visualizer.setXmlParam("ColorBand5", "88,102,107");
			visualizer.setXmlParam("ColorBand6", "94,107,112");
			visualizer.setXmlParam("ColorBand7", "100,113,118");
			visualizer.setXmlParam("ColorBand8", "106,120,125");
			visualizer.setXmlParam("ColorBand9", "112,121,131");
			visualizer.setXmlParam("ColorBand10", "117,131,136");
			visualizer.setXmlParam("ColorBand11", "122,137,142");
			visualizer.setXmlParam("ColorBand12", "127,141,146");
			visualizer.setXmlParam("ColorBand13", "131,145,150");
			visualizer.setXmlParam("ColorBand14", "136,150,155");
			visualizer.setXmlParam("ColorBand15", "140,154,159");
			visualizer.setXmlParam("ColorBand16", "145,159,164");
			visualizer.setXmlParam("colorbandpeak", "162,193,204");
			visualizer.setXmlParam("colorosc1", "82,97,102");
			visualizer.setXmlParam("colorosc2", "83,97,104");
			visualizer.setXmlParam("colorosc3", "106,120,125");
			visualizer.setXmlParam("colorosc4", "127,141,146");
			visualizer.setXmlParam("colorosc5", "145,159,164");
		}
		else if (v_color == 7)
		{
			visualizer.setXmlParam("ColorBand1", "#5a5490");
			visualizer.setXmlParam("ColorBand2", "#60599a");
			visualizer.setXmlParam("ColorBand3", "#665ea1");
			visualizer.setXmlParam("ColorBand4", "#6c63ac");
			visualizer.setXmlParam("ColorBand5", "#7368b1");
			visualizer.setXmlParam("ColorBand6", "#7a6dba");
			visualizer.setXmlParam("ColorBand7", "#8274c4");
			visualizer.setXmlParam("ColorBand8", "#8a7ad0");
			visualizer.setXmlParam("ColorBand9", "#927bd9");
			visualizer.setXmlParam("ColorBand10", "#9985e1");
			visualizer.setXmlParam("ColorBand11", "#9f8ceb");
			visualizer.setXmlParam("ColorBand12", "#a590f2");
			visualizer.setXmlParam("ColorBand13", "#aa94f9");
			visualizer.setXmlParam("ColorBand14", "#b199fa");
			visualizer.setXmlParam("ColorBand15", "#bda4fc");
			visualizer.setXmlParam("ColorBand16", "#bda4fc");
			visualizer.setXmlParam("colorbandpeak", "#b5bffb");
			visualizer.setXmlParam("colorosc1", "#665ea1");
			visualizer.setXmlParam("colorosc2", "#7a6dba");
			visualizer.setXmlParam("colorosc3", "#927bd9");
			visualizer.setXmlParam("colorosc4", "#9f8ceb");
			visualizer.setXmlParam("colorosc5", "#b199fa");
		}
		else if (v_color == 8)
		{
			visualizer.setXmlParam("ColorBand1", "255,4,55");
			visualizer.setXmlParam("ColorBand2", "242,5,55");
			visualizer.setXmlParam("ColorBand3", "229,6,55");
			visualizer.setXmlParam("ColorBand4", "217,7,57");
			visualizer.setXmlParam("ColorBand5", "203,10,56");
			visualizer.setXmlParam("ColorBand6", "190,10,58");
			visualizer.setXmlParam("ColorBand7", "177,12,58");
			visualizer.setXmlParam("ColorBand8", "164,13,58");
			visualizer.setXmlParam("ColorBand9", "151,14,59");
			visualizer.setXmlParam("ColorBand10", "138,16,59");
			visualizer.setXmlParam("ColorBand11", "125,16,59");
			visualizer.setXmlParam("ColorBand12", "112,18,60");
			visualizer.setXmlParam("ColorBand13", "99,19,61");
			visualizer.setXmlParam("ColorBand14", "86,21,61");
			visualizer.setXmlParam("ColorBand15", "73,21,61");
			visualizer.setXmlParam("ColorBand16", "60,23,62");
			visualizer.setXmlParam("colorbandpeak", "190,10,58");
			visualizer.setXmlParam("colorosc1", "255,4,55");
			visualizer.setXmlParam("colorosc2", "229,6,55");
			visualizer.setXmlParam("colorosc3", "203,10,56");
			visualizer.setXmlParam("colorosc4", "164,13,58");
			visualizer.setXmlParam("colorosc5", "112,18,60");
		}
		else if (v_color == 9)
		{
			visualizer.setXmlParam("ColorBand1", "247,207,0");
			visualizer.setXmlParam("ColorBand2", "240,195,0");
			visualizer.setXmlParam("ColorBand3", "232,186,0");
			visualizer.setXmlParam("ColorBand4", "224,175,0");
			visualizer.setXmlParam("ColorBand5", "216,165,0");
			visualizer.setXmlParam("ColorBand6", "207,154,0");
			visualizer.setXmlParam("ColorBand7", "200,144,0");
			visualizer.setXmlParam("ColorBand8", "191,135,0");
			visualizer.setXmlParam("ColorBand9", "184,124,0");
			visualizer.setXmlParam("ColorBand10", "175,114,0");
			visualizer.setXmlParam("ColorBand11", "167,103,0");
			visualizer.setXmlParam("ColorBand12", "160,92,0");
			visualizer.setXmlParam("ColorBand13", "152,82,0");
			visualizer.setXmlParam("ColorBand14", "143,73,0");
			visualizer.setXmlParam("ColorBand15", "136,62,0");
			visualizer.setXmlParam("ColorBand16", "128,52,0");
			visualizer.setXmlParam("colorbandpeak", "184,124,0");
			visualizer.setXmlParam("colorosc1", "252,201,202");
			visualizer.setXmlParam("colorosc2", "233,169,169");
			visualizer.setXmlParam("colorosc3", "215,136,137");
			visualizer.setXmlParam("colorosc4", "195,104,105");
			visualizer.setXmlParam("colorosc5", "177,72,71");
		}
		else if (v_color == 10)
		{
			visualizer.setXmlParam("ColorBand1", "255,4,55");
			visualizer.setXmlParam("ColorBand2", "242,5,55");
			visualizer.setXmlParam("ColorBand3", "229,6,55");
			visualizer.setXmlParam("ColorBand4", "217,7,57");
			visualizer.setXmlParam("ColorBand5", "203,10,56");
			visualizer.setXmlParam("ColorBand6", "190,10,58");
			visualizer.setXmlParam("ColorBand7", "177,12,58");
			visualizer.setXmlParam("ColorBand8", "164,13,58");
			visualizer.setXmlParam("ColorBand9", "151,14,59");
			visualizer.setXmlParam("ColorBand10", "138,16,59");
			visualizer.setXmlParam("ColorBand11", "125,16,59");
			visualizer.setXmlParam("ColorBand12", "112,18,60");
			visualizer.setXmlParam("ColorBand13", "99,19,61");
			visualizer.setXmlParam("ColorBand14", "86,21,61");
			visualizer.setXmlParam("ColorBand15", "73,21,61");
			visualizer.setXmlParam("ColorBand16", "60,23,62");
			visualizer.setXmlParam("colorbandpeak", "190,10,58");
			visualizer.setXmlParam("colorosc1", "255,4,55");
			visualizer.setXmlParam("colorosc2", "229,6,55");
			visualizer.setXmlParam("colorosc3", "203,10,56");
			visualizer.setXmlParam("colorosc4", "164,13,58");
			visualizer.setXmlParam("colorosc5", "112,18,60");
		}
		else if (v_color == 11)
		{
			visualizer.setXmlParam("ColorBand1", "130,185,217");
			visualizer.setXmlParam("ColorBand2", "137,189,218");
			visualizer.setXmlParam("ColorBand3", "144,192,220");
			visualizer.setXmlParam("ColorBand4", "151,195,221");
			visualizer.setXmlParam("ColorBand5", "158,198,222");
			visualizer.setXmlParam("ColorBand6", "165,201,224");
			visualizer.setXmlParam("ColorBand7", "171,204,226");
			visualizer.setXmlParam("ColorBand8", "178,208,228");
			visualizer.setXmlParam("ColorBand9", "185,211,230");
			visualizer.setXmlParam("ColorBand10", "192,215,230");
			visualizer.setXmlParam("ColorBand11", "198,218,231");
			visualizer.setXmlParam("ColorBand12", "206,221,234");
			visualizer.setXmlParam("ColorBand13", "212,224,236");
			visualizer.setXmlParam("ColorBand14", "219,227,237");
			visualizer.setXmlParam("ColorBand15", "225,231,238");
			visualizer.setXmlParam("ColorBand16", "233,234,240");
			visualizer.setXmlParam("colorbandpeak", "233,234,240");
			visualizer.setXmlParam("colorosc1", "225,230,238");
			visualizer.setXmlParam("colorosc2", "203,220,233");
			visualizer.setXmlParam("colorosc3", "182,209,229");
			visualizer.setXmlParam("colorosc4", "160,199,223");
			visualizer.setXmlParam("colorosc5", "138,189,219");
		}
		else if (v_color == 12)
		{
			visualizer.setXmlParam("ColorBand1", "214,168,186");
			visualizer.setXmlParam("ColorBand2", "182,43,171");
			visualizer.setXmlParam("ColorBand3", "106,1,242");
			visualizer.setXmlParam("ColorBand4", "8,34,245");
			visualizer.setXmlParam("ColorBand5", "4,166,251");
			visualizer.setXmlParam("ColorBand6", "3,246,118");
			visualizer.setXmlParam("ColorBand7", "80,245,0");
			visualizer.setXmlParam("ColorBand8", "223,245,5");
			visualizer.setXmlParam("ColorBand9", "247,143,5");
			visualizer.setXmlParam("ColorBand10", "254,41,5");
			visualizer.setXmlParam("ColorBand11", "216,34,5");
			visualizer.setXmlParam("ColorBand12", "209,160,158");
			visualizer.setXmlParam("ColorBand13", "230,242,246");
			visualizer.setXmlParam("ColorBand14", "230,242,246");
			visualizer.setXmlParam("ColorBand15", "216,208,232");
			visualizer.setXmlParam("ColorBand16", "216,208,232");
			visualizer.setXmlParam("colorbandpeak", "225,160,235");
			visualizer.setXmlParam("colorosc1", "216,208,232");
			visualizer.setXmlParam("colorosc2", "230,242,246");
			visualizer.setXmlParam("colorosc3", "209,160,158");
			visualizer.setXmlParam("colorosc4", "216,34,5");
			visualizer.setXmlParam("colorosc5", "254,41,5");
		}
		else if (v_color == 13)
		{
			visualizer.setXmlParam("ColorBand1", "252,201,202");
			visualizer.setXmlParam("ColorBand2", "247,192,193");
			visualizer.setXmlParam("ColorBand3", "242,183,185");
			visualizer.setXmlParam("ColorBand4", "236,176,175");
			visualizer.setXmlParam("ColorBand5", "232,166,167");
			visualizer.setXmlParam("ColorBand6", "227,157,158");
			visualizer.setXmlParam("ColorBand7", "222,149,149");
			visualizer.setXmlParam("ColorBand8", "217,141,140");
			visualizer.setXmlParam("ColorBand9", "212,132,132");
			visualizer.setXmlParam("ColorBand10", "208,123,123");
			visualizer.setXmlParam("ColorBand11", "202,114,114");
			visualizer.setXmlParam("ColorBand12", "197,106,106");
			visualizer.setXmlParam("ColorBand13", "192,97,98");
			visualizer.setXmlParam("ColorBand14", "187,89,88");
			visualizer.setXmlParam("ColorBand15", "182,81,80");
			visualizer.setXmlParam("ColorBand16", "177,72,71");
			visualizer.setXmlParam("colorbandpeak", "184,124,0");
			visualizer.setXmlParam("colorosc1", "252,201,202");
			visualizer.setXmlParam("colorosc2", "233,169,169");
			visualizer.setXmlParam("colorosc3", "215,136,137");
			visualizer.setXmlParam("colorosc4", "195,104,105");
			visualizer.setXmlParam("colorosc5", "177,72,71");
		}
		else if (v_color == 14)
		{
			visualizer.setXmlParam("colorallbands", "0,255,0");
			visualizer.setXmlParam("colorbandpeak", "0,255,0");
			visualizer.setXmlParam("colorosc1", "0,255,0");
			visualizer.setXmlParam("colorosc2", "0,255,0");
			visualizer.setXmlParam("colorosc3", "0,255,0");
			visualizer.setXmlParam("colorosc4", "0,255,00");
			visualizer.setXmlParam("colorosc5", "0,255,0");
		}
	setVis (currentMode);
}

Trigger.onLeftButtonDown (int x, int y)
{
	currentMode++;

	if (currentMode == 6)
	{
		currentMode = 0;
	}

	setVis	(currentMode);
	complete;
}



Trigger.onRightButtonUp (int x, int y)
{
	visMenu = new PopUpMenu;
	specmenu = new PopUpMenu;
	oscmenu = new PopUpMenu;
	pksmenu = new PopUpMenu;
	anamenu = new PopUpMenu;
	stylemenu = new PopUpMenu;
	fpsmenu = new PopUpMenu;
	colmenu = new PopUpMenu;

	visMenu.addCommand("Presets:", 999, 0, 1);
	visMenu.addCommand("No Visualization", 100, currentMode == 0, 0);
	
	visMenu.addSubMenu(colmenu, "Visualizer Color Schemes");
	colmenu.addCommand("Default", 500, v_color == 0, 0);
	colmenu.addCommand("Bars and Scope", 502, v_color == 2, 0);
	colmenu.addCommand("Ocean Mist and Scope", 503, v_color == 3, 0);
	colmenu.addCommand("Fire Storm and Scope", 504, v_color == 4, 0);
	colmenu.addCommand("Winamp Modern", 505, v_color == 5, 0);
	colmenu.addCommand("Bento", 506, v_color == 6, 0);
	colmenu.addCommand("Big Bento Modern", 507, v_color == 7, 0);
	colmenu.addCommand("REVOCS", 508, v_color == 8, 0);
	colmenu.addCommand("Ryuko", 510, v_color == 10, 0);
	colmenu.addCommand("Satsuki", 511, v_color == 11, 0);
	colmenu.addCommand("Ragyo", 512, v_color == 12, 0);
	colmenu.addCommand("A.P.E", 509, v_color == 9, 0);
	colmenu.addCommand("Zero Two", 513, v_color == 13, 0);
	colmenu.addCommand("Sound Recorder", 514, v_color == 14, 0);
	
	specmenu.addCommand("Thick Bands", 1, currentMode == 1, 0);
	specmenu.addCommand("Thin Bands", 2, currentMode == 2, 0);
	visMenu.addSubMenu(specmenu, "Spectrum Analyzer");

	oscmenu.addCommand("Lines", 3, currentMode == 3, 0);
	oscmenu.addCommand("Dots", 4, currentMode == 4, 0);
	oscmenu.addCommand("Solid", 5, currentMode == 5, 0);
	visMenu.addSubMenu(oscmenu, "Oscilloscope");

	visMenu.addSeparator();
	visMenu.addCommand("Options:", 102, 0, 1);

	visMenu.addCommand("Show Peaks", 101, show_peaks == 1, 0);
	pksmenu.addCommand("Slower", 200, p_falloffspeed == 0, 0);
	pksmenu.addCommand("Slow", 201, p_falloffspeed == 1, 0);
	pksmenu.addCommand("Moderate", 202, p_falloffspeed == 2, 0);
	pksmenu.addCommand("Fast", 203, p_falloffspeed == 3, 0);
	pksmenu.addCommand("Faster", 204, p_falloffspeed == 4, 0);
	
	visMenu.addSubMenu(pksmenu, "Peak Falloff Speed");
	anamenu.addCommand("Slower", 300, a_falloffspeed == 0, 0);
	anamenu.addCommand("Slow", 301, a_falloffspeed == 1, 0);
	anamenu.addCommand("Moderate", 302, a_falloffspeed == 2, 0);
	anamenu.addCommand("Fast", 303, a_falloffspeed == 3, 0);
	anamenu.addCommand("Faster", 304, a_falloffspeed == 4, 0);
	
	visMenu.addSubMenu(anamenu, "Analyzer Falloff Speed");
	stylemenu.addCommand("Normal", 400, a_coloring == 0, 0);
	stylemenu.addCommand("Fire", 402, a_coloring == 2, 0);
	stylemenu.addCommand("Line", 403, a_coloring == 3, 0);
	
	visMenu.addSubMenu(stylemenu, "Analyzer Coloring");
	
	visMenu.addSeparator();
	
	visMenu.addSubMenu(fpsmenu, "Frames Per Second");
	fpsmenu.addCommand("Lame (30 FPS)", 407, v_fps == 0, 0);
	fpsmenu.addCommand("Fast (60 FPS)", 409, v_fps == 2, 0);
	fpsmenu.addCommand("Faster (75 FPS)", 410, v_fps == 3, 0);
	fpsmenu.addCommand("Warp 6 (512 FPS)", 411, v_fps == 4, 0);
	
	visMenu.addSeparator();
	
	visMenu.addcommand(translate("Start/Stop plug-in")+"\tCtrl+Shift+K", 404, 0,0);
	visMenu.addcommand(translate("Configure plug-in...")+"\tAlt+K", 405, 0,0);
	visMenu.addcommand(translate("Select plug-in...")+"\tCtrl+K", 406, 0,0);

	ProcessMenuResult (visMenu.popAtMouse());

	delete visMenu;
	delete specmenu;
	delete oscmenu;
	delete pksmenu;
	delete anamenu;
	delete stylemenu;
	delete fpsmenu;
	delete colmenu;

	complete;	
}

ProcessMenuResult (int a)
{
	if (a < 1) return;

	if (a > 0 && a <= 6 || a == 100)
	{
		if (a == 100) a = 0;
		setVis(a);
	}

	else if (a == 101)
	{
		show_peaks = (show_peaks - 1) * (-1);
		visualizer.setXmlParam("peaks", integerToString(show_peaks));
		visualizershade.setXmlParam("peaks", integerToString(show_peaks));
		visualizerpl.setXmlParam("peaks", integerToString(show_peaks));
		setPrivateInt(getSkinName(), "Visualizer show Peaks", show_peaks);
	}

	else if (a >= 200 && a <= 204)
	{
		p_falloffspeed = a - 200;
		visualizer.setXmlParam("peakfalloff", integerToString(p_falloffspeed));
		visualizershade.setXmlParam("peakfalloff", integerToString(p_falloffspeed));
		visualizerpl.setXmlParam("peakfalloff", integerToString(p_falloffspeed));
		setPrivateInt(getSkinName(), "Visualizer peaks falloff", p_falloffspeed);
	}

	else if (a >= 300 && a <= 304)
	{
		a_falloffspeed = a - 300;
		visualizer.setXmlParam("falloff", integerToString(a_falloffspeed));
		visualizershade.setXmlParam("falloff", integerToString(a_falloffspeed));
		visualizerpl.setXmlParam("falloff", integerToString(a_falloffspeed));
		setPrivateInt(getSkinName(), "Visualizer analyzer falloff", a_falloffspeed);
	}

	else if (a >= 400 && a <= 403)
	{
		a_coloring = a - 400;
		if (a_coloring == 0)
		{
			visualizer.setXmlParam("coloring", "Normal");
			visualizershade.setXmlParam("coloring", "Normal");
			visualizerpl.setXmlParam("coloring", "Normal");
		}
		else if (a_coloring == 1)
		{
			visualizer.setXmlParam("coloring", "Normal");
			visualizershade.setXmlParam("coloring", "Normal");
			visualizerpl.setXmlParam("coloring", "Normal");
		}
		else if (a_coloring == 2)
		{
			visualizer.setXmlParam("coloring", "Fire");
			visualizershade.setXmlParam("coloring", "Fire");
			visualizerpl.setXmlParam("coloring", "Fire");
		}
		else if (a_coloring == 3)
		{
			visualizer.setXmlParam("coloring", "Line");
			visualizershade.setXmlParam("coloring", "Line");
			visualizerpl.setXmlParam("coloring", "Line");
		}
		setPrivateInt(getSkinName(), "Visualizer analyzer coloring", a_coloring);
	}
		
  else if (a == 404)
  {
    OAIDUBtnUE1.Leftclick ();
  }
  else if (a == 405)
  {
    OAIDUBtnUE2.Leftclick ();
  }
  else if (a == 406)
  {
    OAIDUBtnUE3.Leftclick ();
  }
  
  	else if (a >= 407 && a <= 411)
	{
		v_fps = a - 407;
		if (v_fps == 0)
		{
			visualizer.setXmlParam("fps", "30");
		}
		else if (v_fps == 1)
		{
			visualizer.setXmlParam("fps", "30");
		}
		else if (v_fps == 2)
		{
			visualizer.setXmlParam("fps", "60");
		}
		else if (v_fps == 3)
		{
			visualizer.setXmlParam("fps", "75");
		}
		else if (v_fps == 4)
		{
			visualizer.setXmlParam("fps", "512");
		}
		setPrivateInt(getSkinName(), "Visualizer FPS", v_fps);
	}
	else if (a >= 500 && a <= 514)
	{
		v_color = a - 500;
		if (v_color == 0)
		{
			visualizer.setXmlParam("ColorBand1", "22,131,7");
			visualizer.setXmlParam("ColorBand2", "39,147,0");
			visualizer.setXmlParam("ColorBand3", "47,155,7");
			visualizer.setXmlParam("ColorBand4", "55,180,15");
			visualizer.setXmlParam("ColorBand5", "48,189,15");
			visualizer.setXmlParam("ColorBand6", "39,205,15");
			visualizer.setXmlParam("ColorBand7", "146,221,32");
			visualizer.setXmlParam("ColorBand8", "187,221,40");
			visualizer.setXmlParam("ColorBand9", "212,180,32");
			visualizer.setXmlParam("ColorBand10", "220,164,23");
			visualizer.setXmlParam("ColorBand11", "197,122,7");
			visualizer.setXmlParam("ColorBand12", "213,114,0");
			visualizer.setXmlParam("ColorBand13", "213,101,0");
			visualizer.setXmlParam("ColorBand14", "213,89,0");
			visualizer.setXmlParam("ColorBand15", "205,40,15");
			visualizer.setXmlParam("ColorBand16", "238,48,15");
			visualizer.setXmlParam("colorbandpeak", "150,150,150");
			visualizer.setXmlParam("colorosc1", "255,255,255");
			visualizer.setXmlParam("colorosc2", "214,214,222");
			visualizer.setXmlParam("colorosc3", "181,189,189");
			visualizer.setXmlParam("colorosc4", "160,170,175");
			visualizer.setXmlParam("colorosc5", "148,156,165");
		}
		else if (v_color == 1)
		{
			visualizer.setXmlParam("ColorBand1", "22,131,7");
			visualizer.setXmlParam("ColorBand2", "39,147,0");
			visualizer.setXmlParam("ColorBand3", "47,155,7");
			visualizer.setXmlParam("ColorBand4", "55,180,15");
			visualizer.setXmlParam("ColorBand5", "48,189,15");
			visualizer.setXmlParam("ColorBand6", "39,205,15");
			visualizer.setXmlParam("ColorBand7", "146,221,32");
			visualizer.setXmlParam("ColorBand8", "187,221,40");
			visualizer.setXmlParam("ColorBand9", "212,180,32");
			visualizer.setXmlParam("ColorBand10", "220,164,23");
			visualizer.setXmlParam("ColorBand11", "197,122,7");
			visualizer.setXmlParam("ColorBand12", "213,114,0");
			visualizer.setXmlParam("ColorBand13", "213,101,0");
			visualizer.setXmlParam("ColorBand14", "213,89,0");
			visualizer.setXmlParam("ColorBand15", "205,40,15");
			visualizer.setXmlParam("ColorBand16", "238,48,15");
			visualizer.setXmlParam("colorbandpeak", "150,150,150");
			visualizer.setXmlParam("colorosc1", "255,255,255");
			visualizer.setXmlParam("colorosc2", "214,214,222");
			visualizer.setXmlParam("colorosc3", "181,189,189");
			visualizer.setXmlParam("colorosc4", "160,170,175");
			visualizer.setXmlParam("colorosc5", "148,156,165");
		}
		else if (v_color == 2)
		{
			visualizer.setXmlParam("colorallbands", "0,176,32");
			visualizer.setXmlParam("colorbandpeak", "32,32,255");
			visualizer.setXmlParam("colorosc1", "160,255,160");
			visualizer.setXmlParam("colorosc2", "160,255,160");
			visualizer.setXmlParam("colorosc3", "160,255,160");
			visualizer.setXmlParam("colorosc4", "160,255,160");
			visualizer.setXmlParam("colorosc5", "160,255,160");
		}
		else if (v_color == 3)
		{
			visualizer.setXmlParam("colorallbands", "0,0,255");
			visualizer.setXmlParam("colorbandpeak", "255,255,255");
			visualizer.setXmlParam("colorosc1", "160,255,160");
			visualizer.setXmlParam("colorosc2", "160,255,160");
			visualizer.setXmlParam("colorosc3", "160,255,160");
			visualizer.setXmlParam("colorosc4", "160,255,160");
			visualizer.setXmlParam("colorosc5", "160,255,160");
		}
		else if (v_color == 4)
		{
			visualizer.setXmlParam("colorallbands", "255,165,0");
			visualizer.setXmlParam("colorbandpeak", "255,0,0");
			visualizer.setXmlParam("colorosc1", "160,255,160");
			visualizer.setXmlParam("colorosc2", "160,255,160");
			visualizer.setXmlParam("colorosc3", "160,255,160");
			visualizer.setXmlParam("colorosc4", "160,255,160");
			visualizer.setXmlParam("colorosc5", "160,255,160");
		}
		else if (v_color == 5)
		{
			visualizer.setXmlParam("ColorBand1", "242,244,247");
			visualizer.setXmlParam("ColorBand2", "172,185,209");
			visualizer.setXmlParam("ColorBand3", "242,244,247");
			visualizer.setXmlParam("ColorBand4", "172,185,209");
			visualizer.setXmlParam("ColorBand5", "242,244,247");
			visualizer.setXmlParam("ColorBand6", "172,185,209");
			visualizer.setXmlParam("ColorBand7", "242,244,247");
			visualizer.setXmlParam("ColorBand8", "172,185,209");
			visualizer.setXmlParam("ColorBand9", "242,244,247");
			visualizer.setXmlParam("ColorBand10", "172,185,209");
			visualizer.setXmlParam("ColorBand11", "242,244,247");
			visualizer.setXmlParam("ColorBand12", "172,185,209");
			visualizer.setXmlParam("ColorBand13", "242,244,247");
			visualizer.setXmlParam("ColorBand14", "172,185,209");
			visualizer.setXmlParam("ColorBand15", "242,244,247");
			visualizer.setXmlParam("ColorBand16", "172,185,209");
			visualizer.setXmlParam("colorbandpeak", "242,244,247");
			visualizer.setXmlParam("colorosc1", "242,244,247");
			visualizer.setXmlParam("colorosc2", "242,244,247");
			visualizer.setXmlParam("colorosc3", "242,244,247");
			visualizer.setXmlParam("colorosc4", "242,244,247");
			visualizer.setXmlParam("colorosc5", "242,244,247");
		}
		else if (v_color == 6)
		{
			visualizer.setXmlParam("ColorBand1", "82,97,102");
			visualizer.setXmlParam("ColorBand2", "74,88,93");
			visualizer.setXmlParam("ColorBand3", "78,92,97");
			visualizer.setXmlParam("ColorBand4", "83,97,104");
			visualizer.setXmlParam("ColorBand5", "88,102,107");
			visualizer.setXmlParam("ColorBand6", "94,107,112");
			visualizer.setXmlParam("ColorBand7", "100,113,118");
			visualizer.setXmlParam("ColorBand8", "106,120,125");
			visualizer.setXmlParam("ColorBand9", "112,121,131");
			visualizer.setXmlParam("ColorBand10", "117,131,136");
			visualizer.setXmlParam("ColorBand11", "122,137,142");
			visualizer.setXmlParam("ColorBand12", "127,141,146");
			visualizer.setXmlParam("ColorBand13", "131,145,150");
			visualizer.setXmlParam("ColorBand14", "136,150,155");
			visualizer.setXmlParam("ColorBand15", "140,154,159");
			visualizer.setXmlParam("ColorBand16", "145,159,164");
			visualizer.setXmlParam("colorbandpeak", "162,193,204");
			visualizer.setXmlParam("colorosc1", "82,97,102");
			visualizer.setXmlParam("colorosc2", "83,97,104");
			visualizer.setXmlParam("colorosc3", "106,120,125");
			visualizer.setXmlParam("colorosc4", "127,141,146");
			visualizer.setXmlParam("colorosc5", "145,159,164");
		}
		else if (v_color == 7)
		{
			visualizer.setXmlParam("ColorBand1", "#5a5490");
			visualizer.setXmlParam("ColorBand2", "#60599a");
			visualizer.setXmlParam("ColorBand3", "#665ea1");
			visualizer.setXmlParam("ColorBand4", "#6c63ac");
			visualizer.setXmlParam("ColorBand5", "#7368b1");
			visualizer.setXmlParam("ColorBand6", "#7a6dba");
			visualizer.setXmlParam("ColorBand7", "#8274c4");
			visualizer.setXmlParam("ColorBand8", "#8a7ad0");
			visualizer.setXmlParam("ColorBand9", "#927bd9");
			visualizer.setXmlParam("ColorBand10", "#9985e1");
			visualizer.setXmlParam("ColorBand11", "#9f8ceb");
			visualizer.setXmlParam("ColorBand12", "#a590f2");
			visualizer.setXmlParam("ColorBand13", "#aa94f9");
			visualizer.setXmlParam("ColorBand14", "#b199fa");
			visualizer.setXmlParam("ColorBand15", "#bda4fc");
			visualizer.setXmlParam("ColorBand16", "#bda4fc");
			visualizer.setXmlParam("colorbandpeak", "#b5bffb");
			visualizer.setXmlParam("colorosc1", "#665ea1");
			visualizer.setXmlParam("colorosc2", "#7a6dba");
			visualizer.setXmlParam("colorosc3", "#927bd9");
			visualizer.setXmlParam("colorosc4", "#9f8ceb");
			visualizer.setXmlParam("colorosc5", "#b199fa");
		}
		else if (v_color == 8)
		{
			visualizer.setXmlParam("ColorBand1", "255,4,55");
			visualizer.setXmlParam("ColorBand2", "242,5,55");
			visualizer.setXmlParam("ColorBand3", "229,6,55");
			visualizer.setXmlParam("ColorBand4", "217,7,57");
			visualizer.setXmlParam("ColorBand5", "203,10,56");
			visualizer.setXmlParam("ColorBand6", "190,10,58");
			visualizer.setXmlParam("ColorBand7", "177,12,58");
			visualizer.setXmlParam("ColorBand8", "164,13,58");
			visualizer.setXmlParam("ColorBand9", "151,14,59");
			visualizer.setXmlParam("ColorBand10", "138,16,59");
			visualizer.setXmlParam("ColorBand11", "125,16,59");
			visualizer.setXmlParam("ColorBand12", "112,18,60");
			visualizer.setXmlParam("ColorBand13", "99,19,61");
			visualizer.setXmlParam("ColorBand14", "86,21,61");
			visualizer.setXmlParam("ColorBand15", "73,21,61");
			visualizer.setXmlParam("ColorBand16", "60,23,62");
			visualizer.setXmlParam("colorbandpeak", "190,10,58");
			visualizer.setXmlParam("colorosc1", "255,4,55");
			visualizer.setXmlParam("colorosc2", "229,6,55");
			visualizer.setXmlParam("colorosc3", "203,10,56");
			visualizer.setXmlParam("colorosc4", "164,13,58");
			visualizer.setXmlParam("colorosc5", "112,18,60");
		}
		else if (v_color == 9)
		{
			visualizer.setXmlParam("ColorBand1", "247,207,0");
			visualizer.setXmlParam("ColorBand2", "240,195,0");
			visualizer.setXmlParam("ColorBand3", "232,186,0");
			visualizer.setXmlParam("ColorBand4", "224,175,0");
			visualizer.setXmlParam("ColorBand5", "216,165,0");
			visualizer.setXmlParam("ColorBand6", "207,154,0");
			visualizer.setXmlParam("ColorBand7", "200,144,0");
			visualizer.setXmlParam("ColorBand8", "191,135,0");
			visualizer.setXmlParam("ColorBand9", "184,124,0");
			visualizer.setXmlParam("ColorBand10", "175,114,0");
			visualizer.setXmlParam("ColorBand11", "167,103,0");
			visualizer.setXmlParam("ColorBand12", "160,92,0");
			visualizer.setXmlParam("ColorBand13", "152,82,0");
			visualizer.setXmlParam("ColorBand14", "143,73,0");
			visualizer.setXmlParam("ColorBand15", "136,62,0");
			visualizer.setXmlParam("ColorBand16", "128,52,0");
			visualizer.setXmlParam("colorbandpeak", "184,124,0");
			visualizer.setXmlParam("colorosc1", "252,201,202");
			visualizer.setXmlParam("colorosc2", "233,169,169");
			visualizer.setXmlParam("colorosc3", "215,136,137");
			visualizer.setXmlParam("colorosc4", "195,104,105");
			visualizer.setXmlParam("colorosc5", "177,72,71");
		}
		else if (v_color == 10)
		{
			visualizer.setXmlParam("ColorBand1", "255,4,55");
			visualizer.setXmlParam("ColorBand2", "242,5,55");
			visualizer.setXmlParam("ColorBand3", "229,6,55");
			visualizer.setXmlParam("ColorBand4", "217,7,57");
			visualizer.setXmlParam("ColorBand5", "203,10,56");
			visualizer.setXmlParam("ColorBand6", "190,10,58");
			visualizer.setXmlParam("ColorBand7", "177,12,58");
			visualizer.setXmlParam("ColorBand8", "164,13,58");
			visualizer.setXmlParam("ColorBand9", "151,14,59");
			visualizer.setXmlParam("ColorBand10", "138,16,59");
			visualizer.setXmlParam("ColorBand11", "125,16,59");
			visualizer.setXmlParam("ColorBand12", "112,18,60");
			visualizer.setXmlParam("ColorBand13", "99,19,61");
			visualizer.setXmlParam("ColorBand14", "86,21,61");
			visualizer.setXmlParam("ColorBand15", "73,21,61");
			visualizer.setXmlParam("ColorBand16", "60,23,62");
			visualizer.setXmlParam("colorbandpeak", "190,10,58");
			visualizer.setXmlParam("colorosc1", "255,4,55");
			visualizer.setXmlParam("colorosc2", "229,6,55");
			visualizer.setXmlParam("colorosc3", "203,10,56");
			visualizer.setXmlParam("colorosc4", "164,13,58");
			visualizer.setXmlParam("colorosc5", "112,18,60");
		}
		else if (v_color == 11)
		{
			visualizer.setXmlParam("ColorBand1", "130,185,217");
			visualizer.setXmlParam("ColorBand2", "137,189,218");
			visualizer.setXmlParam("ColorBand3", "144,192,220");
			visualizer.setXmlParam("ColorBand4", "151,195,221");
			visualizer.setXmlParam("ColorBand5", "158,198,222");
			visualizer.setXmlParam("ColorBand6", "165,201,224");
			visualizer.setXmlParam("ColorBand7", "171,204,226");
			visualizer.setXmlParam("ColorBand8", "178,208,228");
			visualizer.setXmlParam("ColorBand9", "185,211,230");
			visualizer.setXmlParam("ColorBand10", "192,215,230");
			visualizer.setXmlParam("ColorBand11", "198,218,231");
			visualizer.setXmlParam("ColorBand12", "206,221,234");
			visualizer.setXmlParam("ColorBand13", "212,224,236");
			visualizer.setXmlParam("ColorBand14", "219,227,237");
			visualizer.setXmlParam("ColorBand15", "225,231,238");
			visualizer.setXmlParam("ColorBand16", "233,234,240");
			visualizer.setXmlParam("colorbandpeak", "233,234,240");
			visualizer.setXmlParam("colorosc1", "225,230,238");
			visualizer.setXmlParam("colorosc2", "203,220,233");
			visualizer.setXmlParam("colorosc3", "182,209,229");
			visualizer.setXmlParam("colorosc4", "160,199,223");
			visualizer.setXmlParam("colorosc5", "138,189,219");
		}
		else if (v_color == 12)
		{
			visualizer.setXmlParam("ColorBand1", "214,168,186");
			visualizer.setXmlParam("ColorBand2", "182,43,171");
			visualizer.setXmlParam("ColorBand3", "106,1,242");
			visualizer.setXmlParam("ColorBand4", "8,34,245");
			visualizer.setXmlParam("ColorBand5", "4,166,251");
			visualizer.setXmlParam("ColorBand6", "3,246,118");
			visualizer.setXmlParam("ColorBand7", "80,245,0");
			visualizer.setXmlParam("ColorBand8", "223,245,5");
			visualizer.setXmlParam("ColorBand9", "247,143,5");
			visualizer.setXmlParam("ColorBand10", "254,41,5");
			visualizer.setXmlParam("ColorBand11", "216,34,5");
			visualizer.setXmlParam("ColorBand12", "209,160,158");
			visualizer.setXmlParam("ColorBand13", "230,242,246");
			visualizer.setXmlParam("ColorBand14", "230,242,246");
			visualizer.setXmlParam("ColorBand15", "216,208,232");
			visualizer.setXmlParam("ColorBand16", "216,208,232");
			visualizer.setXmlParam("colorbandpeak", "225,160,235");
			visualizer.setXmlParam("colorosc1", "216,208,232");
			visualizer.setXmlParam("colorosc2", "230,242,246");
			visualizer.setXmlParam("colorosc3", "209,160,158");
			visualizer.setXmlParam("colorosc4", "216,34,5");
			visualizer.setXmlParam("colorosc5", "254,41,5");
		}
		else if (v_color == 13)
		{
			visualizer.setXmlParam("ColorBand1", "252,201,202");
			visualizer.setXmlParam("ColorBand2", "247,192,193");
			visualizer.setXmlParam("ColorBand3", "242,183,185");
			visualizer.setXmlParam("ColorBand4", "236,176,175");
			visualizer.setXmlParam("ColorBand5", "232,166,167");
			visualizer.setXmlParam("ColorBand6", "227,157,158");
			visualizer.setXmlParam("ColorBand7", "222,149,149");
			visualizer.setXmlParam("ColorBand8", "217,141,140");
			visualizer.setXmlParam("ColorBand9", "212,132,132");
			visualizer.setXmlParam("ColorBand10", "208,123,123");
			visualizer.setXmlParam("ColorBand11", "202,114,114");
			visualizer.setXmlParam("ColorBand12", "197,106,106");
			visualizer.setXmlParam("ColorBand13", "192,97,98");
			visualizer.setXmlParam("ColorBand14", "187,89,88");
			visualizer.setXmlParam("ColorBand15", "182,81,80");
			visualizer.setXmlParam("ColorBand16", "177,72,71");
			visualizer.setXmlParam("colorbandpeak", "184,124,0");
			visualizer.setXmlParam("colorosc1", "252,201,202");
			visualizer.setXmlParam("colorosc2", "233,169,169");
			visualizer.setXmlParam("colorosc3", "215,136,137");
			visualizer.setXmlParam("colorosc4", "195,104,105");
			visualizer.setXmlParam("colorosc5", "177,72,71");
		}
		else if (v_color == 14)
		{
			visualizer.setXmlParam("colorallbands", "0,255,0");
			visualizer.setXmlParam("colorbandpeak", "0,255,0");
			visualizer.setXmlParam("colorosc1", "0,255,0");
			visualizer.setXmlParam("colorosc2", "0,255,0");
			visualizer.setXmlParam("colorosc3", "0,255,0");
			visualizer.setXmlParam("colorosc4", "0,255,00");
			visualizer.setXmlParam("colorosc5", "0,255,0");
		}
		setPrivateInt(getSkinName(), "Visualizer Color themes", v_color);
	}
}



setVis (int mode)
{
	setPrivateInt(getSkinName(), "Visualizer Mode", mode);
	if (mode == 0)
	{
		HideForVic.show();
		visualizer.setMode(0);
		visualizershade.setMode(0);
		visualizerpl.setMode(0);
	}
	else if (mode == 1)
	{
		visualizer.setXmlParam("bandwidth", "wide");
		visualizershade.setXmlParam("bandwidth", "wide");
		visualizerpl.setXmlParam("bandwidth", "wide");
		HideForVic.show();
		visualizer.setMode(1);
		visualizershade.setMode(1);
		visualizerpl.setMode(1);
	}
	else if (mode == 2)
	{
		visualizer.setXmlParam("bandwidth", "thin");
		visualizershade.setXmlParam("bandwidth", "thin");
		visualizerpl.setXmlParam("bandwidth", "thin");
		HideForVic.show();
		visualizer.setMode(1);
		visualizershade.setMode(1);
		visualizerpl.setMode(1);
	}
	else if (mode == 3)
	{
		visualizer.setXmlParam("oscstyle", "solid");
		visualizershade.setXmlParam("oscstyle", "solid");
		visualizerpl.setXmlParam("oscstyle", "solid");
		HideForVic.hide();
		visualizer.setMode(2);
		visualizershade.setMode(2);
		visualizerpl.setMode(2);
	}
	else if (mode == 4)
	{
		visualizer.setXmlParam("oscstyle", "dots");
		visualizershade.setXmlParam("oscstyle", "dots");
		visualizerpl.setXmlParam("oscstyle", "dots");
		HideForVic.hide();
		visualizer.setMode(2);
		visualizershade.setMode(2);
		visualizerpl.setMode(2);
	}
	else if (mode == 5)
	{
		visualizer.setXmlParam("oscstyle", "lines");
		visualizershade.setXmlParam("oscstyle", "lines");
		visualizerpl.setXmlParam("oscstyle", "lines");
		HideForVic.hide();
		visualizer.setMode(2);
		visualizershade.setMode(2);
		visualizerpl.setMode(2);
	}
	currentMode = mode;
}


TriggerBlocker.onLeftButtonDblClk(int x, int y)
{
  OAIDUBtnUE1.Leftclick ();
}

TriggerBlockerShade.onLeftButtonDblClk(int x, int y)
{
  OAIDUBtnUE1.Leftclick ();
}
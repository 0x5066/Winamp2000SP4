#include "lib/std.mi"

Function refreshVisSettings();
Function setVis (int mode);
Function ProcessMenuResult (int a);

Function setColorBands (String rgb, int start, int end);									//set bands color in range (1-16)				rgb value("0,255,127"), start position(4), end position(12)
Function setColorBandsOdd (String rgb);														//set odd bands color							rgb value("0,255,127")
Function setColorBandsEven (String rgb);													//set even bands color							rgb value("0,255,127")
Function setColorBandsGradient(int r, int g, int b, int stepr, int stepg, int stepb);		//set color bands to a gradient					red(0), green(255), blue(127), step red(10), step green(-5), step blue(+2)
Function setColorosc (String rgb);															//set oscilloscope color						rgb value("0,255,127")
Function setColoroscRange (String rgb, int start, int end);									//set oscilloscope color in range (1-5)			rgb value("0,255,127"), start position(1), end position(4)
Function setColoroscOdd (String rgb);														//set odd oscilloscope color					rgb value("0,255,127")
Function setColoroscEven (String rgb);														//set even oscilloscope color					rgb value("0,255,127")

Global Container containerMain;
Global Layout layoutMainNormal, layoutMainShade;
Global Group NormalGroupMain, NormalGroupDisplay, ShadeGroupMain, ShadeGroupDisplay;
Global Vis visualizer, visualizershade;
Global Layer visvgrid_thick, visvgrid_thin, visvgrid_car, vishgrid_thick, vishgrid_thin, vishgrid_car;
Global Button OAIDUBtnUE1, OAIDUBtnUE2, OAIDUBtnUE3;

Global Timer VU, VUStopTimer;

Global PopUpMenu visMenu;
Global PopUpMenu specmenu;
Global PopUpMenu oscmenu;
Global PopUpMenu pksmenu;
Global PopUpMenu anamenu;
Global PopUpMenu stylemenu;
Global PopUpMenu fpsmenu;
Global PopUpMenu colmenu;
Global PopUpMenu wmpmenu;
Global PopUpMenu winmenu;
Global PopUpMenu animenu;
Global PopUpMenu gamemenu;
Global PopUpMenu plusmenu;
Global PopUpMenu vgridmenu;
Global PopUpMenu hgridmenu;
Global PopUpMenu waxpmenu;
Global PopUpMenu vumenu;

Global Int currentMode, a_falloffspeed, p_falloffspeed, a_coloring, v_fps, v_color, vgrid, hgrid, vp_falloffspeed, Level1, Level2;
Global float peak1, peak2, pgrav1, pgrav2, vu_falloffspeed;
Global Boolean show_peaks, show_vupeaks;
Global layer Trigger, HideForVic, TriggerBlocker, TriggerBlockerShade;

Global AnimatedLayer LeftMeter, RightMeter, LeftMeterPeak, RightMeterPeak, SLeftMeter, SRightMeter, SLeftMeterPeak, SRightMeterPeak;

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
	visvgrid_thick = NormalGroupDisplay.findObject("visvgridimg.thick");
	visvgrid_thin = NormalGroupDisplay.findObject("visvgridimg.thin");
	visvgrid_car = NormalGroupDisplay.findObject("visvgridimg.car");

	vishgrid_thick = NormalGroupDisplay.findObject("vishgridimg.thick");
	vishgrid_thin = NormalGroupDisplay.findObject("vishgridimg.thin");
	vishgrid_car = NormalGroupDisplay.findObject("vishgridimg.car");

	LeftMeter = NormalGroupDisplay.findObject("player.vu.left");
	RightMeter = NormalGroupDisplay.findObject("player.vu.right");
	LeftMeterPeak = NormalGroupDisplay.findObject("player.vu.leftpeak");
	RightMeterPeak = NormalGroupDisplay.findObject("player.vu.rightpeak");

	SLeftMeter = NormalGroupDisplay.findObject("player.vu.left");
	SRightMeter = NormalGroupDisplay.findObject("player.vu.right");
	SLeftMeterPeak = NormalGroupDisplay.findObject("player.vu.leftpeak");
	SRightMeterPeak = NormalGroupDisplay.findObject("player.vu.rightpeak");

	layoutMainShade = containerMain.getLayout("shade");
	ShadeGroupMain = layoutMainShade.findObject("player.shade.group.main");
	ShadeGroupDisplay = ShadeGroupMain.findObject("player.shade.group.display");
	visualizershade = ShadeGroupDisplay.findObject("shade.vis");

	Trigger = NormalGroupDisplay.findObject("player.vis.trigger");
	TriggerBlockerShade = ShadeGroupDisplay.findObject("player.vis.blocker");
	HideForVic = NormalGroupDisplay.findObject("hide.for.vic");

	visualizer.setXmlParam("peaks", integerToString(show_peaks));
	visvgrid_thick.setXmlParam("visible", integerToString(vgrid));
	visvgrid_thin.setXmlParam("visible", integerToString(vgrid));
	visvgrid_car.setXmlParam("visible", integerToString(vgrid));
	vishgrid_thick.setXmlParam("visible", integerToString(hgrid));
	vishgrid_thin.setXmlParam("visible", integerToString(hgrid));
	vishgrid_car.setXmlParam("visible", integerToString(hgrid));
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

	pgrav1 = 0;
	pgrav2 = 0;

	VU = new Timer;
	VU.setdelay(16);

	vuStopTimer = new Timer;
	vuStopTimer.setdelay(1000);

	refreshVisSettings ();
}

visualizershade.onSetVisible(int on) {
	if (on) refreshVisSettings ();
}

VU.onTimer() {
//credit to Egor Petrov/E-Trance for the original piece of code used in his EPS3 skin
//modified to remove the signal being made logarithmic, making it linear, removed the smoothing as well
//gravity/peak smoothness and optimizations by mirzi
	float DivL1 = 1.75;
	float DivR1 = DivL1;

	level1 = (getLeftVuMeter()*LeftMeter.getLength()/256);
	level2 = (getRightVuMeter()*RightMeter.getLength()/256);

    LeftMeter.gotoFrame(level1);
    RightMeter.gotoFrame(level2);

	SLeftMeter.gotoFrame(level1);
    SRightMeter.gotoFrame(level2);

	if (level1 >= peak1){
		peak1 = level1;
		pgrav1 = 0;
	}
	else{
		peak1 += pgrav1;
		pgrav1 -= vu_falloffspeed;
	}
	if (level2 >= peak2){
		peak2 = level2;
		pgrav2 = 0;
	}
	else{
		peak2 += pgrav2;
		pgrav2 -= vu_falloffspeed;
	}

	LeftMeterPeak.gotoFrame(peak1);
	RightMeterPeak.gotoFrame(peak2);

	SLeftMeterPeak.gotoFrame(peak1);
	SRightMeterPeak.gotoFrame(peak2);
}

// saving those precious cycles
System.onStop(){
	if(currentMode == 6){
		VU.start(); //prevents VU meter getting stuck on stop
		VUStopTimer.start();
	}
}

System.onPause(){
	if(currentMode == 6){
		VUStopTimer.start();
	}
}

System.onResume(){
	if(currentMode == 6){
		VUStopTimer.stop();
		VU.start();
	}
}

System.onPlay(){
	if(currentMode == 6){
		VUStopTimer.stop();
		VU.start();
	}
}

// this timer stops all vu meter calculations
VUStopTimer.onTimer(){
	VUStopTimer.stop();
	VU.stop();
}

refreshVisSettings ()
{
	currentMode = getPrivateInt(getSkinName(), "Visualizer Mode", 1);
	show_peaks = getPrivateInt(getSkinName(), "Visualizer show Peaks", 1);
	show_vupeaks = getPrivateInt(getSkinName(), "Visualizer show VU Peaks", 1);
	vgrid = getPrivateInt(getSkinName(), "Visualizer show Vertical Grid", 0);
	hgrid = getPrivateInt(getSkinName(), "Visualizer show Horizontal Grid", 0);
	a_falloffspeed = getPrivateInt(getSkinName(), "Visualizer analyzer falloff", 4);
	p_falloffspeed = getPrivateInt(getSkinName(), "Visualizer peaks falloff", 0);
	vp_falloffspeed = getPrivateInt(getSkinName(), "Visualizer VU peaks falloff", 2);
	a_coloring = getPrivateInt(getSkinName(), "Visualizer analyzer coloring", 0);
	v_fps = getPrivateInt(getSkinName(), "Visualizer FPS", 3);
	v_color = getPrivateInt(getSkinName(), "Visualizer Color themes", 0);

	visualizer.setXmlParam("peaks", integerToString(show_peaks));
	visvgrid_thick.setXmlParam("visible", integerToString(vgrid));
	visvgrid_thin.setXmlParam("visible", integerToString(vgrid));
	visvgrid_car.setXmlParam("visible", integerToString(vgrid));
	vishgrid_thick.setXmlParam("visible", integerToString(hgrid));
	vishgrid_thin.setXmlParam("visible", integerToString(hgrid));
	vishgrid_car.setXmlParam("visible", integerToString(hgrid));
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
	LeftMeterPeak.setXmlParam("visible", integerToString(show_vupeaks));
	RightMeterPeak.setXmlParam("visible", integerToString(show_vupeaks));

	visualizershade.setXmlParam("peaks", integerToString(show_peaks));
	visualizershade.setXmlParam("peakfalloff", integerToString(p_falloffspeed));
	visualizershade.setXmlParam("falloff", integerToString(a_falloffspeed));

	vu_falloffspeed = (vp_falloffspeed/100)+0.02;

	if (a_coloring == 0)
	{
		visualizer.setXmlParam("coloring", "Normal");
		visualizershade.setXmlParam("coloring", "Normal");
	}
	else if (a_coloring == 1)
	{
		visualizer.setXmlParam("coloring", "Normal");
		visualizershade.setXmlParam("coloring", "Normal");
	}
	else if (a_coloring == 2)
	{
		visualizer.setXmlParam("coloring", "Fire");
		visualizershade.setXmlParam("coloring", "Fire");
	}
	else if (a_coloring == 3)
	{
		visualizer.setXmlParam("coloring", "Line");
		visualizershade.setXmlParam("coloring", "Line");
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
		else if (v_fps == 5)
		{
			visualizer.setXmlParam("fps", "120");
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

		setColorosc("160,255,160");

	}
	else if (v_color == 3)
	{
		visualizer.setXmlParam("colorallbands", "0,0,255");
		visualizer.setXmlParam("colorbandpeak", "255,255,255");

		setColorosc("160,255,160");

	}
	else if (v_color == 4)
	{
		visualizer.setXmlParam("colorallbands", "255,165,0");
		visualizer.setXmlParam("colorbandpeak", "255,0,0");

		setColorosc("160,255,160");

	}
	else if (v_color == 5)
	{
		setColorBandsOdd("242,244,247");
		setColorBandsEven("172,185,209");
		visualizer.setXmlParam("colorbandpeak", "242,244,247");

		setColorosc("242,244,247");

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
	else if (v_color == 8) //REVOCS, now empty
	{

	}
	else if (v_color == 9) //A.P.E, now empty
	{

	}
	else if (v_color == 10) //Ryuko, now empty
	{

	}
	else if (v_color == 11) //Satsuki, now empty
	{

	}
	else if (v_color == 12) //Ragyo, now empty
	{

	}
	else if (v_color == 13) //Zero Two, now empty
	{

	}
	else if (v_color == 14)
	{
		visualizer.setXmlParam("colorallbands", "0,255,0");
		visualizer.setXmlParam("colorbandpeak", "0,255,0");

		setColorosc("0,255,0");

	}
	else if (v_color == 15)
	{
		visualizer.setXmlParam("ColorBand16", "130,166,170");
		visualizer.setXmlParam("ColorBand15", "137,171,175");
		visualizer.setXmlParam("ColorBand14", "145,175,180");
		visualizer.setXmlParam("ColorBand13", "151,180,184");
		visualizer.setXmlParam("ColorBand12", "159,185,188");
		visualizer.setXmlParam("ColorBand11", "166,190,193");
		visualizer.setXmlParam("ColorBand10", "173,194,197");
		visualizer.setXmlParam("ColorBand9", "181,198,202");
		visualizer.setXmlParam("ColorBand8", "188,203,207");
		visualizer.setXmlParam("ColorBand7", "195,208,212");
		visualizer.setXmlParam("ColorBand6", "202,213,215");
		visualizer.setXmlParam("ColorBand5", "209,218,220");
		visualizer.setXmlParam("ColorBand4", "217,222,225");
		visualizer.setXmlParam("ColorBand3", "224,227,229");
		visualizer.setXmlParam("ColorBand2", "231,232,233");
		visualizer.setXmlParam("ColorBand1", "235,234,236");
		visualizer.setXmlParam("colorbandpeak", "254,246,231");
		visualizer.setXmlParam("colorosc5", "47,44,50");
		visualizer.setXmlParam("colorosc4", "85,83,88");
		visualizer.setXmlParam("colorosc3", "146,143,147");
		visualizer.setXmlParam("colorosc2", "205,203,207");
		visualizer.setXmlParam("colorosc1", "235,234,236");

	}
	else if (v_color == 16)
	{
		visualizer.setXmlParam("ColorBand1", "181,231,94");
		visualizer.setXmlParam("ColorBand2", "186,228,94");
		visualizer.setXmlParam("ColorBand3", "190,227,94");
		visualizer.setXmlParam("ColorBand4", "195,224,94");
		visualizer.setXmlParam("ColorBand5", "198,223,94");
		visualizer.setXmlParam("ColorBand6", "203,221,94");
		visualizer.setXmlParam("ColorBand7", "207,218,94");
		visualizer.setXmlParam("ColorBand8", "211,217,94");
		visualizer.setXmlParam("ColorBand9", "216,215,94");
		visualizer.setXmlParam("ColorBand10", "221,213,94");
		visualizer.setXmlParam("ColorBand11", "225,212,94");
		visualizer.setXmlParam("ColorBand12", "229,208,94");
		visualizer.setXmlParam("ColorBand13", "234,207,94");
		visualizer.setXmlParam("ColorBand14", "236,186,94");
		visualizer.setXmlParam("ColorBand15", "232,146,94");
		visualizer.setXmlParam("ColorBand16", "229,108,94");
		visualizer.setXmlParam("colorbandpeak", "150,150,150");

		setColorosc("196,181,80");

	}
	else if (v_color == 17)
	{
		setColorBandsOdd("0,222,255");
		setColorBandsEven("0,97,142");
		visualizer.setXmlParam("colorbandpeak", "140,222,255");

		setColorosc("140,222,255");

	}
	else if (v_color == 18)
	{
		setColorBandsOdd("255,0,0");
		setColorBandsEven("105,0,0");
		visualizer.setXmlParam("colorbandpeak", "255,43,0");

		setColorosc("255,43,0");

	}
	else if (v_color == 19)
	{
		setColorBandsOdd("0,255,185");
		setColorBandsEven("0,0,0");
		visualizer.setXmlParam("colorband15", "255, 51, 26");
		visualizer.setXmlParam("colorbandpeak", "0,0,0");

		setColorosc("0,255,185");
	}
	else if (v_color == 20)
	{
		visualizer.setXmlParam("colorallbands", "59,51,163");
		visualizer.setXmlParam("colorbandpeak", "122,115,219");	
		
		setColorosc("122,115,219");
	}
	else if (v_color == 21)
	{
		visualizer.setXmlParam("colorallbands", "213,175,38");
		visualizer.setXmlParam("colorbandpeak", "213,175,38");

		setColorosc("213,175,38");

	}
	else if (v_color == 22)
	{

	}
	if(v_color == 23){
		//luna
		
		visualizer.setXmlParam("colorallbands", "49,106,197");
		visualizer.setXmlParam("colorbandpeak", "49,106,197");
		setColorOsc("49,106,197");

	}
	else if(v_color == 24){
		//olive green
		
		visualizer.setXmlParam("colorallbands", "147,160,112");
		visualizer.setXmlParam("colorbandpeak", "153,84,10");
		setColorOsc("147,160,112");
	}
	else if(v_color == 25){
		//silver
		
		visualizer.setXmlParam("colorallbands", "178,180,191");
		visualizer.setXmlParam("colorbandpeak", "178,180,191");
		setColorOsc("178,180,191");
	}
	else if(v_color == 26){
		//luna - gradient

		setColorBandsGradient(3,84,227,4,4,2);

		visualizer.setXmlParam("colorbandpeak", "61,149,255");
		setColorOscOdd("3,84,227");
		setColorOscEven("61,149,255");

	}
	else if(v_color == 27){
		//olive green - gradient

		setColorBandsGradient(165,179,125,4,4,4);

		visualizer.setXmlParam("colorbandpeak", "231,240,197");
		setColorOscOdd("165,179,125");
		setColorOscEven("231,240,197");

	}
	else if(v_color == 28){
		//silver - gradient

		setColorBandsGradient(165,164,190,6,6,4);

		visualizer.setXmlParam("colorbandpeak", "252,252,252");
		setColorOscOdd("165,164,190");
		setColorOscEven("252,252,252");

	}
	else if(v_color == 29){
		//zune orange
		setColorBandsGradient(127,59,20,5,3,1);

		visualizer.setXmlParam("colorbandpeak", "231,121,49");
		setColorOscOdd("127,59,20");
		setColorOscEven("214,101,33");
	}
	else if(v_color == 30){
		//zune dark
		setColorBandsGradient(38,38,38,4,4,4);
		
		visualizer.setXmlParam("colorbandpeak", "231,121,49");
		setColorOscOdd("38,38,38");
		setColorOscEven("109,109,109");
	}
	else if (v_color == 31)
	{
		//lines & peaks only
		visualizer.setXmlParam("ColorBand1", "0,0,0");
		visualizer.setXmlParam("ColorBand2", "0,0,0");
		visualizer.setXmlParam("ColorBand3", "0,0,0");
		visualizer.setXmlParam("ColorBand4", "0,0,0");
		visualizer.setXmlParam("ColorBand5", "0,0,0");
		visualizer.setXmlParam("ColorBand6", "0,0,0");
		visualizer.setXmlParam("ColorBand7", "0,0,0");
		visualizer.setXmlParam("ColorBand8", "0,0,0");
		visualizer.setXmlParam("ColorBand9", "0,0,0");
		visualizer.setXmlParam("ColorBand10", "0,0,0");
		visualizer.setXmlParam("ColorBand11", "0,0,0");
		visualizer.setXmlParam("ColorBand12", "0,0,0");
		visualizer.setXmlParam("ColorBand13", "0,0,0");
		visualizer.setXmlParam("ColorBand14", "0,0,0");
		visualizer.setXmlParam("ColorBand15", "255,255,255");
		visualizer.setXmlParam("ColorBand16", "255,255,255");
		visualizer.setXmlParam("colorbandpeak", "255,255,255");
		setColorosc("255,255,255");
	}
	else if (v_color == 32)
	{
		//klk displays, now empty
		}
		if (vgrid == 0)
		{
			visvgrid_thick.setXmlParam("visible", "0");
			visvgrid_thin.setXmlParam("visible", "0");
			visvgrid_car.setXmlParam("visible", "0");
		}
		else if (vgrid == 1)
		{
			visvgrid_thick.setXmlParam("visible", "0");
			visvgrid_thin.setXmlParam("visible", "0");
			visvgrid_car.setXmlParam("visible", "0");
		}
		else if (vgrid == 2)
		{
			visvgrid_thick.setXmlParam("visible", "1");
			visvgrid_thin.setXmlParam("visible", "0");
			visvgrid_car.setXmlParam("visible", "0");
		}
		else if (vgrid == 3)
		{
			visvgrid_thick.setXmlParam("visible", "0");
			visvgrid_thin.setXmlParam("visible", "1");
			visvgrid_car.setXmlParam("visible", "0");
		}
		else if (vgrid == 4)
		{
			visvgrid_thick.setXmlParam("visible", "0");
			visvgrid_thin.setXmlParam("visible", "0");
			visvgrid_car.setXmlParam("visible", "1");
		}
		else if (vgrid == 5)
		{
			visvgrid_thick.setXmlParam("visible", "1");
			visvgrid_thin.setXmlParam("visible", "1");
			visvgrid_car.setXmlParam("visible", "1");
		}

		if (hgrid == 0)
		{
			vishgrid_thick.setXmlParam("visible", "0");
			vishgrid_thin.setXmlParam("visible", "0");
			vishgrid_car.setXmlParam("visible", "0");
		}
		else if (hgrid == 1)
		{
			vishgrid_thick.setXmlParam("visible", "0");
			vishgrid_thin.setXmlParam("visible", "0");
			vishgrid_car.setXmlParam("visible", "0");
		}
		else if (hgrid == 2)
		{
			vishgrid_thick.setXmlParam("visible", "1");
			vishgrid_thin.setXmlParam("visible", "0");
			vishgrid_car.setXmlParam("visible", "0");
		}
		else if (hgrid == 3)
		{
			vishgrid_thick.setXmlParam("visible", "0");
			vishgrid_thin.setXmlParam("visible", "1");
			vishgrid_car.setXmlParam("visible", "0");
		}
		else if (hgrid == 4)
		{
			vishgrid_thick.setXmlParam("visible", "0");
			vishgrid_thin.setXmlParam("visible", "0");
			vishgrid_car.setXmlParam("visible", "1");
		}
		else if (hgrid == 5)
		{
			vishgrid_thick.setXmlParam("visible", "1");
			vishgrid_thin.setXmlParam("visible", "1");
			vishgrid_car.setXmlParam("visible", "1");
		}
	setVis (currentMode);
}

Trigger.onLeftButtonDown (int x, int y)
{
	currentMode++;

	if (currentMode == 7)
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
	wmpmenu = new PopUpMenu;
	winmenu = new PopUpMenu;
	animenu = new PopUpMenu;
	gamemenu = new PopUpMenu;
	plusmenu = new PopUpMenu;
	vgridmenu = new PopUpMenu;
	hgridmenu = new PopUpMenu;
	waxpmenu = new PopUpMenu;
	vumenu = new PopUpMenu;

	visMenu.addCommand("Presets:", 999, 0, 1);
	visMenu.addCommand("No Visualization", 100, currentMode == 0, 0);

	visMenu.addSubMenu(colmenu, "Visualizer Color Schemes");

	// colmenu.addSubMenu(animenu, "");
	// animenu.addCommand("", 508, v_color == 8, 0);
	// animenu.addCommand("", 510, v_color == 10, 0);
	// animenu.addCommand("", 511, v_color == 11, 0);
	// animenu.addCommand("", 512, v_color == 12, 0);
	// animenu.addCommand("", 532, v_color == 32, 0);
	// animenu.addCommand("", 509, v_color == 9, 0);
	// animenu.addCommand("", 513, v_color == 13, 0);
	
	colmenu.addSubMenu(plusmenu, "Microsoft Plus! 98");
	plusmenu.addCommand("More Windows", 521, v_color == 21, 0);
	
	colmenu.addSubMenu(gamemenu, "Video Games");
	gamemenu.addCommand("GoldSrc VGUI", 516, v_color == 16, 0);
	
	colmenu.addSubMenu(wmpmenu, "Windows Media Player");
	wmpmenu.addCommand("Bars and Scope", 502, v_color == 2, 0);
	wmpmenu.addCommand("Ocean Mist and Scope", 503, v_color == 3, 0);
	wmpmenu.addCommand("Fire Storm and Scope", 504, v_color == 4, 0);
	
	colmenu.addSubMenu(winmenu, "Winamp Skins");
	winmenu.addCommand("Winamp Classic", 500, v_color == 0, 0);
	winmenu.addCommand("Winamp Modern", 505, v_color == 5, 0);
	winmenu.AddSubMenu(waxpmenu, "Winamp XP");
	winmenu.addCommand("Bento", 506, v_color == 6, 0);
	winmenu.addCommand("Big Bento Modern", 507, v_color == 7, 0);	

	waxpmenu.addCommand("Luna", 523, v_color == 23, 0);
	waxpmenu.addCommand("Luna (Gradient)", 526, v_color == 26, 0);
	waxpmenu.addCommand("Olive Green", 524, v_color == 24, 0);
	waxpmenu.addCommand("Olive Green (Gradient)", 527, v_color == 27, 0);
	waxpmenu.addCommand("Silver", 525, v_color == 25, 0);
	waxpmenu.addCommand("Silver (Gradient)", 528, v_color == 28, 0);
	waxpmenu.addCommand("Zune Orange", 529, v_color == 29, 0);
	waxpmenu.addCommand("Zune Dark", 530, v_color == 30, 0);

	colmenu.addCommand("Commodore 64", 520, v_color == 20, 0);
	colmenu.addCommand("Lines && Peaks only", 531, v_color == 31, 0);
	colmenu.addCommand("Midori Mizuno", 515, v_color == 15, 0);
	colmenu.addCommand("Sound Recorder", 514, v_color == 14, 0);

	colmenu.addCommand("RTA-31 Spectrum Analyzer", 519, v_color == 19, 0);
	colmenu.addCommand("That old Hi-Fi", 517, v_color == 17, 0);
	colmenu.addCommand("That old Hi-Fi in crimson red", 518, v_color == 18, 0);
	
	specmenu.addCommand("Thick Bands", 1, currentMode == 1, 0);
	specmenu.addCommand("Thin Bands", 2, currentMode == 2, 0);
	visMenu.addSubMenu(specmenu, "Spectrum Analyzer");

	oscmenu.addCommand("Lines", 3, currentMode == 3, 0);
	oscmenu.addCommand("Dots", 4, currentMode == 4, 0);
	oscmenu.addCommand("Solid", 5, currentMode == 5, 0);
	visMenu.addSubMenu(oscmenu, "Oscilloscope");
    visMenu.addCommand("VU Meter", 6, currentMode == 6, 0);
	visMenu.addCommand("Show VU Peaks", 102, show_vupeaks == 1, 0);

	visMenu.addSeparator();
	visMenu.addCommand("Options:", 998, 0, 1);
	
	visMenu.addCommand("Show Peaks", 101, show_peaks == 1, 0);
	
	visMenu.addSubMenu(vgridmenu, "Vertical Grid Options");
	vgridmenu.addCommand("No Grid", 600, vgrid == 0, 0);
	vgridmenu.addCommand("Thick Grid", 602, vgrid == 2, 0);
	vgridmenu.addCommand("Thin Grid", 603, vgrid == 3, 0);
	vgridmenu.addCommand("Car Display", 604, vgrid == 4, 0);
	vgridmenu.addCommand("All of the above", 605, vgrid == 5, 0);

	visMenu.addSubmenu(hgridmenu, "Horizontal Grid Options");
	hgridmenu.addCommand("No Grid", 700, hgrid == 0, 0);
	hgridmenu.addCommand("Thick Grid", 702, hgrid == 2, 0);
	hgridmenu.addCommand("Thin Grid", 703, hgrid == 3, 0);
	hgridmenu.addCommand("Car Display", 704, hgrid == 4, 0);
	hgridmenu.addCommand("All of the above", 705, hgrid == 5, 0);
	
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
	visMenu.addSubmenu(vumenu, "VU Peak Falloff Speed");
	vumenu.addCommand("Slower", 700, vp_falloffspeed == 0, 0);
	vumenu.addCommand("Slow", 701, vp_falloffspeed == 1, 0);
	vumenu.addCommand("Moderate", 702, vp_falloffspeed == 2, 0);
	vumenu.addCommand("Fast", 703, vp_falloffspeed == 3, 0);
	vumenu.addCommand("Faster", 704, vp_falloffspeed == 4, 0);
	visMenu.addSeparator();
	
	visMenu.addSubMenu(fpsmenu, "Frames Per Second");
	fpsmenu.addCommand("Lame (30 FPS)", 407, v_fps == 0, 0);
	fpsmenu.addCommand("Fast (60 FPS)", 409, v_fps == 2, 0);
	fpsmenu.addCommand("Faster (75 FPS)", 410, v_fps == 3, 0);
	fpsmenu.addCommand("Impulse Speed (120 FPS)", 412, v_fps == 5, 0);
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
	delete wmpmenu;
	delete winmenu;
	delete animenu;
	delete gamemenu;
	delete vgridmenu;
	delete hgridmenu;
	delete waxpmenu;
	delete vumenu;

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
		setPrivateInt(getSkinName(), "Visualizer show Peaks", show_peaks);
	}

	else if (a == 102)
	{
		show_vupeaks = (show_vupeaks - 1) * (-1);
		LeftMeterPeak.setXmlParam("visible", integerToString(show_vupeaks));
		RightMeterPeak.setXmlParam("visible", integerToString(show_vupeaks));
		setPrivateInt(getSkinName(), "Visualizer show VU Peaks", show_vupeaks);
	}

	else if (a >= 200 && a <= 204)
	{
		p_falloffspeed = a - 200;
		visualizer.setXmlParam("peakfalloff", integerToString(p_falloffspeed));
		visualizershade.setXmlParam("peakfalloff", integerToString(p_falloffspeed));
		setPrivateInt(getSkinName(), "Visualizer peaks falloff", p_falloffspeed);
	}

	else if (a >= 300 && a <= 304)
	{
		a_falloffspeed = a - 300;
		visualizer.setXmlParam("falloff", integerToString(a_falloffspeed));
		visualizershade.setXmlParam("falloff", integerToString(a_falloffspeed));
		setPrivateInt(getSkinName(), "Visualizer analyzer falloff", a_falloffspeed);
	}

	else if (a >= 700 && a <= 704)
	{
		vp_falloffspeed = a - 700;
		vu_falloffspeed = (vp_falloffspeed/100)+0.02;
		setPrivateInt(getSkinName(), "Visualizer VU peaks falloff", vp_falloffspeed);
	}

	else if (a >= 400 && a <= 403)
	{
		a_coloring = a - 400;
		if (a_coloring == 0)
		{
			visualizer.setXmlParam("coloring", "Normal");
			visualizershade.setXmlParam("coloring", "Normal");
		}
		else if (a_coloring == 1)
		{
			visualizer.setXmlParam("coloring", "Normal");
			visualizershade.setXmlParam("coloring", "Normal");
		}
		else if (a_coloring == 2)
		{
			visualizer.setXmlParam("coloring", "Fire");
			visualizershade.setXmlParam("coloring", "Fire");
		}
		else if (a_coloring == 3)
		{
			visualizer.setXmlParam("coloring", "Line");
			visualizershade.setXmlParam("coloring", "Line");
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
	
	else if (a >= 407 && a <= 413)
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
		else if (v_fps == 5)
		{
			visualizer.setXmlParam("fps", "120");
		}
		setPrivateInt(getSkinName(), "Visualizer FPS", v_fps);
	}
	else if (a >= 500 && a <= 532)
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

			setColorosc("160,255,160");

		}
		else if (v_color == 3)
		{
			visualizer.setXmlParam("colorallbands", "0,0,255");
			visualizer.setXmlParam("colorbandpeak", "255,255,255");

			setColorosc("160,255,160");

		}
		else if (v_color == 4)
		{
			visualizer.setXmlParam("colorallbands", "255,165,0");
			visualizer.setXmlParam("colorbandpeak", "255,0,0");

			setColorosc("160,255,160");

		}
		else if (v_color == 5)
		{
			setColorBandsOdd("242,244,247");
			setColorBandsEven("172,185,209");
			visualizer.setXmlParam("colorbandpeak", "242,244,247");

			setColorosc("242,244,247");

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
		else if (v_color == 8) //REVOCS, now empty
		{

		}
		else if (v_color == 9) //A.P.E, now empty
		{

		}
		else if (v_color == 10) //Ryuko, now empty
		{

		}
		else if (v_color == 11) //Satsuki, now empty
		{

		}
		else if (v_color == 12) //Ragyo, now empty
		{

		}
		else if (v_color == 13) //Zero Two, now empty
		{

		}
		else if (v_color == 14)
		{
			visualizer.setXmlParam("colorallbands", "0,255,0");
			visualizer.setXmlParam("colorbandpeak", "0,255,0");

			setColorosc("0,255,0");

		}
		else if (v_color == 15)
		{
			visualizer.setXmlParam("ColorBand16", "130,166,170");
			visualizer.setXmlParam("ColorBand15", "137,171,175");
			visualizer.setXmlParam("ColorBand14", "145,175,180");
			visualizer.setXmlParam("ColorBand13", "151,180,184");
			visualizer.setXmlParam("ColorBand12", "159,185,188");
			visualizer.setXmlParam("ColorBand11", "166,190,193");
			visualizer.setXmlParam("ColorBand10", "173,194,197");
			visualizer.setXmlParam("ColorBand9", "181,198,202");
			visualizer.setXmlParam("ColorBand8", "188,203,207");
			visualizer.setXmlParam("ColorBand7", "195,208,212");
			visualizer.setXmlParam("ColorBand6", "202,213,215");
			visualizer.setXmlParam("ColorBand5", "209,218,220");
			visualizer.setXmlParam("ColorBand4", "217,222,225");
			visualizer.setXmlParam("ColorBand3", "224,227,229");
			visualizer.setXmlParam("ColorBand2", "231,232,233");
			visualizer.setXmlParam("ColorBand1", "235,234,236");
			visualizer.setXmlParam("colorbandpeak", "254,246,231");
			visualizer.setXmlParam("colorosc5", "47,44,50");
			visualizer.setXmlParam("colorosc4", "85,83,88");
			visualizer.setXmlParam("colorosc3", "146,143,147");
			visualizer.setXmlParam("colorosc2", "205,203,207");
			visualizer.setXmlParam("colorosc1", "235,234,236");

		}
		else if (v_color == 16)
		{
			visualizer.setXmlParam("ColorBand1", "181,231,94");
			visualizer.setXmlParam("ColorBand2", "186,228,94");
			visualizer.setXmlParam("ColorBand3", "190,227,94");
			visualizer.setXmlParam("ColorBand4", "195,224,94");
			visualizer.setXmlParam("ColorBand5", "198,223,94");
			visualizer.setXmlParam("ColorBand6", "203,221,94");
			visualizer.setXmlParam("ColorBand7", "207,218,94");
			visualizer.setXmlParam("ColorBand8", "211,217,94");
			visualizer.setXmlParam("ColorBand9", "216,215,94");
			visualizer.setXmlParam("ColorBand10", "221,213,94");
			visualizer.setXmlParam("ColorBand11", "225,212,94");
			visualizer.setXmlParam("ColorBand12", "229,208,94");
			visualizer.setXmlParam("ColorBand13", "234,207,94");
			visualizer.setXmlParam("ColorBand14", "236,186,94");
			visualizer.setXmlParam("ColorBand15", "232,146,94");
			visualizer.setXmlParam("ColorBand16", "229,108,94");
			visualizer.setXmlParam("colorbandpeak", "150,150,150");

			setColorosc("196,181,80");

		}
		else if (v_color == 17)
		{
			setColorBandsOdd("0,222,255");
			setColorBandsEven("0,97,142");
			visualizer.setXmlParam("colorbandpeak", "140,222,255");

			setColorosc("140,222,255");

		}
		else if (v_color == 18)
		{
			setColorBandsOdd("255,0,0");
			setColorBandsEven("105,0,0");
			visualizer.setXmlParam("colorbandpeak", "255,43,0");

			setColorosc("255,43,0");

		}
		else if (v_color == 19)
		{
			setColorBandsOdd("0,255,185");
			setColorBandsEven("0,0,0");
			visualizer.setXmlParam("colorband15", "255, 51, 26");
			visualizer.setXmlParam("colorbandpeak", "0,0,0");

			setColorosc("0,255,185");
		}
		else if (v_color == 20)
		{
			visualizer.setXmlParam("colorallbands", "59,51,163");
			visualizer.setXmlParam("colorbandpeak", "122,115,219");	
			
			setColorosc("122,115,219");
		}
		else if (v_color == 21)
		{
			visualizer.setXmlParam("colorallbands", "213,175,38");
			visualizer.setXmlParam("colorbandpeak", "213,175,38");

			setColorosc("213,175,38");

		}
		else if (v_color == 22)
		{

		}
		if(v_color == 23){
			//luna
			
			visualizer.setXmlParam("colorallbands", "49,106,197");
			visualizer.setXmlParam("colorbandpeak", "49,106,197");
			setColorOsc("49,106,197");

		}
		else if(v_color == 24){
			//olive green
			
			visualizer.setXmlParam("colorallbands", "147,160,112");
			visualizer.setXmlParam("colorbandpeak", "153,84,10");
			setColorOsc("147,160,112");
		}
		else if(v_color == 25){
			//silver
			
			visualizer.setXmlParam("colorallbands", "178,180,191");
			visualizer.setXmlParam("colorbandpeak", "178,180,191");
			setColorOsc("178,180,191");
		}
		else if(v_color == 26){
			//luna - gradient

			setColorBandsGradient(3,84,227,4,4,2);

			visualizer.setXmlParam("colorbandpeak", "61,149,255");
			setColorOscOdd("3,84,227");
			setColorOscEven("61,149,255");

		}
		else if(v_color == 27){
			//olive green - gradient

			setColorBandsGradient(165,179,125,4,4,4);

			visualizer.setXmlParam("colorbandpeak", "231,240,197");
			setColorOscOdd("165,179,125");
			setColorOscEven("231,240,197");

		}
		else if(v_color == 28){
			//silver - gradient

			setColorBandsGradient(165,164,190,6,6,4);

			visualizer.setXmlParam("colorbandpeak", "252,252,252");
			setColorOscOdd("165,164,190");
			setColorOscEven("252,252,252");

		}
		else if(v_color == 29){
			//zune orange
			setColorBandsGradient(127,59,20,5,3,1);

			visualizer.setXmlParam("colorbandpeak", "231,121,49");
			setColorOscOdd("127,59,20");
			setColorOscEven("214,101,33");
		}
		else if(v_color == 30){
			//zune dark
			setColorBandsGradient(38,38,38,4,4,4);
			
			visualizer.setXmlParam("colorbandpeak", "231,121,49");
			setColorOscOdd("38,38,38");
			setColorOscEven("109,109,109");
		}
		else if (v_color == 31)
		{
			//lines & peaks only
			visualizer.setXmlParam("ColorBand1", "0,0,0");
			visualizer.setXmlParam("ColorBand2", "0,0,0");
			visualizer.setXmlParam("ColorBand3", "0,0,0");
			visualizer.setXmlParam("ColorBand4", "0,0,0");
			visualizer.setXmlParam("ColorBand5", "0,0,0");
			visualizer.setXmlParam("ColorBand6", "0,0,0");
			visualizer.setXmlParam("ColorBand7", "0,0,0");
			visualizer.setXmlParam("ColorBand8", "0,0,0");
			visualizer.setXmlParam("ColorBand9", "0,0,0");
			visualizer.setXmlParam("ColorBand10", "0,0,0");
			visualizer.setXmlParam("ColorBand11", "0,0,0");
			visualizer.setXmlParam("ColorBand12", "0,0,0");
			visualizer.setXmlParam("ColorBand13", "0,0,0");
			visualizer.setXmlParam("ColorBand14", "0,0,0");
			visualizer.setXmlParam("ColorBand15", "255,255,255");
			visualizer.setXmlParam("ColorBand16", "255,255,255");
			visualizer.setXmlParam("colorbandpeak", "255,255,255");
			setColorosc("255,255,255");
		}
		else if (v_color == 32)
		{
			//klk displays, now empty
		}
		setPrivateInt(getSkinName(), "Visualizer Color themes", v_color);
	}
	else if (a >= 600 && a <= 605)
	{
		vgrid = a - 600;
		if (vgrid == 0)
		{
			visvgrid_thick.setXmlParam("visible", "0");
			visvgrid_thin.setXmlParam("visible", "0");
			visvgrid_car.setXmlParam("visible", "0");
		}
		else if (vgrid == 1)
		{
			visvgrid_thick.setXmlParam("visible", "0");
			visvgrid_thin.setXmlParam("visible", "0");
			visvgrid_car.setXmlParam("visible", "0");
		}
		else if (vgrid == 2)
		{
			visvgrid_thick.setXmlParam("visible", "1");
			visvgrid_thin.setXmlParam("visible", "0");
			visvgrid_car.setXmlParam("visible", "0");
		}
		else if (vgrid == 3)
		{
			visvgrid_thick.setXmlParam("visible", "0");
			visvgrid_thin.setXmlParam("visible", "1");
			visvgrid_car.setXmlParam("visible", "0");
		}
		else if (vgrid == 4)
		{
			visvgrid_thick.setXmlParam("visible", "0");
			visvgrid_thin.setXmlParam("visible", "0");
			visvgrid_car.setXmlParam("visible", "1");
		}
		else if (vgrid == 5)
		{
			visvgrid_thick.setXmlParam("visible", "1");
			visvgrid_thin.setXmlParam("visible", "1");
			visvgrid_car.setXmlParam("visible", "1");
		}
		setPrivateInt(getSkinName(), "Visualizer show Vertical Grid", vgrid);
	}
	else if (a >= 700 && a <= 705)
	{
		hgrid = a - 700;
		if (hgrid == 0)
		{
			vishgrid_thick.setXmlParam("visible", "0");
			vishgrid_thin.setXmlParam("visible", "0");
			vishgrid_car.setXmlParam("visible", "0");
		}
		else if (hgrid == 1)
		{
			vishgrid_thick.setXmlParam("visible", "0");
			vishgrid_thin.setXmlParam("visible", "0");
			vishgrid_car.setXmlParam("visible", "0");
		}
		else if (hgrid == 2)
		{
			vishgrid_thick.setXmlParam("visible", "1");
			vishgrid_thin.setXmlParam("visible", "0");
			vishgrid_car.setXmlParam("visible", "0");
		}
		else if (hgrid == 3)
		{
			vishgrid_thick.setXmlParam("visible", "0");
			vishgrid_thin.setXmlParam("visible", "1");
			vishgrid_car.setXmlParam("visible", "0");
		}
		else if (hgrid == 4)
		{
			vishgrid_thick.setXmlParam("visible", "0");
			vishgrid_thin.setXmlParam("visible", "0");
			vishgrid_car.setXmlParam("visible", "1");
		}
		else if (hgrid == 5)
		{
			vishgrid_thick.setXmlParam("visible", "1");
			vishgrid_thin.setXmlParam("visible", "1");
			vishgrid_car.setXmlParam("visible", "1");
		}
		setPrivateInt(getSkinName(), "Visualizer show Horizontal Grid", hgrid);
	}
}

//sets every ColorBand in a range to a color
setColorBands(String rgb, int start, int end)
{
	for(int i=start; i<=end; i++){
		while(visualizer.getXmlParam("ColorBand"+integerToString(i)) != rgb){
			visualizer.setXmlParam("ColorBand"+integerToString(i)+"", rgb);
		}
	}
}

//sets every odd ColorBand to a color
setColorBandsOdd(String rgb)
{
	for(int i=1; i<=15; i=i+2){
		while(visualizer.getXmlParam("ColorBand"+integerToString(i)) != rgb){
			visualizer.setXmlParam("ColorBand"+integerToString(i)+"", rgb);
		}
	}
}

//sets every even ColorBand to a color
setColorBandsEven(String rgb)
{
	for(int i=2; i<=16; i=i+2){
		while(visualizer.getXmlParam("ColorBand"+integerToString(i)) != rgb){
			visualizer.setXmlParam("ColorBand"+integerToString(i)+"", rgb);
		}
	}
}

//makes a gradient using rgb values and steps for each color
setColorBandsGradient(int r, int g, int b, int stepr, int stepg, int stepb)
{
	String grad = integerToString(r) +","+ integerToString(g) +","+ integerToString(b);

	//debug stuff 1
	//String executed_loops = "Loops executed (should be 1 to 16):\n";

	for(int i=1; i<=16; i++){
		//wacup pls
		while(visualizer.getXmlParam("ColorBand"+integerToString(i)) != grad){
			visualizer.setXmlParam("ColorBand"+integerToString(i)+"", grad);
		}

		//debug stuff 2
		//executed_loops += "Executed loop " +integerToString(i)+ ", grad = " +grad+ "\n";

		r=r+stepr; g=g+stepg; b=b+stepb;
		grad = integerToString(r) +","+ integerToString(g) +","+ integerToString(b);
	}

	//debug stuff 3
	//messagebox(""+executed_loops, "debug message", 1, "");
}

//sets every colorosc to a color
setColorosc(String rgb)
{
	for(int i=1; i<=5; i++){
		while(visualizer.getXmlParam("colorosc"+integerToString(i)) != rgb){
			visualizer.setXmlParam("colorosc"+integerToString(i)+"", rgb);
		}
	}
}

//sets every colorosc in a range color
setColoroscRange(String rgb, int start, int end)
{
	for(int i=start; i<=end; i++){
		while(visualizer.getXmlParam("colorosc"+integerToString(i)) != rgb){
			visualizer.setXmlParam("colorosc"+integerToString(i)+"", rgb);
		}
	}
}

//sets every odd colorosc to a color
setColoroscOdd(String rgb)
{
	for(int i=1; i<=5; i=i+2){
		while(visualizer.getXmlParam("colorosc"+integerToString(i)) != rgb){
			visualizer.setXmlParam("colorosc"+integerToString(i)+"", rgb);
		}
	}
}

//sets every even colorosc to a color
setColoroscEven(String rgb)
{
	for(int i=2; i<=4; i=i+2){
		while(visualizer.getXmlParam("colorosc"+integerToString(i)) != rgb){
			visualizer.setXmlParam("colorosc"+integerToString(i)+"", rgb);
		}
	}
}


setVis (int mode)
{
	setPrivateInt(getSkinName(), "Visualizer Mode", mode);
	if (mode == 0)
	{
        VU.stop();
		LeftMeterPeak.setXmlParam("alpha", "0");
		RightMeterPeak.setXmlParam("alpha", "0");
		LeftMeter.setXmlParam("visible", "0");
		RightMeter.setXmlParam("visible", "0");
		SLeftMeterPeak.setXmlParam("alpha", "0");
		SRightMeterPeak.setXmlParam("alpha", "0");
		SLeftMeter.setXmlParam("visible", "0");
		SRightMeter.setXmlParam("visible", "0");
		HideForVic.show();
		visualizer.setMode(0);
		visualizershade.setMode(0);
	}
	else if (mode == 1)
	{
        VU.stop();
		LeftMeterPeak.setXmlParam("alpha", "0");
		RightMeterPeak.setXmlParam("alpha", "0");
		LeftMeter.setXmlParam("visible", "0");
		RightMeter.setXmlParam("visible", "0");
		SLeftMeterPeak.setXmlParam("alpha", "0");
		SRightMeterPeak.setXmlParam("alpha", "0");
		SLeftMeter.setXmlParam("visible", "0");
		SRightMeter.setXmlParam("visible", "0");
		visualizer.setXmlParam("bandwidth", "wide");
		visualizershade.setXmlParam("bandwidth", "wide");
		HideForVic.show();
		visualizer.setMode(1);
		visualizershade.setMode(1);
	}
	else if (mode == 2)
	{
        VU.stop();
		LeftMeterPeak.setXmlParam("alpha", "0");
		RightMeterPeak.setXmlParam("alpha", "0");
		LeftMeter.setXmlParam("visible", "0");
		RightMeter.setXmlParam("visible", "0");
		SLeftMeterPeak.setXmlParam("alpha", "0");
		SRightMeterPeak.setXmlParam("alpha", "0");
		SLeftMeter.setXmlParam("visible", "0");
		SRightMeter.setXmlParam("visible", "0");
		visualizer.setXmlParam("bandwidth", "thin");
		visualizershade.setXmlParam("bandwidth", "thin");
		HideForVic.show();
		visualizer.setMode(1);
		visualizershade.setMode(1);
	}
	else if (mode == 3)
	{
        VU.stop();
		LeftMeterPeak.setXmlParam("alpha", "0");
		RightMeterPeak.setXmlParam("alpha", "0");
		LeftMeter.setXmlParam("visible", "0");
		RightMeter.setXmlParam("visible", "0");
		SLeftMeterPeak.setXmlParam("alpha", "0");
		SRightMeterPeak.setXmlParam("alpha", "0");
		SLeftMeter.setXmlParam("visible", "0");
		SRightMeter.setXmlParam("visible", "0");
		visualizer.setXmlParam("oscstyle", "solid");
		visualizershade.setXmlParam("oscstyle", "solid");
		HideForVic.hide();
		visualizer.setMode(2);
		visualizershade.setMode(2);
	}
	else if (mode == 4)
	{
        VU.stop();
		LeftMeterPeak.setXmlParam("alpha", "0");
		RightMeterPeak.setXmlParam("alpha", "0");
		LeftMeter.setXmlParam("visible", "0");
		RightMeter.setXmlParam("visible", "0");
		SLeftMeterPeak.setXmlParam("alpha", "0");
		SRightMeterPeak.setXmlParam("alpha", "0");
		SLeftMeter.setXmlParam("visible", "0");
		SRightMeter.setXmlParam("visible", "0");
		visualizer.setXmlParam("oscstyle", "dots");
		visualizershade.setXmlParam("oscstyle", "dots");
		HideForVic.hide();
		visualizer.setMode(2);
		visualizershade.setMode(2);
	}
	else if (mode == 5)
	{
        VU.stop();
		LeftMeterPeak.setXmlParam("alpha", "0");
		RightMeterPeak.setXmlParam("alpha", "0");
		LeftMeter.setXmlParam("visible", "0");
		RightMeter.setXmlParam("visible", "0");
		SLeftMeterPeak.setXmlParam("alpha", "0");
		SRightMeterPeak.setXmlParam("alpha", "0");
		SLeftMeter.setXmlParam("visible", "0");
		SRightMeter.setXmlParam("visible", "0");
		visualizer.setXmlParam("oscstyle", "lines");
		visualizershade.setXmlParam("oscstyle", "lines");
		HideForVic.hide();
		visualizer.setMode(2);
		visualizershade.setMode(2);
	}
    else if (mode == 6)
	{
		VU.start();
		LeftMeter.setXmlParam("visible", "1");
		RightMeter.setXmlParam("visible", "1");
		LeftMeterPeak.setXmlParam("alpha", "255");
		RightMeterPeak.setXmlParam("alpha", "255");
		SLeftMeter.setXmlParam("visible", "1");
		SRightMeter.setXmlParam("visible", "1");
		SLeftMeterPeak.setXmlParam("alpha", "255");
		SRightMeterPeak.setXmlParam("alpha", "255");
		visualizer.setMode(0);
		visualizershade.setMode(0);
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
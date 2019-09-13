#include "std.mi"
#include "lib/winampconfig.mi"

#define ISOBANDS "31.5 Hz,63 Hz,125 Hz,250 Hz,500 Hz,1 KHz,2 KHz,4 KHz,8 KHz,16 KHz"
#define WINAMPBANDS "70 Hz,180 Hz,320 Hz,600 Hz,1 KHz,3 KHz,6 KHz,12 KHz,14 KHz,16 KHz"


Global Container containerMain;
Global Container containerPL;
Global Container containerEq;
Global Layout layoutEqNormal, layoutEqShade, layoutMainNormal, layoutMainShade;
Global GuiObject textNormalSongInfo, textShadeSongInfo;
Global Text textNormalActionInfo, textShadeActionInfo;
Global Group ShadeGroupMain, ShadeGroupDisplay, EqNormalGroup;

Global Button btnEQp12, btnEQ0, btnEQm12;
Global Layer EqONLight, AutoONLight, FrequencyLabel;

Global Slider sliderEqNormalEQBand00, sliderEqNormalEQBand01, sliderEqNormalEQBand02, sliderEqNormalEQBand03, sliderEqNormalEQBand04, sliderEqNormalEQBand05;
Global Slider sliderEqNormalEQBand06, sliderEqNormalEQBand07, sliderEqNormalEQBand08, sliderEqNormalEQBand09, sliderEqNormalEQBand10;

Global Togglebutton EqONBtn, AutoONBtn;

Function showActionInfo(String strValue);
Function setSongTicker();

Global Timer timerSongTicker;
Global Boolean boolReleaseSongTicker;
Global Boolean boolSongTicker;

Global int AutoState;
Global int EqState;


System.onScriptLoaded() {
  containerMain = System.getContainer("main");

	layoutMainNormal = containerMain.getLayout("normal");
	layoutMainShade = containerMain.getLayout("shade");
	textNormalSongInfo = layoutMainNormal.findObject("player.display.songname");
	textNormalActionInfo = layoutMainNormal.findObject("player.display.actioninfo");

	ShadeGroupMain = layoutMainShade.findObject("player.shade.group.main");
	ShadeGroupDisplay = ShadeGroupMain.findObject("player.shade.group.display");
	textShadeSongInfo = ShadeGroupDisplay.findObject("shade.display.songname");
	textShadeActionInfo = ShadeGroupDisplay.findObject("player.display.actioninfo");	
	
  containerEq = System.getContainer("equalizer");
  layoutEqNormal = containerEq.getLayout("normaleq");
	layoutEqShade = containerEq.getLayout("shade");

	EqNormalGroup = layoutEqNormal.getObject("equalizer.normal.group.main.content");
	FrequencyLabel = EqNormalGroup.getObject("eq.frequency.labels");
	
	EqONBtn = EqNormalGroup.getObject("eq.button.on");
	AutoONBtn = EqNormalGroup.getObject("eq.button.auto");
	EqONLight = EqNormalGroup.getObject("eq.light.on");
	AutoONLight = EqNormalGroup.getObject("eq.light.auto");

	sliderEqNormalEQBand00 = EqNormalGroup.findObject("preamp");
	sliderEqNormalEQBand01 = EqNormalGroup.findObject("eq1");
	sliderEqNormalEQBand02 = EqNormalGroup.findObject("eq2");
	sliderEqNormalEQBand03 = EqNormalGroup.findObject("eq3");
	sliderEqNormalEQBand04 = EqNormalGroup.findObject("eq4");
	sliderEqNormalEQBand05 = EqNormalGroup.findObject("eq5");
	sliderEqNormalEQBand06 = EqNormalGroup.findObject("eq6");
	sliderEqNormalEQBand07 = EqNormalGroup.findObject("eq7");
	sliderEqNormalEQBand08 = EqNormalGroup.findObject("eq8");
	sliderEqNormalEQBand09 = EqNormalGroup.findObject("eq9");
	sliderEqNormalEQBand10 = EqNormalGroup.findObject("eq10");

	btnEQp12 = EqNormalGroup.findObject("EQ_p12");
	btnEQ0 = EqNormalGroup.findObject("EQ_0");
	btnEQm12 = EqNormalGroup.findObject("EQ_m12");

  WinampConfigGroup eqwcg = WinampConfig.getGroup("{72409F84-BAF1-4448-8211-D84A30A1591A}");
  int freqmode = eqwcg.getInt("frequencies"); // returns 0 for classical winamp levels, 1 for ISO levels
  system.onEqFreqChanged(freqmode);


  AutoState=getPrivateInt(getSkinName(), "AutoState", AutoState);
  EqState=getPrivateInt(getSkinName(), "EqState", EqState);
  

  if (AutoState == 1) { AutoONLight.setXmlParam("image", "onauto.light.on"); AutoState = 1; }
  else { AutoONLight.setXmlParam("image", "onauto.light.off"); AutoState = 0; }

  if (EqState == 1) { EqONLight.setXmlParam("image", "onauto.light.on"); EqState = 1; }
  else { EqONLight.setXmlParam("image", "onauto.light.off"); EqState = 0; }

	textNormalActionInfo.hide();
	textShadeActionInfo.hide();
	  
  timerSongTicker = new Timer;
	timerSongTicker.setDelay(1000);
	boolReleaseSongTicker = true;
	
	setSongTicker();
}

System.onScriptUnloading() {
  setPrivateInt(getSkinName(), "AutoState", AutoState);
  setPrivateInt(getSkinName(), "EqState", EqState);
  delete timerSongTicker;
}

System.onEqChanged (boolean newstatus)
{
	if (!newstatus)
	{
    if (EqONBtn.isMouseOverRect()) { EqONLight.setXmlParam("image", "onauto.light.on.h");	}
    else if (!EqONBtn.isMouseOverRect()) { EqONLight.setXmlParam("image", "onauto.light.off"); }
    EqState = 0;
	}
	else
	{
    if (EqONBtn.isMouseOverRect()) { EqONLight.setXmlParam("image", "onauto.light.on.h");	}
    else if (!EqONBtn.isMouseOverRect()) { EqONLight.setXmlParam("image", "onauto.light.on"); }
    EqState = 1;
	}
}

/*EqONBtn.onToggle(boolean onoff)
{
	if (onoff) {
    EqONLight.setXmlParam("image", "onauto.light.on");
    EqState == 1;
	}
	else {
    EqONLight.setXmlParam("image", "onauto.light.off");
    EqState == 0;
	}
}*/

AutoONBtn.onToggle(boolean onoff)
{
	if (onoff) {
    if (AutoONBtn.isMouseOverRect()) { AutoONLight.setXmlParam("image", "onauto.light.on.h"); }
    else if (!AutoONBtn.isMouseOverRect()) { AutoONLight.setXmlParam("image", "onauto.light.off"); }
  AutoState = 1;
	}
	else {
    if (AutoONBtn.isMouseOverRect()) { AutoONLight.setXmlParam("image", "onauto.light.on.h");	}
    else if (!AutoONBtn.isMouseOverRect()) { AutoONLight.setXmlParam("image", "onauto.light.on"); }
    AutoState = 0;
	}
}


Global Boolean manual_set;

system.onEqBandChanged(int band, int value)
{
	if (manual_set) return;
	String t;
	Float f = value;
	f = f / 10.5;
	WinampConfigGroup eqwcg = WinampConfig.getGroup("{72409F84-BAF1-4448-8211-D84A30A1591A}");
	if (eqwcg.getInt("frequencies") == 1) {
		if (f >= 0) t = "EQ: " + translate(getToken(ISOBANDS,",",band)) + ": +" + floattostring(f, 1) + " "+ translate("dB");
		else t = "EQ: " + translate(getToken(ISOBANDS,",",band)) + ": " + floattostring(f, 1) + " "+ translate("dB");
	}
	else {
		if (f >= 0) t = "EQ: " + translate(getToken(WINAMPBANDS,",",band)) + ": +" + floattostring(f, 1) + " "+ translate("dB");
		else t = "EQ: " + translate(getToken(WINAMPBANDS,",",band)) + ": " + floattostring(f, 1) + " "+ translate("dB");
	}

  
  showActionInfo(t);
}



System.onEqFreqChanged (boolean isoonoff)
{
	if (isoonoff == 1)
	{
		FrequencyLabel.setXmlParam("image", "eq.normal.labels.iso");
		for(int i=0; i<10; i++) EqNormalGroup.findObject("eq"+integerToString(i+1)).setXmlParam("tooltip", getToken(ISOBANDS,",",i));
	}
	else
	{
		FrequencyLabel.setXmlParam("image", "eq.normal.labels.winamp");
		for(int i=0; i<10; i++) EqNormalGroup.findObject("eq"+integerToString(i+1)).setXmlParam("tooltip", getToken(WINAMPBANDS,",",i));
	}
}

EqONBtn.onLeftButtonDown (int x, int y)
{
  EqONLight.setXmlParam("image", "onauto.light.on.d");
  /*if (EqState == 1)
  {
    EqONLight.setXmlParam("image", "onauto.light.on.d");
    EqState = 0;
  }
  else if (EqState == 0)
  {
    EqONLight.setXmlParam("image", "onauto.light.on.d");
    EqState = 1;
  }*/
}

AutoONBtn.onLeftButtonDown (int x, int y)
{
  AutoONLight.setXmlParam("image", "onauto.light.on.d");
  /*if (AutoState == 1)
  {
    AutoONLight.setXmlParam("image", "onauto.light.on.d");
    AutoState = 0;
  }
  else
  {
    AutoState = 1;
    AutoONLight.setXmlParam("image", "onauto.light.on.d");
  }*/
}
    
    
EqONBtn.onLeftButtonUp (int x, int y)
{
  if (EqONBtn.isMouseOverRect()) {
    if (EqState == 1) { EqONLight.setXmlParam("image", "onauto.light.on.h"); EqState = 1; }
    else if (EqState == 0) { EqONLight.setXmlParam("image", "onauto.light.on.h"); EqState = 0; }
  }
  else
  {
    if (EqState == 1) { EqONLight.setXmlParam("image", "onauto.light.on"); EqState = 1; }
    else if (EqState == 0) { EqONLight.setXmlParam("image", "onauto.light.off"); EqState = 0; }
  }
}

AutoONBtn.onLeftButtonUp (int x, int y)
{
  if (AutoONBtn.isMouseOverRect())
  {
    if (AutoState == 1) { AutoONLight.setXmlParam("image", "onauto.light.on.h"); AutoState = 1; }
    else if (AutoState == 0) { AutoONLight.setXmlParam("image", "onauto.light.on"); AutoState = 0; }
  }
  else
  {
    if (AutoState == 1) { AutoONLight.setXmlParam("image", "onauto.light.on.h"); AutoState = 1;	}
    else if (AutoState == 0) { AutoONLight.setXmlParam("image", "onauto.light.off"); AutoState = 0; }
  }
}

EqONBtn.onEnterArea()
{
  EqONLight.setXmlParam("image", "onauto.light.on.h");
}

AutoONBtn.onEnterArea()
{
  AutoONLight.setXmlParam("image", "onauto.light.on.h");
}

EqONBtn.onLeaveArea()
{
  if (EqState == 1)
  {
    EqONLight.setXmlParam("image", "onauto.light.on");
    EqState = 1;
  }
  else if (EqState == 0)
  {
    EqONLight.setXmlParam("image", "onauto.light.off");
    EqState = 0;
  }
}

AutoONBtn.onLeaveArea()
{
  if (AutoState == 1)
  {
    AutoONLight.setXmlParam("image", "onauto.light.on");
    AutoState = 1;
  }
  else if (AutoState == 0)
  {
    AutoONLight.setXmlParam("image", "onauto.light.off");
    AutoState = 0;
  }
}

system.onEqPreampChanged(int value)
{
	value = sliderEqNormalEQBand00.getPosition(); // Somehow this function returns a range from [-127;125] with hotpos -3, so we take the slider instead
	String t = "EQ: " + translate("Preamp:") + " ";
	Float f = value;
	f = f / 10.5;
	if (f >= 0) t += "+"+floattostring(f, 1) + " "+ translate("dB");
	else t += floattostring(f, 1) + " "+ translate("dB");

  showActionInfo(t); // Vic-Songticker send message
}


timerSongTicker.onTimer() {
	if (boolReleaseSongTicker) {
		textNormalActionInfo.hide();
		textShadeActionInfo.hide();

		textNormalSongInfo.show();
		textShadeSongInfo.show();
		
		timerSongTicker.stop();
	}
}

showActionInfo(String strValue) {
	timerSongTicker.stop();
	timerSongTicker.start();
	
	textNormalSongInfo.hide();
	textNormalActionInfo.show();
	textNormalActionInfo.setText(strValue);

	textShadeSongInfo.hide();
	textShadeActionInfo.show();
	textShadeActionInfo.setText(strValue);
}

setSongTicker() {
	textNormalSongInfo.setXMLParam("ticker", System.integerToString(boolSongTicker));
	textShadeSongInfo.setXMLParam("ticker", System.integerToString(boolSongTicker));
}


System.onAccelerator(String action, String section, String key) {
	if (action == "HOTKEY_SHADETOGGLEEQ")
	{
    if (layoutEqNormal.isVisible())
      layoutEqNormal.getContainer().switchToLayout("shade");
    else
      layoutEqShade.getContainer().switchToLayout("normaleq");
    complete;
	}
}
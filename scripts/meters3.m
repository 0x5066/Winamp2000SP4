// This script is copyrighted. Egor Petrov 2003 - 2005. egorka_petrov@mail.ru
// Modified by Gordon "The1" Freeman.

// Ver 1.01 (Added test mode)
// You can use this script for other skins.
#include "lib/std.mi"
#include "lib/application.mi"

Global Layer LeftMeter, RightMeter, bar3, bar4, bar5, bar6, bar7, bar8, bar9, bar10, bar11, bar12; // Animated layer
Global Timer Refresh;
Global Text debugtext, debugtext2;
Global int ONOFF, Level1, Level2, Level3, Level4, Level5, Level6, Level7, Level8, Level9, Level10, Level11, Level12, DivL1, DivL2, DivL3, DivL4, DivL5, DivL6, DivL7, DivL8, DivL9, DivL10, DivL11, DivL12, DivR1, DivR2, DivR3, DivR4, DivR5, DivR6, DivR7, DivR8, DivR9, DivR10, DivR11, DivR12;

#define sndlevel 5

Function togg();

System.onScriptLoaded() {
  Group animgroup = getScriptGroup();
  LeftMeter = animgroup.getObject("ragyovis_hair.animatedlayerL");
  RightMeter = animgroup.getObject("ragyovis_hair.animatedlayerR");
  bar3 = animgroup.getObject("bar3");
  bar4 = animgroup.getObject("bar4");
  bar5 = animgroup.getObject("bar5");
  bar6 = animgroup.getObject("bar6");
  bar7 = animgroup.getObject("bar7");
  bar8 = animgroup.getObject("bar8");
  bar9 = animgroup.getObject("bar9");
  bar10 = animgroup.getObject("bar10");
  bar11 = animgroup.getObject("bar11");
  bar12 = animgroup.getObject("bar12");
  
  debugtext = animgroup.getObject("debug_stuff");
  debugtext2 = animgroup.getObject("more_debug_stuff");
  ONOFF = getPrivateInt("EPS3", "Disable VU meters3", 0);
	string paramslist = getPrivateString("EPS3", "Electronic meters3", "4;200;4;200");
	DivL1 = stringToInteger(getToken(paramslist, ";", 0));
	DivL2 = stringToInteger(getToken(paramslist, ";", 1));
	DivR1 = stringToInteger(getToken(paramslist, ";", 2));
	DivR2 = stringToInteger(getToken(paramslist, ";", 3));
	
	DivL3 = stringToInteger(getToken(paramslist, ";", 0));
	DivL4 = stringToInteger(getToken(paramslist, ";", 1));
	DivR3 = stringToInteger(getToken(paramslist, ";", 2));
	DivR4 = stringToInteger(getToken(paramslist, ";", 3));
	
	DivL5 = stringToInteger(getToken(paramslist, ";", 0));
	DivL6 = stringToInteger(getToken(paramslist, ";", 1));
	DivR5 = stringToInteger(getToken(paramslist, ";", 2));
	DivR6 = stringToInteger(getToken(paramslist, ";", 3));
	
	DivL7 = stringToInteger(getToken(paramslist, ";", 0));
	DivL8 = stringToInteger(getToken(paramslist, ";", 1));
	DivR7 = stringToInteger(getToken(paramslist, ";", 2));
	DivR8 = stringToInteger(getToken(paramslist, ";", 3));
	
	DivL9 = stringToInteger(getToken(paramslist, ";", 0));
	DivL10 = stringToInteger(getToken(paramslist, ";", 1));
	DivR9 = stringToInteger(getToken(paramslist, ";", 2));
	DivR10 = stringToInteger(getToken(paramslist, ";", 3));
	
	DivL11 = stringToInteger(getToken(paramslist, ";", 0));
	DivL12 = stringToInteger(getToken(paramslist, ";", 1));
	DivR11 = stringToInteger(getToken(paramslist, ";", 2));
	DivR12 = stringToInteger(getToken(paramslist, ";", 3));

  Refresh = new Timer;
  Refresh.setDelay(0);
  Refresh.start();
}

System.onScriptUnloading() {
  delete Refresh;
  setPrivateInt("EPS3", "Disable VU meters3", ONOFF);
	setPrivateString("EPS3", "Electronic meters3", 
	integerToString(DivL1)+";"
	+integerToString(DivL2)+";"
	+integerToString(DivR1)+";"
	+integerToString(DivR2));
}

Refresh.onTimer() {
	level1 += 	(getVisBand(0, 0) - level1) / DivL1; //smoothness
	level2 += 	(getVisBand(0, 1) - level2) / DivR1; //smoothness
	level3 += 	(getVisBand(0, 2) - level3) / DivL3; //smoothness
	level4 += 	(getVisBand(0, 3) - level4) / DivR3; //smoothness
	level5 += 	(getVisBand(0, 4) - level5) / DivL5; //smoothness
	level6 += 	(getVisBand(0, 5) - level6) / DivR5; //smoothness
	level7 += 	(getVisBand(0, 6) - level7) / DivL7; //smoothness
	level8 += 	(getVisBand(0, 7) - level8) / DivR7; //smoothness
	level9 += 	(getVisBand(0, 8) - level9) / DivL9; //smoothness
	level10 += 	(getVisBand(0, 9) - level10) / DivR9; //smoothness
	level11 += 	(getVisBand(0, 10) - level11) / DivL11; //smoothness
	level12 += 	(getVisBand(0, 11) - level12) / DivR11; //smoothness
	int frame1 = level1/DivL2* (stringToInteger(LeftMeter.getXmlParam("h"))); //sensitivity
	int frame2 = level2/DivR2* (stringToInteger(RightMeter.getXmlParam("h"))); //sensitivity
	int frame3 = level3/DivL4* (stringToInteger(bar3.getXmlParam("h"))); //sensitivity
	int frame4 = level4/DivR4* (stringToInteger(bar4.getXmlParam("h"))); //sensitivity
	int frame5 = level5/DivL6* (stringToInteger(bar5.getXmlParam("h"))); //sensitivity
	int frame6 = level6/DivR6* (stringToInteger(bar6.getXmlParam("h"))); //sensitivity
	int frame7 = level7/DivL8* (stringToInteger(bar7.getXmlParam("h"))); //sensitivity
	int frame8 = level8/DivR8* (stringToInteger(bar8.getXmlParam("h"))); //sensitivity
	int frame9 = level9/DivL10* (stringToInteger(bar9.getXmlParam("h"))); //sensitivity
	int frame10 = level10/DivR10* (stringToInteger(bar10.getXmlParam("h"))); //sensitivity
	int frame11 = level11/DivL12* (stringToInteger(bar11.getXmlParam("h"))); //sensitivity
	int frame12 = level12/DivR12* (stringToInteger(bar12.getXmlParam("h"))); //sensitivity
  debugtext.setXmlParam("text", 
    "level11: " +integerToString(level11)+ 
    ", level12: " +integerToString(level12)+
    ", frame11: " +integerToString(frame11)+
    ", frame12: " +integerToString(frame12)+""
  );
  debugtext2.setXmlParam("text", 
    "divl11, l12: " +integerToString(DivL11)+ ", " +integerToString(DivL12)+
    ", divr11, r12: " +integerToString(DivR11)+ ", " +integerToString(DivR12)+
    ", bar11 h: " +bar11.getXmlParam("h")+
    ", bar12 h: " +bar12.getXmlParam("h")+""
  );
  
  if (frame1 < LeftMeter.getXmlParam("h") && frame2 < RightMeter.getXmlParam("h")) {
    LeftMeter.setXmlParam("h", integerToString(level1+sndlevel));
    RightMeter.setXmlParam("h", integerToString(level2+sndlevel));
	}
	if (frame3 < bar3.getXmlParam("h") && frame4 < bar4.getXmlParam("h")) {
    bar3.setXmlParam("h", integerToString(level3+sndlevel));
    bar4.setXmlParam("h", integerToString(level4+sndlevel));
	}
	if (frame5 < bar5.getXmlParam("h") && frame6 < bar6.getXmlParam("h")) {
    bar5.setXmlParam("h", integerToString(level5+sndlevel));
    bar6.setXmlParam("h", integerToString(level6+sndlevel));
	}
	if (frame7 < bar7.getXmlParam("h") && frame8 < bar8.getXmlParam("h")) {
    bar7.setXmlParam("h", integerToString(level7+sndlevel));
    bar8.setXmlParam("h", integerToString(level8+sndlevel));
	}
	if (frame9 < bar9.getXmlParam("h") && frame10 < bar10.getXmlParam("h")) {
    bar9.setXmlParam("h", integerToString(level9+sndlevel));
    bar10.setXmlParam("h", integerToString(level10+sndlevel));
	}
	if (frame11 < bar11.getXmlParam("h") && frame12 < bar12.getXmlParam("h")) {
    bar11.setXmlParam("h", integerToString(level11+sndlevel));
    bar12.setXmlParam("h", integerToString(level12+sndlevel));
	}
}

System.onKeyDown(string key) {
  if (key == "ctrl+m") {
    togg();
  }
}

LeftMeter.onLeftButtonUp(int x, int y) {
  PopupMenu MainMenu;
	MainMenu = new PopupMenu;
	PopupMenu Div1Menu;
	Div1Menu = new PopupMenu;
	PopupMenu Div2Menu;
	Div2Menu = new PopupMenu;
	
	//modify i = N instead of doing a replace all 10s operation, thereby causing a god damn black hole
	
	for (int i = 1; i < 10; ++i) Div1Menu.addCommand(integerToString(i), i*10, 
	DivL1 == i &&
	DivR1 == i &&
	DivL3 == i &&
	DivR3 == i &&
	DivL5 == i &&
	DivR5 == i &&
	DivL7 == i && 
	DivR7 == i &&
	DivL9 == i &&
	DivR9 == i &&
	DivL11 == i &&
	DivR11 == i, 0);
	
	Div1Menu.addCommand("info", 100, 0, 0);
	
	for (int i = 10; i < 26; ++i) Div2Menu.addCommand(integerToString(i*10), i*20, 
	DivL2 == i*10 && 
	DivR2 == i*10 && 
	DivL4 == i*10 && 
	DivR4 == i*10 && 
	DivL6 == i*10 && 
	DivR6 == i*10 && 
	DivL8 == i*10 && 
	DivR8 == i*10 && 
	DivL10 == i*10 && 
	DivR10 == i*10 && 
	DivL12 == i*10 && 
	DivR12 == i*10, 0);
	
	MainMenu.addSubMenu(Div1Menu, "Smoothness");
	MainMenu.addSubMenu(Div2Menu, "Sensitivity");

	int com = MainMenu.popAtMouse();
	if (com > 0 && com < 100) {
		DivL1 = com / 10; //smoothness
		DivR1 = DivL1; //smoothness
		
		DivL3 = com / 10;
		DivR3 = DivL3;
		
		DivL5 = com / 10;
		DivR5 = DivL5;
		
		DivL7 = com / 10;
		DivR7 = DivL7;
		
		DivL9 = com / 10;
		DivR9 = DivL9;
		
		DivL11 = com / 10;
		DivR11 = DivL11;
	}
	else if (com > 199 && com < 530) {
		DivL2 = com / 2; //sensitivity
		DivR2 = DivL2; //sensitivity
		
		DivL4 = com / 2;
		DivR4 = DivL4;
		
		DivL6 = com / 2;
		DivR6 = DivL6;
		
		DivL8 = com / 2;
		DivR8 = DivL8;
		
		DivL10 = com / 2;
		DivR10 = DivL10;
		
		DivL12 = com / 2;
		DivR12 = DivL12;
	}
	else if (com == 100) {
		messagebox("This is a amount of sections between two recent points.\nThese sections are not equal.\nMore sections - nicely animation, but less speed.\n 4 sections by default", "Animation info", 1, "");
	}
}

togg() {
  if (Refresh.isRunning() == 1) {
    LeftMeter.setTargetSpeed(2+random(3));
    //RightMeter.setTargetSpeed(1+random(4));
    LeftMeter.setTargetA(0);
    //RightMeter.setTargetA(0);
    LeftMeter.gotoTarget();
    //RightMeter.gotoTarget();
    Refresh.stop();
    ONOFF = 1;
  }
  else if (Refresh.isRunning() == 0) {
    LeftMeter.setTargetA(255);
    //RightMeter.setTargetA(255);
    LeftMeter.gotoTarget();
    //RightMeter.gotoTarget();
    Refresh.start();
    ONOFF = 0;
  }
}
// This script is copyrighted. Egor Petrov 2003 - 2005. egorka_petrov@mail.ru
// Modified by 0x5066.

// Ver 1.01 (Added test mode)
// You can use this script for other skins.
#include "lib/std.mi"
#include "lib/application.mi"

Global Layer LeftMeter, RightMeter, bar3, bar4, bar5, bar6, bar7, bar8, bar9, bar10, bar11, bar12, bar13, bar14, bar15, bar16, bar17, bar18, bar19, bar20, bar21, bar22, bar23, bar24; // layer
Global Timer Refresh;
Global Text debugtext, debugtext2;
Global int ONOFF, Level1, Level2, Level3, Level4, Level5, Level6, Level7, Level8, Level9, Level10, Level11, Level12, Level13, Level14, Level15, Level16, Level17, Level18, Level19, Level20, Level21, Level22, Level23, Level24, DivL1, DivL2, DivL3, DivL4, DivL5, DivL6, DivL7, DivL8, DivL9, DivL10, DivL11, DivL12, DivL13, DivL14, DivL15, DivL16, DivL17, DivL18, DivL19, DivL20, DivL21, DivL22, DivL23, DivL24, DivR1, DivR2, DivR3, DivR4, DivR5, DivR6, DivR7, DivR8, DivR9, DivR10, DivR11, DivR12, DivR13, DivR14, DivR15, DivR16, DivR17, DivR18, DivR19, DivR20, DivR21, DivR22, DivR23, DivR24;

#define sndlevel 5
#define dontlimit 300
#define dolimitpls 4

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
  bar13 = animgroup.getObject("bar13");
  bar14 = animgroup.getObject("bar14");
  bar15 = animgroup.getObject("bar15");
  bar16 = animgroup.getObject("bar16");
  bar17 = animgroup.getObject("bar17");
  bar18 = animgroup.getObject("bar18");
  bar19 = animgroup.getObject("bar19");
  bar20 = animgroup.getObject("bar20");
  bar21 = animgroup.getObject("bar21");
  bar22 = animgroup.getObject("bar22");
  bar23 = animgroup.getObject("bar23");
  bar24 = animgroup.getObject("bar24");
  
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

	DivL13 = stringToInteger(getToken(paramslist, ";", 0));
	DivL14 = stringToInteger(getToken(paramslist, ";", 1));
	DivR13 = stringToInteger(getToken(paramslist, ";", 2));
	DivR14 = stringToInteger(getToken(paramslist, ";", 3));

	DivL15 = stringToInteger(getToken(paramslist, ";", 0));
	DivL16 = stringToInteger(getToken(paramslist, ";", 1));
	DivR15 = stringToInteger(getToken(paramslist, ";", 2));
	DivR16 = stringToInteger(getToken(paramslist, ";", 3));

	DivL17 = stringToInteger(getToken(paramslist, ";", 0));
	DivL18 = stringToInteger(getToken(paramslist, ";", 1));
	DivR17 = stringToInteger(getToken(paramslist, ";", 2));
	DivR18 = stringToInteger(getToken(paramslist, ";", 3));

	DivL19 = stringToInteger(getToken(paramslist, ";", 0));
	DivL20 = stringToInteger(getToken(paramslist, ";", 1));
	DivR19 = stringToInteger(getToken(paramslist, ";", 2));
	DivR20 = stringToInteger(getToken(paramslist, ";", 3));

	DivL21 = stringToInteger(getToken(paramslist, ";", 0));
	DivL22 = stringToInteger(getToken(paramslist, ";", 1));
	DivR21 = stringToInteger(getToken(paramslist, ";", 2));
	DivR22 = stringToInteger(getToken(paramslist, ";", 3));

	DivL23 = stringToInteger(getToken(paramslist, ";", 0));
	DivL24 = stringToInteger(getToken(paramslist, ";", 1));
	DivR23 = stringToInteger(getToken(paramslist, ";", 2));
	DivR24 = stringToInteger(getToken(paramslist, ";", 3));

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
	level13 += 	(getVisBand(0, 12) - level13) / DivL13; //smoothness
	level14 += 	(getVisBand(0, 13) - level14) / DivR13; //smoothness
	level15 += 	(getVisBand(0, 14) - level15) / DivL15; //smoothness
	level16 += 	(getVisBand(0, 15) - level16) / DivR15; //smoothness
	level17 += 	(getVisBand(0, 16) - level17) / DivL17; //smoothness
	level18 += 	(getVisBand(0, 17) - level18) / DivR17; //smoothness
	level19 += 	(getVisBand(0, 18) - level19) / DivL19; //smoothness
	level20 += 	(getVisBand(0, 19) - level20) / DivR19; //smoothness
	level21 += 	(getVisBand(0, 20) - level21) / DivL21; //smoothness
	level22 += 	(getVisBand(0, 21) - level22) / DivR21; //smoothness
	level23 += 	(getVisBand(0, 22) - level23) / DivL23; //smoothness
	level24 += 	(getVisBand(0, 23) - level24) / DivR23; //smoothness
	int frame1 = level1/dontlimit* (stringToInteger(LeftMeter.getXmlParam("h"))); //sensitivity
	int frame2 = level2/dontlimit* (stringToInteger(RightMeter.getXmlParam("h"))); //sensitivity
	int frame3 = level3/dontlimit* (stringToInteger(bar3.getXmlParam("h"))); //sensitivity
	int frame4 = level4/dontlimit* (stringToInteger(bar4.getXmlParam("h"))); //sensitivity
	int frame5 = level5/dontlimit* (stringToInteger(bar5.getXmlParam("h"))); //sensitivity
	int frame6 = level6/dontlimit* (stringToInteger(bar6.getXmlParam("h"))); //sensitivity
	int frame7 = level7/dontlimit* (stringToInteger(bar7.getXmlParam("h"))); //sensitivity
	int frame8 = level8/dontlimit* (stringToInteger(bar8.getXmlParam("h"))); //sensitivity
	int frame9 = level9/dontlimit* (stringToInteger(bar9.getXmlParam("h"))); //sensitivity
	int frame10 = level10/dontlimit* (stringToInteger(bar10.getXmlParam("h"))); //sensitivity
	int frame11 = level11/dontlimit* (stringToInteger(bar11.getXmlParam("h"))); //sensitivity
	int frame12 = level12/dontlimit* (stringToInteger(bar12.getXmlParam("h"))); //sensitivity
	int frame13 = level13/dontlimit* (stringToInteger(bar13.getXmlParam("h"))); //sensitivity
	int frame14 = level14/dontlimit* (stringToInteger(bar14.getXmlParam("h"))); //sensitivity
	int frame15 = level15/dontlimit* (stringToInteger(bar15.getXmlParam("h"))); //sensitivity
	int frame16 = level16/dontlimit* (stringToInteger(bar16.getXmlParam("h"))); //sensitivity
	int frame17 = level17/dontlimit* (stringToInteger(bar17.getXmlParam("h"))); //sensitivity
	int frame18 = level18/dontlimit* (stringToInteger(bar18.getXmlParam("h"))); //sensitivity
	int frame19 = level19/dontlimit* (stringToInteger(bar19.getXmlParam("h"))); //sensitivity
	int frame20 = level20/dontlimit* (stringToInteger(bar20.getXmlParam("h"))); //sensitivity
	int frame21 = level21/dontlimit* (stringToInteger(bar21.getXmlParam("h"))); //sensitivity
	int frame22 = level22/dontlimit* (stringToInteger(bar22.getXmlParam("h"))); //sensitivity
	int frame23 = level23/dontlimit* (stringToInteger(bar23.getXmlParam("h"))); //sensitivity
	int frame24 = level24/dontlimit* (stringToInteger(bar24.getXmlParam("h"))); //sensitivity
  debugtext.setXmlParam("text", 
    "level11: " +integerToString(level11)+ 
    ", level12: " +integerToString(level12)+
    ", frame11: " +integerToString(frame11)+
    ", frame12: " +integerToString(frame12)+""
  );
  debugtext2.setXmlParam("text", 
    "divl11, l12: " +integerToString(dontlimit)+ ", " +integerToString(dontlimit)+
    ", divr11, r12: " +integerToString(dontlimit)+ ", " +integerToString(dontlimit)+
    ", bar11 h: " +bar11.getXmlParam("h")+
    ", bar12 h: " +bar12.getXmlParam("h")+""
  );
  
  if (frame1 < LeftMeter.getXmlParam("h") && frame2 < RightMeter.getXmlParam("h")) {
    LeftMeter.setXmlParam("h", integerToString(level1/dolimitpls+sndlevel));
    RightMeter.setXmlParam("h", integerToString(level2/dolimitpls+sndlevel));
	}
	if (frame3 < bar3.getXmlParam("h") && frame4 < bar4.getXmlParam("h")) {
    bar3.setXmlParam("h", integerToString(level3/dolimitpls+sndlevel));
    bar4.setXmlParam("h", integerToString(level4/dolimitpls+sndlevel));
	}
	if (frame5 < bar5.getXmlParam("h") && frame6 < bar6.getXmlParam("h")) {
    bar5.setXmlParam("h", integerToString(level5/dolimitpls+sndlevel));
    bar6.setXmlParam("h", integerToString(level6/dolimitpls+sndlevel));
	}
	if (frame7 < bar7.getXmlParam("h") && frame8 < bar8.getXmlParam("h")) {
    bar7.setXmlParam("h", integerToString(level7/dolimitpls+sndlevel));
    bar8.setXmlParam("h", integerToString(level8/dolimitpls+sndlevel));
	}
	if (frame9 < bar9.getXmlParam("h") && frame10 < bar10.getXmlParam("h")) {
    bar9.setXmlParam("h", integerToString(level9/dolimitpls+sndlevel));
    bar10.setXmlParam("h", integerToString(level10/dolimitpls+sndlevel));
	}
	if (frame11 < bar11.getXmlParam("h") && frame12 < bar12.getXmlParam("h")) {
    bar11.setXmlParam("h", integerToString(level11/dolimitpls+sndlevel));
    bar12.setXmlParam("h", integerToString(level12/dolimitpls+sndlevel));
	}
	if (frame13 < bar13.getXmlParam("h") && frame14 < bar14.getXmlParam("h")) {
    bar13.setXmlParam("h", integerToString(level13/dolimitpls+sndlevel));
    bar14.setXmlParam("h", integerToString(level14/dolimitpls+sndlevel));
	}
	if (frame15 < bar15.getXmlParam("h") && frame16 < bar16.getXmlParam("h")) {
    bar15.setXmlParam("h", integerToString(level15/dolimitpls+sndlevel));
    bar16.setXmlParam("h", integerToString(level16/dolimitpls+sndlevel));
	}
	if (frame17 < bar17.getXmlParam("h") && frame18 < bar18.getXmlParam("h")) {
    bar17.setXmlParam("h", integerToString(level17/dolimitpls+sndlevel));
    bar18.setXmlParam("h", integerToString(level18/dolimitpls+sndlevel));
	}
	if (frame19 < bar19.getXmlParam("h") && frame20 < bar20.getXmlParam("h")) {
    bar19.setXmlParam("h", integerToString(level19/dolimitpls+sndlevel));
    bar20.setXmlParam("h", integerToString(level20/dolimitpls+sndlevel));
	}
	if (frame21 < bar21.getXmlParam("h") && frame22 < bar22.getXmlParam("h")) {
    bar21.setXmlParam("h", integerToString(level21/dolimitpls+sndlevel));
    bar22.setXmlParam("h", integerToString(level22/dolimitpls+sndlevel));
	}
	if (frame23 < bar23.getXmlParam("h") && frame24 < bar24.getXmlParam("h")) {
    bar23.setXmlParam("h", integerToString(level23/dolimitpls+sndlevel));
    bar24.setXmlParam("h", integerToString(level24/dolimitpls+sndlevel));
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
	DivR11 == i &&	
	DivL13 == i &&
	DivR13 == i &&
	DivL15 == i &&
	DivR15 == i &&
	DivL17 == i && 
	DivR17 == i &&
	DivL19 == i &&
	DivR19 == i &&
	DivL21 == i &&
	DivR21 == i &&
	DivL23 == i &&
	DivR23 == i, 0);
	
	Div1Menu.addCommand("info", 100, 0, 0);
	
	MainMenu.addSubMenu(Div1Menu, "Smoothness");

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

		DivL13 = com / 10;
		DivR13 = DivL13;
		
		DivL15 = com / 10;
		DivR15 = DivL15;
		
		DivL17 = com / 10;
		DivR17 = DivL17;
		
		DivL19 = com / 10;
		DivR19 = DivL19;
		
		DivL21 = com / 10;
		DivR21 = DivL21;

		DivL23 = com / 10;
		DivR23 = DivL23;
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

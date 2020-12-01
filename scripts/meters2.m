// This script is copyrighted. Egor Petrov 2003 - 2005. egorka_petrov@mail.ru
// Modified by Gordon "The1" Freeman.

// Ver 1.01 (Added test mode)
// You can use this script for other skins.
#include "lib/std.mi"

Global AnimatedLayer RightMeter, LeftMeter;// Animated layer
Global Timer Refresh;
Global int ONOFF, Level1, Level2, DivL1, DivL2, DivR1, DivR2;

Function togg();

System.onScriptLoaded() {
  Group animgroup = getScriptGroup();
  LeftMeter = animgroup.getObject("ragyovis_hair.animatedlayerL");
  RightMeter = animgroup.getObject("ragyovis_hair.animatedlayerR");
  ONOFF = getPrivateInt("EPS2", "Disable VU meters2", 0);
	string paramslist = getPrivateString("EPS2", "Electronic meters2", "4;200;4;200");
	DivL1 = stringToInteger(getToken(paramslist, ";", 0));
	DivL2 = stringToInteger(getToken(paramslist, ";", 1));
	DivR1 = stringToInteger(getToken(paramslist, ";", 2));
	DivR2 = stringToInteger(getToken(paramslist, ";", 3));
  Refresh = new Timer;
  Refresh.setDelay(0);
  Refresh.start();
}

System.onScriptUnloading() {
  delete Refresh;
  setPrivateInt("EPS2", "Disable VU meters2", ONOFF);
	setPrivateString("EPS2", "Electronic meters2", integerToString(DivL1)+";"+integerToString(DivL2)+";"+integerToString(DivR1)+";"+integerToString(DivR2));
}

Refresh.onTimer() {
  level1 += (getVisBand(0, 0) - level1) / DivL1;
	level2 += (getVisBand(0, 58) - level2) / DivR1;
	int frame1 = level1/DivL2*LeftMeter.getLength();
	int frame2 = level2/DivR2*RightMeter.getLength();
  if (frame1 < LeftMeter.getLength() && frame2 < RightMeter.getLength()) {
    LeftMeter.gotoFrame(frame1);
    RightMeter.gotoFrame(frame2);
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
	
	for (int i = 1; i < 10; ++i) Div1Menu.addCommand(integerToString(i), i*10, DivL1 == i && DivR1 == i, 0);
	Div1Menu.addCommand("info", 100, 0, 0);
	for (int i = 10; i < 26; ++i) Div2Menu.addCommand(integerToString(i*10), i*20, DivL2 == i*10 && DivR2 == i*10, 0);
	MainMenu.addSubMenu(Div1Menu, "Smoothness");
	MainMenu.addSubMenu(Div2Menu, "Sensitivity");

	int com = MainMenu.popAtMouse();
	if (com > 0 && com < 100) {
		DivL1 = com / 10;
		DivR1 = DivL1;
	}
	else if (com > 199 && com < 530) {
		DivL2 = com / 2;
		DivR2 = DivL2;
	}
	else if (com == 100) {
		messagebox("This is a amount of sections between two recent points.\nThese sections are not equal.\nMore sections - nicely animation, but less speed.\n 4 sections by default", "Animation info", 1, "");
	}
}

togg() {
  if (Refresh.isRunning() == 1) {
    LeftMeter.setTargetSpeed(2+random(3));
    RightMeter.setTargetSpeed(1+random(4));
    LeftMeter.setTargetA(0);
    RightMeter.setTargetA(0);
    LeftMeter.gotoTarget();
    RightMeter.gotoTarget();
    Refresh.stop();
    ONOFF = 1;
  }
  else if (Refresh.isRunning() == 0) {
    LeftMeter.setTargetA(255);
    RightMeter.setTargetA(255);
    LeftMeter.gotoTarget();
    RightMeter.gotoTarget();
    Refresh.start();
    ONOFF = 0;
  }
}
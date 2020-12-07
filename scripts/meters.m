// This script is copyrighted. Egor Petrov 2003 - 2005. egorka_petrov@mail.ru
// Modified by 0x5066.

// Ver 2.1 (No its not, what kind of a liar are you? actually fixed having to rely on a dumb fixed number)
// Ver 2.0 (It's now a skin specific script)
// Ver 1.01 (Added test mode)
// You can use this script for other skins.
#include "lib/std.mi"
#define dontlimit 300 
//this is here for the - what used to be - sensitivity function, 300 is probably a safe value as anything below that (probably) clips the signal off in a weird way, 250 will do that

Global AnimatedLayer RightMeter, LeftMeter;// Animated layer
Global Timer Refresh;
Global int ONOFF, Level1, Level2, DivL1, DivL2, DivR1, DivR2, dontamp;

Function togg();

System.onScriptLoaded() {
  Group animgroup = getScriptGroup();
  LeftMeter = animgroup.getObject("leftVuMeter");
  RightMeter = animgroup.getObject("rightVuMeter");
  ONOFF = getPrivateInt("RyukoAndSatsuki", "Disable Headbanging", 0);
	string paramslist = getPrivateString("RyukoAndSatsuki", "Digital Headbanging", "4;200;4;200");
  dontamp = stringToInteger(getToken(paramslist, ";", 0));
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
  setPrivateInt("RyukoAndSatsuki", "Disable Headbanging", ONOFF);
	setPrivateString("RyukoAndSatsuki", "Digital Headbanging", integerToString(DivL1)+";"+integerToString(DivL2)+";"+integerToString(DivR1)+";"+integerToString(DivR2));
}

Refresh.onTimer() {
  level1 += ((getVisBand(0, 0)*LeftMeter.getLength()/256) / 3 + ((getVisBand(0, 1)*LeftMeter.getLength()/256) / 3) + (getVisBand(0, 2)*LeftMeter.getLength()/256) / 3 - level1 / DivL1); //returns what getVisBand actually returns with smoothness included
	level2 += ((getVisBand(0, 0)*LeftMeter.getLength()/256) / 3 + ((getVisBand(0, 1)*LeftMeter.getLength()/256) / 3) + (getVisBand(0, 2)*LeftMeter.getLength()/256) / 3 - level2 / DivR1);
	int frame1 = level1/dontlimit;
	int frame2 = level2/dontlimit;
  if (frame1 < LeftMeter.getLength() && frame2 < RightMeter.getLength()) {
    LeftMeter.gotoFrame(level1/dontamp);
    RightMeter.gotoFrame(level2/dontamp);
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
	
	//modify i = N instead of doing a replace all 10s operation, thereby causing a god damn black hole
	
	for (int i = 1; i < 10; ++i) Div1Menu.addCommand(integerToString(i), i*10, DivL1 == i && DivR1 == i && dontamp == i, 0);
	Div1Menu.addCommand("info", 100, 0, 0);
	MainMenu.addSubMenu(Div1Menu, "Smoothness");

	int com = MainMenu.popAtMouse();
	if (com > 0 && com < 100) {
		DivL1 = com / 10;
		DivR1 = DivL1;
		dontamp = com / 10;
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

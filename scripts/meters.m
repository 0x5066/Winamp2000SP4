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
Global int ONOFF, Level1, DivL1, dontamp;

Global int sensitivity;

Function togg();

System.onScriptLoaded() {
  Group animgroup = getScriptGroup();
  LeftMeter = animgroup.getObject("leftVuMeter");
  RightMeter = animgroup.getObject("rightVuMeter");
  ONOFF = getPrivateInt("RyukoAndSatsuki", "Disable Headbanging", 0);
	string paramslist = getPrivateString("RyukoAndSatsuki", "Digital Headbanging", "4;200;4;200");
  dontamp = stringToInteger(getToken(paramslist, ";", 0));
	DivL1 = stringToInteger(getToken(paramslist, ";", 0));
  sensitivity = getPrivateInt(getSkinName(), "RyukoVisSensitivity", 3);
  Refresh = new Timer;
  Refresh.setDelay(0);
  Refresh.start();
}

System.onScriptUnloading() {
  delete Refresh;
  //why doesn't this work wtf
  setPrivateInt(getSkinName(), "RyukoVisSensitivity", sensitivity);
  setPrivateInt("RyukoAndSatsuki", "Disable Headbanging", ONOFF);
	setPrivateString("RyukoAndSatsuki", "Digital Headbanging", integerToString(DivL1));
}

Refresh.onTimer() {

  for(int i = 0; i<sensitivity; i++){
    // idk how correct the sensitivity division is but it seems to work
    level1 += (getVisBand(0, sensitivity)*LeftMeter.getLength()/256 - level1) / DivL1;
  }

  int frame1 = level1;
	int frame2 = level1;

  if (frame1 < LeftMeter.getLength() && frame2 < RightMeter.getLength()) {
    LeftMeter.gotoFrame(level1/dontamp);
    RightMeter.gotoFrame(level1/dontamp);
	}

}

System.onKeyDown(string key) {
  if (key == "ctrl+m") {
    togg();
  }
}

LeftMeter.onLeftButtonUp(int x, int y) {
  PopupMenu MainMenu = new PopupMenu;
	PopupMenu Div1Menu = new PopupMenu;
  PopupMenu SensMenu = new PopupMenu;
	
	//modify i = N instead of doing a replace all 10s operation, thereby causing a god damn black hole
	
	for (int i = 1; i < 10; ++i) Div1Menu.addCommand(integerToString(i), i*10, DivL1 == i && dontamp == i, 0);
	Div1Menu.addCommand("info", 100, 0, 0);
	MainMenu.addSubMenu(Div1Menu, "Smoothness");

  for (int i = 1; i < 9; ++i) SensMenu.addCommand(integerToString(i), i, sensitivity == i, 0);
	MainMenu.addSubMenu(SensMenu, "Sensitivity");

	int com = MainMenu.popAtMouse();
	if(com>=1 && com<9){
    sensitivity = com;
  }
  else if (com > 9 && com < 100) {
		DivL1 = com / 10;
		dontamp = com / 10;
	}
  //at this moment, the dontamp variable clamps the signal logarithmic, rather than
  //doing it in a relatively linear manner as it did previously,
  //the cause of this is unknown and it is a regression
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

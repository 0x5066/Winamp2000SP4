//please, steal this, i beg you
//provides you with an actual MM:SS time display
//one that nullsoft removed for some unknown reason
//either during or on release of winamp3 and they
//never bothered to fix this, so i did

#include "lib/std.mi"

Global Container containerMain;
Global Group MainGroup, DisplayGroup;
Global GuiObject DisplayTime;
Global Layout layoutMainNormal;
Global Timer timerSongTimer;

Function AreWePlaying();

System.onScriptLoaded() {
    containerMain = System.getContainer("main");
    layoutMainNormal = containerMain.getLayout("normal");
	MainGroup = layoutMainNormal.getObject("player.normal.group.main");
	DisplayGroup = MainGroup.getObject("player.normal.group.display");
  DisplayTime = DisplayGroup.getObject("display.time");

  	timerSongTimer = new Timer;
	timerSongTimer.setDelay(100);

    AreWePlaying();
}

System.onPlay(){
    timerSongTimer.start();
}

System.onPause(){
    timerSongTimer.start();
}

System.onResume(){
    timerSongTimer.start();
}

System.onStop(){
    timerSongTimer.stop();
    DisplayTime.setXmlParam("text", " :  ");
}

timerSongTimer.onTimer() {
    int milliseconds = System.getPosition();
    String currentpos = System.integerToTime(milliseconds);

    if(milliseconds < 600000){
        DisplayTime.setXmlParam("text", "0"+currentpos);
    }
    else{
        DisplayTime.setXmlParam("text", currentpos);
    }
}

AreWePlaying() {

    int milliseconds = System.getPosition();
    String currentpos = System.integerToTime(milliseconds);

    if (getStatus() == -1) //Paused
		{
            if(milliseconds < 600000){
                DisplayTime.setXmlParam("text", "0"+currentpos);
            }   
            else{
                DisplayTime.setXmlParam("text", currentpos);
            }
            timerSongTimer.start();         
		}
    else if (getStatus() == 0)
		{
            DisplayTime.setXmlParam("text", " :  ");
		}
	else if (getStatus() == 1)
		{
            if(milliseconds < 600000){
                DisplayTime.setXmlParam("text", "0"+currentpos);
            }   
            else{
                DisplayTime.setXmlParam("text", currentpos);
            }
            timerSongTimer.start();    
		}
}
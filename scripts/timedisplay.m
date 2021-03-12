//please, steal this, i beg you
//provides you with an actual MM:SS time display
//one that nullsoft removed for some unknown reason
//either during or on release of winamp3 and they
//never bothered to fix this, so i did

//THIS THING IS HIDEOUS
//there's probably ways of improving it
//but it works for now and that's all that matters

#include "lib/std.mi"

Global Container containerMain;
Global Group MainGroup, DisplayGroup;
Global GuiObject DisplayTime;
Global Layout layoutMainNormal;
Global Timer timerSongTimer;
Global Timer timerSongTimerReverse;
Global int timermode;

Function AreWePlaying();
Function InReverse();
Function TimeElapsedOrRemaining();
Function setTimer(int mode);
Function StaticTime();
Function StaticTimeRemainder();

System.onScriptLoaded() 
{
    containerMain = System.getContainer("main");
    layoutMainNormal = containerMain.getLayout("normal");
	MainGroup = layoutMainNormal.getObject("player.normal.group.main");
	DisplayGroup = MainGroup.getObject("player.normal.group.display");
    DisplayTime = DisplayGroup.getObject("display.time");

  	timerSongTimer = new Timer;
	timerSongTimer.setDelay(50);
    timerSongTimerReverse = new Timer;
    timerSongTimerReverse.setDelay(50);

    TimeElapsedOrRemaining();
}

TimeElapsedOrRemaining()
{
    timermode = getPrivateInt(getSkinName(), "TimerElapsedRemaining", 0);
    setTimer(timermode);
}

DisplayTime.onLeftButtonDown(int x, int y)
{
    timermode++;

    if (timermode == 2)
    {
        timermode = 0;
    }
    setTimer(timermode);
    complete;
}

System.onPlay(){
    int songlength = System.getPlayItemLength();

    TimeElapsedOrRemaining();
    if (timermode == 1){
        if(songlength == 0){
            StaticTime();
            timerSongTimerReverse.stop();
            timerSongTimer.start();
        }
        else{
            StaticTimeRemainder();
            timerSongTimer.stop();
            timerSongTimerReverse.start();
        }
    }
}

System.onPause(){
    int songlength = System.getPlayItemLength();

    TimeElapsedOrRemaining();
    if (timermode == 1){
        if(songlength == 0){
            StaticTime();
            timerSongTimerReverse.stop();
            timerSongTimer.start();
        }
        else{
            StaticTimeRemainder();
            timerSongTimer.stop();
            timerSongTimerReverse.start();
        }
    }
}

System.onResume(){
    int songlength = System.getPlayItemLength();

    TimeElapsedOrRemaining();
    if (timermode == 1){
        if(songlength == 0){
            StaticTime();
            timerSongTimerReverse.stop();
            timerSongTimer.start();
        }
        else{
            StaticTimeRemainder();
            timerSongTimer.stop();
            timerSongTimerReverse.start();
        }
    }
}

System.onInfoChange(String info){
    int songlength = System.getPlayItemLength();

    TimeElapsedOrRemaining();
    if (timermode == 1){
        if(songlength == 0){
            StaticTime();
            timerSongTimerReverse.stop();
            timerSongTimer.start();
        }
        else{
            StaticTimeRemainder();
            timerSongTimer.stop();
            timerSongTimerReverse.start();
        }
    }
}

System.onStop(){
    TimeElapsedOrRemaining();
    timerSongTimer.stop();
    timerSongTimerReverse.stop();
    DisplayTime.setXmlParam("text", " :  ");
}

StaticTime(){ //Needed since the timer has a delay of 50 and we dont want any odd flashing on loading
    int milliseconds = System.getPosition();
    String currentpos = System.integerToTime(milliseconds);

    if(milliseconds < 600000){
        DisplayTime.setXmlParam("text", "0"+currentpos);
    }
    else
    {
        DisplayTime.setXmlParam("text", currentpos);
    }
}

StaticTimeRemainder(){ //Needed since the timer has a delay of 50 and we dont want any odd flashing on loading
    int milliseconds = System.getPosition();
    int songlength = System.getPlayItemLength();
    int remainder = songlength - milliseconds;
    String strremainder = System.integerToTime(remainder);

    if(remainder < 600000)
    {
        DisplayTime.setXmlParam("text", "-0"+strremainder);
    }
    else
    {
        DisplayTime.setXmlParam("text", "-"+strremainder);
    }
}

timerSongTimer.onTimer() {
    int milliseconds = System.getPosition();
    String currentpos = System.integerToTime(milliseconds);

    if(milliseconds < 600000)
    {
        DisplayTime.setXmlParam("text", "0"+currentpos);
    }
    else
    {
        DisplayTime.setXmlParam("text", currentpos);
    }
}

timerSongTimerReverse.onTimer() {
    int milliseconds = System.getPosition();
    int songlength = System.getPlayItemLength();
    int remainder = songlength - milliseconds;
    String strremainder = System.integerToTime(remainder);

    if(remainder < 600000)
    {
        DisplayTime.setXmlParam("text", "-0"+strremainder);
    }
    else
    {
        DisplayTime.setXmlParam("text", "-"+strremainder);
    }
}

AreWePlaying() {
    if (getStatus() == -1) //Paused
		{
            timerSongTimerReverse.stop();
            StaticTime();
            timerSongTimer.start();         
		}
    else if (getStatus() == 0) //Stopped
		{
            timerSongTimerReverse.stop();
            timerSongTimer.stop();
            DisplayTime.setXmlParam("text", " :  ");
		}
	else if (getStatus() == 1) //Playing
		{
            timerSongTimerReverse.stop();
            StaticTime();
            timerSongTimer.start();   
	    }
}

InReverse(){
    int songlength = System.getPlayItemLength();

    if (getStatus() == -1) //Paused
        {
            timerSongTimer.stop();
            StaticTimeRemainder();
            timerSongTimerReverse.start();         
		}
    else if (getStatus() == 0) //Stopped
		{
            timerSongTimer.stop();
            timerSongTimerReverse.stop();
            DisplayTime.setXmlParam("text", " :  ");
		}
	else if (getStatus() == 1) //Playing
		{
            timerSongTimer.stop();
            StaticTimeRemainder();
            timerSongTimerReverse.start();   
	    }
    if(songlength == 0){
        StaticTime();
        timerSongTimerReverse.stop();
        timerSongTimer.start();
    }
    else{
        StaticTimeRemainder();
        timerSongTimer.stop();
        timerSongTimerReverse.start();
    }
}

setTimer (int mode){
    if(System.getPlayItemLength() > 0){
	    setPrivateInt(getSkinName(), "TimerElapsedRemaining", mode);
	    if (mode == 0)
	    {
            AreWePlaying();
	    }
	    else if (mode == 1)
	    {
            InReverse();
	    }
	    timermode = mode;
    }else{
        setPrivateInt(getSkinName(), "TimerElapsedRemaining", 0);
        AreWePlaying();
        timermode = 0;
    }
}
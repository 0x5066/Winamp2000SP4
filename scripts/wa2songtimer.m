//please, steal this, i beg you
//provides you with an actual MM:SS time display
//one that nullsoft removed for some unknown reason
//either during or on release of winamp3 and they
//never bothered to fix this, so i did

//THIS THING IS HIDEOUS but beautiful
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

//Here we run these checks every time a playback related action happens
//It's not enough to check on title change
System.onPlay(){
    int songlength = System.getPlayItemLength();

    TimeElapsedOrRemaining();
    if (timermode == 1){
        if(songlength == 0 || songlength == -1){
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
        if(songlength == 0 || songlength == -1){
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
        if(songlength == 0 || songlength == -1){
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
        if(songlength == 0 || songlength == -1){
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

//We stop every timer and instead display Winamp Modern's default of "00:00"
System.onStop(){
    TimeElapsedOrRemaining();
    timerSongTimer.stop();
    timerSongTimerReverse.stop();
    DisplayTime.setXmlParam("text", "  :  ");
}

StaticTime(){ //Needed since the timer has a delay of 50 and we don't want any odd flashing on loading
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

StaticTimeRemainder(){ //Needed since the timer has a delay of 50 and we don't want any odd flashing on loading
    int milliseconds = System.getPosition();
    int songlength = System.getPlayItemLength();
    int remainder = songlength - milliseconds;
    int milliseconds_rev = milliseconds-songlength;
    String strremainder = System.integerToTime(remainder);
    String currentpos_rev = System.integerToTime(milliseconds-songlength);

//The purpose of this check is to ensure we properly place
//a "0" if we happen to be below 600000ms, or 10 minutes
//If we are above 600000ms or 10 minutes, don't append a "0"
    if(remainder < 600000)
    {
        DisplayTime.setXmlParam("text", "-0"+strremainder);
    }
    else
    {
        DisplayTime.setXmlParam("text", "-"+strremainder);
    }
//In case of plugins providing a way to play outside the song's original length
//and the user just so happened to have time remaining enabled, we want to
//ensure they still get the proper time position displayed, even if it's irrelevant.
//Winamp 2/Winamp Classic do this.
    if(milliseconds > songlength)
    {
        if(milliseconds_rev < 600000){
            DisplayTime.setXmlParam("text", "-0"+currentpos_rev);
        }
        else
        {
        DisplayTime.setXmlParam("text", "-"+currentpos_rev);
        }
    }
}

timerSongTimer.onTimer() {
    int milliseconds = System.getPosition();
    String currentpos = System.integerToTime(milliseconds);

//The purpose of this check is to ensure we properly place
//a "0" if we happen to be below 600000ms, or 10 minutes
//If we are above 600000ms or 10 minutes, don't append a "0"
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
    int milliseconds_rev = milliseconds-songlength;
    String strremainder = System.integerToTime(remainder);
    String currentpos_rev = System.integerToTime(milliseconds-songlength);

//The purpose of this check is to ensure we properly place
//a "0" if we happen to be below 600000ms, or 10 minutes
//If we are above 600000ms or 10 minutes, don't append a "0"
    if(remainder < 600000)
    {
        DisplayTime.setXmlParam("text", "-0"+strremainder);
    }
    else
    {
        DisplayTime.setXmlParam("text", "-"+strremainder);
    }
//The purpose of this check is to ensure we properly place
//a "0" if we happen to be below 600000ms, or 10 minutes
//If we are above 600000ms or 10 minutes, don't append a "0"
    if(milliseconds > songlength)
    {
        if(milliseconds_rev < 600000){
            DisplayTime.setXmlParam("text", "-0"+currentpos_rev);
        }
        else
        {
        DisplayTime.setXmlParam("text", "-"+currentpos_rev);
        }
    }
}

AreWePlaying() {
//Just some sanity checks to ensure we're in the right modes
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
            DisplayTime.setXmlParam("text", "  :  ");
		}
	else if (getStatus() == 1) //Playing
		{
            timerSongTimerReverse.stop();
            StaticTime();
            timerSongTimer.start();   
	    }
}

InReverse(){
//Just some sanity checks to ensure we're in the right modes
    int songlength = System.getPlayItemLength();

//In case of streams of VGM formats of endless playback
//We don't want the user to still be able to toggle
//between time remaining or elapsed, so we force
//the elapsed mode to run
    if(songlength == 0 || songlength == -1){
        StaticTime();
        timerSongTimerReverse.stop();
        timerSongTimer.start();
    }
    else{
        StaticTimeRemainder();
        timerSongTimer.stop();
        timerSongTimerReverse.start();
    }
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
}

setTimer (int mode){
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
}
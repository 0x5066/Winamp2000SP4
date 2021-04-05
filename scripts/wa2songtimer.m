//please, steal this, i beg you
//provides you with an actual MM:SS time display
//one that nullsoft removed for some unknown reason
//either during beta testing or on release of winamp3 
//and they never bothered to fix this, so i did

//THIS THING IS HIDEOUS but beautiful
//there's probably ways of improving it
//but it works for now and that's all that matters

#include "lib/std.mi"

//Global String digits;
Global String currentpos, strremainder, currentpos_rev;
Global GuiObject DisplayTime, DisplayTimeShade;
Global Timer timerSongTimer;
Global Timer timerSongTimerReverse;
//Global int ZZorNot;
Global int milliseconds;
Global int songlength;
Global int remainder;
Global int milliseconds_rev;

Global PopUpMenu clockMenu;

Function AreWePlaying();
Function InReverse();
Function TimeElapsedOrRemaining();
Function setTimer(int timermode);
//Function setDigits(int mode2);
Function StaticTime();
Function StaticTimeRemainder();
Function endless();
Function notendless();
Function stopped();
Function initplaytimer();
Function playing();
Function playing_rev();
Function ItsBeenMuchTooLong();
//Function YesZZ();
//Function NoZZ();

System.onScriptLoaded() 
{
    Group mainshade = getContainer("Main").getLayout("Shade");
    /* Replace "timer" with "shade.time" for Winamp Classic Modern */
    DisplayTimeShade = mainshade.findObject("shade.time");

    Group mainnormal = getContainer("Main").getLayout("Normal");
    /* Replace "timer" with "display.time" for Winamp Classic Modern */
    DisplayTime = mainnormal.findObject("display.time");
    //The above was taken from Ariszló's updated oldtimer.maki script
    //Allows it to be included in the skin.xml file of the skin

    //ints for playback
    milliseconds = System.getPosition();
    songlength = System.getPlayItemLength();
    remainder = songlength - milliseconds;
    milliseconds_rev = milliseconds-songlength;

    //strings for playback
    currentpos = System.integerToTime(milliseconds);
    strremainder = System.integerToTime(remainder);
    currentpos_rev = System.integerToTime(milliseconds-songlength);

  	timerSongTimer = new Timer;
	timerSongTimer.setDelay(50);
    timerSongTimerReverse = new Timer;
    timerSongTimerReverse.setDelay(50);

    setTimer(getPrivateInt(getSkinName(), "TimerElapsedRemaining", 1));
    TimeElapsedOrRemaining();
}

TimeElapsedOrRemaining()
{
    int timermode = getPrivateInt(getSkinName(), "TimerElapsedRemaining", 1);
    setTimer(timermode);
}

DisplayTime.onRightButtonUp (int x, int y){
    int timermode = getPrivateInt(getSkinName(), "TimerElapsedRemaining", 1);

  	clockMenu = new PopUpMenu;

  	//clockMenu.addCommand("Presets:", 0, 0, 1);
  	  
	clockMenu.addcommand("Time elapsed", 1, timermode == 1,0);
	clockMenu.addcommand("Time remaining", 2, timermode == 2,0);
	//clockMenu.addSeparator();
    //clockMenu.addcommand("No 00", 2, timermode == 2,0);
	//clockMenu.addcommand("Yes 00", 3, timermode == 3,0);
  	
	timermode = clockMenu.popAtMouse();
    //int result2 = clockMenu.popAtMouse();
 
	setTimer(timermode);
    //setDigits(result2);
	
	complete;
}

DisplayTimeShade.onRightButtonUp (int x, int y){
    int timermode = getPrivateInt(getSkinName(), "TimerElapsedRemaining", 1);

  	clockMenu = new PopUpMenu;

  	//clockMenu.addCommand("Presets:", 0, 0, 1);
  	  
	clockMenu.addcommand("Time elapsed", 1, timermode == 1,0);
	clockMenu.addcommand("Time remaining", 2, timermode == 2,0);
	//clockMenu.addSeparator();
    //clockMenu.addcommand("No 00", 2, timermode == 2,0);
	//clockMenu.addcommand("Yes 00", 3, timermode == 3,0);
  	
	timermode = clockMenu.popAtMouse();
    //int result2 = clockMenu.popAtMouse();
 
	setTimer(timermode);
    //setDigits(result2);
	
	complete;
}

DisplayTime.onLeftButtonDown(int x, int y)
{
    int timermode = getPrivateInt(getSkinName(), "TimerElapsedRemaining", 1);

    timermode++;

    if (timermode == 3){
        timermode = 1;
    }
    setTimer(timermode);
    complete;
}

DisplayTimeShade.onLeftButtonDown(int x, int y)
{
    int timermode = getPrivateInt(getSkinName(), "TimerElapsedRemaining", 1);

    timermode++;

    if (timermode == 3){
        timermode = 1;
    }
    setTimer(timermode);
    complete;
}

//Here we run these checks every time a playback related action happens
//It's not enough to check on title change
System.onPlay(){
    int timermode = getPrivateInt(getSkinName(), "TimerElapsedRemaining", 1);

    TimeElapsedOrRemaining();
    if (timermode == 2){
        if(songlength <= 0){
            endless();
//We do this to check if what we're currently playing is a stream/endless VGM track
//as trying to display the time remaining is pointless and only adds a "-", so we
//force to start the timer for the "Time Elapsed" mode if that is the case
        }
        else{
            notendless();
//otherwise, display the time remaining
        }
    }
}

System.onPause(){
    int timermode = getPrivateInt(getSkinName(), "TimerElapsedRemaining", 1);

    TimeElapsedOrRemaining();
    if (timermode == 2){
        if(songlength <= 0){
            endless();
        }
        else{
            notendless();
        }
    }
}

System.onResume(){
    int timermode = getPrivateInt(getSkinName(), "TimerElapsedRemaining", 1);

    TimeElapsedOrRemaining();
    if (timermode == 2){
        if(songlength <= 0){
            endless();
        }
        else{
            notendless();
        }
    }
}

System.onInfoChange(String info){
    int timermode = getPrivateInt(getSkinName(), "TimerElapsedRemaining", 1);

    TimeElapsedOrRemaining();
    if (timermode == 2){
        if(songlength <= 0){
            endless();
        }
        else{
            notendless();
        }
    }
}

//We stop every timer and instead display Winamp Modern's default of "00:00"
//In this case it's "  :  "
System.onStop(){
    TimeElapsedOrRemaining();
    stopped();
}

StaticTime(){ //Needed since the timer has a delay of 50ms and we don't want any odd flashing on loading

    playing();
}

StaticTimeRemainder(){ //Needed since the timer has a delay of 50ms and we don't want any odd flashing on loading
    milliseconds = System.getPosition();
    songlength = System.getPlayItemLength();

//The purpose of this check is to ensure we properly place
//a "0" if we happen to be below 600000ms, or 10 minutes
//If we are above 600000ms or 10 minutes, don't append a "0"
    playing_rev();
//In case of plugins providing a way to play outside the song's original length
//and the user just so happened to have time remaining enabled, we want to
//ensure they still get the proper time position displayed, even if it's irrelevant.
//Winamp 2/Winamp Classic do this.
    if(milliseconds > songlength){
        ItsBeenMuchTooLong();
    }
}

timerSongTimer.onTimer(){
    currentpos = System.integerToTime(milliseconds);

//The purpose of this check is to ensure we properly place
//a "0" if we happen to be below 600000ms, or 10 minutes
//If we are above 600000ms or 10 minutes, don't append a "0"
    playing();
}

timerSongTimerReverse.onTimer(){
    milliseconds = System.getPosition();
    songlength = System.getPlayItemLength();

//The purpose of this check is to ensure we properly place
//a "0" if we happen to be below 600000ms, or 10 minutes
//If we are above 600000ms or 10 minutes, don't append a "0"
    playing_rev();
//The purpose of this check is to ensure we properly place
//a "0" if we happen to be below 600000ms, or 10 minutes
//If we are above 600000ms or 10 minutes, don't append a "0"
    if(milliseconds > songlength){
        ItsBeenMuchTooLong();
    }
}

AreWePlaying() {
//Just some sanity checks to ensure we're in the right modes
    if (getStatus() == -1){ //Paused
        initplaytimer();
	}
    else if (getStatus() == 0){ //Stopped
        stopped();
	}
	else if (getStatus() == 1){ //Playing
        initplaytimer();  
	}
}

InReverse(){
//Just some sanity checks to ensure we're in the right modes
    songlength = System.getPlayItemLength();
//In case of streams or VGM formats with endless playback
//We don't want the user to still be able to toggle
//between time remaining or elapsed, so we force
//the elapsed mode to run
//This has now been actually fixed
    if(songlength <= 0){
        if (getStatus() == -1){ //Paused
            endless();
	    }
    else if (getStatus() == 0){ //Stopped
            stopped();
	    }
	    else if (getStatus() == 1){ //Playing
            endless(); 
	    }
    }
    else{
        if (getStatus() == -1){ //Paused
            notendless();    
		}
    else if (getStatus() == 0){ //Stopped
            stopped();
		}
	else if (getStatus() == 1){ //Playing
            notendless();  
	    }
    }
}

/*
YesZZ(){
    digits = "00:00";
}

NoZZ(){
    digits = "  :  ";
}
*/

setTimer(int timermode){
    if(timermode>=1 && timermode<=2){ //i fucking hate building menus
	    if (timermode == 1){
            AreWePlaying();
	    }
	    else if (timermode == 2){
            InReverse();
        }
    /*
    else if (mode == 2)
	{
        NoZZ();
	}
	else if (mode == 3)
	{
        YesZZ();
	}
    */
	    setPrivateInt(getSkinName(), "TimerElapsedRemaining", timermode);
    }
}

/*
setDigits (int mode2){
	setPrivateInt(getSkinName(), "00 or not", mode2);
	if (mode2 == 0)
	{
        NoZZ();
	}
	else if (mode2 == 1)
	{
        YesZZ();
	}
	ZZorNot = mode2;
}
*/

endless(){
    StaticTime();
    timerSongTimerReverse.stop();
    timerSongTimer.start();
}

notendless(){
    StaticTimeRemainder();
    timerSongTimer.stop();
    timerSongTimerReverse.start();
}

stopped(){
    timerSongTimer.stop();
    timerSongTimerReverse.stop();
    //DisplayTime.setXmlParam("text", digits);
    //DisplayTimeShade.setXmlParam("text", digits);
    DisplayTime.setXmlParam("text", "  :  ");
    DisplayTimeShade.setXmlParam("text", "  :  ");
}

playing(){
    milliseconds = System.getPosition();
    currentpos = System.integerToTime(milliseconds);

    if(milliseconds < 600000){
        DisplayTime.setXmlParam("text", "0"+currentpos);
        DisplayTimeShade.setXmlParam("text", "0"+currentpos);
    }
    else{
        DisplayTime.setXmlParam("text", currentpos);
        DisplayTimeShade.setXmlParam("text", currentpos);
    }
}

playing_rev(){
    milliseconds = System.getPosition();
    songlength = System.getPlayItemLength();
    remainder = songlength - milliseconds;
    milliseconds_rev = milliseconds-songlength;
    strremainder = System.integerToTime(remainder);
    currentpos_rev = System.integerToTime(milliseconds-songlength);

    if(remainder < 600000){
        DisplayTime.setXmlParam("text", "-0"+strremainder);
        DisplayTimeShade.setXmlParam("text", "-0"+strremainder);
    }
    else{
        DisplayTime.setXmlParam("text", "-"+strremainder);
        DisplayTimeShade.setXmlParam("text", "-"+strremainder);
    }
}

ItsBeenMuchTooLong(){ //I feel it coming on, the feeling's gettin' strong
    milliseconds = System.getPosition();
    songlength = System.getPlayItemLength();
    milliseconds_rev = milliseconds-songlength;

    if(milliseconds_rev < 600000){
        DisplayTime.setXmlParam("text", "-0"+currentpos_rev);
        DisplayTimeShade.setXmlParam("text", "-0"+currentpos_rev);
    }
    else{
        DisplayTime.setXmlParam("text", "-"+currentpos_rev);
        DisplayTimeShade.setXmlParam("text", "-"+currentpos_rev);
    }
}

initplaytimer(){
    timerSongTimerReverse.stop();
    StaticTime();
    timerSongTimer.start();   
}
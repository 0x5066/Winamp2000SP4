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
Global Text DisplayTime, DisplayTimeShade;
Global Timer timerSongTimer;
Global Timer timerSongTimerReverse;
Global Timer PauseBlinkPaused, PauseBlink, Clock;
//Global int ZZorNot;
Global int timermode;
Global int milliseconds;
Global int songlength;
Global int remainder;
Global int milliseconds_rev;
Global int i;
Global float TimeBPM;
Global float JoggingBPM;

Global PopUpMenu clockMenu;

Function AreWePlaying();
Function InReverse();
Function TimeElapsedOrRemaining();
Function setTimer(int timermode);
//Function setDigits(int mode2);
Function StaticTime();
Function StaticTimeRemainder();
Function endless();
Function endlesspaused();
Function notendless();
Function notendlesspaused();
Function notendlesspaused_rev();
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
	timerSongTimer.setDelay(0);
    timerSongTimer.start();
    timerSongTimerReverse = new Timer;
    timerSongTimerReverse.setDelay(50);
    PauseBlink = new Timer;
    PauseBlink.setDelay(50);
    PauseBlinkPaused = new Timer;
    PauseBlinkPaused.setDelay(50);
    Clock = new Timer;
    Clock.setDelay(1000);
    Clock.start();

    JoggingBPM = 133.33333333333333333333333333333;
}

timerSongTimer.onTimer(){
    TimeBPM = System.getPosition(); //60bpm
    float jogging_naked = (TimeBPM*3.1319166666666666666666666666667/125);
    DisplayTime.setText(integerToString(jogging_naked/32)+":"+integerToString((jogging_naked/2%16))+":"+integerToString(jogging_naked/0.5%24));
}
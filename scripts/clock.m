//-----------------------------------------------------------------------------
// clock.m
//
// Example of a Clock Script
// Displays the current time in the Timer when not playing.
//
// created by FrisbeeMonkey
//-----------------------------------------------------------------------------

//                         USING THIS SCRIPT:
//*****************************************************************************
//  1.  Define a Timer in your XML, something like:
//        <!-- Timer -->
//        <Text
//          id="Timer"
//          display="time"
//          x="194" y="10"
//          w="70" h="18"
//          font="player.timernum"
//          align="right"
//          shadowcolor="0,0,0"
//          shadowx="0" shadowy="1"
//          timecolonwidth="7"
//        />
//  2.  Make sure its id is "Timer".
//  3.  Copy this script (and clock.maki) to your scripts folder.
//  4.  If you don't have clock.maki, compile this script.
//  5.  Add this line to the group that contains your Timer:
//        <script id="clock" file="scripts/clock.maki"/>
//  6.  Refresh your skin(F5) and try it out.
//*****************************************************************************

// never forget to include std.mi
#include "../../../lib/std.mi"

//declares global variables for use in script
Global Text TimerTxt;
Global Timer ClockTmr;
Global Group cGroup;
Global Boolean showTime;
Global Int currentTime;

//when the script is loaded, do this
System.onScriptLoaded() {
	//gets the group that has the objects we want
	cGroup = getScriptGroup();

	//gets the id tag of the object we want
	TimerTxt = cGroup.findObject("Timer");

	// Initialize our timer
	ClockTmr = new Timer;
	ClockTmr.setDelay(100);

    //determines whether Winamp is playing or stopped
	showTime = (getplayitemstring() == "");

	//if stopped, then show the current time
	if (showTime) {
		ClockTmr.start();
	}
}

//if updates the current time every 100 ms.
ClockTmr.onTimer() {
	if (showTime) {
		currentTime = System.getTimeOfDay();
		//keeps time on a 12 not 24 hr basis
		if ( currentTime > 43200000 ) {
			currentTime = currentTime - 43200000;
		}
		//converts time to HH:MM:SS
		string TimeStr = integerToLongTime(currentTime);
		//chops off :SS leaving us with HH:MM
		TimeStr = strleft(TimeStr, strlen(TimeStr)-3);
		//displays current time in Timer
		TimerTxt.setText(TimeStr);
	}
}

//if stopped, start timer, show time
System.onStop() {
	showTime = 1;
	ClockTmr.start();
}

//if playing, stop timer, clear text
System.onPlay() {
	showTime = 0;
	ClockTmr.stop();
	TimerTxt.setText("");
}

//deletes the Timer when the script is unloaded
System.onScriptLoaded() {
  delete ClockTmr;

}

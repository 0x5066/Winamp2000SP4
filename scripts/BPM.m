#include "lib/std.mi"

Global group doomguy;
Global GuiObject statusface;
Global AnimatedLayer satsukianim, newcat;
Global Timer randomint;
Global Timer visint;
Global int rand;
Global int intvis;
Global float TimeBPM;
Global float headbang;
Global text debug1, debug2;

Function doomgrin();
Function IDDQD();
Function doomglare();
Function doomattacked();
Function doomshock();

System.onScriptLoaded(){

    doomguy = getScriptGroup();
    statusface = doomguy.getObject("st");
    satsukianim = doomguy.getObject("satsuki");
    newcat = doomguy.getObject("newcat");
    debug1 = doomguy.getObject("intvisdebug");
    debug2 = doomguy.getObject("randdebug");

    randomint = new Timer;
    randomint.setDelay(0);
    randomint.start();
}

randomint.onTimer(){
    headbang = 133.33333333333333333333333333333;
    TimeBPM = System.getPosition(); //60bpm
    float BPM_proper = System.Stringtointeger(System.getPlayItemMetaDataString("bpm"))/60;
    float highscore = TimeBPM*1.8334/headbang; //110bpm, highscore's BPM
    float highscorerestart = highscore%8; //resets the frame counter after surpassing 8, works best with animatedlayers that have "start="0" end="7"" atm

    float jogging_naked = (TimeBPM*3.1316167/headbang);
    float jogging_nakedrestart = jogging_naked%8;
    float jogging_nakedrestart2 = jogging_naked*2%16;

    float bpm2 = (TimeBPM*BPM_proper/headbang);
    float BPM_restart = BPM2%8;
    float BPM_restart2 = BPM2*2%16;

    if(bpm2 == 0){
        satsukianim.gotoFrame(jogging_nakedrestart);
        newcat.gotoFrame(jogging_nakedrestart2);
        debug1.setXmlParam("text", System.FloatToString(jogging_naked, 5));
        debug2.setXmlParam("text", System.FloatToString(jogging_nakedrestart, 5));
    }
    else{
        satsukianim.gotoFrame(BPM_restart);
        newcat.gotoFrame(BPM_restart2);
        debug1.setXmlParam("text", System.FloatToString(BPM_proper, 5));
        debug2.setXmlParam("text", System.FloatToString(BPM_restart, 5));
    }

    if(jogging_naked > 0 && (jogging_naked % 2) == 0){
        doomgrin();
    }
    else{
        doomglare();
    }

}

doomgrin(){
    statusface.setXmlParam("image", "stface3");
}

IDDQD(){
    statusface.setXmlParam("image", "stface4");
}

doomglare(){
    statusface.setXmlParam("image", "stface1");
}

doomshock(){
    statusface.setXmlParam("image", "stface5");
}

doomattacked(){
    statusface.setXmlParam("image", "stface6");
}
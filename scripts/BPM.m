#include "lib/std.mi"

Global group doomguy;
Global GuiObject statusface;
Global AnimatedLayer newcat;
Global Timer randomint;
Global Timer visint;
Global int rand;
Global int intvis;
Global float TimeBPM;
Global float headbang;
Global float ProperHZ;
Global float forty3hz;
Global float twenty5hz;
Global float twenty9hz;
Global float thirty4hz;
Global float fifty1hz;
Global text debug1, debug2, debug3, debug4;

Function doomgrin();
Function IDDQD();
Function doomglare();
Function doomattacked();
Function doomshock();
Function four3hz();
Function two5hz();
Function two9hz();
Function three4hz();
Function five1hz();

System.onScriptLoaded(){

    doomguy = getScriptGroup();
    statusface = doomguy.getObject("st");
    newcat = doomguy.getObject("newcat");
    debug1 = doomguy.getObject("intvisdebug");
    debug2 = doomguy.getObject("randdebug");
    debug3 = doomguy.getObject("bpmdebug");
    debug4 = doomguy.getObject("bpmdebug2");

    randomint = new Timer;
    randomint.setDelay(0);
    randomint.start();

    visint = new Timer;
    visint.setDelay(0);
    visint.start();
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
    float jogging_nakedrestartrat = (jogging_naked*8%16);

    float bpm2 = (TimeBPM*BPM_proper/headbang);
    float BPM_restart = BPM2%8;
    float BPM_restart2 = BPM2*2%16;

    debug1.setXmlParam("text", System.getPlayItemMetaDataString("bpm"));

    if(bpm2 == 0){
        newcat.gotoFrame(jogging_nakedrestartrat);
        //debug1.setXmlParam("text", System.FloatToString(jogging_naked, 5));
        debug2.setXmlParam("text", System.FloatToString(jogging_nakedrestartrat, 5));
    }
    else{
        newcat.gotoFrame(BPM_restart2);
        //debug1.setXmlParam("text", System.FloatToString(BPM_proper, 5));
        debug2.setXmlParam("text", System.FloatToString(BPM_restart, 5));
    }

    /* if(jogging_naked > 0 && (jogging_naked % 2) == 0){
        doomgrin();
    }
    else{
        doomglare();
    } */

}

/* visint.onTimer(){

    float jogging_naked_slow = (TimeBPM*3.1316167)/400;

    ProperHZ = System.getPosition(); //60hz
    forty3hz = (ProperHZ/1.3953488372093023255813953488372)/4%2; //43hz
    twenty5hz = (ProperHZ/2.5)%2; //25hz
    twenty9hz = (ProperHZ/2.0689655172413793103448275862069)/4%2; //29hz
    thirty4hz = (ProperHZ/1.7647058823529411764705882352941)/4%2; //34hz
    fifty1hz = (ProperHZ/1.1764705882352941176470588235294)/4%2; //51hz

    debug4.setXmlParam("text", System.FloatToString(jogging_naked_slow, 4));

    if(jogging_naked_slow < 20){
        four3hz();
        debug3.setXmlParam("text", "43hz "+System.FloatToString(forty3hz, 4));
    }
    else if(jogging_naked_slow < 40){
        two5hz();
        debug3.setXmlParam("text", "25hz "+System.FloatToString(twenty5hz, 4));
    }
    else if(jogging_naked_slow < 60){
        two9hz();
        debug3.setXmlParam("text", "29hz "+System.FloatToString(twenty9hz, 4));
    }
    else if(jogging_naked_slow < 75){
        three4hz();
        debug3.setXmlParam("text", "34hz "+System.FloatToString(thirty4hz, 4));
    }
    else if(jogging_naked_slow < 80){
        five1hz();
        debug3.setXmlParam("text", "51hz "+System.FloatToString(fifty1hz, 4));
    }

}

four3hz(){
    if(forty3hz == 1){
        doomgrin();
    }
    else{
        doomglare();
    }
}

two5hz(){
    if(twenty5hz == 1){
        doomshock();
    }
    else{
        doomglare();
    }
}

two9hz(){
    if(twenty9hz == 1){
        doomattacked();
    }
    else{
        doomglare();
    }
}

three4hz(){
    if(forty3hz == 1){
        doomgrin();
    }
    else{
        doomglare();
    }
}

five1hz(){
    if(forty3hz == 1){
        IDDQD();
    }
    else{
        doomglare();
    }
} */

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
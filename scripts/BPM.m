#include "lib/std.mi"

Global group doomguy;
Global GuiObject statusface;
Global AnimatedLayer satsukianim;
Global Timer randomint;
Global Timer visint;
Global int rand;
Global int intvis;
Global int BPM;
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
    debug1 = doomguy.getObject("intvisdebug");
    debug2 = doomguy.getObject("randdebug");

    randomint = new Timer;
    randomint.setDelay(0);
    randomint.start();
}

randomint.onTimer(){
    bpm = System.getPosition(); //60bpm
    int highway = bpm*1.834/125; //110,04bpm
    int highwayrestart = highway%8; //resets the frame counter after surpassing 8, works best with animatedlayers that have "start="0" end="7"" atm
    debug1.setXmlParam("text", System.integerToString(highway));
    debug2.setXmlParam("text", System.integerToString(highwayrestart));

    satsukianim.gotoFrame(highwayrestart);

    if(highway > 0 && (highway % 2) == 0){
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
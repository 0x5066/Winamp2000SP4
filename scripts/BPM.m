#include "lib/std.mi"

Global group doomguy;
Global GuiObject statusface;
Global AnimatedLayer satsukianim, newcat;
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
    newcat = doomguy.getObject("newcat");
    debug1 = doomguy.getObject("intvisdebug");
    debug2 = doomguy.getObject("randdebug");

    randomint = new Timer;
    randomint.setDelay(0);
    randomint.start();
}

randomint.onTimer(){
    bpm = System.getPosition(); //60bpm
    int highscore = bpm*1.834/125; //110,04bpm, highscore's BPM is actually 110bpm or so but i cant get the exact number
    int highscorerestart = highscore%8; //resets the frame counter after surpassing 8, works best with animatedlayers that have "start="0" end="7"" atm

    int jogging_naked = bpm*3.12985/125;
    int jogging_nakedrestart = jogging_naked%8;
    int jogging_nakedrestart2 = jogging_naked*2%16;
    debug1.setXmlParam("text", System.integerToString(jogging_naked));
    debug2.setXmlParam("text", System.integerToString(jogging_nakedrestart));

    satsukianim.gotoFrame(jogging_nakedrestart);
    newcat.gotoFrame(jogging_nakedrestart2);

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
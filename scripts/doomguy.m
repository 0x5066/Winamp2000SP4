#include "lib/std.mi"

Global group doomguy;
Global GuiObject statusface;
Global Timer randomint;
Global Timer visint;
Global int rand;
Global int intvis;
Global text debug1, debug2;

Function doomgrin();
Function IDDQD();
Function doomglare();

System.onScriptLoaded(){

    doomguy = getScriptGroup();
    statusface = doomguy.getObject("st");
    debug1 = doomguy.getObject("intvisdebug");
    debug2 = doomguy.getObject("randdebug");

    randomint = new Timer;
    randomint.setDelay(0);
    randomint.start();

}

randomint.onTimer(){
    rand = System.getPosition();
    debug1.setXmlParam("text", "milliseconds: "+System.IntegerToString(rand));

    if(rand <= 0){
        doomgrin();
        debug2.setXmlParam("text", "if(rand == 0)");
    }
    else if(rand <= 160){
        doomglare();
        debug2.setXmlParam("text", "else if(rand == 160)");
    }
    else if(rand <= 330){
        IDDQD();
        debug2.setXmlParam("text", "else if(rand == 330)");
    }
    else{
        doomglare();
        debug2.setXmlParam("text", "else");
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
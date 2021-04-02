#include "lib/std.mi"

Global group doomguy;
Global layer statusface;
Global Timer randomint;
Global Timer visint;
Global int rand;
Global int intvis;
Global text debug1, debug2;

Function doomgrin();

System.onScriptLoaded(){

    doomguy = getScriptGroup();
    statusface = doomguy.getObject("st");
    debug1 = doomguy.getObject("intvisdebug");
    debug2 = doomguy.getObject("randdebug");

    randomint = new Timer;
    randomint.setDelay(500);
    randomint.start();

    visint = new Timer;
    visint.setDelay(0);
    visint.start();
}

randomint.onTimer(){
    rand = System.random(3);
    debug2.setXmlParam("text", System.integerToString(rand));
}
visint.onTimer(){
    intvis = System.getVisBand(0,0);
    debug1.setXmlParam("text", System.integerToString(intvis));

    if(intvis > 128){
    statusface.setXmlParam("image", "stface4");
    }
        else if(intvis >= 96){
        statusface.setXmlParam("image", "stface3");
        }
        else{
        statusface.setXmlParam("image", "stface"+System.integerToString(rand));
    }
}

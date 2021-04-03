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
Function doomattacked();
Function doomshock();

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
    rand = System.getPosition() / 4;
    debug1.setXmlParam("text", "milliseconds: "+System.IntegerToString(rand));

    //use with joging aaaa.wav

    if(rand < 0){
        doomattacked();
        debug2.setXmlParam("text", "if(rand < 0)");
    }
    else if(rand < 160){
        IDDQD();
        debug2.setXmlParam("text", "else if(rand < 160)");
    }
    else if(rand < 332){
        doomshock();
        debug2.setXmlParam("text", "else if(rand < 332)");
    }
    else if(rand < 380){
        doomattacked();
        debug2.setXmlParam("text", "else if(rand < 380)");
    }
    else if(rand < 571){
        doomglare();
        debug2.setXmlParam("text", "else if(rand < 571)");
    }
    else if(rand < 572){
        IDDQD();
        debug2.setXmlParam("text", "else if(rand < 572)");
    }
    else if(rand > 580){
        doomglare();
        debug2.setXmlParam("text", "else if(rand < 580)");
    }
    else if(rand < 652){
        IDDQD();
        debug2.setXmlParam("text", "else if(rand < 652)");
    }
    else if(rand > 659){
        doomglare();
        debug2.setXmlParam("text", "else if(rand < 659)");
    }
    else if(rand < 732){
        IDDQD();
        debug2.setXmlParam("text", "else if(rand < 732)");
    }
    else if(rand > 740){
        doomglare();
        debug2.setXmlParam("text", "else if(rand < 740)");
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

doomshock(){
    statusface.setXmlParam("image", "stface5");
}

doomattacked(){
    statusface.setXmlParam("image", "stface6");
}
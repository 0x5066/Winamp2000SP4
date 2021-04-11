//doesnt work
//compiler isnt clear about it

#include "lib/std.mi"

Global Button MLBTN;
Global GuiObject MLBTNTEXT;

System.onScriptLoaded(){
    Group mainnormal2 = getContainer("Main").getLayout("Normal");

    MLBTN = mainnormal2.findObject("MLList");
    MLBTNTEXT = mainnormal2.findObject("mlplbutton");

}

MLBTN.onActivate(int activated){
    if(activated){
        MLBTNTEXT.setXmlParam("x", "327", "y", "193");
    }
    else{
        MLBTNTEXT.setXmlParam("x", "325", "y", "191");
    }
}

#include "lib/std.mi"

Global Button infoToggle;
Global Container containerPL;
Global Layout layoutPLNormal;
Global Group bothGroup, pldirGroup, plContentGroup;

Global boolean state;

function showPlaylistInfo(boolean state);

System.onScriptLoaded() {
    containerPL = System.getContainer("PLEdit");
	layoutPLNormal = containerPL.getLayout("normalpl");

    bothGroup = layoutPLNormal.findObject("both");
    pldirGroup = bothGroup.findObject("pldir");
    plContentGroup = bothGroup.findObject("pledit.content.group");

    infoToggle = layoutPLNormal.findObject("pledit.button.showinfo");

    state = getPrivateInt(getSkinName(), "Show PL Info", 1);
    showPlaylistInfo(state);
}

System.onScriptUnloading() {
    setPrivateInt(getSkinName(), "Show PL Info", state);
}

infoToggle.onLeftButtonUp(int x, int y){
	// toggle playlist info
    state = !state;
    showPlaylistInfo(state);
}

showPlaylistInfo(boolean state){
    if(state){
        pldirGroup.setXmlParam("visible", "true");

        plContentGroup.setXmlParam("x", "200");
        plContentGroup.setXmlParam("w", "-200");
    }else{
        pldirGroup.setXmlParam("visible", "false");

        plContentGroup.setXmlParam("x", "0");
        plContentGroup.setXmlParam("w", "0");
    }
}
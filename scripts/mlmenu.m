#include "lib/std.mi"
#include "lib/attribs.m"

System.onScriptLoaded() {
  initAttribs();
  myattr_toggleMenus.onDataChanged();
}

myattr_toggleMenus.onDataChanged() {
  group content = getscriptgroup().findobject("ml.dummy.group");
  group menuBar = getscriptgroup().findobject("ml.menu.group");
  if (getData() == "1") {
    content.setXmlParam("y", "23");
    content.setXmlParam("h", "-23");
    menuBar.show();
  } else {
    content.setXmlParam("y", "0");
    content.setXmlParam("h", "0");
    menuBar.hide();
  }
}

System.onKeyDown(String key) {
  if (myattr_toggleMenus.getData() == "0") return;
  Layout l = getScriptGroup().getParentLayout();
  if (!l.isActive()) return;
  if (key == "alt+f") {
    getScriptGroup().findObject("mlFile.menu").sendAction("open", "", 0, 0, 0, 0);
    complete;
  }
  if (key == "alt+i") {
    getScriptGroup().findObject("mlView.menu").sendAction("open", "", 0, 0, 0, 0);
    complete;
  }
  if (key == "alt+h") {
    getScriptGroup().findObject("mlHelp.menu").sendAction("open", "", 0, 0, 0, 0);
    complete;
  }
}

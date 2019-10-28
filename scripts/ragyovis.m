#include <lib/std.mi>

Global Group frameGroup;
Global AnimatedLayer ragyoHair;
Global int totalFrames, lastBeat;
Global Timer beatTimer;

System.onScriptLoaded() {
  frameGroup = getScriptGroup();
  ragyoHair = frameGroup.findObject("ragyovis_hair.animatedlayer");
  totalFrames = ragyoHair.getLength() - 1;
  lastBeat = 0;

  beatTimer = new Timer;
  beatTimer.setDelay(17);
  beatTimer.start();
}

System.onScriptUnloading() {
  delete beatTimer;
}

beatTimer.onTimer() {
  double beatValue = (System.getLeftVuMeter() + System.getRightVuMeter()) / (2 * 255);
  int ragyoFrame = beatValue * (totalFrames + 1);

  if (ragyoFrame > totalFrames) ragyoFrame = totalFrames;
  if (ragyoFrame < lastBeat) ragyoFrame = lastBeat - 1;

  lastBeat = ragyoFrame;

  ragyoHair.gotoframe(ragyoFrame);
}

#include <lib/std.mi>

Global Group frameGroup;
Global AnimatedLayer ragyoHairL, ragyoHairR;
Global int totalFramesL, totalFramesR, lastBeatL, lastBeatR;
Global Timer beatTimer;

System.onScriptLoaded() {
  frameGroup = getScriptGroup();
  ragyoHairL = frameGroup.findObject("ragyovis_hair.animatedlayerL");
  ragyoHairR = frameGroup.findObject("ragyovis_hair.animatedlayerR");
  totalFramesL = ragyoHairL.getLength() - 1;
  totalFramesR = ragyoHairR.getLength() - 1;
  lastBeatL = 0;
  lastBeatR = 0;

  beatTimer = new Timer;
  beatTimer.setDelay(17);
  beatTimer.start();
}

System.onScriptUnloading() {
  delete beatTimer;
}

beatTimer.onTimer() {
  double beatValueL = System.getLeftVuMeter() / 255;
  double beatValueR = System.getRightVuMeter() / 255;

  int ragyoFrameL = beatValueL * (totalFramesL + 1);
  int ragyoFrameR = beatValueR * (totalFramesR + 1);

  if (ragyoFrameL > totalFramesL) ragyoFrameL = totalFramesL;
  if (ragyoFrameL < lastBeatL) ragyoFrameL = (ragyoFrameL + lastBeatL) / 3;


  if (ragyoFrameR > totalFramesR) ragyoFrameR = totalFramesR;
  if (ragyoFrameR < lastBeatR) ragyoFrameR = (ragyoFrameR + lastBeatR) / 3;

  lastBeatL = ragyoFrameL;
  lastBeatR = ragyoFrameR;

  ragyoHairL.gotoframe(ragyoFrameL);
  ragyoHairR.gotoframe(ragyoFrameR);
}

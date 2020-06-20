#include "lib/std.mi"

Global Group frameGroup;
Global AnimatedLayer VGUI_peakL, VGUI_peakR;
Global int totalFramesL, totalFramesR, lastBeatL, lastBeatR;
Global Timer beatTimer;

System.onScriptLoaded() {
  frameGroup = getScriptGroup();
  VGUI_peakL = frameGroup.findObject("vguivis.animatedlayerL");
  VGUI_peakR = frameGroup.findObject("vguivis.animatedlayerR");
  totalFramesL = VGUI_peakL.getLength() - 1;
  totalFramesR = VGUI_peakR.getLength() - 1;
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

  int VGUIFrameL = beatValueL * (totalFramesL + 1);
  int VGUIFrameR = beatValueR * (totalFramesR + 1);

  if (VGUIFrameL > totalFramesL) VGUIFrameL = totalFramesL;
  if (VGUIFrameL < lastBeatL) VGUIFrameL = (VGUIFrameL + lastBeatL) / 1.3;

  if (VGUIFrameR > totalFramesR) VGUIFrameR = totalFramesR;
  if (VGUIFrameR < lastBeatR) VGUIFrameR = (VGUIFrameR + lastBeatR) / 1.3;

  lastBeatL = VGUIFrameL;
  lastBeatR = VGUIFrameR;

  VGUI_peakL.gotoframe(VGUIFrameL);
  VGUI_peakR.gotoframe(VGUIFrameR);
}

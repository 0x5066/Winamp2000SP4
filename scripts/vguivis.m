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
  double sens = 1.0;

  double vuLeft = System.getLeftVuMeter()*sens;
  double vuRight = System.getRightVuMeter()*sens;

  //untested shit
  /*
  //exponential
  double beatValueL = pow(2.718,vuLeft/46);
  double beatValueL = pow(2.718,vuRight/46);
  
  //hybrid (exp+lin)
  double beatValueL = vuLeft*vuLeft / 255;
  double beatValueR = vuRight*vuRight / 255;

  //linear
  double beatValueL = vuLeft / 255;
  double beatValueR = vuRight / 255;

  //hybrid (log+lin)
  double beatValueL = (sqrt(vuLeft)*15.97)) / 255;
  double beatValueR = (sqrt(vuRight)*15.97)) / 255;
  */

  //logarithmic
  double beatValueL = (sqrt(sqrt(vuLeft))*63.813) / 255;
  double beatValueR = (sqrt(sqrt(vuRight))*63.813) / 255;

  int VGUIFrameL = beatValueL * (totalFramesL + 1);
  int VGUIFrameR = beatValueR * (totalFramesR + 1);

  if (VGUIFrameL > totalFramesL) VGUIFrameL = totalFramesL;
  if (VGUIFrameL < lastBeatL) VGUIFrameL = (VGUIFrameL + lastBeatL) / 2;

  if (VGUIFrameR > totalFramesR) VGUIFrameR = totalFramesR;
  if (VGUIFrameR < lastBeatR) VGUIFrameR = (VGUIFrameR + lastBeatR) / 2;

  lastBeatL = VGUIFrameL;
  lastBeatR = VGUIFrameR;

  VGUI_peakL.gotoframe(VGUIFrameL);
  VGUI_peakR.gotoframe(VGUIFrameR);
}

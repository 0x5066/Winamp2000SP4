// This script is copyrighted. Egor Petrov 2003 - 2005. egorka_petrov@mail.ru
// Modified by 0x5066.

// Ver 2.0 You can now use this to modify the height of a layer... yay?
// Ver 1.01 (Added test mode)
// You can use this script for other skins. (probably not)
#include "lib/std.mi"
#include "lib/application.mi"

Global Layer LeftMeter, RightMeter, bar3, bar4, bar5, bar6, bar7, bar8, bar9, bar10, bar11, bar12, bar13, bar14, bar15, bar16, bar17, bar18, bar19, bar20, bar21, bar22, bar23, bar24, bar25, bar26, bar27, bar28, bar29, bar30, bar31, bar32, bar33, bar34, bar35, bar36, bar37, bar38, bar39, bar40, bar41, bar42, bar43, bar44, bar45, bar46, bar47, bar48, bar49, bar50, bar51, bar52, bar53, bar54, bar55, bar56, bar57, bar58, bar59, bar60, bar61, bar62, bar63, bar64, bar64, bar65, bar66, bar67, bar68, bar69, bar70, bar71, bar72, bar73, bar74, bar75; // layer
Global Timer Refresh;
Global Text debugtext, debugtext2;
Global int ONOFF, Level1, Level2, Level3, Level4, Level5, Level6, Level7, Level8, Level9, Level10, Level11, Level12, Level13, Level14, Level15, Level16, Level17, Level18, Level19, Level20, Level21, Level22, Level23, Level24, Level25, Level26, Level27, Level28, Level29, Level30, Level31, Level32, Level33, Level34, Level35, Level36, Level37, Level38, Level39, Level40, Level41, Level42, Level43, Level44, Level45, Level46, Level47, Level48, Level49, Level50, Level51, Level52, Level53, Level54, Level55, Level56, Level57, Level58, Level59, Level60, Level61, Level62, Level63, Level64, Level65, Level66, Level67, Level68, Level69, Level70, Level71, Level72, Level73, Level74, Level75, DivL1, DivL2, DivL3, DivL4, DivL5, DivL6, DivL7, DivL8, DivL9, DivL10, DivL11, DivL12, DivL13, DivL14, DivL15, DivL16, DivL17, DivL18, DivL19, DivL20, DivL21, DivL22, DivL23, DivL24, DivL25, DivL26, DivL27, DivL28, DivL29, DivL30, DivL31, DivL32, DivL33, DivL34, DivL35, DivL36, DivL37, DivL38, DivL39, DivL40, DivL41, DivL42, DivL43, DivL44, DivL45, DivL46, DivL47, DivL48, DivL49, DivL50, DivL51, DivL52, DivL53, DivL54, DivL55, DivL56, DivL57, DivL58, DivL59, DivL60, DivL61, DivL62, DivL63, DivL64, DivL65, DivL66, DivL67, DivL68, DivL69, DivL70, DivL71, DivL72, DivL73, DivL74, DivL75, DivR1, DivR2, DivR3, DivR4, DivR5, DivR6, DivR7, DivR8, DivR9, DivR10, DivR11, DivR12, DivR13, DivR14, DivR15, DivR16, DivR17, DivR18, DivR19, DivR20, DivR21, DivR22, DivR23, DivR24, DivR25, DivR26, DivR27, DivR28, DivR29, DivR30, DivR31, DivR32, DivR33, DivR34, DivR35, DivR36, DivR37, DivR38, DivR39, DivR40, DivR41, DivR42, DivR43, DivR44, DivR45, DivR46, DivR47, DivR48, DivR49, DivR50, DivR51, DivR52, DivR53, DivR54, DivR55, DivR56, DivR57, DivR58, DivR59, DivR60, DivR61, DivR62, DivR63, DivR64, DivR65, DivR66, DivR67, DivR68, DivR69, DivR70, DivR71, DivR72, DivR73, DivR74, DivR75;

#define base 1 
//no exact idea what it means, but dont set to 0
#define dontlimit 300 
//this is here for the - what used to be - sensitivity function, 300 is probably a safe value as anything below that (probably) clips the signal off in a weird way, 250 will do that
#define dolimitpls 2 
//reduce signal hotness with this, this value is divided so becareful!
#define base2 128 
//sets how low the "analyzer" is going to be, if dividing by 2 it's set to 128, dividing by 4 then you set it to 64, divided by 8 then you set it to 32 i think, idk

Function togg();

System.onScriptLoaded() {
  Group animgroup = getScriptGroup();
  LeftMeter = animgroup.getObject("ragyovis_hair.animatedlayerL");
  RightMeter = animgroup.getObject("ragyovis_hair.animatedlayerR");
  bar3 = animgroup.getObject("bar3");
  bar4 = animgroup.getObject("bar4");
  bar5 = animgroup.getObject("bar5");
  bar6 = animgroup.getObject("bar6");
  bar7 = animgroup.getObject("bar7");
  bar8 = animgroup.getObject("bar8");
  bar9 = animgroup.getObject("bar9");
  bar10 = animgroup.getObject("bar10");
  bar11 = animgroup.getObject("bar11");
  bar12 = animgroup.getObject("bar12");
  bar13 = animgroup.getObject("bar13");
  bar14 = animgroup.getObject("bar14");
  bar15 = animgroup.getObject("bar15");
  bar16 = animgroup.getObject("bar16");
  bar17 = animgroup.getObject("bar17");
  bar18 = animgroup.getObject("bar18");
  bar19 = animgroup.getObject("bar19");
  bar20 = animgroup.getObject("bar20");
  bar21 = animgroup.getObject("bar21");
  bar22 = animgroup.getObject("bar22");
  bar23 = animgroup.getObject("bar23");
  bar24 = animgroup.getObject("bar24");
  bar25 = animgroup.getObject("bar25");
  bar26 = animgroup.getObject("bar26");
  bar27 = animgroup.getObject("bar27");
  bar28 = animgroup.getObject("bar28");
  bar29 = animgroup.getObject("bar29");
  bar30 = animgroup.getObject("bar30");
  bar31 = animgroup.getObject("bar31");
  bar32 = animgroup.getObject("bar32");
  bar33 = animgroup.getObject("bar33");
  bar34 = animgroup.getObject("bar34");
  bar35 = animgroup.getObject("bar35");
  bar36 = animgroup.getObject("bar36");
  bar37 = animgroup.getObject("bar37");
  bar38 = animgroup.getObject("bar38");
  bar39 = animgroup.getObject("bar39");
  bar40 = animgroup.getObject("bar40");
  bar41 = animgroup.getObject("bar41");
  bar42 = animgroup.getObject("bar42");
  bar43 = animgroup.getObject("bar43");
  bar44 = animgroup.getObject("bar44");
  bar45 = animgroup.getObject("bar45");
  bar46 = animgroup.getObject("bar46");
  bar47 = animgroup.getObject("bar47");
  bar48 = animgroup.getObject("bar48");
  bar49 = animgroup.getObject("bar49");
  bar50 = animgroup.getObject("bar50");
  bar51 = animgroup.getObject("bar51");
  bar52 = animgroup.getObject("bar52");
  bar53 = animgroup.getObject("bar53");
  bar54 = animgroup.getObject("bar54");
  bar55 = animgroup.getObject("bar55");
  bar56 = animgroup.getObject("bar56");
  bar57 = animgroup.getObject("bar57");
  bar58 = animgroup.getObject("bar58");
  bar59 = animgroup.getObject("bar59");
  bar60 = animgroup.getObject("bar60");
  bar61 = animgroup.getObject("bar61");
  bar62 = animgroup.getObject("bar62");
  bar63 = animgroup.getObject("bar63");
  bar64 = animgroup.getObject("bar64");
  bar65 = animgroup.getObject("bar65");
  bar66 = animgroup.getObject("bar66");
  bar67 = animgroup.getObject("bar67");
  bar68 = animgroup.getObject("bar68");
  bar69 = animgroup.getObject("bar69");
  bar70 = animgroup.getObject("bar70");
  bar71 = animgroup.getObject("bar71");
  bar72 = animgroup.getObject("bar72");
  bar73 = animgroup.getObject("bar73");
  bar74 = animgroup.getObject("bar74");
  bar75 = animgroup.getObject("bar75");
  
  debugtext = animgroup.getObject("debug_stuff");
  debugtext2 = animgroup.getObject("more_debug_stuff");
  ONOFF = getPrivateInt("EPS3", "Disable VU meters3", 0);
	string paramslist = getPrivateString("EPS3", "Electronic meters3", "4;200;4;200");
	DivL1 = stringToInteger(getToken(paramslist, ";", 0));
	DivL2 = stringToInteger(getToken(paramslist, ";", 1));
	DivR1 = stringToInteger(getToken(paramslist, ";", 2));
	DivR2 = stringToInteger(getToken(paramslist, ";", 3));
	
	DivL3 = stringToInteger(getToken(paramslist, ";", 0));
	DivL4 = stringToInteger(getToken(paramslist, ";", 1));
	DivR3 = stringToInteger(getToken(paramslist, ";", 2));
	DivR4 = stringToInteger(getToken(paramslist, ";", 3));
	
	DivL5 = stringToInteger(getToken(paramslist, ";", 0));
	DivL6 = stringToInteger(getToken(paramslist, ";", 1));
	DivR5 = stringToInteger(getToken(paramslist, ";", 2));
	DivR6 = stringToInteger(getToken(paramslist, ";", 3));
	
	DivL7 = stringToInteger(getToken(paramslist, ";", 0));
	DivL8 = stringToInteger(getToken(paramslist, ";", 1));
	DivR7 = stringToInteger(getToken(paramslist, ";", 2));
	DivR8 = stringToInteger(getToken(paramslist, ";", 3));
	
	DivL9 = stringToInteger(getToken(paramslist, ";", 0));
	DivL10 = stringToInteger(getToken(paramslist, ";", 1));
	DivR9 = stringToInteger(getToken(paramslist, ";", 2));
	DivR10 = stringToInteger(getToken(paramslist, ";", 3));
	
	DivL11 = stringToInteger(getToken(paramslist, ";", 0));
	DivL12 = stringToInteger(getToken(paramslist, ";", 1));
	DivR11 = stringToInteger(getToken(paramslist, ";", 2));
	DivR12 = stringToInteger(getToken(paramslist, ";", 3));

	DivL13 = stringToInteger(getToken(paramslist, ";", 0));
	DivL14 = stringToInteger(getToken(paramslist, ";", 1));
	DivR13 = stringToInteger(getToken(paramslist, ";", 2));
	DivR14 = stringToInteger(getToken(paramslist, ";", 3));

	DivL15 = stringToInteger(getToken(paramslist, ";", 0));
	DivL16 = stringToInteger(getToken(paramslist, ";", 1));
	DivR15 = stringToInteger(getToken(paramslist, ";", 2));
	DivR16 = stringToInteger(getToken(paramslist, ";", 3));

	DivL17 = stringToInteger(getToken(paramslist, ";", 0));
	DivL18 = stringToInteger(getToken(paramslist, ";", 1));
	DivR17 = stringToInteger(getToken(paramslist, ";", 2));
	DivR18 = stringToInteger(getToken(paramslist, ";", 3));

	DivL19 = stringToInteger(getToken(paramslist, ";", 0));
	DivL20 = stringToInteger(getToken(paramslist, ";", 1));
	DivR19 = stringToInteger(getToken(paramslist, ";", 2));
	DivR20 = stringToInteger(getToken(paramslist, ";", 3));

	DivL21 = stringToInteger(getToken(paramslist, ";", 0));
	DivL22 = stringToInteger(getToken(paramslist, ";", 1));
	DivR21 = stringToInteger(getToken(paramslist, ";", 2));
	DivR22 = stringToInteger(getToken(paramslist, ";", 3));

	DivL23 = stringToInteger(getToken(paramslist, ";", 0));
	DivL24 = stringToInteger(getToken(paramslist, ";", 1));
	DivR23 = stringToInteger(getToken(paramslist, ";", 2));
	DivR24 = stringToInteger(getToken(paramslist, ";", 3));
	
	DivL25 = stringToInteger(getToken(paramslist, ";", 0));
	DivL26 = stringToInteger(getToken(paramslist, ";", 1));
	DivR25 = stringToInteger(getToken(paramslist, ";", 2));
	DivR26 = stringToInteger(getToken(paramslist, ";", 3));

	DivL27 = stringToInteger(getToken(paramslist, ";", 0));
	DivL28 = stringToInteger(getToken(paramslist, ";", 1));
	DivR27 = stringToInteger(getToken(paramslist, ";", 2));
	DivR28 = stringToInteger(getToken(paramslist, ";", 3));

	DivL29 = stringToInteger(getToken(paramslist, ";", 0));
	DivL30 = stringToInteger(getToken(paramslist, ";", 1));
	DivR29 = stringToInteger(getToken(paramslist, ";", 2));
	DivR30 = stringToInteger(getToken(paramslist, ";", 3));

	DivL31 = stringToInteger(getToken(paramslist, ";", 0));
	DivL32 = stringToInteger(getToken(paramslist, ";", 1));
	DivR31 = stringToInteger(getToken(paramslist, ";", 2));
	DivR32 = stringToInteger(getToken(paramslist, ";", 3));

	DivL33 = stringToInteger(getToken(paramslist, ";", 0));
	DivL34 = stringToInteger(getToken(paramslist, ";", 1));
	DivR33 = stringToInteger(getToken(paramslist, ";", 2));
	DivR34 = stringToInteger(getToken(paramslist, ";", 3));

	DivL35 = stringToInteger(getToken(paramslist, ";", 0));
	DivL36 = stringToInteger(getToken(paramslist, ";", 1));
	DivR35 = stringToInteger(getToken(paramslist, ";", 2));
	DivR36 = stringToInteger(getToken(paramslist, ";", 3));

	DivL37 = stringToInteger(getToken(paramslist, ";", 0));
	DivL38 = stringToInteger(getToken(paramslist, ";", 1));
	DivR37 = stringToInteger(getToken(paramslist, ";", 2));
	DivR38 = stringToInteger(getToken(paramslist, ";", 3));

	DivL39 = stringToInteger(getToken(paramslist, ";", 0));
	DivL40 = stringToInteger(getToken(paramslist, ";", 1));
	DivR39 = stringToInteger(getToken(paramslist, ";", 2));
	DivR40 = stringToInteger(getToken(paramslist, ";", 3));

	DivL41 = stringToInteger(getToken(paramslist, ";", 0));
	DivL42 = stringToInteger(getToken(paramslist, ";", 1));
	DivR41 = stringToInteger(getToken(paramslist, ";", 2));
	DivR42 = stringToInteger(getToken(paramslist, ";", 3));

	DivL43 = stringToInteger(getToken(paramslist, ";", 0));
	DivL44 = stringToInteger(getToken(paramslist, ";", 1));
	DivR43 = stringToInteger(getToken(paramslist, ";", 2));
	DivR44 = stringToInteger(getToken(paramslist, ";", 3));
	
	DivL45 = stringToInteger(getToken(paramslist, ";", 0));
	DivL46 = stringToInteger(getToken(paramslist, ";", 1));
	DivR45 = stringToInteger(getToken(paramslist, ";", 2));
	DivR46 = stringToInteger(getToken(paramslist, ";", 3));

	DivL47 = stringToInteger(getToken(paramslist, ";", 0));
	DivL48 = stringToInteger(getToken(paramslist, ";", 1));
	DivR47 = stringToInteger(getToken(paramslist, ";", 2));
	DivR48 = stringToInteger(getToken(paramslist, ";", 3));

	DivL49 = stringToInteger(getToken(paramslist, ";", 0));
	DivL50 = stringToInteger(getToken(paramslist, ";", 1));
	DivR49 = stringToInteger(getToken(paramslist, ";", 2));
	DivR50 = stringToInteger(getToken(paramslist, ";", 3));

	DivL51 = stringToInteger(getToken(paramslist, ";", 0));
	DivL52 = stringToInteger(getToken(paramslist, ";", 1));
	DivR51 = stringToInteger(getToken(paramslist, ";", 2));
	DivR52 = stringToInteger(getToken(paramslist, ";", 3));

	DivL53 = stringToInteger(getToken(paramslist, ";", 0));
	DivL54 = stringToInteger(getToken(paramslist, ";", 1));
	DivR53 = stringToInteger(getToken(paramslist, ";", 2));
	DivR54 = stringToInteger(getToken(paramslist, ";", 3));

	DivL55 = stringToInteger(getToken(paramslist, ";", 0));
	DivL56 = stringToInteger(getToken(paramslist, ";", 1));
	DivR55 = stringToInteger(getToken(paramslist, ";", 2));
	DivR56 = stringToInteger(getToken(paramslist, ";", 3));

	DivL57 = stringToInteger(getToken(paramslist, ";", 0));
	DivL58 = stringToInteger(getToken(paramslist, ";", 1));
	DivR57 = stringToInteger(getToken(paramslist, ";", 2));
	DivR58 = stringToInteger(getToken(paramslist, ";", 3));

	DivL59 = stringToInteger(getToken(paramslist, ";", 0));
	DivL60 = stringToInteger(getToken(paramslist, ";", 1));
	DivR59 = stringToInteger(getToken(paramslist, ";", 2));
	DivR60 = stringToInteger(getToken(paramslist, ";", 3));

	DivL61 = stringToInteger(getToken(paramslist, ";", 0));
	DivL62 = stringToInteger(getToken(paramslist, ";", 1));
	DivR61 = stringToInteger(getToken(paramslist, ";", 2));
	DivR62 = stringToInteger(getToken(paramslist, ";", 3));

	DivL63 = stringToInteger(getToken(paramslist, ";", 0));
	DivL64 = stringToInteger(getToken(paramslist, ";", 1));
	DivR63 = stringToInteger(getToken(paramslist, ";", 2));
	DivR64 = stringToInteger(getToken(paramslist, ";", 3));
	
	DivL65 = stringToInteger(getToken(paramslist, ";", 0));
	DivL66 = stringToInteger(getToken(paramslist, ";", 1));
	DivR65 = stringToInteger(getToken(paramslist, ";", 2));
	DivR66 = stringToInteger(getToken(paramslist, ";", 3));

	DivL67 = stringToInteger(getToken(paramslist, ";", 0));
	DivL68 = stringToInteger(getToken(paramslist, ";", 1));
	DivR67 = stringToInteger(getToken(paramslist, ";", 2));
	DivR68 = stringToInteger(getToken(paramslist, ";", 3));

	DivL69 = stringToInteger(getToken(paramslist, ";", 0));
	DivL70 = stringToInteger(getToken(paramslist, ";", 1));
	DivR69 = stringToInteger(getToken(paramslist, ";", 2));
	DivR70 = stringToInteger(getToken(paramslist, ";", 3));

	DivL71 = stringToInteger(getToken(paramslist, ";", 0));
	DivL72 = stringToInteger(getToken(paramslist, ";", 1));
	DivR71 = stringToInteger(getToken(paramslist, ";", 2));
	DivR72 = stringToInteger(getToken(paramslist, ";", 3));

	DivL73 = stringToInteger(getToken(paramslist, ";", 0));
	DivL74 = stringToInteger(getToken(paramslist, ";", 1));
	DivR73 = stringToInteger(getToken(paramslist, ";", 2));
	DivR74 = stringToInteger(getToken(paramslist, ";", 3));

	DivL75 = stringToInteger(getToken(paramslist, ";", 0));
	DivR75 = stringToInteger(getToken(paramslist, ";", 2));
  Refresh = new Timer;
  Refresh.setDelay(0);
  Refresh.start();
}

System.onScriptUnloading() {
  delete Refresh;
  setPrivateInt("EPS3", "Disable VU meters3", ONOFF);
	setPrivateString("EPS3", "Electronic meters3", 
	integerToString(DivL1)+";"
	+integerToString(DivL2)+";"
	+integerToString(DivR1)+";"
	+integerToString(DivR2));
}

Refresh.onTimer() {
	level1 -= 	(getVisBand(0, 0) + level1) / DivL1; //smoothness
	level2 -= 	(getVisBand(0, 1) + level2) / DivR1; //smoothness
	level3 -= 	(getVisBand(0, 2) + level3) / DivL3; //smoothness
	level4 -= 	(getVisBand(0, 3) + level4) / DivR3; //smoothness
	level5 -= 	(getVisBand(0, 4) + level5) / DivL5; //smoothness
	level6 -= 	(getVisBand(0, 5) + level6) / DivR5; //smoothness
	level7 -= 	(getVisBand(0, 6) + level7) / DivL7; //smoothness
	level8 -= 	(getVisBand(0, 7) + level8) / DivR7; //smoothness
	level9 -= 	(getVisBand(0, 8) + level9) / DivL9; //smoothness
	level10 -= 	(getVisBand(0, 9) + level10) / DivR9; //smoothness
	level11 -= 	(getVisBand(0, 10) + level11) / DivL11; //smoothness
	level12 -= 	(getVisBand(0, 11) + level12) / DivR11; //smoothness
	level13 -= 	(getVisBand(0, 12) + level13) / DivL13; //smoothness
	level14 -= 	(getVisBand(0, 13) + level14) / DivR13; //smoothness
	level15 -= 	(getVisBand(0, 14) + level15) / DivL15; //smoothness
	level16 -= 	(getVisBand(0, 15) + level16) / DivR15; //smoothness
	level17 -= 	(getVisBand(0, 16) + level17) / DivL17; //smoothness
	level18 -= 	(getVisBand(0, 17) + level18) / DivR17; //smoothness
	level19 -= 	(getVisBand(0, 18) + level19) / DivL19; //smoothness
	level20 -= 	(getVisBand(0, 19) + level20) / DivR19; //smoothness
	level21 -= 	(getVisBand(0, 20) + level21) / DivL21; //smoothness
	level22 -= 	(getVisBand(0, 21) + level22) / DivR21; //smoothness
	level23 -= 	(getVisBand(0, 22) + level23) / DivL23; //smoothness
	level24 -= 	(getVisBand(0, 23) + level24) / DivR23; //smoothness
	level25 -= 	(getVisBand(0, 24) + level25) / DivL25; //smoothness
	level26 -= 	(getVisBand(0, 25) + level26) / DivR25; //smoothness
	level27 -= 	(getVisBand(0, 26) + level27) / DivL27; //smoothness
	level28 -= 	(getVisBand(0, 27) + level28) / DivR27; //smoothness
	level29 -= 	(getVisBand(0, 28) + level29) / DivL29; //smoothness
	level30 -= 	(getVisBand(0, 29) + level30) / DivR29; //smoothness
	level31 -= 	(getVisBand(0, 30) + level31) / DivL31; //smoothness
	level32 -= 	(getVisBand(0, 31) + level32) / DivR31; //smoothness
	level33 -= 	(getVisBand(0, 32) + level33) / DivL33; //smoothness
	level34 -= 	(getVisBand(0, 33) + level34) / DivR33; //smoothness
	level35 -= 	(getVisBand(0, 34) + level35) / DivL35; //smoothness
	level36 -= 	(getVisBand(0, 35) + level36) / DivR35; //smoothness
	level37 -= 	(getVisBand(0, 36) + level37) / DivL37; //smoothness
	level38 -= 	(getVisBand(0, 37) + level38) / DivR37; //smoothness
	level39 -= 	(getVisBand(0, 38) + level39) / DivL39; //smoothness
	level40 -= 	(getVisBand(0, 39) + level40) / DivR39; //smoothness
	level41 -= 	(getVisBand(0, 40) + level41) / DivL41; //smoothness
	level42 -= 	(getVisBand(0, 41) + level42) / DivR41; //smoothness
	level43 -= 	(getVisBand(0, 42) + level43) / DivL43; //smoothness
	level44 -= 	(getVisBand(0, 43) + level44) / DivR43; //smoothness
	level45 -= 	(getVisBand(0, 44) + level45) / DivL45; //smoothness
	level46 -= 	(getVisBand(0, 45) + level46) / DivR45; //smoothness
	level47 -= 	(getVisBand(0, 46) + level47) / DivL47; //smoothness
	level48 -= 	(getVisBand(0, 47) + level48) / DivR47; //smoothness
	level49 -= 	(getVisBand(0, 48) + level49) / DivL49; //smoothness
	level50 -= 	(getVisBand(0, 49) + level50) / DivR49; //smoothness
	level51 -= 	(getVisBand(0, 50) + level51) / DivL51; //smoothness
	level52 -= 	(getVisBand(0, 51) + level52) / DivR51; //smoothness
	level53 -= 	(getVisBand(0, 52) + level53) / DivL53; //smoothness
	level54 -= 	(getVisBand(0, 53) + level54) / DivR53; //smoothness
	level55 -= 	(getVisBand(0, 54) + level55) / DivL55; //smoothness
	level56 -= 	(getVisBand(0, 55) + level56) / DivR55; //smoothness
	level57 -= 	(getVisBand(0, 56) + level57) / DivL57; //smoothness
	level58 -= 	(getVisBand(0, 57) + level58) / DivR57; //smoothness
	level59 -= 	(getVisBand(0, 58) + level59) / DivL59; //smoothness
	level60 -= 	(getVisBand(0, 59) + level60) / DivR59; //smoothness
	level61 -= 	(getVisBand(0, 60) + level61) / DivL61; //smoothness
	level62 -= 	(getVisBand(0, 61) + level62) / DivR61; //smoothness
	level63 -= 	(getVisBand(0, 62) + level63) / DivL63; //smoothness
	level64 -= 	(getVisBand(0, 63) + level64) / DivR63; //smoothness
	level65 -= 	(getVisBand(0, 64) + level65) / DivL65; //smoothness
	level66 -= 	(getVisBand(0, 65) + level66) / DivR65; //smoothness
	level67 -= 	(getVisBand(0, 66) + level67) / DivL67; //smoothness
	level68 -= 	(getVisBand(0, 67) + level68) / DivR67; //smoothness
	level69 -= 	(getVisBand(0, 68) + level69) / DivL69; //smoothness
	level70 -= 	(getVisBand(0, 69) + level70) / DivR69; //smoothness
	level71 -= 	(getVisBand(0, 70) + level71) / DivL71; //smoothness
	level72 -= 	(getVisBand(0, 71) + level72) / DivR71; //smoothness
	level73 -= 	(getVisBand(0, 72) + level73) / DivL73; //smoothness
	level74 -= 	(getVisBand(0, 73) + level74) / DivR73; //smoothness
	level75 -= 	(getVisBand(0, 74) + level75) / DivR73; //smoothness
	int frame1 = level1/dontlimit* (stringToInteger(LeftMeter.getXmlParam("h"))); //sensitivity
	int frame2 = level2/dontlimit* (stringToInteger(RightMeter.getXmlParam("h"))); //sensitivity
	int frame3 = level3/dontlimit* (stringToInteger(bar3.getXmlParam("h"))); //sensitivity
	int frame4 = level4/dontlimit* (stringToInteger(bar4.getXmlParam("h"))); //sensitivity
	int frame5 = level5/dontlimit* (stringToInteger(bar5.getXmlParam("h"))); //sensitivity
	int frame6 = level6/dontlimit* (stringToInteger(bar6.getXmlParam("h"))); //sensitivity
	int frame7 = level7/dontlimit* (stringToInteger(bar7.getXmlParam("h"))); //sensitivity
	int frame8 = level8/dontlimit* (stringToInteger(bar8.getXmlParam("h"))); //sensitivity
	int frame9 = level9/dontlimit* (stringToInteger(bar9.getXmlParam("h"))); //sensitivity
	int frame10 = level10/dontlimit* (stringToInteger(bar10.getXmlParam("h"))); //sensitivity
	int frame11 = level11/dontlimit* (stringToInteger(bar11.getXmlParam("h"))); //sensitivity
	int frame12 = level12/dontlimit* (stringToInteger(bar12.getXmlParam("h"))); //sensitivity
	int frame13 = level13/dontlimit* (stringToInteger(bar13.getXmlParam("h"))); //sensitivity
	int frame14 = level14/dontlimit* (stringToInteger(bar14.getXmlParam("h"))); //sensitivity
	int frame15 = level15/dontlimit* (stringToInteger(bar15.getXmlParam("h"))); //sensitivity
	int frame16 = level16/dontlimit* (stringToInteger(bar16.getXmlParam("h"))); //sensitivity
	int frame17 = level17/dontlimit* (stringToInteger(bar17.getXmlParam("h"))); //sensitivity
	int frame18 = level18/dontlimit* (stringToInteger(bar18.getXmlParam("h"))); //sensitivity
	int frame19 = level19/dontlimit* (stringToInteger(bar19.getXmlParam("h"))); //sensitivity
	int frame20 = level20/dontlimit* (stringToInteger(bar20.getXmlParam("h"))); //sensitivity
	int frame21 = level21/dontlimit* (stringToInteger(bar21.getXmlParam("h"))); //sensitivity
	int frame22 = level22/dontlimit* (stringToInteger(bar22.getXmlParam("h"))); //sensitivity
	int frame23 = level23/dontlimit* (stringToInteger(bar23.getXmlParam("h"))); //sensitivity
	int frame24 = level24/dontlimit* (stringToInteger(bar24.getXmlParam("h"))); //sensitivity
	int frame25 = level25/dontlimit* (stringToInteger(bar25.getXmlParam("h"))); //sensitivity
	int frame26 = level26/dontlimit* (stringToInteger(bar26.getXmlParam("h"))); //sensitivity
	int frame27 = level27/dontlimit* (stringToInteger(bar27.getXmlParam("h"))); //sensitivity
	int frame28 = level28/dontlimit* (stringToInteger(bar28.getXmlParam("h"))); //sensitivity
	int frame29 = level29/dontlimit* (stringToInteger(bar29.getXmlParam("h"))); //sensitivity
	int frame30 = level30/dontlimit* (stringToInteger(bar30.getXmlParam("h"))); //sensitivity
	int frame31 = level31/dontlimit* (stringToInteger(bar31.getXmlParam("h"))); //sensitivity
	int frame32 = level32/dontlimit* (stringToInteger(bar32.getXmlParam("h"))); //sensitivity
	int frame33 = level33/dontlimit* (stringToInteger(bar33.getXmlParam("h"))); //sensitivity
	int frame34 = level34/dontlimit* (stringToInteger(bar34.getXmlParam("h"))); //sensitivity
	int frame35 = level35/dontlimit* (stringToInteger(bar35.getXmlParam("h"))); //sensitivity
	int frame36 = level36/dontlimit* (stringToInteger(bar36.getXmlParam("h"))); //sensitivity
	int frame37 = level37/dontlimit* (stringToInteger(bar37.getXmlParam("h"))); //sensitivity
	int frame38 = level38/dontlimit* (stringToInteger(bar38.getXmlParam("h"))); //sensitivity
	int frame39 = level39/dontlimit* (stringToInteger(bar39.getXmlParam("h"))); //sensitivity
	int frame40 = level40/dontlimit* (stringToInteger(bar40.getXmlParam("h"))); //sensitivity
	int frame41 = level41/dontlimit* (stringToInteger(bar41.getXmlParam("h"))); //sensitivity
	int frame42 = level42/dontlimit* (stringToInteger(bar42.getXmlParam("h"))); //sensitivity
	int frame43 = level43/dontlimit* (stringToInteger(bar43.getXmlParam("h"))); //sensitivity
	int frame44 = level44/dontlimit* (stringToInteger(bar44.getXmlParam("h"))); //sensitivity
	int frame45 = level45/dontlimit* (stringToInteger(bar45.getXmlParam("h"))); //sensitivity
	int frame46 = level46/dontlimit* (stringToInteger(bar46.getXmlParam("h"))); //sensitivity
	int frame47 = level47/dontlimit* (stringToInteger(bar47.getXmlParam("h"))); //sensitivity
	int frame48 = level48/dontlimit* (stringToInteger(bar48.getXmlParam("h"))); //sensitivity
	int frame49 = level49/dontlimit* (stringToInteger(bar49.getXmlParam("h"))); //sensitivity
	int frame50 = level50/dontlimit* (stringToInteger(bar50.getXmlParam("h"))); //sensitivity
	int frame51 = level51/dontlimit* (stringToInteger(bar51.getXmlParam("h"))); //sensitivity
	int frame52 = level52/dontlimit* (stringToInteger(bar52.getXmlParam("h"))); //sensitivity
	int frame53 = level53/dontlimit* (stringToInteger(bar53.getXmlParam("h"))); //sensitivity
	int frame54 = level54/dontlimit* (stringToInteger(bar54.getXmlParam("h"))); //sensitivity
	int frame55 = level55/dontlimit* (stringToInteger(bar55.getXmlParam("h"))); //sensitivity
	int frame56 = level56/dontlimit* (stringToInteger(bar56.getXmlParam("h"))); //sensitivity
	int frame57 = level57/dontlimit* (stringToInteger(bar57.getXmlParam("h"))); //sensitivity
	int frame58 = level58/dontlimit* (stringToInteger(bar58.getXmlParam("h"))); //sensitivity
	int frame59 = level59/dontlimit* (stringToInteger(bar59.getXmlParam("h"))); //sensitivity
	int frame60 = level60/dontlimit* (stringToInteger(bar60.getXmlParam("h"))); //sensitivity
	int frame61 = level61/dontlimit* (stringToInteger(bar61.getXmlParam("h"))); //sensitivity
	int frame62 = level62/dontlimit* (stringToInteger(bar62.getXmlParam("h"))); //sensitivity
	int frame63 = level63/dontlimit* (stringToInteger(bar63.getXmlParam("h"))); //sensitivity
	int frame64 = level64/dontlimit* (stringToInteger(bar64.getXmlParam("h"))); //sensitivity
	int frame65 = level65/dontlimit* (stringToInteger(bar65.getXmlParam("h"))); //sensitivity
	int frame66 = level66/dontlimit* (stringToInteger(bar66.getXmlParam("h"))); //sensitivity
	int frame67 = level67/dontlimit* (stringToInteger(bar67.getXmlParam("h"))); //sensitivity
	int frame68 = level68/dontlimit* (stringToInteger(bar68.getXmlParam("h"))); //sensitivity
	int frame69 = level69/dontlimit* (stringToInteger(bar69.getXmlParam("h"))); //sensitivity
	int frame70 = level70/dontlimit* (stringToInteger(bar70.getXmlParam("h"))); //sensitivity
	int frame71 = level71/dontlimit* (stringToInteger(bar71.getXmlParam("h"))); //sensitivity
	int frame72 = level72/dontlimit* (stringToInteger(bar72.getXmlParam("h"))); //sensitivity
	int frame73 = level73/dontlimit* (stringToInteger(bar73.getXmlParam("h"))); //sensitivity
	int frame74 = level74/dontlimit* (stringToInteger(bar74.getXmlParam("h"))); //sensitivity
	int frame75 = level75/dontlimit* (stringToInteger(bar75.getXmlParam("h"))); //sensitivity
/*   debugtext.setXmlParam("text", 
    "level11: " +integerToString(level11)+ 
    ", level12: " +integerToString(level12)+
    ", frame11: " +integerToString(frame11)+
    ", frame12: " +integerToString(frame12)+""
  );
  debugtext2.setXmlParam("text", 
    "divl11, l12: " +integerToString(dontlimit)+ ", " +integerToString(dontlimit)+
    ", divr11, r12: " +integerToString(dontlimit)+ ", " +integerToString(dontlimit)+
    ", bar11 h: " +bar11.getXmlParam("h")+
    ", bar12 h: " +bar12.getXmlParam("h")+""
  ); */
  
  if (frame1 < LeftMeter.getXmlParam("h") && frame2 < RightMeter.getXmlParam("h")) {
    LeftMeter.setXmlParam("h", integerToString(base2+level1/dolimitpls+base));
    RightMeter.setXmlParam("h", integerToString(base2+level2/dolimitpls+base));
	}
	if (frame3 < bar3.getXmlParam("h") && frame4 < bar4.getXmlParam("h")) {
    bar3.setXmlParam("h", integerToString(base2+level3/dolimitpls+base));
    bar4.setXmlParam("h", integerToString(base2+level4/dolimitpls+base));
	}
	if (frame5 < bar5.getXmlParam("h") && frame6 < bar6.getXmlParam("h")) {
    bar5.setXmlParam("h", integerToString(base2+level5/dolimitpls+base));
    bar6.setXmlParam("h", integerToString(base2+level6/dolimitpls+base));
	}
	if (frame7 < bar7.getXmlParam("h") && frame8 < bar8.getXmlParam("h")) {
    bar7.setXmlParam("h", integerToString(base2+level7/dolimitpls+base));
    bar8.setXmlParam("h", integerToString(base2+level8/dolimitpls+base));
	}
	if (frame9 < bar9.getXmlParam("h") && frame10 < bar10.getXmlParam("h")) {
    bar9.setXmlParam("h", integerToString(base2+level9/dolimitpls+base));
    bar10.setXmlParam("h", integerToString(base2+level10/dolimitpls+base));
	}
	if (frame11 < bar11.getXmlParam("h") && frame12 < bar12.getXmlParam("h")) {
    bar11.setXmlParam("h", integerToString(base2+level11/dolimitpls+base));
    bar12.setXmlParam("h", integerToString(base2+level12/dolimitpls+base));
	}
	if (frame13 < bar13.getXmlParam("h") && frame14 < bar14.getXmlParam("h")) {
    bar13.setXmlParam("h", integerToString(base2+level13/dolimitpls+base));
    bar14.setXmlParam("h", integerToString(base2+level14/dolimitpls+base));
	}
	if (frame15 < bar15.getXmlParam("h") && frame16 < bar16.getXmlParam("h")) {
    bar15.setXmlParam("h", integerToString(base2+level15/dolimitpls+base));
    bar16.setXmlParam("h", integerToString(base2+level16/dolimitpls+base));
	}
	if (frame17 < bar17.getXmlParam("h") && frame18 < bar18.getXmlParam("h")) {
    bar17.setXmlParam("h", integerToString(base2+level17/dolimitpls+base));
    bar18.setXmlParam("h", integerToString(base2+level18/dolimitpls+base));
	}
	if (frame19 < bar19.getXmlParam("h") && frame20 < bar20.getXmlParam("h")) {
    bar19.setXmlParam("h", integerToString(base2+level19/dolimitpls+base));
    bar20.setXmlParam("h", integerToString(base2+level20/dolimitpls+base));
	}
	if (frame21 < bar21.getXmlParam("h") && frame22 < bar22.getXmlParam("h")) {
    bar21.setXmlParam("h", integerToString(base2+level21/dolimitpls+base));
    bar22.setXmlParam("h", integerToString(base2+level22/dolimitpls+base));
	}
	if (frame23 < bar23.getXmlParam("h") && frame24 < bar24.getXmlParam("h")) {
    bar23.setXmlParam("h", integerToString(base2+level23/dolimitpls+base));
    bar24.setXmlParam("h", integerToString(base2+level24/dolimitpls+base));
	}
	if (frame25 < bar25.getXmlParam("h") && frame26 < bar26.getXmlParam("h")) {
    bar25.setXmlParam("h", integerToString(base2+level25/dolimitpls+base));
    bar26.setXmlParam("h", integerToString(base2+level26/dolimitpls+base));
	}
	if (frame27 < bar27.getXmlParam("h") && frame28 < bar28.getXmlParam("h")) {
    bar27.setXmlParam("h", integerToString(base2+level27/dolimitpls+base));
    bar28.setXmlParam("h", integerToString(base2+level28/dolimitpls+base));
	}
	if (frame29 < bar29.getXmlParam("h") && frame30 < bar30.getXmlParam("h")) {
    bar29.setXmlParam("h", integerToString(base2+level29/dolimitpls+base));
    bar30.setXmlParam("h", integerToString(base2+level30/dolimitpls+base));
	}
	if (frame31 < bar31.getXmlParam("h") && frame32 < bar32.getXmlParam("h")) {
    bar31.setXmlParam("h", integerToString(base2+level31/dolimitpls+base));
    bar32.setXmlParam("h", integerToString(base2+level32/dolimitpls+base));
	}
	if (frame33 < bar33.getXmlParam("h") && frame34 < bar34.getXmlParam("h")) {
    bar33.setXmlParam("h", integerToString(base2+level33/dolimitpls+base));
    bar34.setXmlParam("h", integerToString(base2+level34/dolimitpls+base));
	}
	if (frame35 < bar35.getXmlParam("h") && frame36 < bar36.getXmlParam("h")) {
    bar35.setXmlParam("h", integerToString(base2+level35/dolimitpls+base));
    bar36.setXmlParam("h", integerToString(base2+level36/dolimitpls+base));
	}
	if (frame37 < bar37.getXmlParam("h") && frame38 < bar38.getXmlParam("h")) {
    bar37.setXmlParam("h", integerToString(base2+level37/dolimitpls+base));
    bar38.setXmlParam("h", integerToString(base2+level38/dolimitpls+base));
	}
	if (frame39 < bar19.getXmlParam("h") && frame40 < bar40.getXmlParam("h")) {
    bar39.setXmlParam("h", integerToString(base2+level39/dolimitpls+base));
    bar40.setXmlParam("h", integerToString(base2+level40/dolimitpls+base));
	}
	if (frame41 < bar21.getXmlParam("h") && frame42 < bar42.getXmlParam("h")) {
    bar41.setXmlParam("h", integerToString(base2+level41/dolimitpls+base));
    bar42.setXmlParam("h", integerToString(base2+level42/dolimitpls+base));
	}
	if (frame43 < bar43.getXmlParam("h") && frame44 < bar44.getXmlParam("h")) {
    bar43.setXmlParam("h", integerToString(base2+level43/dolimitpls+base));
    bar44.setXmlParam("h", integerToString(base2+level44/dolimitpls+base));
	}
	if (frame45 < bar45.getXmlParam("h") && frame46 < bar46.getXmlParam("h")) {
    bar45.setXmlParam("h", integerToString(base2+level45/dolimitpls+base));
    bar46.setXmlParam("h", integerToString(base2+level46/dolimitpls+base));
	}
	if (frame47 < bar47.getXmlParam("h") && frame48 < bar48.getXmlParam("h")) {
    bar47.setXmlParam("h", integerToString(base2+level47/dolimitpls+base));
    bar48.setXmlParam("h", integerToString(base2+level48/dolimitpls+base));
	}
	if (frame49 < bar49.getXmlParam("h") && frame50 < bar50.getXmlParam("h")) {
    bar49.setXmlParam("h", integerToString(base2+level49/dolimitpls+base));
    bar50.setXmlParam("h", integerToString(base2+level50/dolimitpls+base));
	}
	if (frame51 < bar51.getXmlParam("h") && frame52 < bar52.getXmlParam("h")) {
    bar51.setXmlParam("h", integerToString(base2+level51/dolimitpls+base));
    bar52.setXmlParam("h", integerToString(base2+level52/dolimitpls+base));
	}
	if (frame53 < bar53.getXmlParam("h") && frame54 < bar54.getXmlParam("h")) {
    bar53.setXmlParam("h", integerToString(base2+level53/dolimitpls+base));
    bar54.setXmlParam("h", integerToString(base2+level54/dolimitpls+base));
	}
	if (frame55 < bar55.getXmlParam("h") && frame56 < bar56.getXmlParam("h")) {
    bar55.setXmlParam("h", integerToString(base2+level55/dolimitpls+base));
    bar56.setXmlParam("h", integerToString(base2+level56/dolimitpls+base));
	}
	if (frame57 < bar57.getXmlParam("h") && frame58 < bar58.getXmlParam("h")) {
    bar57.setXmlParam("h", integerToString(base2+level57/dolimitpls+base));
    bar58.setXmlParam("h", integerToString(base2+level58/dolimitpls+base));
	}
	if (frame59 < bar59.getXmlParam("h") && frame60 < bar60.getXmlParam("h")) {
    bar59.setXmlParam("h", integerToString(base2+level59/dolimitpls+base));
    bar60.setXmlParam("h", integerToString(base2+level60/dolimitpls+base));
	}
	if (frame61 < bar61.getXmlParam("h") && frame62 < bar62.getXmlParam("h")) {
    bar61.setXmlParam("h", integerToString(base2+level61/dolimitpls+base));
    bar62.setXmlParam("h", integerToString(base2+level62/dolimitpls+base));
	}
	if (frame63 < bar63.getXmlParam("h") && frame64 < bar64.getXmlParam("h")) {
    bar63.setXmlParam("h", integerToString(base2+level63/dolimitpls+base));
    bar64.setXmlParam("h", integerToString(base2+level64/dolimitpls+base));
	}
	if (frame65 < bar65.getXmlParam("h") && frame66 < bar66.getXmlParam("h")) {
    bar65.setXmlParam("h", integerToString(base2+level65/dolimitpls+base));
    bar66.setXmlParam("h", integerToString(base2+level66/dolimitpls+base));
	}
	if (frame67 < bar47.getXmlParam("h") && frame68 < bar68.getXmlParam("h")) {
    bar67.setXmlParam("h", integerToString(base2+level67/dolimitpls+base));
    bar68.setXmlParam("h", integerToString(base2+level68/dolimitpls+base));
	}
	if (frame69 < bar69.getXmlParam("h") && frame70 < bar70.getXmlParam("h")) {
    bar69.setXmlParam("h", integerToString(base2+level69/dolimitpls+base));
    bar70.setXmlParam("h", integerToString(base2+level70/dolimitpls+base));
	}
	if (frame71 < bar71.getXmlParam("h") && frame72 < bar72.getXmlParam("h")) {
    bar71.setXmlParam("h", integerToString(base2+level71/dolimitpls+base));
    bar72.setXmlParam("h", integerToString(base2+level72/dolimitpls+base));
	}
	if (frame73 < bar73.getXmlParam("h") && frame74 < bar74.getXmlParam("h")) {
    bar73.setXmlParam("h", integerToString(base2+level73/dolimitpls+base));
    bar74.setXmlParam("h", integerToString(base2+level74/dolimitpls+base));
	}
	if (frame73 < bar75.getXmlParam("h")) {
    bar75.setXmlParam("h", integerToString(base2+level75/dolimitpls+base));
	}
}

System.onKeyDown(string key) {
  if (key == "ctrl+m") {
    togg();
  }
}

LeftMeter.onLeftButtonUp(int x, int y) {
  PopupMenu MainMenu;
	MainMenu = new PopupMenu;
	PopupMenu Div1Menu;
	Div1Menu = new PopupMenu;
	PopupMenu Div2Menu;
	Div2Menu = new PopupMenu;
	
	//modify i = N instead of doing a replace all 10s operation, thereby causing a god damn black hole
	
	for (int i = 1; i < 10; ++i) Div1Menu.addCommand(integerToString(i), i*10, 
	DivL1 == i &&
	DivR1 == i &&
	DivL3 == i &&
	DivR3 == i &&
	DivL5 == i &&
	DivR5 == i &&
	DivL7 == i && 
	DivR7 == i &&
	DivL9 == i &&
	DivR9 == i &&
	DivL11 == i &&
	DivR11 == i &&	
	DivL13 == i &&
	DivR13 == i &&
	DivL15 == i &&
	DivR15 == i &&
	DivL17 == i && 
	DivR17 == i &&
	DivL19 == i &&
	DivR19 == i &&
	DivL21 == i &&
	DivR21 == i &&
	DivL23 == i &&
	DivR23 == i &&
	DivL25 == i &&
	DivR25 == i &&
	DivL27 == i && 
	DivR27 == i &&
	DivL29 == i &&
	DivR29 == i &&
	DivL31 == i &&
	DivR31 == i &&
	DivL33 == i &&
	DivR33 == i &&
	DivL35 == i &&
	DivR35 == i &&
	DivL37 == i && 
	DivR37 == i &&
	DivL39 == i &&
	DivR39 == i &&
	DivL41 == i &&
	DivR41 == i &&
	DivL43 == i &&
	DivR43 == i &&
	DivL45 == i &&
	DivR45 == i &&
	DivL47 == i && 
	DivR47 == i &&
	DivL49 == i &&
	DivR49 == i &&
	DivL51 == i &&
	DivR51 == i &&
	DivL53 == i &&
	DivR53 == i &&
	DivL55 == i &&
	DivR55 == i &&
	DivL57 == i && 
	DivR57 == i &&
	DivL59 == i &&
	DivR59 == i &&
	DivL61 == i &&
	DivR61 == i &&
	DivL63 == i &&
	DivR63 == i &&
	DivL65 == i &&
	DivR65 == i &&
	DivL67 == i && 
	DivR67 == i &&
	DivL69 == i &&
	DivR69 == i &&
	DivL71 == i &&
	DivR71 == i &&
	DivL73 == i &&
	DivR73 == i, 0);
	
	Div1Menu.addCommand("info", 100, 0, 0);
	
	MainMenu.addSubMenu(Div1Menu, "Smoothness");

	int com = MainMenu.popAtMouse();
	if (com > 0 && com < 100) {
		DivL1 = com / 10; //smoothness
		DivR1 = DivL1; //smoothness
		
		DivL3 = com / 10;
		DivR3 = DivL3;
		
		DivL5 = com / 10;
		DivR5 = DivL5;
		
		DivL7 = com / 10;
		DivR7 = DivL7;
		
		DivL9 = com / 10;
		DivR9 = DivL9;
		
		DivL11 = com / 10;
		DivR11 = DivL11;

		DivL13 = com / 10;
		DivR13 = DivL13;
		
		DivL15 = com / 10;
		DivR15 = DivL15;
		
		DivL17 = com / 10;
		DivR17 = DivL17;
		
		DivL19 = com / 10;
		DivR19 = DivL19;
		
		DivL21 = com / 10;
		DivR21 = DivL21;

		DivL23 = com / 10;
		DivR23 = DivL23;
		
		DivL25 = com / 10;
		DivR25 = DivL25;
		
		DivL27 = com / 10;
		DivR27 = DivL27;
		
		DivL29 = com / 10;
		DivR29 = DivL29;
		
		DivL31 = com / 10;
		DivR31 = DivL31;

		DivL33 = com / 10;
		DivR33 = DivL33;
		
		DivL35 = com / 10;
		DivR35 = DivL35;
		
		DivL37 = com / 10;
		DivR37 = DivL37;
		
		DivL39 = com / 10;
		DivR39 = DivL39;
		
		DivL41 = com / 10;
		DivR41 = DivL41;

		DivL43 = com / 10;
		DivR43 = DivL43;

		DivL45 = com / 10;
		DivR45 = DivL45;
		
		DivL47 = com / 10;
		DivR47 = DivL47;
		
		DivL49 = com / 10;
		DivR49 = DivL49;
		
		DivL51 = com / 10;
		DivR51 = DivL51;

		DivL53 = com / 10;
		DivR53 = DivL53;
		
		DivL55 = com / 10;
		DivR55 = DivL55;
		
		DivL57 = com / 10;
		DivR57 = DivL57;
		
		DivL59 = com / 10;
		DivR59 = DivL59;
		
		DivL61 = com / 10;
		DivR61 = DivL61;

		DivL63 = com / 10;
		DivR63 = DivL63;
		
		DivL65 = com / 10;
		DivR65 = DivL65;
		
		DivL67 = com / 10;
		DivR67 = DivL67;
		
		DivL69 = com / 10;
		DivR69 = DivL69;
		
		DivL71 = com / 10;
		DivR71 = DivL71;

		DivL73 = com / 10;
		DivR73 = DivL73;
	}
	else if (com == 100) {
		messagebox("This is a amount of sections between two recent points.\nThese sections are not equal.\nMore sections - nicely animation, but less speed.\n 4 sections by default", "Animation info", 1, "");
	}
}

togg() {
  if (Refresh.isRunning() == 1) {
    LeftMeter.setTargetSpeed(2+random(3));
    //RightMeter.setTargetSpeed(1+random(4));
    LeftMeter.setTargetA(0);
    //RightMeter.setTargetA(0);
    LeftMeter.gotoTarget();
    //RightMeter.gotoTarget();
    Refresh.stop();
    ONOFF = 1;
  }
  else if (Refresh.isRunning() == 0) {
    LeftMeter.setTargetA(255);
    //RightMeter.setTargetA(255);
    LeftMeter.gotoTarget();
    //RightMeter.gotoTarget();
    Refresh.start();
    ONOFF = 0;
  }
}

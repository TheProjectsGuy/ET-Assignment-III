String CURRENT_SCREEN = "Introduction Screen".toUpperCase();
String CURRENT_VIEW = "Homepage".toUpperCase();


void setup() {
  fullScreen();
  bootupFunction();
}



void draw() {
  switch(CURRENT_SCREEN) {
  case "INTRODUCTION SCREEN":
    Introduction_Screen_Handler();
    break;
  case "GRAPHER SCREEN":
    Grapher_Screen_Handler();
    break;
  case "THERMISTOR ANALYZER":
    Thermistor_Analyzer_Handler();
    break;
  case "TEMPERATURE DATABASE":
    Temperature_Database_Handler();
    break;
  }
  //Essential buttons
  makeEssentialButtons();  //The close button and the importat menu items, the code is there in Basic_Functions
}


void keyPressed() {
  switch(CURRENT_SCREEN) {
  case "INTRODUCTION SCREEN":
    Introduction_Screen_keyPressed();
    break;
  case "GRAPHER SCREEN":
    Grapher_Screen_keyPressed();
    break;
  case "THERMISTOR ANALYZER":
    Thermistor_Analyzer_keyPressed();
    break;
  case "TEMPERATURE DATABASE":
    Temperature_Database_keyPressed();
    break;
  }
}
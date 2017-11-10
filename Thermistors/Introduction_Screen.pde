//CURRENT_SCREEN = INTRODUCTION SCREEN
void Introduction_Screen_Handler() {
  switch(CURRENT_VIEW) {
  case "HOMEPAGE":  //CURRENT_VIEW = HOMEPAGE
    MakeHomepage();
    break;
  }
}

void MakeHomepage() {
  background(127);
  MakeHomepageButtons();
  MakeLinkButtons();
}

void Introduction_Screen_keyPressed() {
}

void MakeHomepageButtons() {
  Make_Default_Calibration_Curve_Button();  //The default calibration curve button
  Make_Info_Calibration_Curve_Button();  //The info button

  Make_Thermistor_Analyzer_Button();

  Make_Thermistor_Database_Button();
}

PImage Thermistor_Database_Icon;  
void Make_Thermistor_Database_Button() {  //124 by 50
  if (mouseX <= width/2 + 124/2.0 && mouseX >= width/2 - 124/2.0 && mouseY <= height/2 + 50/2.0 - 150 && mouseY >= height/2 - 50/2.0 - 150) {
    Thermistor_Database_Icon = loadImage("data/Images/Introduction Screen/Database_hovered.png");
    if (mousePressed) {
      doCommand("Screen.TEMPERATURE_DATABASE.Select_thermistor_loader");  // ;-> "Temperature Database"."Select Thermistor loader"
    }
  } else {
    Thermistor_Database_Icon = loadImage("data/Images/Introduction Screen/Database_unhovered.png");
  }
  imageMode(CENTER);
  image(Thermistor_Database_Icon, width/2, height/2 - 150);
}

PImage ThermistorAnalyzerIcon_Button;
void Make_Thermistor_Analyzer_Button() {
  if (mouseX <= width/2 + 50 && mouseX >= width/2 && mouseY >= height / 2 + 50 && mouseY <= height / 2 + 100) {
    if (mousePressed) {
      doCommand("SCREEN.Thermistor_Analyzer.Form_View_Loader");  // ;-> "SCREEN.Thermistor_Analyzer.Form_View_Loader"
    }
    ThermistorAnalyzerIcon_Button = loadImage("data/Images/Introduction Screen/Thermistor_Analyzer_hovered.png");
  } else {
    ThermistorAnalyzerIcon_Button = loadImage("data/Images/Introduction Screen/Thermistor_Analyzer_unhovered.png");
  }
  imageMode(CORNER);
  image(ThermistorAnalyzerIcon_Button, width/2, height / 2 + 50, 50, 50);
}

void MakeLinkButtons() {
  MakeWikipediaIcon_Button();
  MakeHTMLLinkIcon_Button();
  MakePDFLinkIcon_Button();
}

String PDFLink = "https://www.omega.com/temperature/Z/pdf/z256-257.pdf";
PImage PDFLink_Icon;
void MakePDFLinkIcon_Button() {
  PDFLink_Icon = loadImage("data/Images/Introduction Screen/PDF_Database_Icon.png");
  if (mouseX <= width * 0.95 - 120 + 50 && mouseX >= width * 0.95 - 120 && mouseY <= height * 6/7 + 50 && mouseY >= height * 6/7 && mousePressed) {
    doCommand("OPENLINK." + PDFLink);
  }
  imageMode(CORNER);
  image(PDFLink_Icon, width * 0.95 - 120, height * 6/7, 50, 50);
}

String HTMLLink = "https://www.teamwavelength.com/info/thermistors.php";
PImage HTMLLink_Icon;
void MakeHTMLLinkIcon_Button() {
  if (mouseX <= width * 0.95 - 10 && mouseX >= width * 0.95 - 60 && mouseY >= height * 6/7 && mouseY <= height * 6/7 + 50 && mousePressed) {
    doCommand("OPENLINK." + HTMLLink);
  }
  HTMLLink_Icon = loadImage("data/Images/Introduction Screen/HTML_Link.png");
  imageMode(CORNER);
  image(HTMLLink_Icon, width * 0.95 - 60, height * 6/7, 50, 50);
}

String Wikipedia_Link = "https://en.wikipedia.org/wiki/Thermistor#Basic_operation";
PImage Wikipedia_Icon;
void MakeWikipediaIcon_Button() {
  if (mouseX >= width * 0.95 && mouseX <= width * 0.95 + 50 && mouseY >= height * 6/7 && mouseY <= height * 6/7 + 50) {
    if (mousePressed) {
      doCommand("OPENLINK." + Wikipedia_Link);
    }
    Wikipedia_Icon = loadImage("data/Images/Introduction Screen/Wikipedia_Icon_unhovered.png");
  } else {
    Wikipedia_Icon = loadImage("data/Images/Introduction Screen/Wikipedia_Icon_hovered.png");
  }
  imageMode(CORNER);
  image(Wikipedia_Icon, width * 0.95, height * 6/7, 50, 50);
}

PImage Default_Calibration_Curve_Settings_hovered_Button;
void Make_Info_Calibration_Curve_Button() {  //THe info button
  if (mouseX <= width/2 + 290/2 + 50/2 + 50/2 && mouseX >=  width/2 + 290/2 + 50/2 - 50/2 && mouseY <= height/2 + 50/2 && mouseY >= height/2 - 50/2) {  
    if (mousePressed) {
    }
    Default_Calibration_Curve_Settings_hovered_Button = loadImage("data/Images/Introduction Screen/Default_Calibration_Curve_Settings_hovered.png");
  } else {
    Default_Calibration_Curve_Settings_hovered_Button = loadImage("data/Images/Introduction Screen/Default_Calibration_Curve_Settings_unhovered.png");
  }
  imageMode(CENTER);
  image(Default_Calibration_Curve_Settings_hovered_Button, width/2 + 290/2 + 50/2, height/2, 50, 50);
}

PImage Default_Calibration_Curve_Button;  //285 BY 50
void Make_Default_Calibration_Curve_Button() {
  if (mouseX <= width/2 + 285/2.0 && mouseX >= width/2 - 285/2.0 && mouseY <= height/2 + 50/2.0 && mouseY >= height/2 - 50/2.0) {
    Default_Calibration_Curve_Button = loadImage("data/Images/Introduction Screen/Default_Calibration_Curve_hovered.png");
    if (mousePressed) {
      doCommand("Screen.Grapher_Screen.Default_Graph");  // ;-> "Grapher Screen"."Default Graph"
    }
  } else {
    Default_Calibration_Curve_Button = loadImage("data/Images/Introduction Screen/Default_Calibration_Curve_unhovered.png");
  }
  imageMode(CENTER);
  image(Default_Calibration_Curve_Button, width/2, height/2);
}
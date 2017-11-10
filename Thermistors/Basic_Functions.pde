//Temperature conversions
//Kelvin <-> Celsius
float k_dc(float temperature_K) {   
  return temperature_K - 273.15;
}
float dc_k(float temperature_C) {
  return temperature_C + 273.15;
}
//Fahrenheit <-> Celsius 
float dc_df(float temperature_C) {
  return ((temperature_C / 5.0) * 9.0 + 32);
}
float df_dc(float temperature_F) {
  return (temperature_F - 32) * 5.0 / 9.0;
}





//Bootup section
void bootupFunction() {
  loadFonts();
  loadVariables();
}

void loadFonts() {
  //Grapher fonts
  graphTitleFont = loadFont("AlBayan-Bold-48.vlw");
  graphAxisLabelFont = loadFont("AmericanTypewriter-Semibold-20.vlw");
  graphGridLabelFont = loadFont("ArialMT-10.vlw");

  //Text fonts for Thermistor Analyzer
  UITextField_TextFont = loadFont("AmericanTypewriter-Semibold-20.vlw");
}
void loadVariables() {
  //Loading the calibration Grapher : Grapher variable
  defautThermistorCalibrationCurve = new Graph(width * 1/13, height * 1/9, width * 18/19, height * 4/5);
  defautThermistorCalibrationCurve.setXAxis(k_dc(298), 100, 25);
  defautThermistorCalibrationCurve.setYAxis(0, 3, 20);
  defautThermistorCalibrationCurve.setTitle("Default Thermistor Calibration Curve");
  defautThermistorCalibrationCurve.xlabel = "Temperature (in ˚C)";
  defautThermistorCalibrationCurve.ylabel = "Resistance (in kΩ)";
  defautThermistorCalibrationCurve.backgroundColor = color(255);
}




void makeEssentialButtons() {
  Make_ExitButton();
  if (!CURRENT_SCREEN.equals("INTRODUCTION SCREEN")  || !CURRENT_VIEW.equals("HOMEPAGE")) {
    Make_HomeButton();
  }
}

PImage homeIcon_button;
void Make_HomeButton() {
  if (mouseX <= 55 && mouseX >= 30 && mouseY <= 25) {
    if (mousePressed) {
      doCommand("SCREEN.INTRODUCTION_SCREEN.HOMEPAGE");
    }
    homeIcon_button = loadImage("data/Images/Basic Icons/Home_Button_hovered.png");
  } else {
    homeIcon_button = loadImage("data/Images/Basic Icons/Home_Button_unhovered.png");
  }
  imageMode(CORNER);
  image(homeIcon_button, 30,0,25,25);
}

PImage closeIcon_button;  //25 BY 25
void Make_ExitButton() {
  if (mouseX <= 25 && mouseY <= 25) {
    if (mousePressed) {
      doCommand("exit");
    }
    closeIcon_button = loadImage("data/Images/Basic Icons/Close_Button_hovered.png");
  } else {
    closeIcon_button = loadImage("data/Images/Basic Icons/Close_Button_unhovered.png");
  }
  imageMode(CORNER);
  image(closeIcon_button, 0, 0, 25, 25);
}
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
  loadThermistorDatabase();
}

void loadThermistorDatabase() {
  println("Loading Database");
    //thermistors.add(new Thermistor_Graph_Database());
    Table database = loadTable("data/Thermistor Database/Thermistor-Database.csv", "header");
    for (TableRow t : database.rows()) {
      println(t.getString(0) + " Found");
      Thermistor row = new Thermistor();  
      row.setNameTo(t.getString(0));
      row.setAlpha(t.getFloat(1));
      row.setR_0(t.getFloat(2));
      row.setT_0(t.getFloat(3));
      row.Band_10uA = t.getFloat(4);
      row.Band_100uA = t.getFloat(5);
      row.ResistanceTolerance = t.getFloat(6);
      if (row.Band_100uA > max_100uA_band) {
        max_100uA_band = row.Band_100uA;
      }
      if (row.Band_10uA > max_10uA_band) {
        max_10uA_band = row.Band_10uA;
      }
      if (row.ResistanceTolerance < min_resistanceTolerance) {
        min_resistanceTolerance = row.ResistanceTolerance;
      }
      thermistors.add(row);
    }
  println("100uA : " + max_100uA_band + ", 10uA : " + max_10uA_band + ", Minimum Tolerance : " + min_resistanceTolerance + " out of " + thermistors.size());
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
  defautThermistorCalibrationCurve.setXAxis(k_dc(297), 100, 25);
  defautThermistorCalibrationCurve.setYAxis(0, 3.2, 20);
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
  image(homeIcon_button, 30, 0, 25, 25);
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
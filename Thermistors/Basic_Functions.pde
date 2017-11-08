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
}
void loadVariables() {
  //Loading the calibration Grapher
  calibrationCurve = new Graph(width * 1/13, height * 1/9, width * 18/19, height * 4/5);
  calibrationCurve.setXAxis(-55, 110, 25);
  calibrationCurve.setYAxis(0, 500, 20);
  calibrationCurve.setTitle("Calibration Curve");
  calibrationCurve.xlabel = "Temperature (in ˚C)";
  calibrationCurve.ylabel = "Resistance (in kΩ)";
  calibrationCurve.backgroundColor = color(255);
}
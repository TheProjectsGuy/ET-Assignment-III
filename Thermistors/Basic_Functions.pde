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

//R = Ro exp[ a (1/T - 1/To) ]


//Defaults section
static class Defaults {  //Defaults and Settings
  static class Point {  //Point class
    static float X = 0;
    static float Y = 0;  //X and Y
    static color pointColor = #00ff00;  //Point Colour
    static float pointDiameter = 2;  //Point Diameter
  }
  static class Thermistor {  //Thermistor class
    static float R_0 = 3000;  //3000 Ohms
    static float T_0 = 298;  //298 K
    static float R_1 = 200;  //R1 = 200 Ohms
    static float T_1 = 373;  //100 degree C, 373 K
    static float alpha = 4013.474827;  //alpha (for thermistor = 4013.474827 K) for the given problem
  }
  static class Graph {
    static float precision = 0.001;
  }
}



//Bootup section
void bootupFunction() {
  loadFonts();
}

void loadFonts() {
  
//Grapher fonts
  graphTitleFont = loadFont("AlBayan-Bold-48.vlw");
  

}
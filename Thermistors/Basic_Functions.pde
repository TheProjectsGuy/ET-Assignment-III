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
}

void loadFonts() {
  
//Grapher fonts
  graphTitleFont = loadFont("AlBayan-Bold-48.vlw");
  graphAxisLabelFont = loadFont("AmericanTypewriter-CondensedLight-48.vlw");

}
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

class Thermistor {  //Thermistor class and function
  float alpha = Defaults.Thermistor.alpha;
  float R_0 = Defaults.Thermistor.R_0;
  float T_0 = Defaults.Thermistor.T_0;
  void setAlpha(float alpha) {
    this.alpha = alpha;
  }
  void setR_0(float resistance) {
    this.R_0 = resistance;
  }
  void setT_0(float temperature_K) {
    this.T_0 = temperature_K;
  }

  Thermistor() {
  }

  Thermistor(float alpha, float R_0, float T_0) {
    this.setAlpha(alpha);
    this.setR_0(R_0);
    this.setT_0(T_0);
  }
  //Calculate Aplha values
  float calculateAlpha(float R_1, float T_1_K) throws MathematicalException {
    try {
      return calculateAlpha(R_1, T_1_K, R_0, T_0);
    } 
    catch (Exception e) {
      throw new MathematicalException("Error : " + e.getMessage());
    }
  }
  float calculateAlpha(float R_1, float T_1_K, float R_0, float T_0_K) throws MathematicalException {
    if (R_1 == R_0 || T_1_K == T_0_K) {
      throw new MathematicalException("Data error : (R,T) : (" + str(R_1) + "," + str(T_1_K) + ") ; (" + str(R_0) + "," + str(T_0_K) + ")");
    }
    if (T_1_K < 0 || T_0_K < 0) {
      throw new MathematicalException("Temperatures " + str(T_1_K) + "K and " + str(T_0_K) + "K are theoretically incorrect");
    }
    try {
      this.alpha = log(R_1/R_0) * (1.0/ (1.0/T_1_K - 1.0/T_0_K) );
    }
    catch (Exception e) {
      throw new MathematicalException("Error : " + e.getMessage());
    }
    return alpha;
  }


  float getResistance(float Temperature_K) {    
    return R_0 * exp(alpha * (1.0/Temperature_K - 1.0/T_0));
  }

  float getTemperature_K(float Resistance) {
    return 1.0/((log(Resistance / R_0) / alpha) + 1.0/T_0);
  }
}


class Graph {
  float maxX = 10;  //Maximum X value
  float maxY = 10;  //Maximum Y value
  float grid_X = 10;  //number of divisions on the X axis  
  float grid_Y = 10;  //number of divisions on the Y axis  //Grid * Scale = Max_Value
  float scale_X = 10;  //scale of the X axis
  float scale_Y = 10;  //scale of the Y axis
  void setScaleX(float newScale_X) {  //New scale for the X axis, keeping the same maxX
    this.scale_X = newScale_X;
    this.grid_X = this.maxX / this.scale_X;
  }
  void setScaleY(float newScale_Y) {  //New scale for the Y axis, keeping the same maxY
    this.scale_Y = newScale_Y;
    this.grid_Y = this.maxY / this.scale_Y;
  }
  void setGrid_X(float newGrid_X) {  //New grid size for the X axis
    this.grid_X = newGrid_X;
    this.scale_X = this.maxX / this.grid_X;
  }
  void setGrid_Y(float newGrid_Y) {  //new grid size for the Y axis
    this.grid_Y = newGrid_Y;
    this.scale_Y = this.maxY / this.grid_Y;
  }

  void setMaxX(float newMaxX) {  //new maxX, keeping the same scale for the X axis
    this.maxX = newMaxX;
    this.grid_X = this.maxX / this.scale_X;
  }
  void setMaxY(float newMaxY) {  //new maxX, keeping the same scale for the Y axis
    this.maxY = newMaxY;
    this.grid_Y = this.maxY / this.scale_Y;
  }

  //On screen specifications
  float screen_minX, screen_maxX;
  float screen_minY, screen_maxY;
  void setScreen_minX(float newValue) {
    this.screen_minX = newValue;
  }
  void setScreen_maxX(float newValue) {
    this.screen_maxX = newValue;
  }
  void setScreen_minY(float newValue) {
    this.screen_minY = newValue;
  }
  void setScreen_maxY(float newValue) {
    this.screen_maxY = newValue;
  }
  void setScreen_midX(float newValue) {
    float w = this.screen_maxX - this.screen_minX;
    this.setScreen_minX(newValue - w/2);
    this.setScreen_maxX(newValue + w/2);
  }
  void setScreen_midY(float newValue) {
    float h = this.screen_maxY - this.screen_minY;
    this.setScreen_minY(newValue - h/2);
    this.setScreen_maxY(newValue + h/2);
  }
  void setCenterTo(Point pointOnScreen) {
    this.setCenterTo(pointOnScreen.X, pointOnScreen.Y);
  }
  void setCenterTo(float newX, float newY) {
    this.setScreen_midX(newX);
    this.setScreen_midY(newY);
  }

  boolean makeBoundaries = true, makeGrid = true, writeTitle = false, writeAxisLabel = false;
  String title = "", xlabel = "", ylabel = "";
  void make() {  //Make graph
    
  }
}
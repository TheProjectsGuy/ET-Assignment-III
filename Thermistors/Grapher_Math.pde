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
  //Graph Constructor
  Graph(float minX, float minY, float maxX, float maxY) {  //Specify the top left and bottom right corner of the graph window
    this.screen_minX = minX;
    this.screen_maxX = maxX;
    this.screen_minY = minY;
    this.screen_maxY = maxY;
  }
  //Mid points
  float getScreen_midX() {
    return (this.screen_minX + this.screen_maxX) / 2;
  }
  float getScreen_midY() {
    return (this.screen_minY + this.screen_maxY) / 2;
  }
  Point getScreen_mid() {
    return new Point(this.getScreen_midX(), this.getScreen_midY());
  }
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
  void setScreen_midX(float newValue) {  //Preserve width and change the X coordinate of center
    float w = this.screen_maxX - this.screen_minX;
    this.setScreen_minX(newValue - w/2);
    this.setScreen_maxX(newValue + w/2);
  }
  void setScreen_midY(float newValue) { //Preserve height and change the Y coordinate of center
    float h = this.screen_maxY - this.screen_minY;
    this.setScreen_minY(newValue - h/2);
    this.setScreen_maxY(newValue + h/2);
  }
  void setCenterTo(Point pointOnScreen) {
    this.setCenterTo(pointOnScreen.X, pointOnScreen.Y);
  }
  void setCenterTo(float newX, float newY) {  //Change the center of graph view
    this.setScreen_midX(newX);
    this.setScreen_midY(newY);
  }
  float map_X2screen(float X_value) {
    return map(X_value, 0, maxX, this.screen_minX, this.screen_maxX);
  }

  boolean makeBoundaries = true, makeGrid = true, writeTitle = false, writeAxisLabel = false, writeGrid_Xaxis = true, writeGrid_Yaxis = true;
  String title = "", xlabel = "", ylabel = "";
  color backgroundColor = #ffffff;
  void setBackgroundColor(color newColor) {
    this.backgroundColor = newColor;
  }
  void setTitle(String newTitle) {
    this.title = newTitle;
  }
  color boundaryColor = color(255, 0, 0);
  float boundaryThickness = 1.2;
  //Make graph
  void make() {  
    //Make the background
    strokeWeight(0.15);
    fill(backgroundColor);
    stroke(0, 255, 0);
    rect(screen_minX, screen_minY, screen_maxX, screen_maxY);  
    if (this.makeBoundaries) {
      //Make the boundaries
      rectMode(CORNERS);
      stroke(boundaryColor);
      strokeWeight(boundaryThickness);
      rect(screen_minX, screen_minY, screen_maxX, screen_maxY);
    }
    if (this.writeTitle) {
      //Write the title
      textSize(18);
      textFont(graphTitleFont);
      textAlign(CENTER, BOTTOM);
      text(title, this.getScreen_midX(), this.screen_minY);
    }
    if (this.makeGrid) {
      //Make the grid on the axis
      for (float i = 1; i < this.grid_X; i ++) {
        line(this.screen_minX + i * scale_X, this.screen_minY, this.screen_minX + i * scale_X, this.screen_maxY);
      }
    }
  }
}

PFont graphTitleFont;
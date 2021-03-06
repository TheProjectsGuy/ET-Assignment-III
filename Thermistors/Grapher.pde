//CURRENT_SCREEN = GRAPHER SCREEN

//CURRENT_SCREEN = GRAPHER SCREEN
Thermistor_Graph default_Thermistor = new Thermistor_Graph(new Thermistor(), color(0, 0, 0));

void Grapher_Screen_Handler() {
  switch(CURRENT_VIEW) {
  case "DEFAULT GRAPH":
    MakeDefaultGraph();
    break;
  case "DEFAULT GRAPH PLOTTER":  //Shouldn't go out of this... Must be accessed from within this file only
    PlotPointsOnTheDefaultsGraph();
    break;
  case "DEFAULT GRAPH INFO":
    MakeDefaultThermistorInfo();
    break;
  }
}



void MakeDefaultThermistorInfo() {
  background(255);
  
}

void MakeDefaultGraph() {
  background(255);
  defautThermistorCalibrationCurve.make();
  if (!defautThermistorCalibrationCurve.mouseModeTurnedOn) {
    CURRENT_VIEW = "DEFAULT GRAPH PLOTTER";
  } else {
    PlotPointsOnTheDefaultsGraph();
    defautThermistorCalibrationCurve.makeMouseTracker(default_Thermistor);
  }
}

void PlotPointsOnTheDefaultsGraph() {
  defautThermistorCalibrationCurve.drawGraph(default_Thermistor);
  if (defautThermistorCalibrationCurve.mouseModeTurnedOn) {
    CURRENT_VIEW = "DEFAULT GRAPH";
  }
}

void Grapher_Screen_keyPressed() {
  if (key == 's' || key == 'S') {
    defautThermistorCalibrationCurve.turnOnMouseMode();
  } else if (key == 'h' || key == 'H') {
    defautThermistorCalibrationCurve.turnOffMouseMode();
  }
}





Graph defautThermistorCalibrationCurve;

// Grapher class
class Graph {  //X axis temperature and Y axis resistance (X axis goes from (0 to maxX)) (Y axis goes from (0 to maxY))
  float maxX = 10;  //Maximum X value : Temperatures
  float minX = 7;
  float maxY = 10;  //Maximum Y value : Resistances
  float minY = 0;

  float grid_X = 20;  //number of divisions on the X axis  
  float grid_Y = 10;  //number of divisions on the Y axis  //Grid * Scale = Max_Value - Min_Value
  float getScaleX() {
    return (maxX - minX) / grid_X;
  }
  float getScaleY() {
    return (maxY - minY) / grid_Y;
  }
  void setXAxis(float minX, float maxX, float grid) {
    this.minX = minX;
    this.maxX = maxX;
    this.grid_X = grid;
  }
  void setYAxis(float minY, float maxY, float grid) {
    this.minY = minY;
    this.maxY = maxY;
    this.grid_Y = grid;
  }

  //On screen specifications / on screen properties
  float screen_minX, screen_maxX;
  float screen_minY, screen_maxY;
  //Graph Constructor
  void setCorners(float minX, float minY, float maxX, float maxY) {
    this.screen_minX = minX;
    this.screen_maxX = maxX;
    this.screen_minY = minY;
    this.screen_maxY = maxY;
  }
  Graph(float minX, float minY, float maxX, float maxY) {  //Specify the top left and bottom right corner of the graph window
    this.setCorners(minX, minY, maxX, maxY);
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
  //Set the middle of grapher
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

  float map_X2screen(float X_value) {  //Map an X value to the screen X value
    return constrain(map(X_value, this.minX, this.maxX, this.screen_minX, this.screen_maxX), screen_minX, screen_maxX);
  }
  float map_Y2screen(float Y_value) {  //Map a Y value to the screen Y value
    return constrain(map(Y_value, this.minY, this.maxY, this.screen_maxY, this.screen_minY), screen_minY, screen_maxY);    //The Y axis is flipped here
  }
  float map_screen2X(float screen_Xvalue) {
    return constrain(map(screen_Xvalue, this.screen_minX, this.screen_maxX, this.minX, this.maxX), this.minX, this.maxX);
  }
  float map_screen2Y(float screen_Yvalue) {
    return constrain(map(screen_Yvalue, this.screen_maxY, this.screen_minY, this.minY, this.maxY), this.minY, this.maxY);
  }
  Point map_graph2screen(float X, float Y) {  //Map ax (X,Y) pair to the screen point
    return new Point(map_X2screen(X), map_Y2screen(Y));
  }

  //Grapher properties
  boolean makeBoundaries = true, makeGrid = true, writeTitle = true, writeAxisLabel = true, writeGrid = true;
  String title = "Title", xlabel = "X axis", ylabel = "Y axis";
  color backgroundColor = #ffffff;
  void setBackgroundColor(color newColor) {
    this.backgroundColor = newColor;
  }
  void setTitle(String newTitle) {
    this.title = newTitle;
  }
  color boundaryColor = color(255, 0, 0);
  color gridColor = color(0, 255, 0);
  float boundaryThickness = 1.2;
  //Make graph
  void makeEssentials() {  
    //Make the background
    strokeWeight(0.15);
    fill(backgroundColor);
    stroke(0, 255, 0);
    rect(screen_minX, screen_minY, screen_maxX, screen_maxY);  
    if (this.makeBoundaries) {
      //Make the boundaries
      rectMode(CORNERS);
      stroke(boundaryColor);
      noFill();
      strokeWeight(boundaryThickness);
      rect(screen_minX, screen_minY, screen_maxX, screen_maxY);
    }
    if (this.writeTitle) {
      //Write the title
      textSize(18);
      fill(0, 0, 0);
      textFont(graphTitleFont);
      textAlign(CENTER, BOTTOM);
      text(title, this.getScreen_midX(), this.screen_minY);
    }
    if (this.makeGrid) {
      //Make the grid on the axis
      stroke(gridColor);
      strokeWeight(0.2);
      for (float i = this.minX; i < this.maxX; i+=this.getScaleX()) {  //X axis lines
        line(map_X2screen(i), map_Y2screen(this.minY), map_X2screen(i), map_Y2screen(this.maxY));
      }
      for (float j = this.minY; j < this.maxY; j+=this.getScaleY()) {  //Y axis lines
        line(map_X2screen(this.minX), map_Y2screen(j), map_X2screen(this.maxX), map_Y2screen(j));
      }
    }
    if (this.writeAxisLabel) {
      textAlign(CENTER, TOP);
      fill(0, 0, 0);
      textFont(graphAxisLabelFont, 30);
      text(xlabel, getScreen_midX(), screen_maxY + 30);
      //Write Y label vertically
      textAlign(CENTER, BOTTOM);
      pushMatrix();
      translate(screen_minX - 50, getScreen_midY());
      rotate(-HALF_PI);
      text(ylabel, 0, 0);
      popMatrix();
    }
    if (this.writeGrid) {
      textFont(graphGridLabelFont);
      textSize(15);
      fill(0);
      textAlign(CENTER, TOP);
      for (float i = minX; i <= maxX; i+= getScaleX()) {
        text(String.format("%.1f", i), map_X2screen(i), screen_maxY + 10);
      }
      textAlign(RIGHT, CENTER);
      for (float j = minY; j <= maxY; j+= getScaleY()) {
        text(String.format("%.1f", j), screen_minX - 5, map_Y2screen(j));
      }
    }
  }
  void make() {  //Make the frame
    this.makeEssentials();  //Do the basic stuff
  }
  //Make thermistor characteristic curves
  void make(ArrayList<Thermistor_Graph> thermistors) {  //Plot the thermistor curves (Thermistors in an array list)
    make();  //First make the graph frame
    for (Thermistor_Graph t : thermistors) {  //Plot points
      this.drawGraph(t);
    }
  }
  void drawGraph(Thermistor_Graph tg) {  //Plot a single thermistor graph
    stroke(tg.graphColor);
    for (float i = minX; i <= maxX; i+= Defaults.Graph.precision) {
      point(map_X2screen(i), map_Y2screen(tg.getResistance(i)/1000.0));  //Degrees Celcius Vs KOhm
    }
  }
  void drawGraph(Thermistor thermistorElement) {  
    drawGraph(thermistorElement, color(255, 0, 0));
  }
  void drawGraph(Thermistor thermistorElement, color graphColor) {
    drawGraph(new Thermistor_Graph(thermistorElement, graphColor));
  }

  boolean mouseModeTurnedOn = false;
  void turnOnMouseMode() {
    mouseModeTurnedOn = true;
  }
  void turnOffMouseMode() {
    mouseModeTurnedOn = false;
  }
  void makeMouseTracker(Thermistor_Graph graph) {
    float mouse_X = this.map_screen2X(mouseX), mouse_Y = this.map_screen2Y(mouseY);
    //X axis L follower
    stroke(255, 0, 0);
    strokeWeight(1.2);
    line(map_X2screen(mouse_X), map_Y2screen(graph.getResistance(mouse_X)/1000), map_X2screen(mouse_X), map_Y2screen(this.minY));  //The verticle line : resistance in kOhm
    textAlign(LEFT, BOTTOM);
    textFont(graphGridLabelFont, 10);
    fill(200, 0, 0);
    text(mouse_X + "˚C", map_X2screen(mouse_X) + 2, map_Y2screen(this.minY));  //The text on X axis
    line(map_X2screen(this.minX), map_Y2screen(graph.getResistance(mouse_X)/1000), map_X2screen(mouse_X), map_Y2screen(graph.getResistance(mouse_X)/1000));  //The horizontal line
    text(graph.getResistance(mouse_X) + "Ω", map_X2screen(this.minX), map_Y2screen(graph.getResistance(mouse_X)/1000));   //The text on Y axis
    //Y axis L follower
    stroke(0, 0, 255);
    line(map_X2screen(this.minX), map_Y2screen(mouse_Y), map_X2screen(graph.getTemperature(mouse_Y * 1000)), map_Y2screen(mouse_Y));  //The horizontal line
    fill(0, 0, 200);
    text(mouse_Y * 1000 + "Ω", map_X2screen(this.minX), map_Y2screen(mouse_Y));  //The text on the Y axis
    line(map_X2screen(graph.getTemperature(mouse_Y * 1000)), map_Y2screen(mouse_Y), map_X2screen(graph.getTemperature(mouse_Y * 1000)), map_Y2screen(this.minY));  //The verticle line : resistance in kOhm
    text(graph.getTemperature(mouse_Y * 1000) + "˚C", map_X2screen(graph.getTemperature(mouse_Y * 1000)) + 2, map_Y2screen(this.minY));  //The text on the X axis
  }
}

PFont graphTitleFont, graphAxisLabelFont, graphGridLabelFont;
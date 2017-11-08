Graph calibrationCurve;
//Testing variables
Thermistor t = new Thermistor();
Thermistor_Graph tt = new Thermistor_Graph(t, color(0, 0, 255));

void setup() {
  fullScreen();
  bootupFunction();
}



void draw() {
  background(255);
  calibrationCurve.make();
  calibrationCurve.drawGraph(tt);  //Draw the curve
}
Graph calibrationCurve;

void setup() {
  fullScreen();
  bootupFunction();
  calibrationCurve = new Graph(width * 1/4, height * 1/4, width * 3/4, height * 3/4);
  calibrationCurve.setGrid_X(2);
}



void draw() {
  background(127);
  calibrationCurve.make();
}
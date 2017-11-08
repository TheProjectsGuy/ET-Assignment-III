Graph calibrationCurve;

void setup() {
  fullScreen();
  bootupFunction();
  calibrationCurve = new Graph(width * 1/3, height * 1/2, width * 2/3, height * 3/4);
  calibrationCurve.setGrid_X(20);
}



void draw() {
  background(127);
  calibrationCurve.make();
}
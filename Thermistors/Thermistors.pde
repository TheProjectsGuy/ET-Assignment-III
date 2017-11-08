Graph calibrationCurve;

void setup() {
  fullScreen();
  bootupFunction();
  calibrationCurve = new Graph(width * 1/3, height * 1/3, width * 2/3, height * 2/3);
  calibrationCurve.setTitle("Hello World");
  calibrationCurve.
}



void draw() {
  background(0);
  calibrationCurve.make();
}
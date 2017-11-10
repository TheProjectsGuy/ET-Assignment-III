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
    static float alpha = 4013.474827;  //alpha (for thermistor = 4013.474827 K) for the given problem - calculated
    static String Name = "44005";
  }
  static class Graph {
    static float precision = 0.01;
    static float minTemperature_default_C = -55 + 273.15;
    static float maxTemperature_default_C = 114 + 273.15;
  }
}



static class Point { //A Point on screen
  float X = 0, Y = 0;
  void setX(float newValue) {
    this.X = newValue;
  }
  void setY(float newValue) {
    this.Y = newValue;
  }
  Point() {
    this.setX(Defaults.Point.X);
    this.setY(Defaults.Point.Y);
  }
  Point(float X, float Y) {
    this.setX(X);
    this.setY(Y);
  }
  static float distanceBW(Point P1, Point P2) {  //Distance between two points
    return pow(pow(horizontalDistanceBW(P2, P1), 2) + pow(verticalDistanceBW(P2, P1), 2), 0.5);  //sqrt(a^2 + b^2)
  }
  static float horizontalDistanceBW(Point P2, Point P1) {
    return P2.X - P1.X;
  }
  static float verticalDistanceBW(Point P2, Point P1) {
    return P2.Y - P1.Y;
  }
}
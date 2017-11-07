static class Point { // Point on screen
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
    return pow(pow(horizontalDistanceBW(P2,P1), 2) + pow(verticalDistanceBW(P2,P1), 2), 0.5);  //sqrt(a^2 + b^2)
  }
  static float horizontalDistanceBW(Point P2, Point P1) {
    return P2.X - P1.X;
  }
  static float verticalDistanceBW(Point P2, Point P1) {
    return P2.Y - P1.Y;
  }
  
}

public class MathematicalException extends Exception {
  String description;
  MathematicalException(String Message) {
    this.description = Message;
  }
  String getMessage() {
    return description;
  }
}
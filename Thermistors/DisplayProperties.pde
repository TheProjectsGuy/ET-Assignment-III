static class Point { // Point on screen
  float X, Y;
  void setX(float newValue) {
    this.X = newValue;
  }
  void setY(float newValue) {
    this.Y = newValue;
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
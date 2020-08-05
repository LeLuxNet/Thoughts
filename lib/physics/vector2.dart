class Vector2 {
  double x;
  double y;

  Vector2(this.x, this.y);

  @override
  String toString() {
    return x.toStringAsFixed(2) + " / " + y.toStringAsFixed(2);
  }
}

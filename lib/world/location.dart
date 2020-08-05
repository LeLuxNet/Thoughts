class Location {
  double x;
  double y;

  Location(this.x, this.y);

  int get blockX {
    return x.round();
  }

  int get blockY {
    return y.floor();
  }

  Location clone() {
    return Location(x, y);
  }

  @override
  String toString() {
    return x.toStringAsFixed(2) + " / " + y.toStringAsFixed(2);
  }
}

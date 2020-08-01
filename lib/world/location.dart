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
}

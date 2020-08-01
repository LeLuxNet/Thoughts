import 'dart:ui';

import 'package:flame/position.dart';

class Renderable {
  final double height;
  final double width;

  Renderable(this.height, this.width);

  render(Canvas c, Position pos) {
    c.save();
    c.translate(width / 2, height / 2);
    renderCentered(c, pos);
    c.restore();
  }

  renderCentered(Canvas c, Position pos) {
    c.save();
    c.translate(-width / 2, -height / 2);
    render(c, pos);
    c.restore();
  }
}

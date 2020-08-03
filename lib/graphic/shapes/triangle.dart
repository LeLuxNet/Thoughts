import 'dart:math';
import 'dart:ui';

import 'package:flame/position.dart';
import 'package:thoughts/graphic/renderable.dart';

class Triangle extends Renderable {
  Paint paint;
  Path _path;

  Triangle(double height, double width, this.paint, {bool invert: false})
      : super(height, width) {
    _path = Path();
    if (invert) {
      _path.moveTo(0, 0);
      _path.lineTo(width, 0);
      _path.lineTo(width / 2, height);
    } else {
      _path.moveTo(width / 2, 0);
      _path.lineTo(0, height);
      _path.lineTo(width, height);
    }
    _path.close();
  }

  Triangle.eq(length, paint, {bool invert: false})
      : this(sqrt(3) / 2 * length, length, paint, invert: invert);

  @override
  render(Canvas c, Position pos) {
    c.save();
    c.translate(pos.x, pos.y);
    c.drawPath(_path, paint);
    c.restore();
  }
}

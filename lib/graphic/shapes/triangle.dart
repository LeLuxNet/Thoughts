import 'dart:math';
import 'dart:ui';

import 'package:flame/position.dart';
import 'package:thoughts/graphic/colors.dart';
import 'package:thoughts/graphic/shape.dart';

class Triangle extends Shape {
  Path _path;

  Triangle(double height, double width, Colors color, {bool invert: false})
      : super(height, width, color) {
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

  Triangle.eq(double length, Colors color, {bool invert: false})
      : this(sqrt(3) / 2 * length, length, color, invert: invert);

  @override
  render(Canvas c, Position pos) {
    c.save();
    c.translate(pos.x, pos.y);
    c.drawPath(_path, paint);
    c.restore();
  }
}

import 'dart:math';
import 'dart:ui';

import 'package:flame/position.dart';
import 'package:thoughts/graphic/renderable.dart';

class Triangle extends Renderable {
  Paint paint;
  Path _path;

  Triangle(double height, double width, this.paint) : super(height, width) {
    _path = Path();
    _path.moveTo(width / 2, 0);
    _path.lineTo(0, height);
    _path.lineTo(width, height);
    _path.close();
  }
  
  Triangle.eq(length, paint): this(sqrt(3) / 2 * length, length, paint);

  @override
  render(Canvas c, Position pos) {
    c.save();
    c.translate(pos.x, pos.y);
    c.drawPath(_path, paint);
    c.restore();
  }
}

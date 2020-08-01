import 'dart:ui';

import 'package:flame/position.dart';
import 'package:thoughts/graphic/renderable.dart';

class Rectangle extends Renderable {
  Paint paint;

  Rectangle(double height, double width, this.paint) : super(height, width);

  Rectangle.square(double length, paint) : this(length, length, paint);

  @override
  render(Canvas c, Position pos) {
    c.drawRect(Rect.fromLTWH(pos.x, pos.y, width, height), paint);
  }
}

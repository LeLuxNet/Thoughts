import 'dart:ui';

import 'package:flame/position.dart';
import 'package:thoughts/graphic/colors.dart';
import 'package:thoughts/graphic/shape.dart';

class Rectangle extends Shape {
  Rectangle(double height, double width, Colors paint)
      : super(height, width, paint);

  Rectangle.square(double length, Colors color) : this(length, length, color);

  @override
  render(Canvas c, Position pos) {
    c.drawRect(Rect.fromLTWH(pos.x, pos.y, width, height), paint);
  }
}

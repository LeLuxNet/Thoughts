import 'dart:ui';

import 'package:flame/position.dart';
import 'package:thoughts/graphic/colors.dart';
import 'package:thoughts/graphic/shape.dart';

class Circle extends Shape {
  Circle(double length, Colors color) : super(length, length, color);

  @override
  renderCentered(Canvas c, Position pos) {
    c.drawCircle(pos.toOffset(), height / 2, paint);
  }
}

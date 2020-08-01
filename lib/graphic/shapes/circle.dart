import 'dart:ui';

import 'package:flame/position.dart';
import 'package:thoughts/graphic/renderable.dart';

class Circle extends Renderable {
  Paint paint;

  Circle(double length, this.paint) : super(length, length);

  @override
  renderCentered(Canvas c, Position pos) {
    c.drawCircle(pos.toOffset(), height / 2, paint);
  }
}

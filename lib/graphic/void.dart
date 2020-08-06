import 'dart:ui';

import 'package:flame/position.dart';
import 'package:thoughts/graphic/renderable.dart';

class Void extends Renderable {
  static Void VOID = Void();

  Void() : super(0, 0);

  @override
  render(Canvas c, Position pos) {}

  @override
  renderCentered(Canvas c, Position pos) {}
}

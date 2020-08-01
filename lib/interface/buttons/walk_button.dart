import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/position.dart';
import 'package:flutter/gestures.dart';
import 'package:thoughts/graphic/colors.dart';
import 'package:thoughts/graphic/shapes/rectangle.dart';
import 'package:thoughts/physics/object.dart';

class WalkButton extends PositionComponent with Tapable {
  PhysicsObject object;
  int direction;

  static const WALK_VELOCITY = 10;

  WalkButton(this.object, this.direction);

  @override
  void render(Canvas c) {
    c.drawRect(toRect(), Colors.paint(Colors.WHITE));
  }

  @override
  void onTapDown(TapDownDetails details) {
    object.velocity.x += direction * WALK_VELOCITY;
  }

  @override
  void onTapUp(TapUpDetails details) {
    object.velocity.x -= direction * WALK_VELOCITY;
  }
}

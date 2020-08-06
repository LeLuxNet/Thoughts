import 'dart:math';

import 'package:thoughts/graphic/colors.dart';
import 'package:thoughts/physics/object.dart';
import 'package:thoughts/world/location.dart';

enum Direction { left, right }

class Player extends PhysicsObject {
  static const double WALK_VELOCITY = 5;
  static const double JUMP_VELOCITY = 5.5;

  final random = Random();

  int jumped = 0;
  Direction running;

  int hearts = 3;
  Location checkpointLoc;
  GravitySide checkpointSide;

  Colors bodyColor;

  Player(Location loc, GravitySide gravitySide)
      : super(2, 1, loc, gravitySide) {
    checkpointLoc = loc.clone();
    checkpointSide = gravitySide;

    switchBodyColor();
  }

  @override
  void update(double t) {
    super.update(t);
    if (grounded()) {
      jumped = 0;
    }
    if (running != null) {
      velocity.x = running == Direction.right ? WALK_VELOCITY : -WALK_VELOCITY;
    }
  }

  void jump() {
    if (running != null) {
      return;
    }
    if (jumped == 0) {
      velocity.y -= JUMP_VELOCITY * gravitySide.forceMult;
    } else if (jumped == 1) {
      toggleGravity();
    }
    jumped += 1;
  }

  void run(bool dir) {
    if (running != null) {
      return;
    }
    running = dir ? Direction.right : Direction.left;
  }

  void brake() {
    running = null;
  }

  void toggleGravity() {
    gravitySide =
        gravitySide == GravitySide.top ? GravitySide.bottom : GravitySide.top;
  }

  void damage() {
    hearts--;
    running = null;

    velocity.x = 0;
    velocity.y = 0;

    loc = checkpointLoc.clone();
    gravitySide = checkpointSide;

    switchBodyColor();
  }

  void switchBodyColor() {
    var oldColor = bodyColor;
    while (oldColor == bodyColor) {
      bodyColor = Colors.PLAYER_BODY[random.nextInt(Colors.PLAYER_BODY.length)];
    }
  }
}

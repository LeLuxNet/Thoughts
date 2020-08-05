import 'package:thoughts/physics/object.dart';
import 'package:thoughts/world/location.dart';

enum Direction { left, right }

class Player extends PhysicsObject {
  static const double WALK_VELOCITY = 5;

  int jumped = 0;
  Direction running;

  int hearts = 3;
  Location checkpointLoc;
  GravitySide checkpointSide;

  Player(Location loc, GravitySide gravitySide)
      : super(2, 1, loc, gravitySide) {
    checkpointLoc = loc;
    checkpointSide = gravitySide;
  }

  @override
  void update(double t) {
    super.update(t);
    if (grounded()) {
      jumped = 0;
      checkpointLoc = loc.clone();
      checkpointSide = gravitySide;
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
      velocity.y -= 5.0 * gravitySide.forceMult;
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

    loc = checkpointLoc;
    gravitySide = checkpointSide;
  }
}

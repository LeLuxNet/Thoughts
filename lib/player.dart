import 'package:thoughts/physics/object.dart';
import 'package:thoughts/world/location.dart';

class Player extends PhysicsObject {
  static const WALK_VELOCITY = 10;

  int jumped = 0;
  bool running = false;

  int hearts = 3;
  Location lastCheckpoint;

  Player(Location loc, GravitySide gravitySide) : super(2, 1, loc, gravitySide);

  @override
  void update(double t) {
    super.update(t);
    if (grounded()) {
      jumped = 0;
      lastCheckpoint = loc.clone();
    }
  }

  void jump() {
    if (running) {
      return;
    }
    if (jumped == 0) {
      velocity.y -= 5.0 * gravitySide.forceMult;
    } else if (jumped == 1) {
      toggleGravity();
    }
    jumped += 1;
  }

  void run(bool toRight) {
    if (running) {
      return;
    }
    running = true;
    if (toRight) {
      velocity.x += WALK_VELOCITY;
    } else {
      velocity.x -= WALK_VELOCITY;
    }
  }

  void brake() {
    running = false;
    velocity.x = 0;
  }

  void toggleGravity() {
    gravitySide =
        gravitySide == GravitySide.top ? GravitySide.bottom : GravitySide.top;
  }

  void damage() {
    hearts--;
    loc = lastCheckpoint;
  }
}

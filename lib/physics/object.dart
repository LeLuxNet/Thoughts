import 'package:thoughts/physics/vector2.dart';
import 'package:thoughts/world/block.dart';
import 'package:thoughts/world/location.dart';
import 'package:thoughts/world/world.dart';

class GravitySide {
  static const top = GravitySide(1);
  static const bottom = GravitySide(-1);

  final int forceMult;

  const GravitySide(this.forceMult);
}

enum Axis { x, y }

class PhysicsObject {
  GravitySide gravitySide;
  Vector2 velocity = Vector2(0, 0);
  Location loc;

  int height;
  int width;

  bool grounded = false;

  static const GRAVITY = 10;

  static const AIR_FRICTION = 0.95;
  static const GROUND_FRICTION = 0.6;

  static const MOVEMENT_STEP = 0.01;

  PhysicsObject(this.height, this.width, this.loc, this.gravitySide) {
    World.instance.physicsObjects.add(this);
  }

  double get topY {
    return loc.y + height / 2;
  }

  double get bottomY {
    return loc.y - height / 2;
  }

  double get leftX {
    return loc.x - width / 2;
  }

  double get rightX {
    return loc.x + width / 2;
  }

  double get frontY {
    return loc.y + gravitySide.forceMult * height / 2;
  }

  int get nextY {
    return (frontY + gravitySide.forceMult * 0.5).round();
  }

  List<int> get touchingX {
    List<int> touching = [];
    for (var i = leftX.round(); i <= rightX.round(); i++) {
      touching.add(i);
    }
    return touching;
  }

  List<int> get touchingY {
    List<int> touching = [];
    for (var i = bottomY.round(); i <= topY.round(); i++) {
      touching.add(i);
    }
    return touching;
  }

  void update(double t) {
    _move(t);

    Vector2 delta = Vector2(0, 0);

    if (grounded) {
      velocity.x *= GROUND_FRICTION;
    } else {
      velocity.x *= AIR_FRICTION;
      if (gravitySide != null) {
        delta.y += GRAVITY * gravitySide.forceMult * t;
      }
    }

    velocity.x += delta.x;
    velocity.y += delta.y;
  }

  void _move(double t) {
    grounded = false;
    var oldLoc = loc;

    var velX = velocity.x * t;
    var velY = velocity.y * t;

    while (velX != 0 || velY != 0) {
      var dirX = velX > 0 ? 1 : -1;
      var dirY = velY > 0 ? 1 : -1;

      var oldX = loc.x;
      if (velX * dirX > MOVEMENT_STEP) {
        loc.x += MOVEMENT_STEP * dirX;
        velX -= MOVEMENT_STEP * dirX;
      } else {
        loc.x += velX;
        velX = 0;
      }
      var block = firstCollision();
      if (!identical(oldLoc, loc)) {
        return;
      }
      if (block != null) {
        velX = 0;
        loc.x = oldX;
        velocity.x = 0;
      }

      var oldY = loc.y;
      if (velY * dirY > MOVEMENT_STEP) {
        loc.y += MOVEMENT_STEP * dirY;
        velY -= MOVEMENT_STEP * dirY;
      } else {
        loc.y += velY;
        velY = 0;
      }
      block = firstCollision();
      if (!identical(oldLoc, loc)) {
        return;
      }
      if (block != null) {
        velY = 0;
        loc.y = oldY;
        velocity.y = 0;
        if (gravitySide.forceMult == dirY) {
          grounded = true;
        }
      }
    }
  }

  bool collidingWith(Block block) {
    return block.y - 0.5 <= topY &&
        block.y + 0.5 >= bottomY &&
        block.x + 0.5 >= leftX &&
        block.x - 0.5 <= rightX;
  }

  Block firstCollision() {
    for (var y in touchingY) {
      for (var x in touchingX) {
        var block = World.instance.getBlock(x, y);
        if (block != null) {
          block.collide(this);
          if (block.solid) {
            return block;
          }
        }
      }
    }
    return null;
  }
}

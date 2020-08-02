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

  static const GRAVITY = 10;

  PhysicsObject(this.height, this.width, this.loc, this.gravitySide) {
    World.instance.physicsObjects.add(this);
  }

  double get topY {
    return loc.y + height / 2;
  }

  double get bottomY {
    return loc.y - height / 2;
  }

  double get frontY {
    return loc.y + gravitySide.forceMult * height / 2;
  }

  int get nextY {
    return (frontY + gravitySide.forceMult * 0.5).round();
  }

  void update(double t) {
    _move(t);

    Vector2 delta = Vector2(0, 0);

    if (gravitySide != null && !grounded()) {
      delta.y += GRAVITY * gravitySide.forceMult * t;
    }

    velocity.x += delta.x;
    velocity.y += delta.y;
  }

  void _move(double t) {
    var velX = velocity.x * t;
    var velY = velocity.y * t;

    loc.x += velX;

    loc.y = _collisionY(velY, velY > 0 ? 1 : -1);
  }

  double _collisionY(double delta, int direction) {
    var nextD = loc.y + direction * (height / 2 + 0.5);
    int next = delta > 0 ? nextD.floor() : nextD.ceil();
    var to = next + delta;
    for (int cord = next;
        delta > 0 ? cord <= to : cord >= to;
        cord += direction) {
      var block = World.instance.getBlock(loc.blockX, cord);
      if (block != null) {
        collided(block, Axis.y);
        return cord - direction * (height / 2 + 0.5);
      }
    }
    return loc.y + delta;
  }

  void collided(Block block, Axis axis) {
    if (axis == Axis.y) {
      velocity.y = 0;
    } else {
      velocity.x = 0;
    }
  }

  bool grounded() {
    return nextY == frontY + gravitySide.forceMult * 0.5 &&
        World.instance.getBlock(loc.blockX, nextY) != null;
  }
}
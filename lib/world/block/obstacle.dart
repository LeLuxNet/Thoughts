import 'package:thoughts/graphic/colors.dart';
import 'package:thoughts/graphic/renderable.dart';
import 'package:thoughts/graphic/shapes/triangle.dart';
import 'package:thoughts/physics/object.dart';
import 'package:thoughts/player.dart';
import 'package:thoughts/world/block/block.dart';

class Obstacle extends Block {
  bool invert;

  Obstacle(x, y, this.invert) : super(x, y) {
    solid = false;
  }

  Renderable draw(double size) {
    return Triangle(size, size, Colors.RED, invert: this.invert);
  }

  @override
  void collide(PhysicsObject object) {
    if (isColliding(object)) {
      if (object is Player) {
        object.damage();
      }
    }
  }

  bool isColliding(PhysicsObject object) {
    if (object.rightX < x && object.leftX > x) {
      return false;
    }

    double sideX = 2;
    if (object.leftX < x && object.rightX > x) {
      sideX = 0; // Middle
    } else if (object.loc.x < x) {
      sideX *= x - object.rightX; // Left
    } else {
      sideX *= object.leftX - x; // Right
    }
    sideX = 1 - sideX;

    print(sideX);
    // assert(sideX >= 0 && sideX <= 1);

    return object.gravitySide == GravitySide.bottom
        ? y + sideX > object.frontY
        : y + sideX < object.frontY;
  }
}

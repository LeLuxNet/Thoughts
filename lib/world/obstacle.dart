import 'package:thoughts/graphic/colors.dart';
import 'package:thoughts/graphic/renderable.dart';
import 'package:thoughts/graphic/shapes/triangle.dart';
import 'package:thoughts/physics/object.dart';
import 'package:thoughts/player.dart';
import 'package:thoughts/world/block.dart';

class Obstacle extends Block {
  bool invert;

  Obstacle(x, y, this.invert) : super(x, y) {
    solid = false;
  }

  Renderable draw(double size) {
    return Triangle(size, size, Colors.RED, invert: this.invert);
  }

  @override
  bool collide(PhysicsObject object) {
    if (object is Player) {
      object.damage();
      return true;
    }
    return false;
  }
}

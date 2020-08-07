import 'package:thoughts/graphic/colors.dart';
import 'package:thoughts/graphic/renderable.dart';
import 'package:thoughts/graphic/shapes/rectangle.dart';
import 'package:thoughts/physics/object.dart';
import 'package:thoughts/world/location.dart';

class Block {
  int x;
  int y;

  bool solid;

  Block(this.x, this.y) {
    solid = true;
  }

  Renderable draw(double size) {
    return Rectangle.square(size, Colors.BLOCK_GRAY);
  }

  void collide(PhysicsObject object) {}
}

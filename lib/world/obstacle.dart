import 'package:thoughts/graphic/colors.dart';
import 'package:thoughts/graphic/renderable.dart';
import 'package:thoughts/graphic/shapes/triangle.dart';
import 'package:thoughts/world/block.dart';

class Obstacle extends Block {
  bool invert;
  Obstacle(x, y, invert) : super(x, y);

  Renderable draw(double size) {
    return Triangle(size, size, Colors.RED.paint, invert: this.invert);
  }
}

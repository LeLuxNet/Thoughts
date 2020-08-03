import 'package:thoughts/graphic/colors.dart';
import 'package:thoughts/graphic/renderable.dart';
import 'package:thoughts/graphic/shapes/rectangle.dart';

class Block {
  int x;
  int y;

  Block(this.x, this.y);

  Renderable draw(double size) {
    return Rectangle.square(size, Colors.BLOCK_GRAY.paint);
  }
}

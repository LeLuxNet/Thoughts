import 'dart:ui';

import 'package:thoughts/graphic/colors.dart';
import 'package:thoughts/graphic/renderable.dart';

class Shape extends Renderable {
  Paint paint;

  Shape(height, width, Colors color) : super(height, width) {
    paint = color.paint;
  }
}

import 'dart:ui';

import 'package:flame/position.dart';
import 'package:flame/text_config.dart';

import 'package:thoughts/graphic/colors.dart';

class DebugOverlay {
  final TextConfig font =
      TextConfig(fontSize: 12, fontFamily: 'Arial', color: Colors.WHITE);
  final List<Function> lines = [];

  void render(Canvas canvas) {
    for (var i = 0; i < lines.length; i++) {
      font.render(
          canvas, lines[i](), Position(0, i.toDouble() * font.fontSize));
    }
  }
}

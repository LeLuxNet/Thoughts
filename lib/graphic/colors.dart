import 'dart:ui';

import 'package:flutter/widgets.dart';


class Colors {
  static final WHITE = Colors(0xffffffff);
  static final BLACK = Colors(0xff000000);
  static final BLOCK_GRAY = Colors(0xff303030);
  static final RED = Colors(0xffd20101);

  Color color;

  Colors(int val) {
    this.color = Color(val);
  }

  Paint get paint {
    return Paint()..color = color;
  }

  Colors sat(double sat) {
    var hsv = HSVColor.fromColor(color);
    hsv.withSaturation(hsv.saturation * sat);
    return Colors(hsv.toColor().value);
  }
}

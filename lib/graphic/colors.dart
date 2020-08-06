import 'dart:ui';

import 'package:flutter/widgets.dart';

class Colors {
  static final WHITE = Colors(0xffffffff);
  static final BLACK = Colors(0xff000000);
  static final BLOCK_GRAY = Colors(0xff242424);
  static final RED = Colors(0xffd00000);

  static final PLAYER_HEAD = Colors(0xfffca311);

  // https://coolors.co/2274a5-f75c03-f1c40f-d90368-00cc66
  static final PLAYER_BODY = [
    Colors(0xff2274a5),
    Colors(0xfff75c03),
    Colors(0xfff1c40f),
    Colors(0xffd90368),
    Colors(0xff00cc66),
  ];

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

import 'dart:ui';

class Colors {
  static const WHITE = Color(0xffffffff);
  static const BLACK = Color(0xff000000);
  static const BLOCK_GRAY = Color(0xff191919);
  static const RED = Color(0xffd20101);

  static Paint paint(Color col) {
    return Paint()..color = col;
  }
}

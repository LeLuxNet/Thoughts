import 'dart:ui';

class Background {
  Paint paint;
  Rect _rect;

  Background(this.paint);

  void resize(Size viewport) {
    _rect = Rect.fromLTRB(0, 0, viewport.width, viewport.height);
  }

  void render(Canvas canvas) {
    canvas.drawRect(_rect, paint);
  }
}

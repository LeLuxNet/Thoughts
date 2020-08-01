import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flutter/gestures.dart';
import 'package:thoughts/game.dart';
import 'package:thoughts/graphic/colors.dart';

class Background extends Component with Tapable {
  TheGame game;

  Background(this.game);

  @override
  void render(Canvas c) {
    c.drawRect(toRect(), Colors.paint(Colors.BLACK));
  }

  @override
  Rect toRect() {
    return Rect.fromLTRB(0, 0, game.viewport.width, game.viewport.height);
  }

  @override
  void onTapDown(TapDownDetails details) {
    if (game.player.jumped == 0) {
      game.player.velocity.y -= 5.0 * game.player.gravitySide.forceMult;
    } else if (game.player.jumped == 1) {
      game.toggleGravity();
    }
    game.player.jumped += 1;
  }

  @override
  void update(double t) {}
}

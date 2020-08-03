import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/keyboard.dart';
import 'package:flame/position.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:thoughts/graphic/colors.dart';
import 'package:thoughts/graphic/objects/debug_overlay.dart';
import 'package:thoughts/graphic/shapes/rectangle.dart';
import 'package:thoughts/graphic/shapes/triangle.dart';
import 'package:thoughts/physics/object.dart';
import 'package:thoughts/player.dart';
import 'package:thoughts/world/location.dart';
import 'package:thoughts/world/world.dart';

import 'graphic/colors.dart';
import 'graphic/shapes/rectangle.dart';

class TheGame extends BaseGame with TapDetector, KeyboardEvents {
  static const BLOCK_PILE = 6;

  World world;
  Player player;

  Size viewport;
  double blockSize;
  Position center;

  Rectangle background;
  Rectangle playerShape;
  Triangle heart;

  DebugOverlay debugOverlay = DebugOverlay();

  TheGame(screenDimensions) {
    world = World();
    player = Player(Location(5, 1.5), GravitySide.bottom);

    resize(screenDimensions);

    debugOverlay.lines.addAll([
      () {
        var frames = fps();
        if (frames.isFinite) {
          return frames.round().toString();
        }
        return "N/A";
      },
      () =>
          player.loc.x.toStringAsFixed(2) +
          " / " +
          player.loc.y.toStringAsFixed(2),
      () =>
          player.velocity.x.toStringAsFixed(2) +
          " / " +
          player.velocity.y.toStringAsFixed(2),
      () =>
          player.lastCheckpoint.x.toStringAsFixed(2) +
          " / " +
          player.lastCheckpoint.y.toStringAsFixed(2),
      () => player.touchingX.join(", "),
      () => player.jumped.toString(),
      () => player.grounded().toString(),
      () => player.gravitySide == GravitySide.top ? "top" : "bottom",
      () => player.hearts.toString()
    ]);
  }

  @override
  void render(Canvas c) {
    // Background
    background.render(c, Position(0, 0));

    // World
    int minX = player.loc.x.toInt();
    int maxX = player.loc.x.toInt();
    int minY = player.loc.y.toInt();
    int maxY = player.loc.y.toInt();

    while (_canvasX(minX) > 0) {
      minX--;
    }
    while (_canvasX(maxX) < viewport.width) {
      maxX++;
    }
    while (_canvasY(minY) < viewport.height) {
      minY--;
    }
    while (_canvasY(maxY) > 0) {
      maxY++;
    }

    for (var x = minX; x <= maxX; x++) {
      for (var y = minY; y <= maxY; y++) {
        var block = world.getBlock(x, y);
        if (block != null) {
          block
              .draw(blockSize + 1)
              .renderCentered(c, Position(_canvasX(x), _canvasY(y)));
        }
      }
    }

    // Player
    playerShape.renderCentered(c, center);

    // GameOverlay
    for (var h = 1; h <= player.hearts; h++) {
      heart.render(c, Position(viewport.width - h * heart.width, 0));
    }

    // DebugOverlay
    debugOverlay.render(c);
  }

  double _canvasX(int x) {
    return viewport.width / 2 + (x - player.loc.x) * blockSize;
  }

  double _canvasY(int y) {
    return viewport.height / 2 - (y - player.loc.y) * blockSize;
  }

  @override
  void update(double t) {
    world.update(t);
  }

  @override
  void resize(Size size) {
    super.resize(size);
    viewport = size;
    blockSize = viewport.height / BLOCK_PILE;
    center = Position(viewport.width / 2, viewport.height / 2);

    background = Rectangle(viewport.height, viewport.width, Colors.BLACK.paint);
    playerShape = Rectangle(player.height * blockSize, player.width * blockSize,
        Colors.WHITE.paint);
    heart = Triangle.eq(blockSize / 2, Colors.RED.paint, invert: true);
  }

  @override
  void onTapDown(TapDownDetails details) {
    player.jump();

    final percent = details.localPosition.dx / viewport.width;
    player.run(percent >= 0.5);
  }

  @override
  void onTapUp(TapUpDetails details) {
    player.brake();
  }

  @override
  void onTapCancel() {
    player.brake();
  }

  @override
  void onKeyEvent(e) {
    if (e.data.keyLabel == 'd' || e.data.keyLabel == 'a') {
      if (e is RawKeyDownEvent) {
        player.jump();
        player.run(e.data.keyLabel == 'd');
      } else if (e is RawKeyUpEvent) {
        player.brake();
      }
    }
  }

  @override
  bool recordFps() {
    return true;
  }
}

import 'dart:math';
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/keyboard.dart';
import 'package:flame/position.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:thoughts/graphic/colors.dart';
import 'package:thoughts/graphic/objects/background.dart';
import 'package:thoughts/graphic/objects/debug_overlay.dart';
import 'package:thoughts/graphic/shapes/triangle.dart';
import 'package:thoughts/physics/object.dart';
import 'package:thoughts/player.dart';
import 'package:thoughts/world/block/world.dart';
import 'package:thoughts/world/location.dart';

import 'graphic/colors.dart';
import 'graphic/shapes/circle.dart';

class TheGame extends BaseGame with TapDetector, KeyboardEvents {
  static const MAX_BLOCK_PILE = 6;
  static const MAX_BLOCK_ROW = 12;

  World world;
  Player player;

  Size viewport;
  double blockSize;
  Position center;

  Circle playerCircle;
  Triangle heart;

  Background hitIndicator;

  DebugOverlay debugOverlay = DebugOverlay();

  TheGame(screenDimensions) {
    world = World();
    player = Player(Location(1.5, 12), GravitySide.bottom);

    hitIndicator = Background(Paint()..color = Color(0x00000000));

    resize(screenDimensions);

    debugOverlay.lines.addAll([
      () {
        var frames = fps();
        if (frames.isFinite) {
          return frames.round();
        }
        return "N/A";
      },
      () => player.loc,
      () => player.velocity,
      () => player.checkpointLoc,
      () => player.touchingX.join(", ") + " / " + player.touchingY.join(", "),
      () => player.jumped,
      () => player.grounded,
      () => player.gravitySide == GravitySide.top ? "top" : "bottom",
      () => player.hearts
    ]);
  }

  @override
  void render(Canvas c) {
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
    var headOffset = player.gravitySide.forceMult * blockSize / 2;
    playerCircle.renderCentered(c, Position(center.x, center.y + headOffset));
    Triangle(blockSize, blockSize, player.bodyColor,
            invert: player.gravitySide == GravitySide.top)
        .renderCentered(c, Position(center.x, center.y - headOffset));

    /*
    for (var y in player.touchingY) {
      for (var x in player.touchingX) {
        Rectangle.square(blockSize + 1, Colors(0x990000ff))
            .renderCentered(c, Position(_canvasX(x), _canvasY(y)));
      }
    }
    */

    // GameOverlay
    for (var h = 1; h <= player.hearts; h++) {
      heart.render(c, Position(viewport.width - h * heart.width, 0));
    }
    hitIndicator.render(c);

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
    blockSize =
        max(viewport.width / MAX_BLOCK_ROW, viewport.height / MAX_BLOCK_PILE);
    center = Position(viewport.width / 2, viewport.height / 2);

    hitIndicator.resize(viewport);

    playerCircle = Circle(blockSize, Colors.PLAYER_HEAD);
    heart = Triangle.eq(blockSize / 2, Colors.RED, invert: true);
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

  @override
  Color backgroundColor() {
    return Colors.BLACK.color;
  }
}

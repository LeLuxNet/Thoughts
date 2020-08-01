import 'dart:ui';

import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'package:thoughts/graphic/colors.dart';
import 'package:thoughts/graphic/objects/background.dart';
import 'package:thoughts/graphic/objects/debug_overlay.dart';
import 'package:thoughts/graphic/shapes/rectangle.dart';
import 'package:thoughts/interface/buttons/walk_button.dart';
import 'package:thoughts/physics/object.dart';
import 'package:thoughts/player.dart';
import 'package:thoughts/world/location.dart';
import 'package:thoughts/world/world.dart';

class TheGame extends BaseGame with HasTapableComponents {
  static const BLOCK_PILE = 6;

  World world;
  Player player;

  Size viewport;
  double blockSize;
  Position center;

  Background background;
  Rectangle playerShape;

  WalkButton leftButton;
  WalkButton rightButton;

  DebugOverlay debugOverlay = DebugOverlay();
  int frames;

  TheGame(screenDimensions) {
    world = World();
    player = Player(Location(5, 1.5), GravitySide.bottom);

    background = Background(this);
    add(background);

    leftButton = WalkButton(player, -1);
    rightButton = WalkButton(player, 1);
    add(leftButton);
    add(rightButton);

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
      () => player.jumped.toString(),
      () => player.grounded().toString(),
      () => player.gravitySide == GravitySide.top ? "top" : "bottom"
    ]);
  }

  @override
  void render(Canvas c) {
    // Background
    background.render(c);

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
              .draw(blockSize)
              .renderCentered(c, Position(_canvasX(x), _canvasY(y)));
        }
      }
    }

    // Player
    playerShape.renderCentered(c, center);

    leftButton.render(c);
    rightButton.render(c);

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
    if (t == 0) {
      frames = 0;
    } else {
      frames = 1 ~/ t;
    }

    world.update(t);
  }

  @override
  void resize(Size size) {
    super.resize(size);
    viewport = size;
    blockSize = viewport.height / BLOCK_PILE;
    center = Position(viewport.width / 2, viewport.height / 2);

    playerShape = Rectangle(player.height * blockSize, player.width * blockSize,
        Colors.paint(Colors.WHITE));

    leftButton.height = blockSize;
    leftButton.width = blockSize;
    rightButton.height = blockSize;
    rightButton.width = blockSize;

    leftButton.y = viewport.height - 2 * blockSize;
    rightButton.y = leftButton.y;

    leftButton.x = blockSize;
    rightButton.x = 2.5 * blockSize;
  }

  void toggleGravity() {
    player.gravitySide = player.gravitySide == GravitySide.top
        ? GravitySide.bottom
        : GravitySide.top;
  }

  @override
  bool recordFps() {
    return true;
  }
}

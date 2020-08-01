import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thoughts/game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Flame.util.setLandscape();
    await Flame.util.fullScreen();
  }

  var game = TheGame(await Flame.util.initialDimensions());

  runApp(game.widget);
}

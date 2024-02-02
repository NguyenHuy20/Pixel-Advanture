import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixel_advanture/pixel_advanture.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.setLandscape();
  await Flame.device.fullScreen();
  PixelAdvanture game = PixelAdvanture();
  runApp(GameWidget(game: kDebugMode ? PixelAdvanture() : game));
}

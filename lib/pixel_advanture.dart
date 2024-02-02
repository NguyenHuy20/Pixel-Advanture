import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pixel_advanture/actors/player.dart';
import 'package:pixel_advanture/levels/level.dart';

class PixelAdvanture extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late final CameraComponent cam;
  Player player = Player(character: "Mask Dude");
  late JoystickComponent joystick;
  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    final world = Level(levelName: "Level-01", player: player);

    cam = CameraComponent.withFixedResolution(
        world: world, width: 640, height: 360);
    cam.priority = 0;
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([cam, world]);
    addJoystick();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    updateJoystick();
    super.update(dt);
  }

  void addJoystick() {
    joystick = JoystickComponent(
        priority: 10,
        knob: SpriteComponent(sprite: Sprite(images.fromCache("HUD/Knob.png"))),
        background: SpriteComponent(
            sprite: Sprite(images.fromCache("HUD/Joystick.png"))),
        margin: const EdgeInsets.only(left: 32, bottom: 32));
    add(joystick);
  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.playerDirection = PlayerDirection.left;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.playerDirection = PlayerDirection.right;
        break;
      default:
        player.playerDirection = PlayerDirection.none;
        break;
    }
  }
}

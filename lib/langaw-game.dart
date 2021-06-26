import 'dart:math';
import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/fly.dart';
import 'package:myapp/components/backyard.dart';
import 'package:myapp/components/dog.dart';
import 'package:myapp/components/pirate-woman.dart';
import 'package:myapp/components/samurai.dart';
import 'package:myapp/components/white-hair-man.dart';

class LangawGame extends Game {
  late Size screenSize;
  late double tileSize;
  late Backyard background;
  late List<Fly> flies;
  late Random rnd;

  LangawGame() {
    initialize();
  }

  void initialize() async {
    flies = <Fly>[];
    rnd = Random();
    resize(await Flame.util.initialDimensions());

    background = Backyard(this);
    spawnFly();
  }

  void spawnFly() {
    double x = rnd.nextDouble() * (screenSize.width - tileSize);
    double y = rnd.nextDouble() * (screenSize.height - tileSize);
    switch (rnd.nextInt(4)) {
      case 0:
        flies.add(Dog(this, x, y));
        break;
      case 1:
        flies.add(PirateWoman(this, x, y));
        break;
      case 2:
        flies.add(Samurai(this, x, y));
        break;
      case 3:
        flies.add(WhiteHairMan(this, x, y));
        break;
    }
  }

  void render(Canvas c) {
    background.render(c);

    flies.forEach((Fly fly) => fly.render(c));
  }

  void update(double t) {
    flies.forEach((Fly fly) => fly.update(t));
    flies.removeWhere((Fly fly) => fly.isOffScreen);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void onTapDown(TapDownDetails d) {
    flies.forEach((Fly fly) {
      if (fly.flyRect.contains(d.globalPosition)) {
        fly.onTapDown();
      }
    });
  }
}

import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/fly.dart';
import 'package:myapp/langaw-game.dart';

class PirateWoman extends Fly {
  double get speed => game.tileSize * 5;

  PirateWoman(LangawGame game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1.5, game.tileSize * 1.5);
    flyingSprite = <Sprite>[];
    flyingSprite.add(Sprite('actors/pirate-woman.png', width: 60, height: 60));
    flyingSprite
        .add(Sprite('actors/pirate-woman.png', x: 320, width: 60, height: 60));
    deadSprite = Sprite('actors/pirate-woman.png',
        x: 390, y: 340, width: 60, height: 60);
  }
}

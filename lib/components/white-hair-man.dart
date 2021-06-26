import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/fly.dart';
import 'package:myapp/langaw-game.dart';

class WhiteHairMan extends Fly {
  WhiteHairMan(LangawGame game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1.5, game.tileSize * 1.5);
    flyingSprite = <Sprite>[];
    flyingSprite
        .add(Sprite('actors/white-hair-man.png', width: 60, height: 60));
    flyingSprite.add(
        Sprite('actors/white-hair-man.png', x: 320, width: 60, height: 60));
    deadSprite = Sprite('actors/white-hair-man.png',
        x: 390, y: 340, width: 60, height: 60);
  }
}

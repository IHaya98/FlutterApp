import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:myapp/langaw-game.dart';

class LostView {
  final LangawGame game;
  late Rect rect;
  late Sprite sprite;

  LostView(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize,
      (game.screenSize.height / 2) - (game.tileSize * 5),
      game.tileSize * 7,
      game.tileSize * 5,
    );
    sprite = Sprite('ui/lost.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {}
}

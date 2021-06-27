import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:myapp/langaw-game.dart';
import 'package:myapp/view.dart';

class CreditsButton {
  final LangawGame game;
  late Rect rect;
  late Sprite sprite;

  CreditsButton(this.game) {
    rect = Rect.fromLTWH(
      game.screenSize.width - (game.tileSize * 1.25),
      game.screenSize.height - (game.tileSize * 1.25),
      game.tileSize,
      game.tileSize,
    );
    sprite = Sprite('icon/emo_5.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void onTapDown() {
    game.activeView = View.credits;
  }
}

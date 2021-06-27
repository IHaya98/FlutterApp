import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:myapp/langaw-game.dart';
import 'package:myapp/view.dart';

class HelpButton {
  final LangawGame game;
  late Rect rect;
  late Sprite sprite;

  HelpButton(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize * .25,
      game.screenSize.height - (game.tileSize * 1.25),
      game.tileSize,
      game.tileSize,
    );
    sprite = Sprite('icon/emo_7.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void onTapDown() {
    game.activeView = View.help;
  }
}

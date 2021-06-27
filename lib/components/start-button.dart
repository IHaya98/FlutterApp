import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:myapp/langaw-game.dart';
import 'package:myapp/view.dart';

class StartButton {
  final LangawGame game;
  late Rect rect;
  late Sprite sprite;

  StartButton(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize * 1.5,
      (game.screenSize.height * .75) - (game.tileSize * 1.5),
      game.tileSize * 6,
      game.tileSize * 3,
    );
    sprite = Sprite('ui/start.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {}

  void onTapDown() {
    game.activeView = View.playing;
    game.spawner.start();
  }
}

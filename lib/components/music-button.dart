import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:myapp/langaw-game.dart';

class MusicButton {
  final LangawGame game;
  late Rect rect;
  late Sprite enabledSprite;
  late Sprite disabledSprite;
  late bool isEnabled = true;

  MusicButton(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize * .25,
      game.tileSize * .25,
      game.tileSize * .5,
      game.tileSize * .5,
    );
    enabledSprite = Sprite('icon/music-enabled.png');
    disabledSprite = Sprite('icon/music-disabled.png');
  }

  void render(Canvas c) {
    if (isEnabled) {
      enabledSprite.renderRect(c, rect);
    } else {
      disabledSprite.renderRect(c, rect);
    }
  }

  void onTapDown() {
    if (isEnabled) {
      isEnabled = false;
      // game.homeBGM.setVolume(0);
      // game.playingBGM.setVolume(0);
    } else {
      isEnabled = true;
      // game.homeBGM.setVolume(.25);
      // game.playingBGM.setVolume(.25);
    }
  }
}

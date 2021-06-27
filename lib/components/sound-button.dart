import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:myapp/langaw-game.dart';

class SoundButton {
  final LangawGame game;
  late Rect rect;
  late Sprite enabledSprite;
  late Sprite disabledSprite;
  late bool isEnabled = true;

  SoundButton(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize,
      game.tileSize * .25,
      game.tileSize * .5,
      game.tileSize * .5,
    );
    enabledSprite = Sprite('icon/sound-enabled.png');
    disabledSprite = Sprite('icon/sound-disabled.png');
  }

  void render(Canvas c) {
    if (isEnabled) {
      enabledSprite.renderRect(c, rect);
    } else {
      disabledSprite.renderRect(c, rect);
    }
  }

  void onTapDown() {
    isEnabled = !isEnabled;
  }
}

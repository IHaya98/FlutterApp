import 'dart:ui';
import 'package:flame/sprite.dart';
// import 'package:flame/flame.dart';
import 'package:myapp/langaw-game.dart';
import 'package:myapp/view.dart';
import 'package:myapp/components/callout.dart';

class Fly {
  final LangawGame game;
  late Rect flyRect;
  late bool isDead = false;
  late bool isOffScreen = false;
  late List<Sprite> flyingSprite;
  late Sprite deadSprite;
  late double flyingSpriteIndex = 0;
  late Offset targetLocation;
  late Callout callout;

  double get speed => game.tileSize * 3;

  Fly(this.game) {
    setTargetLocation();
    callout = Callout(this);
  }

  void setTargetLocation() {
    double x = game.rnd.nextDouble() *
        (game.screenSize.width - (game.tileSize * 2.025));
    double y = game.rnd.nextDouble() *
        (game.screenSize.height - (game.tileSize * 2.025));
    targetLocation = Offset(x, y);
  }

  void render(Canvas c) {
    if (isDead) {
      deadSprite.renderRect(c, flyRect.inflate(2));
    } else {
      flyingSprite[flyingSpriteIndex.toInt()].renderRect(c, flyRect.inflate(2));
    }
    if (game.activeView == View.playing) {
      callout.render(c);
    }
  }

  void update(double t) {
    if (isDead) {
      flyRect = flyRect.translate(0, game.tileSize * 12 * t);
      if (flyRect.top > game.screenSize.height) {
        isOffScreen = true;
      }
    } else {
      flyingSpriteIndex += 30 * t * 0.05;
      if (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;
      }
    }
    double stepDistance = speed * t;
    Offset toTarget = targetLocation - Offset(flyRect.left, flyRect.top);
    if (stepDistance < toTarget.distance) {
      Offset stepToTarget =
          Offset.fromDirection(toTarget.direction, stepDistance);
      flyRect = flyRect.shift(stepToTarget);
    } else {
      flyRect = flyRect.shift(toTarget);
      setTargetLocation();
    }

    callout.update(t);
  }

  void onTapDown() {
    if (!isDead) {
      // if (game.soundButton.isEnabled) {
      //   Flame.audio.play('力及ばず.mp3');
      // }
      isDead = true;
      if (game.activeView == View.playing) {
        game.score += 1;
        if (game.score > (game.storage.getInt('highscore') ?? 0)) {
          game.storage.setInt('highscore', game.score);
          game.highscoreDisplay.updateHighscore();
        }
      }
    }
  }
}

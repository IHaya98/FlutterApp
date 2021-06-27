import 'dart:ui';
import 'package:flame/sprite.dart';
// import 'package:flame/flame.dart';
import 'package:flutter/painting.dart';
import 'package:myapp/components/fly.dart';
import 'package:myapp/view.dart';

class Callout {
  final Fly fly;
  late Rect rect;
  late Sprite sprite;
  late double value;

  late TextPainter tp;
  late TextStyle textStyle;
  late Offset textOffset;

  Callout(this.fly) {
    sprite = Sprite('icon/emo_5.png');
    value = 1;
    tp = TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    textStyle = TextStyle(color: Color(0xff000000), fontSize: 15);
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
    tp.paint(c, textOffset);
  }

  void update(double t) {
    if (fly.game.activeView == View.playing) {
      value = value - .5 * t;
      if (value <= 0) {
        // if (fly.game.soundButton.isEnabled) {
        //   Flame.audio.play('力及ばず.mp3');
        // }
        // fly.game.playHomeBGM();
        fly.game.activeView = View.lost;
      }
    }

    rect = Rect.fromLTWH(
      fly.flyRect.left - (fly.game.tileSize * .25),
      fly.flyRect.top - (fly.game.tileSize * .5),
      fly.game.tileSize * .75,
      fly.game.tileSize * .75,
    );

    tp.text = TextSpan(text: (value * 10).toInt().toString(), style: textStyle);
    tp.layout();
    textOffset = Offset(rect.center.dx - (tp.width / 2),
        rect.top + (rect.height * .4) - (tp.height / 2));
  }
}

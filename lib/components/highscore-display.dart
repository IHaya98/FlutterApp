import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:myapp/langaw-game.dart';

class HighscoreDisplay {
  final LangawGame game;
  late TextPainter painter;
  late TextStyle textStyle;
  late Offset position;

  HighscoreDisplay(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    Shadow shadow = Shadow(
      blurRadius: 3,
      color: Color(0xff000000),
      offset: Offset.zero,
    );

    textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 30,
      shadows: [shadow, shadow, shadow, shadow],
    );

    position = Offset.zero;

    updateHighscore();
  }
  void updateHighscore() {
    int highscore = game.storage.getInt('highscore') ?? 0;

    painter.text =
        TextSpan(text: 'High Score:' + highscore.toString(), style: textStyle);
    painter.layout();
    position = Offset(
        game.screenSize.width - (game.tileSize * .25) - painter.width,
        game.tileSize * .25);
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }
}

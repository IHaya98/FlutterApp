import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:myapp/langaw-game.dart';

class ScoreDisplay {
  final LangawGame game;
  late TextPainter painter;
  late TextStyle textStyle;
  late Offset position;

  ScoreDisplay(this.game) {
    painter = TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);

    textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 90,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: Color(0xff000000),
          offset: Offset(3, 3),
        ),
      ],
    );

    position = Offset.zero;
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void update(double t) {
    if ((painter.text ?? '') != game.score.toString()) {
      painter.text = TextSpan(text: game.score.toString(), style: textStyle);

      painter.layout();

      position = Offset((game.screenSize.width / 2) - (painter.width / 2),
          (game.screenSize.height * .25) - (painter.height / 2));
    }
  }
}

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/flame.dart';

import 'langaw-game.dart';

void main() async {
  SharedPreferences storage = await SharedPreferences.getInstance();
  LangawGame game = LangawGame(storage);
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  runApp(game.widget);

  final flameUtil = Util();
  flameUtil.fullScreen();
  flameUtil.addGestureRecognizer(tapper);
  flameUtil.setOrientation(DeviceOrientation.portraitUp);
  Flame.images.loadAll(<String>[
    'bg/backyard.png',
    'actors/dog.png',
    'actors/pirate-woman.png',
    'actors/samurai.png',
    'actors/white-hair-man.png',
    'ui/home.png',
    'ui/start.png',
    'ui/lost.png',
    'icon/emo_5.png',
    'icon/emo_7.png',
    'icon/music-enabled.png',
    'icon/music-disabled.png',
    'icon/sound-enabled.png',
    'icon/sound-disabled.png',
  ]);
  // Flame.audio.disableLog();
  // Flame.audio.loadAll(<String>[
  //   '勝利のパレード.mp3',
  //   '冒険へ.mp3',
  //   'ゆるドラシル.mp3',
  //   '力及ばず.mp3',
  //   '希望の詩.mp3',
  //   '強敵.mp3',
  // ]);
}

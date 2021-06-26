import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/gestures.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/flame.dart';

import 'box-game.dart';
import 'langaw-game.dart';

void main() {
  LangawGame game = LangawGame();
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
    'actors/white-hair-man.png'
  ]);
}

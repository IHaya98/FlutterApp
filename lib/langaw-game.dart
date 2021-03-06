import 'dart:math';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/fly.dart';
import 'package:myapp/components/backyard.dart';
import 'package:myapp/components/dog.dart';
import 'package:myapp/components/pirate-woman.dart';
import 'package:myapp/components/samurai.dart';
import 'package:myapp/components/white-hair-man.dart';
import 'package:myapp/view.dart';
import 'package:myapp/views/home-view.dart';
import 'package:myapp/components/start-button.dart';
import 'package:myapp/views/lost-view.dart';
import 'package:myapp/controllers/spawner.dart';
import 'package:myapp/components/credits-button.dart';
import 'package:myapp/components/help-button.dart';
import 'package:myapp/views/help-view.dart';
import 'package:myapp/views/credits-view.dart';
import 'package:myapp/components/score-display.dart';
import 'package:myapp/components/highscore-display.dart';
import 'package:myapp/components/music-button.dart';
import 'package:myapp/components/sound-button.dart';
// import 'package:audioplayers/audioplayers.dart';

class LangawGame extends Game {
  late final SharedPreferences storage;
  late Size screenSize;
  late double tileSize;
  late Backyard background;
  late List<Fly> flies;
  late Random rnd;

  View activeView = View.home;
  late HomeView homeView;
  late StartButton startButton;
  late LostView lostView;
  late HelpButton helpButton;
  late CreditsButton creditsButton;
  late HelpView helpView;
  late CreditsView creditsView;
  late ScoreDisplay scoreDisplay;
  late HighscoreDisplay highscoreDisplay;

  late FlySpawner spawner;
  // late AudioPlayer homeBGM;
  // late AudioPlayer playingBGM;
  late MusicButton musicButton;
  late SoundButton soundButton;

  late int score;

  LangawGame(this.storage) {
    initialize();
  }

  void initialize() async {
    flies = <Fly>[];
    rnd = Random();
    resize(await Flame.util.initialDimensions());

    background = Backyard(this);
    homeView = HomeView(this);
    startButton = StartButton(this);
    lostView = LostView(this);
    helpButton = HelpButton(this);
    creditsButton = CreditsButton(this);
    helpView = HelpView(this);
    creditsView = CreditsView(this);
    scoreDisplay = ScoreDisplay(this);
    highscoreDisplay = HighscoreDisplay(this);

    spawner = FlySpawner(this);

    score = 0;

    musicButton = MusicButton(this);
    soundButton = SoundButton(this);

    // homeBGM = await Flame.audio.loop('??????????????????.mp3', volume: .25);
    // homeBGM.pause();
    // playingBGM = await Flame.audio.loop('??????????????????.mp3', volume: .25);
    // playingBGM.pause();
    // playHomeBGM();
  }

  // void playHomeBGM() {
  //   playingBGM.pause();
  //   playingBGM.seek(Duration.zero);
  //   homeBGM.stop();
  // }

  // void playPlayingBGM() {
  //   homeBGM.pause();
  //   homeBGM.seek(Duration.zero);
  //   playingBGM.stop();
  // }

  void spawnFly() {
    double x = rnd.nextDouble() * (screenSize.width - tileSize);
    double y = rnd.nextDouble() * (screenSize.height - tileSize);
    switch (rnd.nextInt(4)) {
      case 0:
        flies.add(Dog(this, x, y));
        break;
      case 1:
        flies.add(PirateWoman(this, x, y));
        break;
      case 2:
        flies.add(Samurai(this, x, y));
        break;
      case 3:
        flies.add(WhiteHairMan(this, x, y));
        break;
    }
  }

  void render(Canvas c) {
    background.render(c);
    highscoreDisplay.render(c);
    helpButton.render(c);
    creditsButton.render(c);
    musicButton.render(c);
    soundButton.render(c);

    flies.forEach((Fly fly) => fly.render(c));
    if (activeView == View.home) homeView.render(c);
    if (activeView == View.home || activeView == View.lost) {
      startButton.render(c);
    }
    if (activeView == View.lost) lostView.render(c);
    if (activeView == View.help) helpView.render(c);
    if (activeView == View.credits) creditsView.render(c);
    if (activeView == View.playing) scoreDisplay.render(c);
  }

  void update(double t) {
    flies.forEach((Fly fly) => fly.update(t));
    flies.removeWhere((Fly fly) => fly.isOffScreen);
    if (activeView == View.playing) scoreDisplay.update(t);
    spawner.update(t);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;
    //startButton
    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        startButton.onTapDown();
        isHandled = true;
      }
    }
    //flies
    if (!isHandled) {
      bool didHitAFly = false;
      flies.forEach((Fly fly) {
        if (fly.flyRect.contains(d.globalPosition)) {
          fly.onTapDown();
          isHandled = true;
          didHitAFly = true;
        }
      });
      if (activeView == View.playing && !didHitAFly) {
        // if (soundButton.isEnabled) {
        //   Flame.audio.play('????????????.mp3');
        // }
        // playHomeBGM();
        activeView = View.lost;
      }
    }
    // dialog boxes
    if (!isHandled) {
      if (activeView == View.help || activeView == View.credits) {
        activeView = View.home;
        isHandled = true;
      }
    }
    // help button
    if (!isHandled && helpButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        helpButton.onTapDown();
        isHandled = true;
      }
    }
    // credits button
    if (!isHandled && creditsButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        creditsButton.onTapDown();
        isHandled = true;
      }
    }
    // music button
    if (!isHandled && musicButton.rect.contains(d.globalPosition)) {
      musicButton.onTapDown();
      isHandled = true;
    }
    // sound button
    if (!isHandled && soundButton.rect.contains(d.globalPosition)) {
      soundButton.onTapDown();
      isHandled = true;
    }
  }
}

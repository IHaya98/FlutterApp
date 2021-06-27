import 'package:myapp/langaw-game.dart';
import 'package:myapp/components/fly.dart';

class FlySpawner {
  final LangawGame game;
  final int maxSpawnInterval = 3000;
  final int minSpawnInterval = 250;
  final int intervalChange = 3;
  final int maxFliesOnScreen = 7;
  late int currentInterval;
  late int nextSpawn;

  FlySpawner(this.game) {
    start();
    game.spawnFly();
  }

  void start() {
    killAll();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void killAll() {
    game.flies.forEach((Fly fly) => fly.isDead = true);
  }

  void update(double t) {
    int nowTimeStamp = DateTime.now().millisecondsSinceEpoch;

    int livingFlies = 0;
    game.flies.forEach((Fly fly) {
      if (!fly.isDead) livingFlies += 1;
    });
    if (nowTimeStamp >= nextSpawn && livingFlies < maxFliesOnScreen) {
      game.spawnFly();
      if (currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * .02).toInt();
      }
      nextSpawn = nowTimeStamp + currentInterval;
    }
  }
}

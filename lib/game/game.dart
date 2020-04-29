import 'dart:ui';

import 'package:flame/game.dart';

import 't_rex/t_rex.dart';
import 'horizon/horizon.dart';
import 'game_config.dart';
import 't_rex/config.dart';
import 'collision/collision_utils.dart';

enum TRexGameStatus { playing, waiting, gameOver }

class TRexGame extends BaseGame {
  TRex tRex;
  Horizon horizon;
  TRexGameStatus status = TRexGameStatus.waiting;

  double currentSpeed = GameConfig.speed;

  TRexGame({Image spriteImage}) {
    tRex = new TRex(spriteImage);
    horizon = new Horizon(spriteImage);

    this
      ..add(horizon)..add(tRex);
  }

  void onTap() {
    tRex.startJump(this.currentSpeed);
  }

  @override
  void update(double t) {
    tRex.update(t);
    horizon.updateWithSpeed(0.0, this.currentSpeed);

    if (tRex.playingIntro && tRex.x >= TRexConfig.startXPos) {
      startGame();
    } else if (tRex.playingIntro) {
      horizon.updateWithSpeed(0.0, this.currentSpeed);
    }

    if (this.playing) {
      horizon.updateWithSpeed(t, this.currentSpeed);
    }

    var obstacles = horizon.horizonLine.obstacleManager.components;
    bool collision =
        obstacles.length > 0 && checkForCollision(obstacles.first, tRex);
    if (!collision) {
      if (this.currentSpeed < GameConfig.maxSpeed) {
        this.currentSpeed += GameConfig.acceleration;
      }
    } else {
      gameOver();
    }
  }

  void startGame() {
    tRex.status = TRexStatus.running;
    status = TRexGameStatus.playing;
    tRex.hasPlayedIntro = true;
  }

  bool get playing => status == TRexGameStatus.playing;
  int count = 0;

  void gameOver() {
    count++;
    print("collision! $count");
  }
}

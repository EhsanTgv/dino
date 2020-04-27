import 'dart:ui';

import 'package:flame/game.dart';

import 't_rex/t_rex.dart';
import 'horizon/horizon.dart';
import 'game_config.dart';
import 't_rex/config.dart';

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
    tRex.startJump(GameConfig.speed);
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

    if (this.currentSpeed < GameConfig.maxSpeed) {
      this.currentSpeed += GameConfig.acceleration;
    }
  }

  void startGame() {
    tRex.status = TRexStatus.running;
    status = TRexGameStatus.playing;
    tRex.hasPlayedIntro = true;
  }

  bool get playing => status == TRexGameStatus.playing;
}

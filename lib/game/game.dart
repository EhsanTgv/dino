import 'dart:ui';

import 'package:flame/game.dart';

//import 'package:trex/game/game_config.dart';
import 'horizon/horizon.dart';
import 't_rex/t_rex.dart';

enum TRexGameStatus { playing, waiting, gameOver }

class TRexGame extends BaseGame {
  TRex tRex;

  Horizon horizon;
  TRexGameStatus status = TRexGameStatus.waiting;

  TRexGame({Image spriteImage}) {
    tRex = new TRex(spriteImage);
    horizon = new Horizon(spriteImage);

    this
      ..add(tRex)..add(horizon);
  }

  @override
  void update(double t) {
    tRex.update(t);
    horizon.update(t);
  }

  void onTap() {
//    tRex.startJump(GameConfig.speed);
  }

  bool get playing => status == TRexGameStatus.playing;
}

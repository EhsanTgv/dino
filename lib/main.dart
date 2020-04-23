import 'dart:ui' as ui;

import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'game/game.dart';

void main() async {
  Flame.audio.disableLog();
  List<ui.Image> image = await Flame.images.loadAll(["sprite.png"]);
  TRexGame tRexGame = TRexGame(spriteImage: image[0]);
  runApp(MaterialApp(
    title: 'Dino',
    color: Colors.white,
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: TRexGameWrapper(tRexGame),
    ),
  ));
  Flame.util.addGestureRecognizer(new TapGestureRecognizer()
    ..onTapDown = (TapDownDetails evt) => tRexGame.onTap());
}

class TRexGameWrapper extends StatelessWidget {
  final TRexGame tRexGame;

  TRexGameWrapper(this.tRexGame);

  @override
  Widget build(BuildContext context) {
    return tRexGame.widget;
  }
}

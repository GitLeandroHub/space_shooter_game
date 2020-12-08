import 'package:flame/text_config.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';

import 'dart:ui';

import 'package:space_shooter_game/game.dart';

class ScoreComponent extends TextComponent with HasGameRef<SpaceShooterGame> {
  //constructor que chama o super que recebe duas coisas: textp inicial e o text config
  ScoreComponent()
      : super("Score 0", config: TextConfig(color: Color(0xffffffff))) {
    x = y = 5;
  }

  @override
  void update(double dt) {
    super.update(dt);
    text = "Score ${gameRef.score}";
  }
}

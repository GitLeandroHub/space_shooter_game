import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/time.dart';

import 'dart:ui';
import 'dart:math';

import 'package:space_shooter_game/game.dart';

import './enemy_component.dart';

class EnemyCreator extends Component with HasGameRef<SpaceShooterGame> {
  Timer enemyCreator;

  Random random = Random();

  EnemyCreator() {
    enemyCreator = Timer(1.0, repeat: true, callback: () {
      //nextDouble torna o número de zero a um
      gameRef.add(
          EnemyComponent((gameRef.size.width - 50) * random.nextDouble(), 0));
    });
    //pois irá executar desde o começo do jogo
    enemyCreator.start();
  }

  @override
  void update(double dt) {
    enemyCreator.update(dt);
  }

  @override
  void render(Canvas canvas) {}
}

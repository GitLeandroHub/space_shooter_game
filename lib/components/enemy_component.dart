import 'package:flame/components/animation_component.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/mixins/has_game_ref.dart';

//import '../game.dart';
import 'package:space_shooter_game/game.dart';

import './explosion_component.dart';

class EnemyComponent extends AnimationComponent
    with HasGameRef<SpaceShooterGame> {
  static const enemy_speed = 150;

  bool destroyed = false;

  EnemyComponent(double x, double y)
      : super(
            50,
            50,
            Animation.sequenced("enemy.png", 1,
                textureWidth: 128, textureHeight: 128)) {
    this.x = x;
    this.y = y;
  }

  @override
  void update(double dt) {
    super.update(dt);

    y += enemy_speed * dt;

    if (gameRef.player != null && gameRef.player.toRect().overlaps(toRect())) {
      takeHit();

      gameRef.playerTakeHit();
    }
  }

  //ciar o método take hit, a variável = false e verificar no "bool destroy"
  void takeHit() {
    destroyed = true;

    gameRef.add(ExplosionComponent(x + 20, y + 20));
    gameRef.increaseScore();
  }

  @override
  //preciso implementar a tela "BaseGame" e variável size
  bool destroy() => destroyed || y >= gameRef.size.height;
}

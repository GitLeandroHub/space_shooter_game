import 'package:flame/components/animation_component.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/mixins/has_game_ref.dart';

import 'package:space_shooter_game/game.dart';
import './enemy_component.dart';

class BulletComponent extends AnimationComponent
    with HasGameRef<SpaceShooterGame> {
  static const bullet_speed = -500;

  bool destroyed = false;

  BulletComponent(double x, double y)
      : super(
            20,
            20,
            Animation.sequenced("bullet.png", 1,
                textureWidth: 24, textureHeight: 20)) {
    this.x = x;
    this.y = y;
  }

  @override
  void update(double dt) {
    //chamar o super, senão todo código que o AnimationComponent herda não será executado
    super.update(dt);

    y += bullet_speed * dt;

    gameRef.components.whereType<EnemyComponent>().forEach((enemy) {
      if (enemy.toRect().overlaps(toRect())) {
        //informar tanto o "tiro" quanto o "inimigo" a colisão
        destroyed = true;
        enemy.takeHit();
      }
    });
  }

  //remover componente do jogo(livrar memória) através do override do método destroy (que por default sempre retorna false)
  //Quando o bullet sai do topo da tela, lembrando que o canvas do flutter é zero "0" o top-left
  //Ou destroy (bool destroyed = false)
  @override
  bool destroy() => destroyed || toRect().bottom <= 0;
}

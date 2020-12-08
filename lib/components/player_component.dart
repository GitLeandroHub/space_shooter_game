import 'package:flame/components/animation_component.dart';
import 'package:flame/animation.dart';
import 'package:flame/time.dart';

//todo componente que tem esse mixin:has_game_ref recbe por padrão a instância do jogo aonda ele está rodando com generics <SpaceShooterGame> para acesso a instancia correta
import 'package:flame/components/mixins/has_game_ref.dart';

//import '../game.dart';
import 'package:space_shooter_game/game.dart';

import './bullet_component.dart';
import './explosion_component.dart';

//Implementar o player component
class PlayerComponent extends AnimationComponent
    with HasGameRef<SpaceShooterGame> {
  bool destroyed = false;
  Timer bulletCreator;

  //AnimationComponte no seu construtor chame o "super" que recebe os tamanhos e a animação
  PlayerComponent()
      : super(
            72,
            60,
            Animation.sequenced("player.png", 4,
                textureWidth: 24, textureHeight: 20)) {
    x = 175;
    y = 600;

    //iniciar o Timer do bulletCreator que recebe o intervalo(true para repetir sempre) e o callback que ele vai exexutar quando der o intervalo pelo método _createShoot
    bulletCreator = Timer(0.5, repeat: true, callback: _createBullet);
  }

  void _createBullet() {
    //agora pela instância do HasGameRef tem-se acesso a uma variãvel chamada gameRef e adicionar o component Bullet passando o x + offset
    gameRef.add(BulletComponent(x + 20, y + 20));
  }

  void beginFire() {
    bulletCreator.start();
  }

  void stopFire() {
    bulletCreator.stop();
  }

  void move(double deltaX, double deltaY) {
    x += deltaX;
    y += deltaY;
  }

  @override
  void update(double dt) {
    super.update(dt);

    bulletCreator.update(dt);
  }

  void takeHit() {
    gameRef.add(ExplosionComponent(x, y));

    destroyed = true;
  }

  @override
  bool destroy() => destroyed;
}

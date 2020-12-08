//Diferente dos componentes anteriores, este não defina já a animação, ele recebe a animação criado no background (random baseado no spritesheet)
//criar um componente para verificar e garantir que a estrela saiu da tela quando ela chegar no fim do paralax dela

import 'package:flame/components/animation_component.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/mixins/has_game_ref.dart';

//import '../game.dart';
import 'package:space_shooter_game/game.dart';

class StarComponent extends AnimationComponent
    with HasGameRef<SpaceShooterGame> {
  static const star_speed = 10;

  bool destroyed = false;

  //recebe x, y e neste caso recebe a animação também
  //10, 10?
  StarComponent(double x, double y, Animation animation)
      : super(10, 10, animation) {
    this.x = x;
    this.y = y;
  }

  @override
  void update(double dt) {
    super.update(dt);

    y += dt * star_speed;
  }

  @override
  //estrela será destruída quando sair da tela, portanto:
  bool destroy() => y >= gameRef.size.height;
}

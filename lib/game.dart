import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/time.dart';
import 'package:flame/components/timer_component.dart';
import 'package:space_shooter_game/components/score_component.dart';
import 'package:flutter/material.dart';
//importar o player
import './components/player_component.dart';
import './components/enemy_creator.dart';
//importar o background
import './components/star_background_creator.dart';
import './components/score_component.dart';
import './audio.dart';

//Não há necessidade de @override de render, nem de @override de update, pois o Flame, pelo BaseGame cuida gerencia isso
//com mixin PanDetector pode-se dar @override de métodos relacionados ao gesto de Pan
//O BaseGame já faz alguns tratamentos em relação ao tamanho da tela, quando tem o resize ou outros eventos do tipo, ele controla, então ele já tem uma variável do tipo size, mas é preciso recebè-la no construtor
class SpaceShooterGame extends BaseGame with PanDetector {
  //fazer o movimento do player, então é preciso guardar a essa instância do PlayerComponent(add) numa variável dentro do game
  PlayerComponent player;
  StarBackGroundCreator starBackGroundCreator;

  int score = 0;
  bool _musicStarted = false;

  //e atribuir a inicialização do player(=)
  SpaceShooterGame(Size size) {
    //Só setar a variável que o BaseGame já implementa
    this.size = size;
    _initPlayer();

    add(EnemyCreator());
    add(starBackGroundCreator = StarBackGroundCreator(size));
    starBackGroundCreator.init();

    add(ScoreComponent());
  }

  //Pela classe BaseGame temos o método "add" que adiciona o jogador
  void _initPlayer() {
    add(player = PlayerComponent());
  }

  @override
  void onPanStart(_) {
    if (!_musicStarted) {
      _musicStarted = true;
      Audio.backgroundMusic();
    }

    player?.beginFire();
  }

  @override
  void onPanEnd(_) {
    player?.stopFire();
  }

  @override
  void onPanCancel() {
    player?.stopFire();
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {
    //adicionar o método .move que foi criado
    player?.move(details.delta.dx, details.delta.dy);
  }

  void increaseScore() {
    score++;
  }

  void playerTakeHit() {
    player.takeHit();

    player = null;

    score = 0;

    add(TimerComponent(Timer(1, callback: _initPlayer)..start()));
  }
}

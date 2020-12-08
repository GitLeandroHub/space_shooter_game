import 'package:flutter/material.dart';
//util é async, entao alterar o main para async
import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';

import './game.dart';

//scrcpy pra fazer o display do aparelho android caso não tenha emulador virtual https://github.com/Genymobile/scrcpy
//Todo jodo do flame "vira" um widget do flutter
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Flame.util.setPortrait();
    await Flame.util.fullScreen();
  }

  final size = await Flame.util.initialDimensions();
  //passar size para widget para repassar para o game
  runApp(SpaceShooterGame(size).widget);
}

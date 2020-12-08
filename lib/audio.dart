import 'package:flame/flame.dart';

class Audio {
  static void explosion() {
    Flame.audio.play('explosion-8.wav');
  }

  static void backgroundMusic() {
    Flame.audio.loopLongAudio('organism_space_funk.mp3');
  }
}

import 'package:audioplayers/audioplayers.dart';
import 'package:quizix/utils/app_sounds.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;

  late AudioPlayer _player;
  bool _isPlaying = false;

  AudioManager._internal() {
    _player = AudioPlayer();
  }

  Future<void> playBackSound() async {
    if (_isPlaying) return;
    _isPlaying = true;
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.setVolume(1.0);
    await _player.play(AssetSource(AppSounds.backSound));
  }

  Future<void> stopBackSound() async {
    _isPlaying = false;
    await _player.stop();
  }
}

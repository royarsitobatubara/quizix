import 'package:flutter/material.dart';
import 'package:quizix/data/user_preferences.dart';

class DataProvider extends ChangeNotifier {

  int _progressDaily = 0;
  bool _backSound = true;

  int get progressDaily => _progressDaily;
  bool get backSound => _backSound;

  DataProvider() {
    loadAll();
  }

  void loadAll() {
    loadProgressDaily();
    loadBackSound();
  }

  // BACK SOUND
  Future<void> loadBackSound() async {
    try {
      final isMusicActive = await UserPreferences.getDataBool(key: 'backSound');
      _backSound = isMusicActive;
    } catch (e) {
      debugPrint('Terjadi kesalahan pada loadBackSound: $e');
      _backSound = true;
    }
    notifyListeners();
  }

  // PROGRESS DAILY
  Future<void> loadProgressDaily() async {
    try {
      final progress = await UserPreferences.getProgressDaily();
      _progressDaily = progress;
      debugPrint('progress: $progress');
    } catch (e) {
      debugPrint('Terjadi kesalahan pada loadProgressDaily: $e');
      _progressDaily = 0;
    }
    notifyListeners();
  }
}

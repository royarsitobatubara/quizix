import 'package:flutter/material.dart';
import 'package:quizix/data/database/db_service.dart';
import 'package:quizix/data/user_storage.dart';
import 'package:quizix/models/history_model.dart';
import 'package:quizix/utils/app_images.dart';

class UserProvider extends ChangeNotifier {
  String _name = "Guest";
  int _point = 0;
  int _progressDaily = 0;
  bool _backSound = true;
  String _profile = '';
  List<HistoryModel> _history = [];

  String get name => _name;
  String get profile => _profile;
  int get point => _point;
  int get progressDaily => _progressDaily;
  bool get backSound => _backSound;
  List<HistoryModel> get history => _history;

  UserProvider() {
    loadAll();
  }

  void loadAll() {
    loadName();
    loadPoint();
    loadBackSound();
    loadHistory();
    loadProgressDaily();
    loadProfile();
  }

  Future<void> loadHistory() async {
    _history = await getAllHistory();
    notifyListeners();
  }

  Future<int> addHistory(HistoryModel itm) async {
    final id = await insertHistory(
      lesson: itm.lesson,
      level: itm.level,
      point: itm.point,
    );

    final newItem = HistoryModel(
      id: id,
      lesson: itm.lesson,
      level: itm.level,
      point: itm.point,
    );
    _history.add(newItem);
    notifyListeners();
    return id;
  }

  // SERVICE FOR NAME
  // LOAD
  Future<void> loadName() async {
    final savedName = await UserStorage.getDataString(key: 'name');
    _name = savedName.trim().isEmpty? 'Guest' :savedName;
    notifyListeners();
  }
  // UPDATE
  Future<void> updateName(String newName) async {
    _name = newName;
    await UserStorage.setDataString(key: 'name', value: newName);
    notifyListeners();
  }

  // SERVICE FOR BACK SOUND
  // LOAD
  Future<void> loadBackSound() async {
    final isMusicActive = await UserStorage.getDataBool(key: 'backSound');
    _backSound = isMusicActive;
    notifyListeners();
  }
  // UPDATE
  Future<void> updateBackSound(bool isActive) async {
    _backSound = isActive;
    await UserStorage.setDataBool(key: 'backSound', value: isActive);
    notifyListeners();
  }

  // SERVICE FOR POINT RANK
  // LOAD
  Future<void> loadPoint() async {
    final getRank = await UserStorage.getPoint();
    _point = getRank;
    notifyListeners();
  }
  // UPDATE
  Future<void> addPoint(int point) async {
    final getPoint = await UserStorage.getPoint();
    int newPoint = getPoint + point;
    await UserStorage.addPoint(newPoint);
    _point = newPoint;
    notifyListeners();
  }

  // SERVICE FOR PROGRESS
  // LOAD
  Future<void> loadProgressDaily() async {
    final progress = await UserStorage.getProgressDaily();
    _progressDaily = progress;
    debugPrint('progress: $progress');
    notifyListeners();
  }
  // UPDATE
  Future<void> addProgressDaily(int progress) async {
    final oldProgress = await UserStorage.getProgressDaily();
    int newProgress = oldProgress + progress;
    _progressDaily = newProgress;
    await UserStorage.setProgressDaily(newProgress);
    notifyListeners();
  }

  Future<void> loadProfile() async {
    final data = await UserStorage.getDataString(key: 'profile');

    if (data.isEmpty || !data.contains('assets/images/')) {
      _profile = AppImages.defaultProfile;
    } else {
      _profile = data;
    }

    notifyListeners();
  }

}

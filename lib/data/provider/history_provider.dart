import 'package:flutter/cupertino.dart';
import 'package:quizix/data/database/history_service.dart';
import 'package:quizix/models/history_model.dart';

class HistoryProvider extends ChangeNotifier {

  List<HistoryModel> _historyList = [];

  List<HistoryModel> get historyList => _historyList;

  HistoryProvider() {
    loadAllHistory();
  }

  Future<void> loadAllHistory() async {
    try {
      final data = await HistoryService.getAllHistory();
      _historyList = data.isNotEmpty ? data : [];
    } catch (e) {
      _historyList = [];
      debugPrint('Terjadi kesalahan loadAllHistory: $e');
    }
    notifyListeners();
  }
}

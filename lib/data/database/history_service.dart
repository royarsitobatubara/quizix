import 'package:flutter/cupertino.dart';
import 'package:quizix/data/database/db_helper.dart';
import 'package:quizix/data/user_preferences.dart';
import 'package:quizix/models/history_model.dart';

class HistoryService {

  static const String _table = 'history';

  static Future<List<HistoryModel>> getAllHistory() async {
    try{
      final userId = await UserPreferences.getIdUser();
      final db = await DbHelper.instance.database;
      final result = await db.query(_table, where: 'user_id=?',whereArgs: [userId]);
      return result.map((e) => HistoryModel.fromJson(e)).toList();
    }catch(e){
      debugPrint('Terjadi kesalahan pada getAllHistory: $e');
      return [];
    }
  }

  static Future<int> insertHistory(HistoryModel itm) async {
    final db = await DbHelper.instance.database;
    try {
      final id = await db.insert(
        _table,
        HistoryModel(
          userId: itm.userId,
          lesson: itm.lesson,
          level: itm.level,
          point: itm.point,
        ).toJson(),
      );
      return id;
    } catch (e) {
      debugPrint('Terjadi kesalahan pada insertHistory: $e');
      return 0;
    }
  }

}
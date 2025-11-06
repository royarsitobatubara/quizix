import 'package:flutter/cupertino.dart';
import 'package:quizix/data/database/db_helper.dart';
import 'package:quizix/models/detail_history_model.dart';

class DetailHistoryService {

  static const String _table = 'detail_history';

  static Future<void> insertDetailHistory(DetailHistoryModel itm) async {
    try{
      final db = await DbHelper.instance.database;
      await db.insert(
          _table,
          DetailHistoryModel(
            historyId: itm.historyId,
            question: itm.question,
            answer: itm.answer,
            isCorrect: itm.isCorrect,
          ).toJson()
      );
    }catch(e){
      debugPrint('Terjadi kesalahan pada insertDetailHistory: $e');
    }
  }

  static Future<List<DetailHistoryModel>> getAllDetailHistory({required int historyId}) async {
    try{
      final db = await DbHelper.instance.database;
      final result = await db.rawQuery(
          'SELECT * FROM detail_history WHERE history_id = ?', [historyId]
      );
      return result.map((e) => DetailHistoryModel.fromJson(e)).toList();
    }catch(e){
      debugPrint('Terjadi kesalahan pada getAllDetailHistory: $e');
      return [];
    }
  }
}
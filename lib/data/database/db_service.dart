  import 'package:flutter/material.dart';
import 'package:quizix/data/database/db_helper.dart';
import 'package:quizix/models/detail_history_model.dart';
  import 'package:quizix/models/history_model.dart';


  // <--------- HISTORY --------->
  Future<int> insertHistory({
    required String lesson,
    required String level,
    required int point,
  }) async {
    final db = await DbHelper.instance.database;
    try {
      final id = await db.insert(
        'history',
        HistoryModel(lesson: lesson, level: level, point: point).toJson(),
      );
      return id;
    } catch (e) {
      debugPrint('Gagal menyimpan history : $e');
      return 0;
    }
  }

  Future<List<HistoryModel>> getAllHistory() async {
    try{
      final db = await DbHelper.instance.database;
      final result = await db.query('history');
      return result.map((e) => HistoryModel.fromJson(e)).toList();
    }catch(e){
      debugPrint('Gagal mengambil history: $e');
      return [];
    }
  }

  // <--------- DETAIL HISTORY --------->
  Future<void> insertDetailHistory(DetailHistoryModel itm) async {
    try{
      final db = await DbHelper.instance.database;
      await db.insert(
        'detail_history',
        DetailHistoryModel(
            historyId: itm.historyId,
            question: itm.question,
            answer: itm.answer,
            isCorrect: itm.isCorrect,
        ).toJson()
      );
    }catch(e){
      debugPrint('Gagal menyimpan detail history: $e');
    }
  }

  Future<List<DetailHistoryModel>> getAllDetailHistory({required int historyId}) async {
    try{
      final db = await DbHelper.instance.database;
      final result = await db.rawQuery(
        'SELECT * FROM detail_history WHERE history_id = ?', [historyId]
      );
      return result.map((e) => DetailHistoryModel.fromJson(e)).toList();
    }catch(e){
      debugPrint('Gagal mengambil detail history: $e');
      return [];
    }
  }
import 'package:flutter/cupertino.dart';
import 'package:quizix/data/database/db_helper.dart';
import 'package:quizix/data/user_preferences.dart';
import 'package:quizix/models/user_model.dart';

class UserService {

  static const String _table = 'user';

  static Future<List<UserModel>> getAllUser() async {
    try{
      final db = await DbHelper.instance.database;
      final data = await db.query(_table);
      return data.map((itm)=>UserModel.fromJson(itm)).toList();
    }catch(e){
      debugPrint('Terjadi kesalahan pada getAllUser: $e');
      return [];
    }
  }

  static Future<UserModel?> getUserByEmailPassword({required String email, required String password}) async {
    try{
      final db = await DbHelper.instance.database;
      final data = await db.query(_table, where: 'email=? AND password=?', whereArgs: [email, password], limit: 1);
      return UserModel.fromJson(data.first);
    }catch(e){
      debugPrint('Terjadi kesalahan pada getAllUser: $e');
      return null;
    }
  }

  static Future<UserModel?> getUserById() async {
    try {
      final id = await UserPreferences.getIdUser();
      if(id == null) {
        debugPrint('user id di butuhkan di getUserById');
      }
      final db = await DbHelper.instance.database;
      final data = await db.query(_table, where: 'id=?', whereArgs: [id], limit: 1);
      if (data.isEmpty) return null;
      return UserModel.fromJson(data.first);
    } catch (e) {
      debugPrint('Terjadi kesalahan pada getUserById: $e');
      return null;
    }
  }


  static Future<bool> insertUser(UserModel data) async {
    try{
      final db = await DbHelper.instance.database;
      final checkEmail = await db.query(_table, where: 'email=?', whereArgs: [data.email], limit: 1);
      if (checkEmail.isEmpty){
        await db.insert(_table, data.toJson());
        return true;
      }
      debugPrint('Email sudah ada');
      return false;
    }catch(e){
      debugPrint('Terjadi kesalahan pada insertUser: $e');
      return false;
    }
  }

  static Future<bool> updateNameUser(String name) async {
    try {
      final id = await UserPreferences.getIdUser();
      if (id == null) {
        debugPrint('ID user diperlukan');
        return false;
      }
      final db = await DbHelper.instance.database;
      final rows = await db.update(
        _table,
        {'name': name},
        where: 'id=?',
        whereArgs: [id],
      );
      if (rows > 0) {
        return true;
      }
      debugPrint('Tidak ada baris yang terupdate (ID mungkin tidak ditemukan)');
      return false;
    } catch (e) {
      debugPrint('Terjadi kesalahan pada updateNameUser: $e');
      return false;
    }
  }

  static Future<bool> updatePasswordUser(String password) async {
    try {
      final id = await UserPreferences.getIdUser();
      if (id == null) {
        debugPrint('ID user diperlukan');
        return false;
      }
      final db = await DbHelper.instance.database;
      final rows = await db.update(
        _table,
        {'password': password},
        where: 'id=?',
        whereArgs: [id],
      );
      if (rows > 0) {
        return true;
      }
      debugPrint('Tidak ada baris yang terupdate (ID mungkin tidak ditemukan)');
      return false;
    } catch (e) {
      debugPrint('Terjadi kesalahan pada updatePasswordUser: $e');
      return false;
    }
  }

  static Future<bool> updateProfileUser(String imagePath) async {
    try {
      final id = await UserPreferences.getIdUser();
      if (id == null) {
        debugPrint('ID user diperlukan');
        return false;
      }
      if(imagePath.trim().isEmpty){
        debugPrint('Path gambar kosong');
        return false;
      }
      final db = await DbHelper.instance.database;
      final rows = await db.update(
        _table,
        {'profile': imagePath},
        where: 'id=?',
        whereArgs: [id],
      );
      if (rows > 0) {
        return true;
      }
      debugPrint('Tidak ada baris yang terupdate (ID mungkin tidak ditemukan)');
      return false;
    } catch (e) {
      debugPrint('Terjadi kesalahan pada updateProfileUser: $e');
      return false;
    }
  }

  static Future<bool> updatePointUser(int point) async {
    try {
      final id = await UserPreferences.getIdUser();
      final db = await DbHelper.instance.database;
      if (id == null) {
        debugPrint('ID User tidak ditemukan');
        return false;
      }
      final user = await getUserById();
      if (user == null) {
        debugPrint('User tidak ditemukan');
        return false;
      }
      final newPoint = user.point + point;
      final updated = await db.update(
        _table,
        {'point': newPoint},
        where: 'id=?',
        whereArgs: [id],
      );
      if (updated == 0) {
        debugPrint('Gagal update point. Tidak ada row terpengaruh.');
        return false;
      }
      return true;
    } catch (e) {
      debugPrint('Error updatePointUser: $e');
      return false;
    }
  }

  static Future<bool> deleteUserById() async {
    try{
      final id = await UserPreferences.getIdUser();
      final db = await DbHelper.instance.database;
      if (id == null) {
        debugPrint('ID User tidak ditemukan');
        return false;
      }
      final result = await db.delete(_table, where: 'id=?', whereArgs: [id]);
      if(result == 0){
        debugPrint('Gagal delete row. Tidak ada row terpengaruh.');
        return false;
      }
      return true;
    }catch(e){
      debugPrint('Error deleteUserById: $e');
      return false;
    }
  }

}
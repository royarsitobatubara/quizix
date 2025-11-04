import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {

  static final DbHelper instance = DbHelper._init();
  static Database? _database;

  DbHelper._init();

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await _initDB('quizix.db');
    return _database!;
  }

  static Future<void> deleteDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'quizix.db');
    await databaseFactory.deleteDatabase(path);
    _database = null;
  }


  Future _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        lesson TEXT,
        level TEXT,
        point INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE detail_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        history_id INTEGER,
        question TEXT,
        answer TEXT,
        is_correct INTEGER
      )
    ''');

  }
}
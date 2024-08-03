import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseTvShowCachedHelper {
  static final DatabaseTvShowCachedHelper _instance = DatabaseTvShowCachedHelper._internal();
  factory DatabaseTvShowCachedHelper() => _instance;

  DatabaseTvShowCachedHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'tv.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Tv (
        id INTEGER PRIMARY KEY,
        page INTEGER,
        type TEXT,
        data TEXT,
        UNIQUE (page, type) ON CONFLICT REPLACE
      )
    ''');
  }

  Future<int> insertTvShowCached(int page, String data, String type) async {
    final db = await database;
    return await db.insert(
      'Tv',
      {'page': page, 'data': data, 'type': type},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getTvShowCached(int page, String type) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Tv',
      where: 'page = ? AND type = ?',
      whereArgs: [page, type],
    );

    if (maps.isNotEmpty) {
      return maps.first['data'] as String?;
    }
    return null;
  }

  Future<void> deleteAllTvShow() async {
    final db = await database;
    await db.delete('Tv');
  }
}

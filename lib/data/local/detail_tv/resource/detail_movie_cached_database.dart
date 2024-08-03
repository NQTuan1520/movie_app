
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class CachedDetailMovieDatabase {
  static final CachedDetailMovieDatabase _instance = CachedDetailMovieDatabase._internal();
  factory CachedDetailMovieDatabase() => _instance;

  CachedDetailMovieDatabase._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'detail.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Detail (
        id INTEGER PRIMARY KEY,
        page INTEGER,
        type TEXT,
        data TEXT,
        UNIQUE (page, type) ON CONFLICT REPLACE
      )
    ''');
  }

  Future<int> insertCached(int page, String data, String type) async {
    final db = await database;
    return await db.insert(
      'Detail',
      {'page': page, 'data': data, 'type': type},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getCached(int page, String type) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Detail',
      where: 'page = ? AND type = ?',
      whereArgs: [page, type],
    );

    if (maps.isNotEmpty) {
      return maps.first['data'] as String?;
    }
    return null;
  }

  Future<void> deleteAllCached() async {
    final db = await database;
    await db.delete('Tv');
  }
}

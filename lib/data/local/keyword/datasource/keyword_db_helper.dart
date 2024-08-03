// data/datasources/keyword_db_helper.dart
// ignore_for_file: unused_import

import 'dart:math';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../domain/keyword/entity/key_word_entity.dart';

class KeywordDbHelper {
  static final KeywordDbHelper _instance = KeywordDbHelper._internal();
  static Database? _database;

  factory KeywordDbHelper() {
    return _instance;
  }

  KeywordDbHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'keywords.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE keywords(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        keyword TEXT
      )
    ''');
  }

  Future<int> insertKeyword(KeywordEntity keyword) async {
    Database db = await database;
    List<KeywordEntity> keywords = await getKeywords();
    KeywordEntity? existingKeyword = keywords.firstWhere((kw) => kw.name!.toLowerCase() == keyword.name!.toLowerCase());
    // ignore: unnecessary_null_comparison
    if (existingKeyword != null) {
      return 0;
    } else {
      return await db.insert('keywords', keyword.toMap());
    }
  }

  Future<List<KeywordEntity>> getKeywords() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('keywords');
    return List.generate(maps.length, (i) {
      return KeywordEntity.fromMap(maps[i]);
    });
  }

  Future<int> deleteKeyword(int id) async {
    Database db = await database;
    return await db.delete('keywords', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllKeywords() async {
    Database db = await database;
    return await db.delete('keywords');
  }
}

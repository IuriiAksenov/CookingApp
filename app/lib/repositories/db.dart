import 'dart:async';
import 'package:app/repositories/db_base_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

abstract class CookingAppDb {
  static Database _db;

  static int get _version => 1;

  static Future<void> _init() async {
    if (_db != null) {
      return;
    }

    try {
      final databasesPath = await getDatabasesPath();
      final mobilePath = path.join(databasesPath, 'CookingApp.db');
      _db = await openDatabase(
        mobilePath,
        version: _version,
        onCreate: _onCreate,
      );
    } catch (ex) {
      print(ex);
    }
  }

  static void _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE favorite (id INTEGER PRIMARY KEY NOT NULL)');
  }

  static Future<List<Map<String, dynamic>>> query(String table) async {
    await _init();
    return await _db.query(table);
  }

  static Future<bool> isExist(String table, int id) async {
    await _init();
    final res = await _db.query(table, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? true : false;
  }

  static Future<int> insert(String table, DbBaseModel model) async {
    await _init();
    return await _db.insert(table, model.toJson());
  }

  static Future<int> delete(String table, int id) async {
    await _init();
    return await _db.delete(table, where: "id = ?", whereArgs: [id]);
  }

  static Future<int> deleteAll(String table) async {
    await _init();
    return await _db.delete(table);
  }

  static Future<List<Map<String, dynamic>>> rawQuery(String sql) async {
    await _init();
    return await _db.rawQuery(sql);
  }

  static Future<int> rawInsert(String sql) async {
    await _init();
    return await _db.rawInsert(sql);
  }
}

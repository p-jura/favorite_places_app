// ignore_for_file: avoid_print

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'favoritePlaces.db'),
      onCreate: (placesDB, version) {
        return placesDB.execute(
            'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, imagePath TEXT, loc_langitude REAL, loc_longitude, loc_adress TEXT)');
      },
      version: 1,
    ).catchError((error) {
      print('database function error: $error');
    });
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    try {
      final database = await DBHelper.database();
      database.insert(table, data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
    } catch (error) {
      print('insert function error: $error');
    }
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final database = await DBHelper.database();
    return database.query(table);
  }
}

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SqlDb {
  static Future<void> createTbl(sql.Database database) async {
    await database.execute("""CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      namaKegiatan TEXT,
      lokasi TEXT,
      jam TEXT,
      timeStamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<sql.Database> db() async {
    //openDatabase adalah harus sesuai dengan nama table
    return sql.openDatabase("users.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTbl(database);
    });
  }

//CREATE
  static Future<int> createDate(
      String? namaKegiatan, String? lokasi, String? jam) async {
    final db = await SqlDb.db();
    final data = {'namaKegiatan': namaKegiatan, 'lokasi': lokasi, 'jam': jam};
    final id = await db.insert('users', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

//READ
  static Future<List<Map<String, dynamic>>> listData() async {
    final db = await SqlDb.db();
    return db.query('users', orderBy: 'id');
  }

//DETAIL
  static Future<List<Map<String, dynamic>>> detailData(int id) async {
    final db = await SqlDb.db();
    return db.query('users', where: 'id = ?', whereArgs: [id], limit: 1);
  }

//UPDATE
  static Future<int> updateData(
      int id, String? namaKegiatan, String? lokasi, String? jam) async {
    final db = await SqlDb.db();
    final data = {
      'namaKegiatan': namaKegiatan,
      'lokasi': lokasi,
      'jam': jam,
      'timeStamp': DateTime.now().toString()
    };
    final results = db.update('users', data, where: 'id = ?', whereArgs: [id]);
    return results;
  }

//DELETE
  static Future<void> deleteData(int id) async {
    final db = await SqlDb.db();
    try {
      await db.delete('users', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      Text(e.toString());
    }
  }
}

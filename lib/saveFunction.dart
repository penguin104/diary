import 'package:flutter/material.dart';
import 'dart:io';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firstView.dart';
import 'home.dart';
import 'newDiary.dart';
import 'more.dart';
import 'main.dart';
import 'package:go_router/go_router.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// データベースクラス
class diaryViewDB {
  Future<String> getDbPath() async {
    final dbDirectory = await getApplicationSupportDirectory();
    final dbFilePath = dbDirectory.path;
    final path = join(dbFilePath, 'diary.db');
    // final exists = await databaseExists(path);
    return path;
  }

  Future<dynamic> init() async {
    final path = await getDbPath();

    final Future database = openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE diary(id INTEGER PRIMARY KEY, date TEXT, title TEXT, diaryText TEXT, cnt INTEGER)",
        );
      },
    );
    return await database;
  }

  Future<void> insertDiary(diary diarydb) async {
    Future database = init();
    final Database db = await database;
    await db.insert(
      'diary',
      diarydb.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> getDiary() async {
    Future database = init();
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('diary');
    // return List.generate(maps.length, (i) {
    //   return diary(maps[i]['date'], maps[i]['title'], maps[i]['diaryText'],
    //       maps[i]['cnt']);
    // });
    for (var i = 0; i < maps.length; i++) {
      diaryModel.add(diary(maps[i]['date'], maps[i]['title'],
          maps[i]['diaryText'], maps[i]['cnt']));
    }
    debugPrint("get! database");
    return;
  }

  Future<void> updateDiary(diary diaryUp) async {
    Future database = init();
    final db = await database;
    await db.update(
      'diary',
      diaryUp.toMap(),
      where: "id = ?",
      whereArgs: [diaryUp.cnt],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<void> deleteDiary(int id) async {
    Future database = init();
    final db = await database;
    await db.delete(
      'diary',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  diaryViewDB();
}

Future<void> saveData(diary saveDiary) async {
  diaryViewDB save = diaryViewDB();
  save.insertDiary(saveDiary);
  debugPrint("save!!");
  print("a ${await save.getDbPath()}");
}

Future<void> loadData() async {
  debugPrint("load!");
  diaryViewDB load = diaryViewDB();
  for (var i = 0; i < diaryModel.length; i++) {
    debugPrint("remove Model!");
    diaryModel.removeAt(i);
  }
  await load.getDiary();
  return;
}

Future<void> delData(diary delDiary) async {
  debugPrint("del!");
  diaryViewDB del = diaryViewDB();
  del.deleteDiary(delDiary.cnt);
}

Future<void> updateData(diary updateDiary) async {
  debugPrint("update!");
  diaryViewDB update = diaryViewDB();
  update.updateDiary(updateDiary);
}

// Future<List> loadData(String key) async {
//   final prefs = await FlutterSecureStorage();
//   List<String> value;
//   final valueDate = prefs.read(key: "diaryModelDate$key").toString();
//   final valueTitle = prefs.read(key: "diaryModelDate$key").toString();
//   final valueMain = prefs.read(key: "diaryModelDate$key").toString();
//   value = [valueDate, valueTitle, valueMain];
//   return value;
// }
//
// Future<void> saveLen(int value) async {
//   final prefs = await FlutterSecureStorage();
//
//   await prefs.write(key: 'len', value: value.toString());
// }
//
// Future<String> loadLen(String key) async {
//   final prefs = await FlutterSecureStorage();
//
//   final value = prefs.read(key: "len");
//   return value.toString();
// }

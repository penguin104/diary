import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
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

  Future<void> getDiary(WidgetRef ref) async {
    final diaryModelSt = ref.watch(diaryModelState);
    final notifier = ref.read(diaryModelState.notifier);

    Future database = init();
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('diary');
    print("state bef");
    print(notifier.state);

    maps.forEach((d) {
      print(d);
      notifier.state
          .add(diary(d['date'], d['title'], d['diaryText'], d['cnt']));
    });
    debugPrint("get! database");
    diaryModelSt;
    print("watch");
    print(notifier.state);
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

Future<void> loadData(WidgetRef ref) async {
  debugPrint("load!");
  final diaryViewDB load = diaryViewDB();
  final diaryModelSt = ref.watch(diaryModelState);
  final notifier = ref.read(diaryModelState.notifier);

  notifier.state.clear();
  load.getDiary(ref);
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

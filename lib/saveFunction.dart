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
import 'dart:math';

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
    return database;
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
    final notifier = ref.watch(diaryModelState.notifier);

    Future database = init();
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('diary');
    print("state bef");
    print(ref.watch(futureDiary)); //todo futureDiaryにdiaryModelStateが反映されてない

    maps.forEach((d) {
      print(d);
      notifier.state
          .add(diary(d['date'], d['title'], d['diaryText'], d['cnt']));
    });
    debugPrint("get! database");
    print(ref.watch(futureDiary));
    diaryModelSt;
    print("watch");
    print(notifier.state);
    return;
  }

  Future<void> updateDiary(diary diaryUp, int afterCnt) async {
    Future database = init();
    final db = await database;
    await db.update(
      'diary',
      diaryUp.toMap(),
      where: "id = ?",
      whereArgs: [afterCnt],
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

Future<int> maxCnt(WidgetRef ref) async {
  final diaryModelSt = ref.watch(diaryModelState);
  List<int> temp = [];
  int maxCnt = 0;

  for (var value in diaryModelSt) {
    temp.add(value.cnt);
  }
  maxCnt = temp.reduce(max);

  return maxCnt;
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
  print("done1");
  final notifier = ref.watch(diaryModelState.notifier);
  print("done3");
  if (notifier.state.isNotEmpty) {
    print("done4");
    notifier.state.clear();
  }
  print("done5");
  await load.getDiary(ref);
  print("done6");
  return;
}

Future<void> delData(diary delDiary) async {
  debugPrint("del!");
  diaryViewDB del = diaryViewDB();
  del.deleteDiary(delDiary.cnt);
}

Future<void> updateData(WidgetRef ref, int i) async {
  final diaryModelSt = ref.watch(diaryModelState);
  debugPrint("update!");
  diaryViewDB update = diaryViewDB();
  update.updateDiary(diaryModelSt[i], diaryModelSt[i].cnt);
}

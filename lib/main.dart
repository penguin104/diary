import 'package:flutter/material.dart';
import 'firstView.dart';
import 'home.dart';
import 'newDiary.dart';
import 'more.dart';
import 'package:go_router/go_router.dart';
import 'saveFunction.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart'; //画面固定
import 'package:sqflite/sqflite.dart';

class routeApp extends StatelessWidget {
  routeApp({super.key});

  final router = GoRouter(initialLocation: "/home", routes: [
    GoRoute(
      path: "/home",
      builder: (context, state) => homeView(),
    ),
    GoRoute(
      path: "/new",
      builder: (context, state) => newDiary(),
    ),
    GoRoute(
      path: "/more",
      builder: (context, state) => moreView(),
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}

// getDatabasesPathを取得
// var databasesPath = await getDatabasesPath();
// String path = '$databasesPath/demo.db';
//
// // データベースを開く(pathに存在しなければ新規作成)
// Database database = await openDatabase(
// path,
// version: 1,
// onCreate: (Database db, int version) async {
// await db.execute(
// 'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, age INTEGER)'
// );
// });

void main() async {
  // var dbPath = await getDatabasesPath();
  // String path = "$dbPath/diary.db"; //DBパス
  //
  // Database databese = await openDatabase(path, version: 1,
  //     onCreate: (Database db, int version) async {
  //   await db.execute(
  //       'CREATE TABLE diaryDb (id INTEGER PRIMARY KEY, date TEXT, title TEXT,mainText TEXT,cnt INTEGER)');
  // });

  // final a = MaterialApp(
  //   home: Scaffold(
  //     body: homeViewWidget,
  //   ),
// );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  final a = routeApp();

  WidgetsFlutterBinding.ensureInitialized(); //縦画面に固定
  SystemChrome.setPreferredOrientations([
    // 縦向き
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(ScreenUtilInit(
      designSize: const Size(428, 926), //基準となる画面サイズiphon13
      builder: (BuildContext context, Widget? widget) => a,
    ));
  });

  //hello
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'home.dart';
import 'newDiary.dart';
import 'more.dart';
import 'package:go_router/go_router.dart';
import 'saveFunction.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart'; //画面固定
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class diary {
  final String date;
  final String title;
  final String diaryText;
  int cnt;

  Map<String, Object> toMap() {
    return {
      "id": cnt,
      "date": date,
      "title": title,
      "diaryText": diaryText,
      "cnt": cnt,
    };
  }

  // final BuildContext context;
  diary(this.date, this.title, this.diaryText, this.cnt);
}

diary diaryMoreList = diary("", "", "", 0);

final diaryModelState = StateProvider<List<diary>>((ref) {
  List<diary> diaryModel = [];
  return diaryModel;
});
// final futureDiary = FutureProvider((ref) {
//   return ref.watch(diaryModelState);
// });

class routeApp extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final material = MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );

    Future.delayed(Duration(seconds: 1), () {
      //mainでなんとかなんねーかなー

      loadData(ref);
      print("build");
      ref.watch(diaryModelState);
    });
    print("return build");
    return material;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //縦画面に固定
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  final a = routeApp();
  final s = ProviderScope(child: a);

  SystemChrome.setPreferredOrientations([
    // 縦向き
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(ScreenUtilInit(
      designSize: const Size(428, 926), //基準となる画面サイズiphon13
      builder: (BuildContext context, Widget? widget) => s,
    ));
  });

  //hello
}

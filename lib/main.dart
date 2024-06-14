import 'package:flutter/material.dart';
import 'firstView.dart';
import 'home.dart';
import 'newDiary.dart';
import 'more.dart';
import 'package:go_router/go_router.dart';
import 'saveFunction.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart'; //画面固定

Future<void> innerDiary() async {
  dynamic diaryModels;

  for (int i = 0; i < int.parse(loadLen("len").toString()); i++) {
    diaryModels = await loadData(i.toString());
    debugPrint("inner done");
    diaryModel[i] = diary(diaryModels[0].toString(), diaryModels[1].toString(),
        diaryModels[2].toString(), i);
  }
}

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

void main() {
  // final a = MaterialApp(
  //   home: Scaffold(
  //     body: homeViewWidget,
  //   ),
// );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  innerDiary();
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

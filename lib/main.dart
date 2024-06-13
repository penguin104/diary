import 'package:flutter/material.dart';
import 'firstView.dart';
import 'home.dart';
import 'newDiary.dart';
import 'more.dart';
import 'package:go_router/go_router.dart';
import 'saveFunction.dart';

class App extends StatelessWidget {
  App({super.key});

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
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}

void main() {
  final firstView = firstViewWidget();
  final homeViewWidget = homeView();
  final newDiaryWidget = newDiary();
  // final a = MaterialApp(
  //   home: Scaffold(
  //     body: homeViewWidget,
  //   ),
// );
  innerDiary();
  final a = App();
  runApp(a);
  //hello
}

Future<void> innerDiary() async {
  dynamic diaryModels;

  for (int i = 0; i < int.parse(loadLen("len").toString()); i++) {
    diaryModels = await loadData(i);
    diaryModel[i] = diary(diaryModels[0].toString(), diaryModels[1].toString(),
        diaryModels[2].toString(), i);
  }
}

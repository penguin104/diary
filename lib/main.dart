import 'package:flutter/material.dart';
import 'firstView.dart';
import 'home.dart';
import 'newDiary.dart';




void main() {
  final firstView = firstViewWidget();
  final homeViewWidget = homeView();
  final newDiaryWidget = newDiary();
  final a = MaterialApp(
    home: Scaffold(
      body: newDiaryWidget,
    ),
  );
  runApp(a);
  //hello
}

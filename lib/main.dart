import 'package:flutter/material.dart';
import 'firstView.dart';
import 'home.dart';




void main() {
  final firstView = firstViewWidget();
  final homeViewWidget = homeView();
  final a = MaterialApp(
    home: Scaffold(
      body: homeViewWidget,
    ),
  );
  runApp(a);
  //hello
}

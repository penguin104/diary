import 'package:flutter/material.dart';
import 'firstView.dart';
void main() {
  final firstView = firstViewWidget();
  final a = MaterialApp(
    home: Scaffold(
      body: firstView,
    ),
  );
  runApp(a);
  //hello
}

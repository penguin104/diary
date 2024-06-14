import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firstView.dart';
import 'home.dart';
import 'newDiary.dart';
import 'more.dart';
import 'package:go_router/go_router.dart';

Future<void> saveData(
    String valueDate, String valueTitle, String valueText, int cnt) async {
  final prefs = await FlutterSecureStorage();
  debugPrint(valueTitle);
  await prefs.write(key: 'diaryModelDate$cnt', value: valueDate.toString());
  await prefs.write(key: "diaryModelTitle$cnt", value: valueTitle.toString());
  await prefs.write(key: "diaryModelMain$cnt", value: valueText.toString());
}

Future<List> loadData(String key) async {
  final prefs = await FlutterSecureStorage();
  List<String> value;
  final valueDate = prefs.read(key: "diaryModelDate$key").toString();
  final valueTitle = prefs.read(key: "diaryModelDate$key").toString();
  final valueMain = prefs.read(key: "diaryModelDate$key").toString();
  value = [valueDate, valueTitle, valueMain];
  return value;
}

Future<void> saveLen(int value) async {
  final prefs = await FlutterSecureStorage();

  await prefs.write(key: 'len', value: value.toString());
}

Future<String> loadLen(String key) async {
  final prefs = await FlutterSecureStorage();

  final value = prefs.read(key: "len");
  return value.toString();
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firstView.dart';
import 'home.dart';
import 'newDiary.dart';
import 'more.dart';
import 'package:go_router/go_router.dart';

Future<void> saveData(diary value) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString('diaryModelDate${value.cnt}', value.date);
  await prefs.setString("diaryModelTitle${value.cnt}", value.title);
  await prefs.setString("diaryModelMain${value.cnt}", value.diaryText);
}

Future<List> loadData(int key) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> value;
  final valueDate = prefs.getString("diaryModelDate$key").toString();
  final valueTitle = prefs.getString("diaryModelDate$key").toString();
  final valueMain = prefs.getString("diaryModelDate$key").toString();
  value = [valueDate, valueTitle, valueMain];
  return value;
}

Future<void> saveLen(int value) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString('len', value.toString());
}

Future<String> loadLen(String key) async {
  final prefs = await SharedPreferences.getInstance();

  final value = prefs.getString("len");
  return value.toString();
}

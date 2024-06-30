import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class LocalNotifications {
//   //todo ここからコピペしっかり読むように
// //https://zenn.dev/flutteruniv_dev/articles/434310831e41f3
//   Future<void> requestPermissions() async {
//     if (Platform.isIOS || Platform.isMacOS) {
//
//       // var flutterLocalNotificationsPlugin;
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//           IOSFlutterLocalNotificationsPlugin>()
//           ?.requestPermissions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//           MacOSFlutterLocalNotificationsPlugin>()
//           ?.requestPermissions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//     } else if (Platform.isAndroid) {
//       var flutterLocalNotificationsPlugin;
//
//       final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
//       flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>();
//       await androidImplementation?.requestPermission();
//     }
//   }

  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin =
      null;

  //timezoneの初期化
  Future<void> initTimeZone() async {
    tz.initializeTimeZones();
    var tokyo = tz.getLocation('Asia/Tokyo');
    tz.setLocalLocation(tokyo);
  }

  //
  Future<void> Initialization(
      {String iconImage = '@mipmap/ic_launcher'}) async {
    //初期化していなければ処理されない
    if (flutterLocalNotificationsPlugin != null) {
      return;
    }
    await initTimeZone();

    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings(iconImage);

    //IOS
    // IOSInitializationSettings iosInitializationSettings = IOSInitializationSettings(onDidReceiveLocalNotification:onDidReceiveLocalNotification,);

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      // iOS: onDidReceiveLocalNotification: onDidReciveLocalNotification,
    );
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin!.initialize(
      initializationSettings,
      // onSelectNotification:onSelectNotification,
    );
  }

  Future<void> onSelectNotification(String? payload) async {}

  Future<void> onDidReceiveLocalNotification(
      int id, String? title, String? payload) async {}

  Future<bool> SetLocalNotification(String title, String body, DateTime dayTime,
      {String channelID = "TextEditorLocalNotification",
      String ChannelName = "TextEditor_SpecifiedNotification",
      String icon = "@mipmap/ic_lancher"}) async {
    if (flutterLocalNotificationsPlugin == null) {
      return false;
    }
    try {
      tz.TZDateTime scheduleDate = tz.TZDateTime(tz.local, dayTime.year,
          dayTime.month, dayTime.day, dayTime.hour, dayTime.minute);
      NotificationDetails notificationDetails = NotificationDetails(
          //android側
          android: AndroidNotificationDetails(
        channelID,
        ChannelName,
        channelDescription: 'diary_notification',
        icon: icon,
      )
          //IOS側

          );
      await flutterLocalNotificationsPlugin!.zonedSchedule(
          1, //IDは通知ごとに変更する
          title,
          body,
          scheduleDate,
          notificationDetails,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }
}

// extension on AndroidFlutterLocalNotificationsPlugin? {
//   requestPermission() {}
// }

//ここまで

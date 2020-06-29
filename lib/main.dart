import 'package:delau/services/push_notofication_service.dart';
import 'package:delau/widget/navigation/navigationBar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:delau/pages/updateTask.dart';
import 'package:delau/autoriz.dart';
import 'package:delau/pages/notes.dart';
import 'package:delau/oneNote.dart';
import 'package:delau/pages/iconDrag.dart';
import 'package:delau/pages/tts.dart';
import 'package:delau/ratingPage.dart';
import 'package:delau/utils/database_helper.dart';
import 'package:delau/widget/notification.dart';
import 'design/theme.dart';

StatelessWidget getBaner(SharedPreferences prefs) {
  prefs.setBool('banner', false);
  DBNoteProvider.db.firstCreateTable().then((res) {
    print(res.toString() + "Это id из Заметок");
  });

  return MyApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool banner = (prefs.getBool('banner') ?? true);

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _firebaseMessaging.getToken().then((token) {
    print(token);
  });

  PushNotificationService pnf = PushNotificationService();
  await pnf.initialise();

  await initializeDateFormatting();
  runApp(
    banner ? getBaner(prefs) : MyApp(),
  );
}

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: DesignTheme.appTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) =>
            BottomBarWithSheetNavigator(selectedIndex: 0),
        '/ntf': (BuildContext context) => LocalNotificationWidget(),
        '/tts': (BuildContext context) => TTS(),
        '/autoriz': (BuildContext context) => AutorizationPage(),
        '/rating': (BuildContext context) => RatingPage(),
        '/icon': (BuildContext context) => IconDrag(),
        '/notes': (BuildContext context) => Notes(),
        '/note': (BuildContext context) => NotePage(),
        '/updateTask': (BuildContext context) => UpdateTask(),
      },
      onGenerateRoute: (RouteSettings) {
        var path = RouteSettings.name.split('/');

        if (path[1] == 'note') {
          return new MaterialPageRoute(
              builder: (context) => new NotePage(id: path[2]),
              settings: RouteSettings);
        }
        if (path[1] == 'updateTask') {
          return new MaterialPageRoute(
              builder: (context) => new UpdateTask(id: path[2]),
              settings: RouteSettings);
        }

        if (path[1] == 'navigator') {
          return new MaterialPageRoute(
              builder: (context) => new BottomBarWithSheetNavigator(
                  selectedIndex: int.parse(path[2])),
              settings: RouteSettings);
        }
      },
    );
  }
}

import 'package:delau/blocs/authBloc.dart';
import 'package:delau/blocs/userPageBloc.dart';
import 'package:delau/pages/auth/auth.dart';
import 'package:delau/pages/userPage.dart';
import 'package:delau/utils/provider/local_store/database_helper.dart';
import 'package:delau/utils/router/customRouter.dart';
import 'package:delau/widget/navigation/navigationBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:delau/pages/updateTask.dart';
import 'package:delau/oneNote.dart';
import 'package:delau/ratingPage.dart';
import 'package:delau/widget/notification.dart';
import 'design/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isReg = await UserDB.udb.isSetAuthUser();

  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  // _firebaseMessaging.getToken().then((token) {
  // });

  // PushNotificationService pnf = PushNotificationService();
  // await pnf.initialise();

  await initializeDateFormatting();
  runApp(MyApp(isReg: isReg));
}

class MyApp extends StatelessWidget {
  MyApp({@required this.isReg});
  bool isReg;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: DesignTheme.appTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: isReg ? '/navigator/0' : '/',
      routes: {
        '/': (BuildContext context) => ChangeNotifierProvider<AuthPageBloc>(
            create: (_) => AuthPageBloc(), child: AuthPage()),
        '/ntf': (BuildContext context) => LocalNotificationWidget(),
        '/rating': (BuildContext context) => RatingPage(),
        '/note': (BuildContext context) => NotePage(),
        '/updateTask': (BuildContext context) => UpdateTask(),
      },
      onGenerateRoute: (RouteSettings) {
        var path = RouteSettings.name.split('/');

        if (path[1] == 'userPage') {
          return MyCustomRoute(
            builder: (context) => ChangeNotifierProvider<UserPageBloc>(
                create: (_) => UserPageBloc(), child: UserPage()),
          );
        }

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

import 'package:delau/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:delau/utils/notification/notification_helper.dart';

class LocalNotificationWidget extends StatefulWidget {
  @override
  _LocalNotificationWidgetState createState() =>
      _LocalNotificationWidgetState();
}

class _LocalNotificationWidgetState extends State<LocalNotificationWidget> {
  final notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final settingsAndroid = AndroidInitializationSettings('app_icon');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);
  }

  final String _id = "67";
  Future onSelectNotification(String id) async => await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            title('Basics'),
            RaisedButton(
              child: Text('Show notification'),
              onPressed: () => showOngoingNotification(notifications,
                  title: 'Tite', body: 'Body'),
            ),
            RaisedButton(
              child: Text('Replace notification'),
              onPressed: () => showOngoingNotification(notifications,
                  title: 'ReplacedTitle', body: 'ReplacedBody'),
            ),
            RaisedButton(
              child: Text('Other notification'),
              onPressed: () => showOngoingNotification(notifications,
                  title: 'OtherTitle', body: 'OtherBody', id: 20),
            ),
            const SizedBox(height: 32),
            title('Feautures'),
            RaisedButton(
              child: Text('Silent notification'),
              onPressed: () => showSilentNotification(notifications,
                  title: 'SilentTitle', body: 'SilentBody', id: 30),
            ),
            const SizedBox(height: 32),
            title('Cancel'),
            RaisedButton(
              child: Text('Cancel all notification'),
              onPressed: notifications.cancelAll,
            ),
          ],
        ),
      ),
    );
  }

  Widget title(String text) => Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Text(
          text,
          style: Theme.of(context).textTheme.title,
          textAlign: TextAlign.center,
        ),
      );
}

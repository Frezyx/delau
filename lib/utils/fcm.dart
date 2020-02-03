import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:delau/models/notification.dart';
import 'package:audioplayers/audioplayers.dart';

class FCMPage extends StatefulWidget {
  @override
  _FCMPageState createState() => _FCMPageState();
}

class _FCMPageState extends State<FCMPage> {

  AudioPlayer audioPlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
    setupNotification();
  }

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];

  void setupNotification() async {
     _firebaseMessaging.getToken().then((token){
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String , dynamic> message) async {
        print("Message here 1: $message");
        final notification = message['notification'];
        audioPlayer.play('assets/alarm.mp3');
        setState(() {
          messages.add(
            Message(title: notification['title'], body: notification['body'],)
          );
        });
      },

      onResume: (Map<String , dynamic> message) async {
        print("Message here 2: $message");
      },

      onLaunch: (Map<String , dynamic> message) async {
        print("Message here 3: $message");
      },

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      ListView(
        children: messages.map(buildMessage).toList(),
      ),
    );
  }

  @override
  Widget buildMessage(Message message) =>
  ListTile(
    title: Text(message.title),
    subtitle: Text(message.title),
  );
}


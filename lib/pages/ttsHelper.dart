// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';

// class TtsHelper extends StatefulWidget {
//   @override
//   _TtsHelperState createState() => _TtsHelperState();
// }

// class _TtsHelperState extends State<TtsHelper> {

//   final FlutterTts flutterTts = FlutterTts();

//   speak() async{
//     await flutterTts.setPitch(1);
//     await flutterTts.setSpeechRate(0.8);
//     await flutterTts.speak('Это тест, Миша извини, что мешаю');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: RaisedButton(
//         onPressed: (){
//           speak();
//         },
//         child: Text("aaaaaa"),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';

class TtsHelper{
  final FlutterTts flutterTts = FlutterTts();

  speakTasks() async{
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.8);
    await flutterTts.speak('Это тест, Миша извини, что мешаю');
  }

}
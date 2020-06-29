// import 'dart:async';
// import 'package:delau/utils/database_helper.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:date_format/date_format.dart';

// final FlutterTts flutterTts = FlutterTts();

// var countTask =  DBProvider.db.getContNow();

// getVoiceInfo() {
//   DBProvider.db.getContNow().then((res) {
//     print(res);
//     DBProvider.db.getAllTasks().then((secondRes){
//       var bigRes = "";
//       for(int i = 0; i < secondRes.length; i++){
//         var item = secondRes[i];
//         var titleS = " " + item.title;
//         var dateS = "";
//         var timeS = " Время: ${item.time.substring(10,15)}";
//         var formatedDateFromSQL = formatDate(DateTime.parse(item.date), [yyyy, '-', mm, '-', dd]);;
//         var nowDateFormate = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);

//         if(nowDateFormate == formatedDateFromSQL){
//           dateS = " Сегодня ";
//         }
//         else{
//           var day = formatedDateFromSQL.substring(8,10);
//           var month = "";
//           switch(int.parse(formatedDateFromSQL.substring(5,7))){
//             case(1):
//               month = "Января";
//               break;
//             case(2):
//               month = "Февраля";
//               break;
//             case(3):
//               month = "Марта";
//               break;
//             case(4):
//               month = "Апреля";
//               break;
//             case(5):
//               month = "Мая";
//               break;
//             case(6):
//               month = "Июня";
//               break;
//             case(7):
//               month = "Июля";
//               break;
//             case(8):
//               month = "Августа";
//               break;
//             case(9):
//               month = "Сентября";
//               break;
//             case(10):
//               month = "Октября";
//               break;
//             case(11):
//               month = "Ноября";
//               break;
//             default:
//               month = "Декабря";
//               break;
//           }
//           dateS = " Дата: $day $month";
//         }
//         bigRes += titleS + dateS + timeS;
//         print(bigRes);
//       }
//       speakTasks(res.toString(), bigRes);
//     });
//   });
// }
// speakTasks(String res, String bigRes) async{
//     await flutterTts.setPitch(1);
//     await flutterTts.setSpeechRate(0.49);
//     await flutterTts.setLanguage('ru-Ru');
//     await flutterTts.speak('У вас $res задач $bigRes');
//   }

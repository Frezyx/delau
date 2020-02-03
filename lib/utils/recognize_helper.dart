import 'package:delau/models/dbModels.dart';
import 'package:flutter/material.dart';
import 'package:delau/utils/database_helper.dart';
  
  List<String> params = [
    'название',
    'пояснение', 
    'маркер', 
    'дата', 
    'время',
    'приоритет'
  ];

  // List<String> params_perems = [
  //   '','','','','',''
  // ];

bool notAWord(String word){
  // print(word);
  // print(word != params[0] && word != params[1] && word != params[2] && word != params[3] && word != params[4] && word != params[5]);
  return (word != params[0] && word != params[1] 
  && word != params[2] && word != params[3] 
  && word != params[4] && word != params[5]);
}

void perseTaskFromResponse(String speechResponse) {
  print("Я начал парсить");
  List<String> params_perems = speechResponse.split(',');
  // for (int g = 0; g < words.length; g++){
  //   print(words[g]);
  // }
  // for (int i = 0; i < words.length-1; i++){
  //   // print("asas");
  //   for (int j = 0; j < params.length-1; j++){
  //     if(words[i] == params[j]){
  //       print(words[i]);
  //       print("Нашёл");
  //       for(int x = i + 1; x < words.length; x++){
  //         if(notAWord(words[x + 1])){
  //           params_perems[j] = params_perems[j] + words[x];
  //         }
  //         else{
  //           break;
  //         }
  //       }
  //     }
  //   }
  // }
  // runDetector();
  var title = params_perems[0].substring( 1, params_perems[0].length);
    var description = params_perems[1];
    var marker = geterMarker(params_perems[2]);
    var date = geterDate(params_perems[3]);
    var time = params_perems[4] + ":00";
    var paginator = geterPaginator(params_perems[5]);
    print(title+"   "+description+ "      "+marker.toString()+"      "+date+"       "+
    time+"      "+paginator.toString());

                Client now_client = Client(
                    title: title,
                    description: description,
                    marker: marker,
                    priority: paginator,
                    date: date,
                    time: time,
                    done: false
                  );
                
                    // Client now_client = Client(
                    //   title: "Raouf",
                    //   description: "Rahiche",
                    //   marker: 4,
                    //   priority: 3,
                    //   date: "2001-12-12",
                    //   time: "22:22",
                    //   done: false);

              addAtLocalDB(now_client);
    print("Закончил");
    // print("From New Module:    ${params_perems[0]}    ${params_perems[1]}    "+ params_perems[2] + "    "
    //             + params_perems[3] + "    "
    //             + params_perems[4] + "    "
    //             + params_perems[5] + "    "
    //             );
}

// void runDetector(){
//   print("Запущен Детектор");
//     var title = params_perems[0].substring( 1, params_perems[0].length);
//     var description = params_perems[1];
//     var marker = geterMarker(params_perems[2]);
//     var date = geterDate(params_perems[3]);
//     var time = params_perems[4] + ":00";
//     var paginator = geterPaginator(params_perems[5]);

                // Client now_client = new Client(
                //     title: title,
                //     description: description,
                //     marker: marker,
                //     priority: paginator,
                //     date: date,
                //     time: time,
                //     done: false
                //   );

                    // Client now_client = Client(
                    //   title: "Raouf",
                    //   description: "Rahiche",
                    //   marker: 4,
                    //   priority: 3,
                    //   date: "2001-12-12",
                    //   time: "22:22",
                    //   done: false);

//               addAtLocalDB(now_client);
// }

addAtLocalDB(Client nowClient) async{
    await DBProvider.db.newClient(nowClient); 
}

int geterMarker(String str){
  String realStr = str.substring(1, str.length);
    if(realStr == "учеба" || realStr == "универ"){
        return 0;
    }
    if(realStr == "работа"){
        return 1;
    }
    if(realStr == "спорт"){
        return 2;
    }
    if(realStr == "встреча" || realStr == "встречи"){
        return 3;
    }
    if(realStr == "покупки" || realStr == "магазин"){
        return 4;
    }
    return 2;
}

String geterDate(String str){
    String result = "";
    List<String> replace = str.split(' ');
    
    // foreach(replace as replace[1]){
    //     echo replace[1]."//";
        if(replace.length == 2){
            if(replace[1] == 'январь' || replace[1] == 'января'){
                result = "2020-"+"01-"+replace[0];
            }
            if(replace[1] == 'февраль' || replace[1] == 'февраля'){
                result ="2020-"+"02-"+replace[0];
            }
            if(replace[1] == 'март' || replace[1] == 'марта'){
                result ="2020-"+"03-"+replace[0];
            }
            if(replace[1] == 'апрель' || replace[1] == 'апреля'){
                result ="2020-"+"04-"+replace[0];
            }
            if(replace[1] == 'май' || replace[1] == 'мая'){
                result ="2020-"+"05-"+replace[0];
            }
            if(replace[1] == 'июнь' || replace[1] == 'июня'){
                result ="2020-"+"06-"+replace[0];
            }
            if(replace[1] == 'июль' || replace[1] == 'июля'){
                result ="2020-"+"07-"+replace[0];
            }
            if(replace[1] == 'август' || replace[1] == 'августа'){
                result ="2020-"+"08-"+replace[0];
            }
            if(replace[1] == 'сентябрь' || replace[1] == 'сентября'){
                result ="2020-"+"09-"+replace[0];
            }
            if(replace[1] == 'октябрь' || replace[1] == 'октября'){
                result ="2020-"+"10-"+replace[0];
            }
            if(replace[1] == 'ноябрь' || replace[1] == 'ноября'){
                result ="2020-"+"11-"+replace[0];
            }
            if(replace[1] == 'декабрь' || replace[1] == 'декабря'){
                result ="2020-"+"12-"+replace[0];
            }
        }
        else  if(replace.length == 3){
            if(replace[1] == 'январь' || replace[1] == 'января'){
                result =replace[3]+"-"+"01-"+replace[0];
            }
            if(replace[1] == 'февраль' || replace[1] == 'февраля'){
                result =replace[3]+"-"+"02-"+replace[0];
            }
            if(replace[1] == 'март' || replace[1] == 'марта'){
                result =replace[3]+"-"+"03-"+replace[0];
            }
            if(replace[1] == 'апрель' || replace[1] == 'апреля'){
                result =replace[3]+"-"+"04-"+replace[0];
            }
            if(replace[1] == 'май' || replace[1] == 'мая'){
                result =replace[3]+"-"+"05-"+replace[0];
            }
            if(replace[1] == 'июнь' || replace[1] == 'июня'){
                result =replace[3]+"-"+"06-"+replace[0];
            }
            if(replace[1] == 'июль' || replace[1] == 'июля'){
                result =replace[3]+"-"+"07-"+replace[0];
            }
            if(replace[1] == 'август' || replace[1] == 'августа'){
                result =replace[3]+"-"+"08-"+replace[0];
            }
            if(replace[1] == 'сентябрь' || replace[1] == 'сентября'){
                result =replace[3]+"-"+"09-"+replace[0];
            }
            if(replace[1] == 'октябрь' || replace[1] == 'октября'){
                result =replace[3]+"-"+"10-"+replace[0];
            }
            if(replace[1] == 'ноябрь' || replace[1] == 'ноября'){
                result =replace[3]+"-"+"11-"+replace[0];
            }
            if(replace[1] == 'декабрь' || replace[1] == 'декабря'){
                result =replace[3]+"-"+"12-"+replace[0];
            }
        }
    return result;
}

int geterPaginator(String str){
    String realStr = str.substring( 1, str.length);
    if(realStr == "очень важно" || realStr == "самое важное" || realStr == "нереально важно" || realStr == "10" || realStr == "9"){
        return 10;
    }
    if(realStr == "важно" || realStr == "не забудь" || realStr == "важненько" || realStr == "8" || realStr == "7"){
        return 8;
    }
    if(realStr == "средне" || realStr == "не так важно" || realStr == "средняя важность" || realStr == "6" || realStr == "5"){
        return 6;
    }
    if(realStr == "не важно" || realStr == "ниже среднего" || realStr == "так себе" || realStr == "4" || realStr == "3"){
        return 4;
    }
    if(realStr == "насрать" || realStr == "похуй" || realStr == "не важно" || realStr == "2" || realStr == "1"){
        return 2;
    }
    return 0;
}


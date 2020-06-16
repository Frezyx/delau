import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:delau/main.dart';
import 'package:delau/models/dbModels.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'database_helper.dart';

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  httpGet(String link) async{
          var response = await http.get('$link');
            if(response.body.toString()== "1"){
              print("Удачно");
            }
            else{   
              print("Неудачно");
            }
            print(response.body.toString());
      }
      

  void runSync(addId){
    DBProvider.db.getAllTasks().then((data){
      for(int i = 0; i < data.length; i++){
        httpGet("https://delau.000webhostapp.com/flutter/addTask.php?header="+
        data[i].title+"&body="+data[i].description+"&date="+
        data[i].date.toString()+"&time="+data[i].time.toString()+"&marker="+
        data[i].marker.toString()+"&paginator="+data[i].priority.toString()+
        "&user_id="+addId.toString()+"&fromMobile=1&mobile_id="+data[i].id.toString());

        DBProvider.db.passDate(i);
          print("Задача #$i загружена");
      }
    });
  }
    void runSyncLogin(id){
          DBProvider.db.getAllTasks().then((data){
            fetchPosts(http.Client(), "https://delau.000webhostapp.com/flutter/getAllPostsById.php?id="+id.toString()).then((dataSqerver){
              print("Запустили синхронизацию");
              for(int i = 0; i < data.length; i++){
                if(data[i].passed == 0){
                  httpGet("https://delau.000webhostapp.com/flutter/addTask.php?header="+
                  data[i].title+"&body="+data[i].description+"&date="+
                  data[i].date.toString()+"&time="+data[i].time.toString()+"&marker="+
                  data[i].marker.toString()+"&paginator="+data[i].priority.toString()+
                  "&user_id="+id.toString()+"&fromMobile=1&mobile_id="+data[i].id.toString());

                  DBProvider.db.passDate(i);
                    print("Задача #$i загружена на сервер");
                }
              }
            });
        });
  }

class TaskModel {
  final int id;
  final String post_header;
  final String post_body;
  final String time_zd;
  final String date_zd;
  final int marker;
  final int paginator;
  final bool done;
  final int user_id;
  final int fromMobile;
  final int mobile_id;
 
  TaskModel({ this.id, this.post_header, this.post_body,
   this.date_zd, this.time_zd, this.marker,
   this.paginator, this.done, this.user_id, this.fromMobile, this.mobile_id});
 
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: int.parse(json['id']),
      user_id: int.parse(json['user_id']),
      fromMobile: int.parse(json['fromMobile']),
      mobile_id: int.parse(json['mobile_id']),
      post_header: json['post_header'] as String,
      post_body: json['post_body'] as String,
      time_zd: json['time-zd'] as String,
      date_zd: json['date-zd'] as String,
      marker: int.parse(json['marker']),
      paginator: int.parse(json['paginator']),
      done: (int.parse(json['done']) == 0),
      
    );
  }
}

List<TaskModel> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
 
  return parsed.map<TaskModel>((json) => TaskModel.fromJson(json)).toList();
}

Future<List<TaskModel>> fetchPosts(http.Client client, String link) async {
  final response = await client.get(link);
  var data = jsonDecode(response.body);
  return parsePosts(response.body);
}
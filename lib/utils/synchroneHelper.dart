import 'package:connectivity/connectivity.dart';
import 'package:delau/main.dart';
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
            if(response.body.toString()== "0"){
              print("Удачно");
            }
            else{   
              print("Неудачно");
            }
            print(response.body.toString());
      }
      

  void runSync(addId){
    DBProvider.db.getAllClients().then((data){
      for(int i = 0; i < data.length; i++){
        httpGet("https://delau.000webhostapp.com/flutter/addTask.php?header="+
        data[i].title+"&body="+data[i].description+"&date="+
        data[i].date.toString()+"&time="+data[i].time.toString()+"&marker="+
        data[i].marker.toString()+"&paginator="+data[i].priority.toString()+
        "&user_id="+addId.toString());

        DBProvider.db.passDate(i);
        print("Задача #$i загружена");
      }
    });
  }

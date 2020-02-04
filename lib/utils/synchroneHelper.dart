import 'dart:async';
import 'dart:io';
import 'package:delau/utils/database_helper.dart';

Future<bool> getSyncStatus() async{

  bool reg = false;
  DBUserProvider.dbc.getClientUser(1).then((res){
    print(res.reg.toString()+" Ответ о регистрации");
    reg = (res.reg == 1); //Если 1 -> зареган -> True -> делаем синхронизацию;
  });

  try {
  final result = await InternetAddress.lookup('google.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty && reg;
  } on SocketException catch (_) {
    return false;
  }
}
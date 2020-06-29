import 'package:delau/models/marker.dart';
import 'package:delau/models/task.dart';
import 'package:delau/utils/provider/own_api/api.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart';

Future<List<Marker>> getMarkersList(int userID) async {
  Response res = await API.taskHandler.getAllMarkers();

  var data = convert.jsonDecode(res.body);
  List<Marker> markerList = [];

  for (var item in data.entries) {
    markerList.add(new Marker(
      id: item.value[0]['marker_id'],
      icon: item.value[0]['marker_name'],
      //TODO: get name from Marker handler
      name: "Нет",
    ));
  }
  return markerList;
}

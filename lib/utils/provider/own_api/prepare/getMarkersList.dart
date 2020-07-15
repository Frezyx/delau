import 'package:delau/models/marker.dart';
import 'package:delau/models/task.dart';
import 'package:delau/utils/provider/own_api/api.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart';

Future<List<Marker>> getMarkersList() async {
  Response res = await API.taskHandler.getAllMarkers();

  var data = convert.jsonDecode(res.body);
  List<Marker> markerList = [];

  for (var item in data.entries) {
    markerList.add(new Marker(
      id: 0,
      icon: item.value,
      //TODO: get name from Marker handler
      name: item.key,
    ));
  }
  return markerList;
}

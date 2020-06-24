import 'package:delau/design/theme.dart';
import 'package:delau/utils/convert/epochFromDate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';

class AlertManager{

  static Future<double> getPriorityPiker(context) async {
    var selectedPriority = 0.0;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
                  title: Text('Выберете приоритет задачи.', style: TextStyle(fontSize: 20),),
                  actions: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 0.0), 
                          child:
                              StarRating(
                              starConfig:
                                StarConfig(
                                  size: 28,
                                  strokeColor: DesignTheme.mainColor,
                                  fillColor: DesignTheme.mainColor,
                              ),
                              rating: selectedPriority,
                              onChangeRating: (int rating) {
                                selectedPriority = double.parse(rating.toString());
                              },
                            ),
                        ),
                        FlatButton(
                          child: Text('Сохранить'), textColor: DesignTheme.mainColor,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
              ]
            );
          },
        );
      },
    );

    return selectedPriority;
  }

  static Future<int> getTimePikerAlert(BuildContext context) async{
    final TimeOfDay picked = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) return picked.hour;
    return null;
  }
  
  static Future<int> getDatePikerAlert(BuildContext context) async {
        final DateTime picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2018, 8),
          lastDate: DateTime(2101),
        );
        if (picked != null) return epochFromDate(picked);
        else return null;
      }
}
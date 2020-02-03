import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:delau/utils/database_helper.dart';

Widget bannerOne(SharedPreferences prefs) {

  prefs.setBool('banner', false); 
  DBUserProvider.dbc.firstCreateTable();// Меняем значение на false
  return
  MaterialApp( 
    home: Scaffold(
    body:  
    new Builder(
      builder: (BuildContext context) {
      return    
     Column(
        children: <Widget>[
         CarouselSlider(
          items: [
            1,
            2,
            3,
            4,
            5,
            6].map((i) {
            return new Builder(
              builder: (BuildContext context) {
                return new Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 80.0,
                  margin: new EdgeInsets.only(left: 15.0, right: 15.0, top: 40.0, bottom: 40.0),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    boxShadow:<BoxShadow>[
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        offset: Offset(0.0, 4.0),
                        blurRadius: 15.0,
                        
                      ),
                    ],
                    image: DecorationImage(
                    image: AssetImage("assets/profile.jpg"), fit: BoxFit.cover),
                    )
                    //     border: Border.all(
                    //       color: Colors.transparent,
                    //       width: 0,
                    //     ),
                    //     borderRadius: BorderRadius.circular(12),
                  // ),
                  // child: Image.network('http://pic3.16pic.com/00/55/42/16pic_5542988_b.jpg', width: double.infinity),

                );
              },
            );
          }).toList(),
          height: MediaQuery.of(context).size.height,
          // autoPlay: true,
          // autoPlayCurve: Curves.elasticIn,
          // autoPlayDuration: const Duration(milliseconds: 5000),
            ),
           ]
          );
      }
    ),
  ),
  );
}
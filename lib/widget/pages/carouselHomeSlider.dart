import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselHomeSlider extends StatelessWidget {
  const CarouselHomeSlider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
    items: [1,2,3,4,5,6].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow:<BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(0.0, 2.0),
                  blurRadius: 20.0,
                ),
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(""),
          );
        },
      );
    }).toList(),
    options: CarouselOptions(
      viewportFraction: 1,
      height: 140.0,
      autoPlay: true,
      autoPlayCurve: Curves.easeInExpo,
      autoPlayInterval: Duration(milliseconds: 8000), 
      autoPlayAnimationDuration: Duration(milliseconds: 800), 
    ),

    );
  }
}
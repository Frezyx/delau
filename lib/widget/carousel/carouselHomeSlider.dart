import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselHomeSlider extends StatelessWidget {

  CarouselHomeSlider({
    @required List<Widget> this.childrens,
    Key key,
  }) : super(key: key);
  List<Widget> childrens;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
    itemCount: childrens.length,
    itemBuilder: (BuildContext context, int i) { 
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
            child: childrens[i]
          );
     }, 
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
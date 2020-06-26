import 'package:carousel_slider/carousel_slider.dart';
import 'package:delau/design/theme.dart';
import 'package:delau/widget/pages/carouselHomeSlider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedTap = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
            children: <Widget>[
                Container(
                  padding: EdgeInsets.all(0),
                  constraints: BoxConstraints.expand(height: 160),
                  decoration: BoxDecoration(
                    color: DesignTheme.mainColor,
                   // gradient: DesignTheme.gradientButton,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 45, left: 20,right: 20,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:<Widget>[

                    Padding(
                      padding: EdgeInsets.only(left: 15,right: 15,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text("17", style: DesignTheme.biggerWhite),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("понедельник", style: DesignTheme.midleWhiteBold),
                                    Text("Август 2020", style: DesignTheme.midleWhiteLight),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                    ]),
                  ),
              ),
              
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: CarouselHomeSlider(),
              ),
            ],
          ),

          buildTabBar(),

      ],
    );
  }

  Padding buildTabBar() {
    return Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              buildTabButton(0, "Список", Icons.menu),
              buildTabButton(1, "Группы", Icons.border_all),
            ]
          ),
        );
      }

  Container buildTabButton(int index, String text, IconData icon) {
    var isOpen = _selectedTap == index;
    return Container(
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.circular(30.0),
            boxShadow: isOpen ? DesignTheme.buttons.selectedTabHomeShadow : DesignTheme.buttons.tabHomeShadow,
          ),
          child: RaisedButton(
            elevation: 0,
            color: isOpen ? DesignTheme.mainColor : Colors.white,
            child: Row(
              children: <Widget>[
                Icon(icon, color: isOpen ? Colors.white : Colors.black ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(text, style: isOpen ? DesignTheme.buttons.selectedTabText : DesignTheme.buttons.tabText),
                ),
              ],
            ),
            onPressed: () {
              setState((){
                _selectedTap = index;
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        );
  }
}
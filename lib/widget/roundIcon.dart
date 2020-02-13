import 'package:delau/models/dbModels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RoundIcon extends StatefulWidget{
  Client _item;

  RoundIcon({Client item,}): _item = item;

  @override
  _RoundIconState createState() => _RoundIconState(_item);
}

class _RoundIconState extends State<RoundIcon> {
  Client item;
  _RoundIconState(this.item);

    List<IconData> i_add = [
    FontAwesome.book,
    FontAwesome.briefcase,
    MdiIcons.fromString('basketball'),
    FontAwesome.users, 
    MdiIcons.fromString('shopping'),
    FontAwesome.spinner
    ];
  
  @override
  Widget build(BuildContext context) {
    return               Container(
                decoration:  new BoxDecoration(
                boxShadow:<BoxShadow>[
                      BoxShadow(
                        color: Color.fromRGBO(71, 9, 150, 0.17),
                        offset: Offset(0.0, 4.0),
                        blurRadius: 15.0,
                      ),
                    ],
                gradient: new LinearGradient(
                      colors: [
                      Color.fromRGBO(162, 122, 246, 1),
                      Color.fromRGBO(114, 103, 239, 1),
                      // Color.fromRGBO(81, 20, 219, 1),
                      // Color.fromRGBO(31, 248, 169, 1),
                      ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.0,1.0],
                    tileMode: TileMode.clamp
                    ),
                    border: Border.all(
                          color: Colors.transparent,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(50),

                ),
                child: Center(
                  child:
                  Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    (item.marker <= 5) ? i_add[item.marker] : MdiIcons.fromString('${item.icon}'),
                    size: 18,
                    color: Colors.white,
                    ),
                ),
                ),
              );
  }
}
import 'package:delau/design/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomSheetAndBar extends StatefulWidget{
  BottomSheetAndBar({List<BottomBarItemButton> items}): _items = items;
  final _items;

  @override
  _BottomSheetAndBarState createState() => _BottomSheetAndBarState(_items);
}

class _BottomSheetAndBarState extends State<BottomSheetAndBar>{ 
  _BottomSheetAndBarState(
    this.items,
  );

  List<BottomBarItemButton> items;
  int selectedIndex;


  @override
  Widget build(BuildContext context) {
    return Container(
          height: 60,
          child: Container(
            margin: EdgeInsets.only(left: 0.0, right: 100),
            child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: items,
                ),
          ),
        );
  }
}

class BottomBarItemButton extends StatefulWidget {
  BottomBarItemButton({
    IconData icon, 
    String text,
    int index,
    int selectedIndex
  }): 
  _icon = icon,
  _text = text,
  _index = index,
  _selectedIndex = selectedIndex;

  final _icon;
  final _text;
  final _index;
  final _selectedIndex;

  @override
  _BottomBarItemButtonState createState() => _BottomBarItemButtonState(_icon, _text, _index, _selectedIndex);
}

class _BottomBarItemButtonState extends State<BottomBarItemButton> {

  _BottomBarItemButtonState(
    this.icon,
    this.text,
    this.index,
    this.selectedIndex,
  );

  bool isOpen;
  IconData icon;
  String text;
  int index;
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      focusColor: Colors.white,
      splashColor: Colors.white,
      hoverColor: Colors.white,
      highlightColor: Colors.white,
       onPressed: () {
         print("gggggggg");
       },
       child:Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget>[
               isOpen ? buildOpenedButton(icon) : buildClosedButton(icon),
               SizedBox(height: 2.5),
               Text(
                 text,
                 style: index == selectedIndex ? 
                 DesignTheme.bnb.mainColorText : DesignTheme.bnb.closedColorText,
               ),
             ],
           ),
         );
  }

  Widget buildClosedButton(IconData icon){
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Icon( 
        icon,
        size: 17,
        color: DesignTheme.greyMedium,
      ),
    );
  }

  Widget buildOpenedButton(IconData icon) {
    return Center(
               child: ClipOval(
                 child: Material(
                   color: DesignTheme.mainColor, // button color
                   child: Ink(
                     // splashColor: DesignTheme.secondColor,
                     child: SizedBox(
                       child: Padding(
                         padding: const EdgeInsets.all(12.0),
                         child: Icon(
                           icon,
                           size: 17,
                           color: Colors.white,
                           ),
                       )
                       ),
                   ),
                 ),
               ),
             );
  }
}
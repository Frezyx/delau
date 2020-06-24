import 'package:delau/design/theme.dart';
import 'package:delau/models/templates/radio.dart';
import 'package:flutter/material.dart';


getCustomRadio(RadioModel _item, int lastItem){
  

  return new Container(
      margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 50.0,
            width: 50.0,
            child: new Center(
              child: new Icon(_item.icon,

              color:_item.isSelected ? Colors.white : _item.index == lastItem ? DesignTheme.mainColor : Colors.black26,
              ),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected
                  ? DesignTheme.mainColor
                  : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected
                      ? DesignTheme.mainColor
                      : _item.index == lastItem ? DesignTheme.mainColor : Colors.black26),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(left: 0.0, top: 4.0),
            child: 
              new Text(
                _item.text,
                style: TextStyle(color:_item.isSelected ? DesignTheme.mainColor
                : _item.index == lastItem ? DesignTheme.mainColor :Colors.black54,),

                ),
          )
        ],
      ),
    );
}
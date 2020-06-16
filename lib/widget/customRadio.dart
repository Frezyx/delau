import 'package:flutter/material.dart';
import '../addTaskPage.dart';

getCustomRadio(RadioModel _item, int lastItem){
  

  return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 50.0,
            width: 50.0,
            child: new Center(
              child: new Icon(_item.icon,

              color:_item.isSelected ? Colors.white : _item.index == lastItem ? Color.fromRGBO(114, 103, 239, 1) : Colors.black26,
              ),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected
                  ? Color.fromRGBO(114, 103, 239, 1)
                  : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected
                      ? Color.fromRGBO(114, 103, 239, 1)
                      : _item.index == lastItem ? Color.fromRGBO(114, 103, 239, 1) : Colors.black26),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(left: 0.0, top: 4.0),
            child: 
              new Text(
                _item.text,
                style: TextStyle(color:_item.isSelected ? Color.fromRGBO(114, 103, 239, 1)
                : _item.index == lastItem ? Color.fromRGBO(114, 103, 239, 1) :Colors.black54,),

                ),
          )
        ],
      ),
    );
}
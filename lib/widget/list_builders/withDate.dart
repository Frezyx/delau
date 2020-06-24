import 'package:delau/blocs/listItemBloc.dart';
import 'package:delau/design/theme.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class ListWithDateItem extends StatefulWidget {

  final int listPosition;
  final List<dynamic> data;

  ListWithDateItem({
    Key key,
    @required this.listPosition,
    @required this.data,
  }) : super(key: key);

  @override
  _ListWithDateItemState createState() => _ListWithDateItemState();
}

class _ListWithDateItemState extends State<ListWithDateItem> {
  bool isOpen;

  @override
  Widget build(BuildContext context) {

    var topSpace = widget.listPosition == 0 ? 22.0 : 9.0;
    var bottomSpace = widget.listPosition == widget.data.length - 1? 22.0 : 9.0;
    final listItemBlocState = Provider.of<ListItemBloc>(context);

    isOpen = Provider.of<bool>(context);

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: topSpace, bottom: bottomSpace),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: listItemBlocState.selectedEvents[widget.listPosition].isChecked ? 
                  Colors.green.withOpacity(0.18) : Color.fromRGBO(0, 0, 0, 0.05),
                  offset: Offset(0.0, 3.0),
                  spreadRadius: 2.0,
                  blurRadius: 11.0,
                ),
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 14.0, left: 2.0),
                    child: Icon(
                      MdiIcons.fromString('${listItemBlocState.getItemIcon(widget.listPosition)}'), 
                      color: listItemBlocState.selectedEvents[widget.listPosition].isChecked? Colors.green : DesignTheme.mainColor
                    ),
                  ),
              AnimatedContainer(
                duration: Duration(milliseconds: 1500),
                // TODO: ADAPTIVE SOLUTION
                width: 152,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(

                      height: listItemBlocState.selectedEvents[widget.listPosition].isOpen? 
                        DesignTheme.size.getAboutHeight(
                          listItemBlocState.selectedEvents[widget.listPosition].description.length, 12,
                          listItemBlocState.selectedEvents[widget.listPosition].name.length,20, true,
                        ): 25,

                      child: Expanded(child:Text(
                        widget.data[widget.listPosition].name,
                        style: DesignTheme.listItemLabel,
                        overflow: listItemBlocState.selectedEvents[widget.listPosition].isOpen? TextOverflow.fade : TextOverflow.ellipsis)
                      ),
                    ),
                    Container(

                      height: listItemBlocState.selectedEvents[widget.listPosition].isOpen? 
                        DesignTheme.size.getAboutHeight(
                          listItemBlocState.selectedEvents[widget.listPosition].description.length, 12,
                          listItemBlocState.selectedEvents[widget.listPosition].name.length,20, false,
                        ): 15,

                      child: Expanded(child: Text(
                        widget.data[widget.listPosition].description,
                        style: DesignTheme.listItemSubtitle,
                        overflow: listItemBlocState.selectedEvents[widget.listPosition].isOpen? TextOverflow.fade : TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Checkbox(
                      activeColor: listItemBlocState.selectedEvents[widget.listPosition].isChecked? Colors.green: DesignTheme.mainColor,
                        onChanged: (bool value) {
                          // setState((){
                            listItemBlocState.changeCheckState(widget.listPosition);
                          // });
                        },
                      value: listItemBlocState.selectedEvents[widget.listPosition].isChecked,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  Widget displayTime(String time) {
    return Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Text(time, style: DesignTheme.listTime, textAlign: TextAlign.center,),
        ));
  }
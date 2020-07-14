import 'package:delau/blocs/listItemBloc.dart';
import 'package:delau/design/theme.dart';
import 'package:delau/utils/provider/own_api/api.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class ListWithDateItem extends StatefulWidget {
  final int listPosition;
  final List<dynamic> data;
  final DateTime date;

  ListWithDateItem({
    Key key,
    @required this.listPosition,
    @required this.data,
    @required this.date,
  }) : super(key: key);

  @override
  _ListWithDateItemState createState() => _ListWithDateItemState();
}

class _ListWithDateItemState extends State<ListWithDateItem> {
  bool isOpen;

  @override
  Widget build(BuildContext context) {
    var topSpace = widget.listPosition == 0 ? 22.0 : 9.0;
    var bottomSpace =
        widget.listPosition == widget.data.length - 1 ? 22.0 : 9.0;
    final listItemBlocState = Provider.of<ListItemBloc>(context);
    final selectedTasks = listItemBlocState.getEventsByDate(widget.date);

    isOpen = Provider.of<bool>(context);

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: topSpace, bottom: bottomSpace),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: selectedTasks[widget.listPosition].isChecked
                  ? DesignTheme.greyLight
                  : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: DesignTheme.greyDark.withOpacity(0.05),
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
                    MdiIcons.fromString(
                        '${selectedTasks[widget.listPosition].icon}'),
                    color: selectedTasks[widget.listPosition].isChecked
                        ? DesignTheme.greyDark
                        : DesignTheme.mainColor),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 1000),
                width: MediaQuery.of(context).size.width / 2.65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: selectedTasks[widget.listPosition].isOpen
                          ? DesignTheme.size.getAboutHeight(
                              selectedTasks[widget.listPosition]
                                  .description
                                  .length,
                              12,
                              selectedTasks[widget.listPosition].name.length,
                              18,
                              true,
                            )
                          : 25,
                      child: Expanded(
                          child: Text(widget.data[widget.listPosition].name,
                              style:
                                  selectedTasks[widget.listPosition].isChecked
                                      ? DesignTheme.listItemLabelChecked
                                      : DesignTheme.listItemLabel,
                              overflow:
                                  selectedTasks[widget.listPosition].isOpen
                                      ? TextOverflow.fade
                                      : TextOverflow.ellipsis)),
                    ),
                    Container(
                      height: selectedTasks[widget.listPosition].isOpen
                          ? DesignTheme.size.getAboutHeight(
                              selectedTasks[widget.listPosition]
                                  .description
                                  .length,
                              12,
                              selectedTasks[widget.listPosition].name.length,
                              18,
                              false,
                            )
                          : 15,
                      child: Expanded(
                        child: Text(
                            widget.data[widget.listPosition].description,
                            style: DesignTheme.listItemSubtitle,
                            overflow: selectedTasks[widget.listPosition].isOpen
                                ? TextOverflow.fade
                                : TextOverflow.ellipsis),
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
                      activeColor: selectedTasks[widget.listPosition].isChecked
                          ? DesignTheme.greyDark
                          : DesignTheme.mainColor,
                      onChanged: (bool value) {
                        selectedTasks[widget.listPosition].isChecked =
                            !selectedTasks[widget.listPosition].isChecked;
                        listItemBlocState.notify();
                        API.taskHandler
                            .checkTask(selectedTasks[widget.listPosition].id)
                            .then((res) {
                          if (!res) {
                            selectedTasks[widget.listPosition].isChecked =
                                !selectedTasks[widget.listPosition].isChecked;
                            listItemBlocState.notify();
                          }
                        });
                      },
                      value: selectedTasks[widget.listPosition].isChecked,
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
    child: Text(
      time,
      style: DesignTheme.listTime,
      textAlign: TextAlign.center,
    ),
  ));
}

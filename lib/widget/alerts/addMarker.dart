import 'package:delau/design/theme.dart';
import 'package:delau/models/marker.dart';
import 'package:delau/models/task.dart';
import 'package:delau/models/templates/radio.dart';
import 'package:delau/utils/iconList.dart';
import 'package:delau/widget/buttons/allertButton.dart';
import 'package:delau/widget/inputs/customRadio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddMarkerAlert extends StatefulWidget {
  @override
  _AddMarkerAlertState createState() => _AddMarkerAlertState();
}

class _AddMarkerAlertState extends State<AddMarkerAlert> {
  final _formKey = GlobalKey<FormState>();
  Marker marker = Marker();
  List<RadioModel> sampleData = new List<RadioModel>();
  ScrollController scrollController;
  var _selectedMarkerIndex;
  var alertHeight = 2;

  @override
  void initState() {
    super.initState();
  }

  setAlertHeight() {
    setState(() {
      alertHeight = alertHeight == 2 ? alertHeight = 6 : alertHeight = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 15.0, left: 15.0, right: 15.0, bottom: 15.0),
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 14.0, top: 4.0, left: 8.0, right: 8.0),
                child: Text(
                  "Добавление маркера",
                  style: DesignTheme.alert.bigText,
                ),
              ),
              buildTitleTextField(),
              Container(
                  height: MediaQuery.of(context).size.height / alertHeight,
                  child: Expanded(
                    child: AnimationLimiter(
                      child: StaggeredGridView.countBuilder(
                          controller: scrollController,
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          crossAxisCount: 5,
                          itemCount: iconsMaterial.length,
                          itemBuilder: (context, i) {
                            return AnimationConfiguration.staggeredGrid(
                                position: i,
                                duration: const Duration(milliseconds: 375),
                                columnCount: 5,
                                child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                        child: getMarkerButton(
                                            iconsMaterial, i))));
                          },
                          staggeredTileBuilder: (int i) =>
                              StaggeredTile.count(1, 1)),
                    ),
                  )),
              SizedBox(height: 5),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    getBottomButton("Отменить", Icons.add, Colors.red, context,
                        close, true, _formKey),
                    getBottomButton(
                        "Сохранить",
                        Icons.add,
                        DesignTheme.mainColor,
                        context,
                        validate,
                        false,
                        _formKey),
                    // getBottomButton("Отменить", Icons.add, Colors.red, context),
                    // getBottomButton(
                    //     "Сохранить", Icons.add, DesignTheme.mainColor, context),
                  ]),
            ]),
          ),
        ),
      ],
    ));
  }

  close(context) {
    Navigator.pop(context);
  }

  validate(_formKey) {
    _formKey.currentState.validate();
  }

  getMarkerButton(iconsMaterial, i) {
    return OutlineButton(
        disabledBorderColor: i == _selectedMarkerIndex
            ? DesignTheme.mainColor
            : DesignTheme.greyMedium,
        highlightedBorderColor: i == _selectedMarkerIndex
            ? DesignTheme.mainColor
            : DesignTheme.greyMedium,
        color: i == _selectedMarkerIndex ? DesignTheme.mainColor : Colors.white,
        hoverColor: Colors.white,
        focusColor: Colors.white,
        highlightColor: Colors.white,
        splashColor: DesignTheme.mainColor,
        onPressed: () {
          marker.icon = iconsMaterial[i];
          var buf = iconsMaterial[0];
          setState(() {
            iconsMaterial[0] = iconsMaterial[i];
            iconsMaterial[i] = buf;
            _selectedMarkerIndex = 0;
          });
        },
        child: Padding(
            padding: EdgeInsets.only(bottom: 5, top: 5),
            child: Icon(
              MdiIcons.fromString(iconsMaterial[i]),
              color: i == _selectedMarkerIndex
                  ? DesignTheme.mainColor
                  : DesignTheme.greyMedium,
            )));
  }

  Widget buildTitleTextField() {
    return TextFormField(
      key: Key('title_task'),
      onTap: () {
        setAlertHeight();
      },
      cursorColor: DesignTheme.mainColor,
      decoration: InputDecoration(
        hintText: "Назовите свой маркер",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTheme.normalBorderRadius),
          borderSide: BorderSide(
            style: BorderStyle.solid,
          ),
        ),
      ),
      validator: (value) {
        if (value.isEmpty)
          return 'Введите название маркера';
        else {
          marker.name = value.toString();
        }
      },
    );
  }
}

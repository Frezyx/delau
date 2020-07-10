import 'package:delau/blocs/userPageBloc.dart';
import 'package:delau/design/theme.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

getPhoto(double screenHeight, double screenWidth, Widget _child) {
  var imgContainerWidth = screenWidth / 2.2;
  var imgContainerHeight = imgContainerWidth;

  return AnimatedContainer(
    duration: Duration(milliseconds: 300),
    width: imgContainerWidth,
    height: imgContainerHeight,
    decoration: new BoxDecoration(
      gradient: DesignTheme.imgCircleGradient,
      borderRadius: new BorderRadius.circular(imgContainerWidth),
    ),
    child: AnimatedContainer(
      duration: Duration(milliseconds: 600),
      margin: EdgeInsets.all(12.5),
      width: imgContainerWidth,
      height: imgContainerHeight,
      decoration: new BoxDecoration(
        color: DesignTheme.mainColor,
        borderRadius: new BorderRadius.circular(imgContainerWidth),
      ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 900),
        margin: EdgeInsets.all(10),
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
              fit: BoxFit.cover,
              image: new NetworkImage(
                  "https://avatars.mds.yandex.net/get-pdb/1779125/deed738a-66f5-46d0-b3c6-020dff434219/s1200")),
        ),
        child: _child,
      ),
    ),
  );
}

getInfoCard(context, String count, String param) {
  final userPageBloc = Provider.of<UserPageBloc>(context);
  var itemSize = MediaQuery.of(context).size.width / 4;
  return Column(
    children: <Widget>[
      Container(
        width: itemSize,
        height: itemSize,
        child: Card(
            shadowColor: Colors.black.withOpacity(0.15),
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            color: Colors.white,
            child: InkWell(
                highlightColor: Colors.white,
                hoverColor: DesignTheme.mainColor,
                focusColor: DesignTheme.mainColor,
                splashColor: DesignTheme.mainColor,
                onLongPress: () {},
                onTap: () {},
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    userPageBloc.isParamLoad
                        ? Text(count, style: DesignTheme.infoCardText)
                        : CircularProgressIndicator(),
                  ],
                ))),
      ),
      SizedBox(height: 10),
      Center(
        child: userPageBloc.isParamLoad
            ? Text(param,
                style: DesignTheme.infoCardUnderLineText,
                overflow: TextOverflow.fade)
            : LinearProgressIndicator(),
      ),
    ],
  );
}

buildNotifyField(String nameField, String valueField) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
    child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(nameField, style: DesignTheme.typeFieldText),
                SizedBox(height: 3),
                Text(valueField, style: DesignTheme.valueFieldText),
              ]),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Уведомления", style: DesignTheme.notifyText),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: InkWell(
                    onTap: () {},
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: 14,
                      height: 14,
                      decoration: new BoxDecoration(
                        color: Colors.transparent,
                        border: new Border.all(
                            width: 1.0, color: DesignTheme.greyDark),
                        borderRadius: new BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ]),
        ]),
  );
}

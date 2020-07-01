import 'package:delau/blocs/userPageBloc.dart';
import 'package:delau/design/theme.dart';
import 'package:delau/widget/appBar/appBar.dart';
import 'package:delau/widget/pages/userEditPage.dart';
import 'package:delau/widget/pages/userPage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UserEditPage extends StatefulWidget {
  @override
  _UserEditPageState createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  var userPageBloc;
  double screenWidth = 0;
  double screenHeight = 0;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    userPageBloc = Provider.of<UserPageBloc>(context);
    setState(() {
      screenWidth = MediaQuery.of(context).size.width;
      screenHeight = MediaQuery.of(context).size.height;
    });
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
            body: Builder(
                builder: (context) => SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 10.0),
                      child: buildBody(context),
                    )))));
  }

  Column buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        getAppBar("Редактрирование профиля", context),
        Form(
            key: _formKey,
            child: Column(children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      getPhoto(
                        screenHeight,
                        screenWidth,
                        getPhotoButton(),
                      ),
                      TextFormField(
                        controller: _weightController,
                        cursorColor: DesignTheme.mainColor,
                        decoration: InputDecoration(
                            labelText: 'Имя',
                            labelStyle: DesignTheme.textFieldLabel,
                            suffixIcon: Icon(
                              FontAwesomeIcons.user,
                            )),
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Введите ваш имя';
                          else {
                            // user.weight = double.parse(value);
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _heightController,
                        cursorColor: DesignTheme.mainColor,
                        decoration: InputDecoration(
                            labelText: 'Фамилия',
                            labelStyle: DesignTheme.textFieldLabel,
                            suffixIcon: Icon(
                              FontAwesomeIcons.user,
                            )),
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Введите вашу фамилию';
                          else {
                            // user.height = double.parse(value);
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _ageController,
                        cursorColor: DesignTheme.mainColor,
                        decoration: InputDecoration(
                            labelText: 'E-mail',
                            labelStyle: DesignTheme.textFieldLabel,
                            suffixIcon: Icon(
                              Icons.alternate_email,
                            )),
                        validator: (value) {
                          if (value.isEmpty) return 'Введите ваш email';
                          if (!EmailValidator.validate(value, true))
                            return 'Введите реальный email адресс';
                          else {
                            // user.age = double.parse(value);
                          }
                        },
                      ),
                    ]),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: DesignTheme.buttons.tabHomeShadow),
                      child: RaisedButton(
                        elevation: 0,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.close, color: Colors.red),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text("Отменить",
                                  style: DesignTheme.buttons.selectedTabText
                                      .copyWith(color: Colors.red)),
                            ),
                          ],
                        ),
                        onPressed: () {
                          userPageBloc.pageIndex = 0;
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: DesignTheme.buttons.selectedTabHomeShadow),
                      child: RaisedButton(
                        elevation: 0,
                        color: DesignTheme.mainColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.save, color: Colors.white),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text("Сохранить",
                                  style: DesignTheme.buttons.selectedTabText),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Scaffold.of(context).showSnackBar(snackBar);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
            ])),
      ],
    );
  }
}

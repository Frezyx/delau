import 'package:delau/design/theme.dart';
import 'package:delau/widget/appBar/appBar.dart';
import 'package:delau/widget/pages/userEditPage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserEditPage extends StatefulWidget {
  @override
  _UserEditPageState createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  double screenWidth = 0;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _weightController = new TextEditingController();
  final TextEditingController _heightController = new TextEditingController();
  final TextEditingController _ageController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    setState(() {
      screenWidth = MediaQuery.of(context).size.width;
    });
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
            body: SingleChildScrollView(
                child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
          child: Column(
            children: <Widget>[
              getAppBar("Редактрирование профиля", context),
              Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 20, top: 40, right: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                              width: MediaQuery.of(context).size.height * 0.20,
                              height: MediaQuery.of(context).size.height * 0.20,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: new NetworkImage(
                                          "https://avatars.mds.yandex.net/get-pdb/1779125/deed738a-66f5-46d0-b3c6-020dff434219/s1200"))),
                              child: getPhotoButton(),
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
                            new SizedBox(height: 10),
                            new TextFormField(
                              controller: _heightController,
                              cursorColor: DesignTheme.mainColor,
                              decoration: InputDecoration(
                                  labelText: 'Рост',
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
                                borderRadius: new BorderRadius.circular(30.0),
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
                                        style: DesignTheme
                                            .buttons.selectedTabText
                                            .copyWith(color: Colors.red)),
                                  ),
                                ],
                              ),
                              onPressed: () {},
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
                                borderRadius: new BorderRadius.circular(30.0),
                                boxShadow:
                                    DesignTheme.buttons.selectedTabHomeShadow),
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
                                        style: DesignTheme
                                            .buttons.selectedTabText),
                                  ),
                                ],
                              ),
                              onPressed: () {},
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
          ),
        ))));
  }
}

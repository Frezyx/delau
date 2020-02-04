import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class RegistrationPage extends StatefulWidget{
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _email;
  String _login;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        padding: EdgeInsets.only(left: 40.0, right: 40.0, top:MediaQuery.of(context).size.height/5, bottom: MediaQuery.of(context).size.height/10),// color: Colors.transparent,
              child: new Form(key: _formKey, child: new Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only( left :MediaQuery.of(context).size.width/30, right :MediaQuery.of(context).size.width/30,),
              child:                 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,   

                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                          Navigator.pushNamed(context, '/autoriz');
                        },
                        splashColor: Colors.transparent,  
                        highlightColor: Colors.transparent,

                        child: Text(
                          "Вход",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18.0,
                          ),
                          
                        ),
                      ),
                    FlatButton(
                      onPressed: () {
                          /*...*/
                        },
                        splashColor: Colors.transparent,  
                        highlightColor: Colors.transparent,

                        child: Text(
                          "Регистрация",
                          style: TextStyle(
                            color: Color.fromRGBO(114, 103, 239, 1),
                            // decoration: TextDecoration.underline,
                            fontSize: 18.0,
                            ),
                        ),
                      ),
                  ],  
                ),
              ),

                new TextFormField(
                  cursorColor: Color.fromRGBO(114, 103, 239, 1),
                  decoration: InputDecoration(   
                  labelText: 'Ваше имя и фамилия',  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),     
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Color.fromRGBO(114, 103, 239, 1)),
                  ),    
                ),
                validator: (value){
                  if (value.isEmpty) return 'Введите ваше имя и фамилию';
                  else {
                    _name = value.toString();
                  }
                },
              ),

              new SizedBox(height: 10.0,),

              new TextFormField(
                  cursorColor: Color.fromRGBO(114, 103, 239, 1),
                  decoration: InputDecoration(   
                  labelText: 'Ваш e-mail',  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),     
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Color.fromRGBO(114, 103, 239, 1)),
                  ),    
                ),
                validator: (value){
                  if (value.isEmpty) return 'Введите ваш e-mail';
                  else {
                    _email = value.toString();
                  }
                },
              ),
              new SizedBox(height: 10.0,),

              new TextFormField(
                  cursorColor: Color.fromRGBO(114, 103, 239, 1),
                  decoration: InputDecoration(   
                  labelText: 'Ваш логин',  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),     
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Color.fromRGBO(114, 103, 239, 1)),
                  ),    
                ),
                validator: (value){
                  if (value.isEmpty) return 'Введите ваш логин';
                  else {
                    _login = value.toString();
                  }
                },
              ),
              new SizedBox(height: 10.0,),

               TextFormField(
                  cursorColor: Color.fromRGBO(114, 103, 239, 1),
                  decoration: InputDecoration(   
                  labelText: 'Ваш пароль',  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    
                  ),     
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Color.fromRGBO(114, 103, 239, 1)),
                  ),    
                ),
                validator: (value){
                  if (value.isEmpty) return 'Введите ваш пароль';
                  else {
                    _password = value.toString();
                  }
                },
                obscureText: true,
              ),
              new SizedBox(height: 20.0,),

            // Padding(
            //   padding: EdgeInsets.only( left :MediaQuery.of(context).size.width/30, right :MediaQuery.of(context).size.width/30,),
            //   child: 
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     crossAxisAlignment: CrossAxisAlignment.center,

            //     children: <Widget>[
                //   RaisedButton(onPressed: (){
                //   if(_formKey.currentState.validate()){
                //     if(_name != null && _email != null && _login != null && _password != null){
        
                //       // Client now_client = new Client(
                //       //       title: _name,
                //       //       description: _surname,
                //       //       marker: selected_radio-1,
                //       //       priority: rating.round(),
                //       //       date: _date.toString(),
                //       //       time: _time.toString(),
                //       //       done: false
                //       //     );

                //       // addAtLocalDB(now_client);
                //       // counter();

                //       // getSyncStatus().then((synchronise){
                //       //     if (synchronise){
                //       //       print("synchromised");
                //       //       httpGet("https://delau.000webhostapp.com/flutter/addTask.php?header="+_name+"1&body="+_surname+"1&date="+_date.toString()+"&time="+_time.toString()+"&marker="+(selected_radio-1).toString()+"&paginator="+rating.round().toString());
                //       //     }
                //       //   });
                //     }
                //   }
                // }, child: Text('Вход'), color: Colors.white, textColor: Color.fromRGBO(114, 103, 239, 1),),

                //   RaisedButton(onPressed: (){
                //   if(_formKey.currentState.validate()){
                //     if(_name != null && _email != null && _login != null && _password != null){
        
                //       // Client now_client = new Client(
                //       //       title: _name,
                //       //       description: _surname,
                //       //       marker: selected_radio-1,
                //       //       priority: rating.round(),
                //       //       date: _date.toString(),
                //       //       time: _time.toString(),
                //       //       done: false
                //       //     );

                //       // addAtLocalDB(now_client);
                //       // counter();

                //       // getSyncStatus().then((synchronise){
                //       //     if (synchronise){
                //       //       print("synchromised");
                //       //       httpGet("https://delau.000webhostapp.com/flutter/addTask.php?header="+_name+"1&body="+_surname+"1&date="+_date.toString()+"&time="+_time.toString()+"&marker="+(selected_radio-1).toString()+"&paginator="+rating.round().toString());
                //       //     }
                //       //   });
                //     }
                //   }
                // }, child: Text('Зарегистрироваться'), color: Color.fromRGBO(114, 103, 239, 1), textColor: Colors.white,),
      //           ],
      //         ),
      //       ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
                side: BorderSide(color: Colors.transparent)
              ),

              onPressed: (){
                if(_formKey.currentState.validate()){
                  if(_name != null && _email != null && _login != null && _password != null){

                  }  
                }
              },
              color: Color.fromRGBO(114, 103, 239, 1),
              textColor: Colors.white,
              
              
              child: 
              Padding(
                child: Text('Зарегистрироваться',
                textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.normal, fontFamily: "Exo 2",fontSize: 18.0, fontWeight: FontWeight.w900, color: Colors.white),),
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width/7.7,
                  right: MediaQuery.of(context).size.width/7.7,
                  top: MediaQuery.of(context).size.width/25,
                  bottom: MediaQuery.of(context).size.width/25,
                ),
              ),
            ),
            
            new SizedBox(height: 2.0,),
            FlatButton(
                      onPressed: () {
                          Navigator.pushNamed(context, '/user');
                        },
                        splashColor: Colors.transparent,  
                        highlightColor: Colors.transparent,
                        
                        child: Text(
                          "Назад",
                          style: TextStyle(
                            color:  Color.fromRGBO(114, 103, 239, 1),
                            fontWeight: FontWeight.w400,
                            // decoration: TextDecoration.underline,
                            fontSize: 16.0,
                            ),
                        ),
                      ),
                      
            ],
          ),
        ),
      ),
  
    );
  }
}
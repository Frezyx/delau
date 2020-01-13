// --------------------------------------
// ----------ОБЫЧНЫЙ LIST VIEW-----------
// --------------------------------------
// import 'package:flutter/material.dart';

// List<Widget> myList = [
//         new Text('line 1'),
//         new Divider(),
//         new Text('line 2'),
//         new Divider(),
//         new Text('line 3'),
//         new Divider(),
//         new Text('line 4'),
//         new Divider(),
//         new Text('line 5'),
//         new Divider(),
// ] ;

// void main() => runApp(
//   MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: new Scaffold(
//       body: new ListView(children: myList,),
//     )
//   )
// );





// --------------------------------------
// ----------Бесконечный LIST VIEW-----------
// --------------------------------------
// import 'package:flutter/material.dart';

// void main() => runApp(
//   MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: new Scaffold(
//       body: new ListView.builder(itemBuilder: (context, index){
//         return new Text("Строка $index");
//       }),
//     )
//   )
// );




// ----------------------------------------------------
// ----------Бесконечный LIST VIEW---------------------
// ----------С ПОДГОТОВЛЕННЫМИ ДАННЫМИ-----------------
//----------------ЖЕСТЬ ОН КРУТ------------------------
//-----------------------------------------------------
// import 'package:flutter/material.dart';

// class MyBody extends StatefulWidget{
//   @override
//   State<StatefulWidget>createState() => MyBodyState();
// }

// class MyBodyState extends State<MyBody>{
//   List<String> _array = [];


//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(itemBuilder: (context,i){
//       print('num $i');
//       print('length ${_array.length}');

//       if(i.isOdd) return new Divider(); 
//       final int index = i ~/ 2;

//       if(index >= _array.length){
//         _array.addAll(['${index + 1}','${index + 2}','${index + 3}']);
//       }
//       return new ListTile(title: new Text(_array[index]),);
//     },);
//   }
// }

// void main() => runApp(
//   MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: new Scaffold(
//       body: MyBody()
//       ),
//     ),
// );







// ----------------------------------------------------
// ----------ФОРМА ДЛЯ ЗАПОЛНЕНИЯ ---------------------
//-----------------------------------------------------

// import 'package:flutter/material.dart';
// import 'package:validators/validators.dart';

// enum GenderList {male, female}

// class MyForm extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() => MyFormState();
// }

// class MyFormState extends State{
//   GenderList _gender;
  
//   bool _agreement= false;
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context){
//     return new Container(padding: EdgeInsets.all(10.0), child: new Form(key: _formKey, child: new Column(
//       children: <Widget>[

//         new SizedBox(height: 160.0,),

//         new Text('Имя пользователя', style: TextStyle(fontSize: 20.0)),
//         new TextFormField(validator: (value){
//           if (value.isEmpty) return 'Введите имя';
//         },),

//         new SizedBox(height: 20.0,),

//         new Text('E-mail', style: TextStyle(fontSize: 20.0)),
//         new TextFormField(validator: (value){
//           if (value.isEmpty) return 'Введите E-mail';
//           if (!isEmail(value)) return 'Введите правильный E-mail';
//         },),

//         new SizedBox(height: 20.0,),
//         new Text('Ваш пол', style: TextStyle(fontSize: 20.0)),
//         new RadioListTile(title: Text('Мужской'),value: GenderList.male, groupValue: _gender, onChanged: (GenderList value){
//           setState(() {
//             _gender = value;
//           });
//         } ,),

//         new RadioListTile(title: Text('Женский'),value: GenderList.female, groupValue: _gender, onChanged: (GenderList value){
//           setState(() {
//             _gender = value;
//           });
//         } ,),

//         new SizedBox(height: 20.0,),

//         new CheckboxListTile(title: Text("Я согласен на обработку персональных данных"), value: _agreement, onChanged: (bool value) => setState(() => _agreement = value),),

//         new SizedBox(height: 20.0,),

//         new RaisedButton(onPressed: (){
//           if(_formKey.currentState.validate()){
//             Color color = Colors.red;
//             String text = "";

//             if(_gender == null){
//               text = "Выберите свой пол";
//             }
//             else if(_agreement == false){
//               text = "Подтвердите согласие на обработку";
//             }
//             else{
//               text = "Проверка прошла успешно";
//               color = Colors.blueAccent;
//             }
//             Scaffold.of(context).showSnackBar(
//             new SnackBar(content: Text('$text'), backgroundColor: color,));
//           }
//         }, child: Text('Отправить'), color: Colors.blueAccent, textColor: Colors.white,)

//       ],
//     ),),);
//   }
// }
// void main() => runApp(
//   MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: new Scaffold(
//       appBar: new AppBar(title: Text('Форма для заполнения'), backgroundColor: Colors.blueAccent,),
//       body: MyForm()
//       ),
//     ),
// );






// --------------------------------------------------------------------------------
// ---------- РОУТИНГ между страницами, с передачей параметра ---------------------
//---------------------------------------------------------------------------------


// import 'package:flutter/material.dart';

// class MainScreen extends StatelessWidget{
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(title: Text("Первая страница"),),
//       body: Center(child: Column(children:<Widget>[
//         RaisedButton(onPressed: (){
//         Navigator.pushNamed(context, '/second');},
//         child: Text("Перейти на вторую"),color: Colors.blueAccent, textColor: Colors.white,),

//         RaisedButton(onPressed: (){
//         Navigator.pushNamed(context, '/second/123');},
//         child: Text("Перейти на вторую 123"),color: Colors.blueAccent, textColor: Colors.white,),

//       ],)
//       ),
//     );
//   }
// }

// class SecondScreen extends StatelessWidget{
//   String _id;

//   SecondScreen({String id}): _id = id;

//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(title: Text("Вторая id пользователя: $_id"),),
//       body: Center(child: RaisedButton(onPressed: (){
//         Navigator.pop(context);
//       },child: Text('Назад'),color: Colors.blueAccent, textColor: Colors.white,
//       ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     initialRoute: '/',
//     routes: {
//       '/':(BuildContext context) => MainScreen(),
//       '/second':(BuildContext context) => SecondScreen(),
//     },
//     onGenerateRoute: (RouteSettings){
//       var path = RouteSettings.name.split('/');
//       if(path[1] == 'second'){
//         return new MaterialPageRoute(builder: (context) => new SecondScreen(id:path[2]),
//         settings: RouteSettings);
//       }
//     },
//   ));
// }



// --------------------------------------------------------------------------------
// ------------------------------МОДАЛЬНОЕ ОКНО -----------------------------------
//---------------------------------------------------------------------------------

// import 'package:flutter/material.dart';

// class MainScreen extends StatelessWidget{  
//   @override
//   Widget build(BuildContext context){
//     final _scaffoldKey = GlobalKey<ScaffoldState>();


//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(title: Text("Больше или меньше ?"),),
//       body: Center(child: Column(children:<Widget>[
//         RaisedButton(onPressed: () async{
//          bool value = await Navigator.push(context, PageRouteBuilder(
//             opaque: false,
//             pageBuilder: (context, _, __) => MyPopup(),
//             transitionsBuilder: (___, animation, ____, child){
//               return FadeTransition(
//                 opacity: animation,
//                 child: ScaleTransition(scale: animation, child:child,),
//               );
//             }
//           ));

//           if(value) _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Больше'), backgroundColor: Colors.blueAccent));
//           else _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Меньше'), backgroundColor: Colors.pinkAccent));
//         },
//         child: Text("Загадать число"),color: Colors.blueAccent, textColor: Colors.white,),

//       ],)
//       ),
//     );
//   }
// }

// class MyPopup extends StatelessWidget{
//   @override
//   Widget build(BuildContext context){
//     return AlertDialog(
//       title: Text('Твой ответ:'),
//       actions: <Widget>[
//         FlatButton(
//           onPressed: (){
//             Navigator.pop(context, true);
//           },
//           child: Text('Больше'),
//         ),
//         FlatButton(
//           onPressed: (){
//             Navigator.pop(context, false);
//           },
//           child: Text('Меньше'),
//         )

//       ],
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: MainScreen(),
//   ));
// }





// --------------------------------------------------------------------------------
// ------------------------------ASYNC AWAIT -----------------------------------
//---------------------------------------------------------------------------------



// import 'package:flutter/material.dart';

// void main() => runApp(new MaterialApp(
//     home:Scaffold(
//       body:MyApp())
//       )
//   );

// class MyApp extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() => MyAppState();
// }

// class MyAppState extends State{
//   SendGlass clock = SendGlass();

//   @override
//   void initState(){
//     super.initState();

//     clock.tick();
//   }

//     _reDrawWidget() async {
//       if(clock.time() == 0) return;      
//       await new Future.delayed(Duration(seconds: 1));
//       setState(() {
//         print('_reDrawWidget()');
//       });
//     }
  

//   @override
//   Widget build(BuildContext context){
//     _reDrawWidget();
    
//     return Center(child: Text('time is:${clock.time()}'),);
//   }
// }

// class SendGlass{
//   int _sand = 0;

//   time(){
//     return _sand;
//   }

//   tick() async{
//     _sand = 100;
//      print('Start tick...');
//      while(_sand > 0){
//        print('tick: ${_sand}');
//        _sand--;

//        await new Future.delayed(Duration(milliseconds: 100));
//      }
//      print('Tick is end...)');
//   }

//   // Future<bool> future() async{
//   //    return true;
//   // }

// }







// --------------------------------------------------------------------------------
// --------------------GET-Мать его-ЗАПРОС -----------------------------------
//---------------------------------------------------------------------------------
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() => runApp(
//   MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: TestHttp()
//   )
// );

// class TestHttp extends StatefulWidget{
//   @override 
//   State<StatefulWidget> createState() => TestHttpState();
// }

// class TestHttpState extends State<TestHttp>{
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(title: Text("Запросеки"),),
//       body: Center(child: FlatButton(onPressed: (){
//         http.get('http://json.flutter.su/echo').then((response){
//           print("Статус ответа: ${response.statusCode}");
//           print("Тело ответа: ${response.body}");

//         }).catchError((error){
//           print('Ты ебловоз блять! А вот твоя ошибка: $error');
//         });
//       },child: Text('Хуя ты Сатсян, дебил конечно!!!'), 
//       color: Colors.blueAccent, textColor: Colors.white,),),
//     );
//   }
// }




// --------------------------------------------------------------------------------
// --------------------GET-Мать его-ЗАПРОС -----------------------------------
// ----------------В АСИНХРОННОМ-МАТЬ ЕГО-МЕТОДЕ -----------------------------------
//---------------------------------------------------------------------------------

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() => runApp(
//   MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: TestHttp()
//   )
// );

// class TestHttp extends StatefulWidget{
//   @override 
//   State<StatefulWidget> createState() => TestHttpState();
// }

// class TestHttpState extends State<TestHttp>{
//   httpGet() async{
//     try{
//       var response = await http.get('http://json.flutter.su/echo');
//       print("Статус ответа: ${response.statusCode}");
//       print("Тело ответа: ${response.body}");
//     } catch (error){
//       print('Ты ебловоз блять! А вот твоя ошибка: $error');
//     }
//   }


//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(title: Text("Запросеки"),),
//       body: Center(child: FlatButton(onPressed: 
//       httpGet,
//       child: Text('Хуя ты Сатсян, дебил конечно!!!'), 
//       color: Colors.blueAccent, textColor: Colors.white,),),
//     );
//   }
// }



// --------------------------------------------------------------------------------
// --------------------POST-Мать его-ЗАПРОС -----------------------------------
// ----------------В АСИНХРОННОМ-МАТЬ ЕГО-МЕТОДЕ -----------------------------------
//---------------------------------------------------------------------------------

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() => runApp(
//   MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: TestHttp()
//   )
// );

// class TestHttp extends StatefulWidget{
//   @override 
//   State<StatefulWidget> createState() => TestHttpState();
// }

// class TestHttpState extends State<TestHttp>{
//   httpGet() async{
//     try{
//       var response = await http.post('http://json.flutter.su/echo',
//        body:
//         {'name': 'my Name',
//          'num': '10',},
//          headers: {'Accept':'application/json'},
//        );
//       print("Статус ответа: ${response.statusCode}");
//       print("Тело ответа: ${response.body}");
//     } catch (error){
//       print('Ты ебловоз блять! А вот твоя ошибка: $error');
//     }
//   }


//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(title: Text("Запросеки"),),
//       body: Center(child: FlatButton(onPressed: 
//       httpGet,
//       child: Text('Хуя ты Сатсян, дебил конечно!!!'), 
//       color: Colors.blueAccent, textColor: Colors.white,),),
//     );
//   }
// }








// class MyStatefulWidget2 extends StatefulWidget {
//   String _id;
//   MyStatefulWidget2({String id}): _id = id;

//   @override
//   _MyStatefulWidgetState3 createState() => _MyStatefulWidgetState3();
// }

// class _MyStatefulWidgetState3 extends State<MyStatefulWidget2> {
//   final _formKey = GlobalKey<FormState>();

//   DateTime _date = new DateTime.now();
//   TimeOfDay _time = new TimeOfDay.now();

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime picked = await showDatePicker(
//       context: context,
//       initialDate: _date,
//       firstDate: DateTime(2018, 8),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != _date)
//       print('Select Date: ${_date.toString()}' );
//       setState(() {
//         _date = picked;
//       });
//   }

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay picked = await showTimePicker(
//       context: context,
//       initialTime: _time,
//     );
//     if (picked != null && picked != _time)
//       print('Select Date: ${_date.toString()}' );
//       setState(() {
//         _time = picked;
//       });
//   }


//   @override
//   Widget build(BuildContext context) {
//      return Scaffold(
//       appBar: AppBar(
//               // backgroundColor: Color.fromRGBO(76, 175, 80, 100),
//               backgroundColor: Colors.pinkAccent,
//               title: const Text('DELAU'),
//           ),
//       body:
//        new Container(
//           padding: EdgeInsets.all(40.0),// color: Colors.transparent,
//           child: new Form(key: _formKey, child: new Column(children: <Widget>[

//         new SizedBox(height: 120.0,),

//         new Text('Название', style: TextStyle(fontSize: 20.0)),
//         new TextFormField(
//           cursorColor: Colors.pinkAccent,
//           decoration: InputDecoration(        
//           focusedBorder: UnderlineInputBorder(      
//             borderSide: BorderSide(color: Colors.pinkAccent),   
//           ),    
//         ),
//           validator: (value){
//           if (value.isEmpty) return 'Введите название задания';
//         },),

//         new SizedBox(height: 20.0,),

//         new Text('Приоритет', style: TextStyle(fontSize: 20.0)),
//         new TextFormField(
//           cursorColor: Colors.pinkAccent,
//           decoration: InputDecoration(        
//           focusedBorder: UnderlineInputBorder(      
//             borderSide: BorderSide(color: Colors.pinkAccent),   
//           ),    
//         ),
//           validator: (value){
//           if (value.isEmpty) return 'Введите название задания';
//         },),

//         new SizedBox(height: 20.0,),

//           new Row(
//             children: <Widget>[
//               FlatButton(
//                 color: Colors.transparent, textColor: Colors.pinkAccent,
//                 padding: EdgeInsets.only( left: 15.0, right: 15.0, top: 15, bottom: 15, ),
//                 onPressed: () {
//                   _selectDate(context);
//                 },
//                 child: 
//                 Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Icon(Icons.date_range,size: 20.0,),
//                     Text(
//                         "Выбрать дату",
//                         style: TextStyle(fontSize: 15.0, fontFamily: 'Roboto', fontWeight: FontWeight.w500,),
//                       ),
//                   ],

//                 ),
//               ),

//               FlatButton(
//                 color: Colors.transparent, textColor: Colors.pinkAccent,
//                 padding: EdgeInsets.only( left: 15.0, top: 15,right: 15.0, bottom: 15),
//                 onPressed: () {
//                   _selectTime(context);
//                 },
//                 child: 
//                 Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Icon(Icons.timer,size: 20.0,),
//                     Text(
//                         "Выбрать время",
//                         style: TextStyle(fontSize: 15.0, fontFamily: 'Roboto', fontWeight: FontWeight.w500,),
//                       ),
//                   ],

//                 ),
//               ),
//             ]
//             ),

//         new SizedBox(height: 20.0,),

//         new Text('Пояснение', style: TextStyle(fontSize: 20.0)),
//         new TextFormField(validator: (value){
//           if (value.isEmpty) return 'Введите название задания';
//         },),

//         new SizedBox(height: 20.0,),

//         new RaisedButton(onPressed: (){
//           if(_formKey.currentState.validate()){
              
//              }
//         }, child: Text('Создать'), color: Colors.blueAccent, textColor: Colors.white,)

//       ],
//      ),),),);
//   }
// }
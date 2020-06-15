// -------------------> ВНЕШНИЕ БИБЛИОТЕКИ
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
// -------------------> ВНУТРЕННИЕ ПРОГРАММЫ
import 'package:delau/addTaskPage.dart';
import 'package:delau/pages/updateTask.dart';
import 'package:delau/autoriz.dart';
import 'package:delau/models/dbModels.dart';
import 'package:delau/notes.dart';
import 'package:delau/oneNote.dart';
import 'package:delau/pages/addMarker.dart';
import 'package:delau/pages/iconDrag.dart';
import 'package:delau/pages/tts.dart';
import 'package:delau/pages/userSettings.dart';
import 'package:delau/ratingPage.dart';
import 'package:delau/reg.dart';
import 'package:delau/tryUserPage.dart';
import 'package:delau/utils/database_helper.dart';
import 'package:delau/utils/fcm.dart';
import 'package:delau/utils/synchroneHelper.dart';
import 'package:delau/utils/ttsHelper.dart';
import 'package:delau/widget/notification.dart';
import 'addTaskPage.dart';
import 'pages/postPage.dart';
import 'widgets_helper.dart';

StatelessWidget getBaner(SharedPreferences prefs){
  prefs.setBool('banner', false); 
    DBUserProvider.dbc.firstCreateTable();// Меняем значение на false
    DBNoteProvider.db.firstCreateTable().then((res){
      print(res.toString()+"Это id из Заметок");
    });
    DBMarkerProvider.db.firstCreateTable().then((res){
      print(res.toString()+"Это из Маркера");
    });

  return MyApp();
}


void main() async{
  WidgetsFlutterBinding.ensureInitialized(); 
  // -------------------> Проверяем в какой раз входит пользователь и создаем/не создаем таблицы в базе данных
  // -------------------> В runApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool banner = (prefs.getBool('banner') ?? true);

  runApp(
       banner? getBaner(prefs) : MyApp(),
    );
}

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),

      debugShowCheckedModeBanner: false,
      initialRoute: '/',
    routes: {
      '/':(BuildContext context) => MyStatefulWidget(),
      '/second':(BuildContext context) => MyStatefulWidget3(),
      '/ntf':(BuildContext context) => LocalNotificationWidget(),
      '/user':(BuildContext context) => UPN(),
      '/tts':(BuildContext context) => TTS(),
      '/fcm':(BuildContext context) => FCMPage(),
      '/reg':(BuildContext context) => RegistrationPage(),
      '/autoriz':(BuildContext context) => AutorizationPage(),
      '/addMark':(BuildContext context) => AddMarkerPage(),
      '/update':(BuildContext context) => UpdatePage(),
      '/rating':(BuildContext context) => RatingPage(),
      '/icon':(BuildContext context) => IconDrag(),
      '/notes':(BuildContext context) => Example01(),
      '/note':(BuildContext context) => NotePage(),
      '/updateTask':(BuildContext context) => UpdateTask(),
    },
    
    onGenerateRoute: (RouteSettings){
      var path = RouteSettings.name.split('/');
      
      if(path[1] == 'postPage'){
        return new MaterialPageRoute(builder: (context) => new PostPage(id:path[2]),
        settings: RouteSettings);
        }
      
        if(path[1] == 'addMark'){
          return new MaterialPageRoute(builder: (context) => new AddMarkerPage(id:path[2], icon:path[3]),
          settings: RouteSettings);
        }

        if(path[1] == 'note'){
          return new MaterialPageRoute(builder: (context) => new NotePage(id:path[2]),
          settings: RouteSettings);
        }
        if(path[1] == 'updateTask'){
          return new MaterialPageRoute(builder: (context) => new UpdateTask(id:path[2]),
          settings: RouteSettings);
        }
      },
    );
  }
}

  httpGet(String link) async{
    try{
      var response = await http.get('$link');
      print("Статус ответа: ${response.statusCode}");
      print("Тело ответа: ${response.body}");
    } catch (error){
      print('Ты ебловоз блять! А вот твоя ошибка: $error');
    }
  }

class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

// ---- Для Future Builder ---- 

var countTask =  DBProvider.db.getContNow();

bool registration = false;
List<int> countTasksByMarker = [0,0,0,0,0,0];

  int userIdServer;

  void refreshCount() {
    setState(() {
      countTask =  DBProvider.db.getContNow();
    });
  }

  void refreshCountCard(id){
    setState(() {
      countTasksByMarker[id]++;
    });
  }

    @override
    void initState(){
      super.initState();

// ---- Достаем данные пользователя из Локальной БД ---- 
      DBUserProvider.dbc.getClientUser(1).then((res){
        registration = (res.reg == 1);
        userIdServer = res.userIdServer;
        // print(registration.toString() + "UserServerId--->" + userIdServer.toString());
      });

// ---- Заполняем количество задач по маркерам ---- 
      DBProvider.db.getAllTasks().then((res){
        for(var item in res){
          switch (item.marker) {
            case 0:
              refreshCountCard(0);
              break;
            case 1:
              refreshCountCard(1);
              break;
            case 2:
              refreshCountCard(2);
              break;
            case 3:
              refreshCountCard(3);
              break;
            case 4:
              refreshCountCard(4);
              break;
            case 5:
              refreshCountCard(5);
              break;            
            default:
          }
        }
      });

    }
// ---- Название маркеров старотовой страницы ---- 
  List<String> slider_titles = ["Учеба", "Работа", "Спорт", "Встречи", "Покупки", "Другое" ];

// ---- Иконки маркеров старотовой страницы ---- 
  List<IconData> i_add = [
    FontAwesome.book, FontAwesome.briefcase,
    MdiIcons.fromString('basketball'), FontAwesome.users, 
    MdiIcons.fromString('shopping'), FontAwesome.spinner
    ];

// ---- Недоработанный метод получения иконок для карточек слайдера ---- 
    // getIcon(int i){
    //   print((i-7).toString() + " Чет говно");
    //   DBMarkerProvider.db.getMarkById(i-7).then((icon){
    //     return MdiIcons.fromString('$icon');
    //   });
    // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:                         
      Column(
        children: [

// -------------------> Карусель

          DecoratedBox(
            child: new Column(
        children: <Widget>[
         CarouselSlider(
           // ---- Знаю такая-себе реализация ---- 
          items: [1,2,3,4,5,6].map((i) {
            return new Builder(
              builder: (BuildContext context) {
                return new Container(
                  width: MediaQuery.of(context).size.width,
                  margin: new EdgeInsets.only(left: 15.0, right: 15.0, top: 40.0, bottom: 20.0),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    boxShadow:<BoxShadow>[
                      BoxShadow(
                        color: Color.fromRGBO(71, 9, 150, 0.37),
                        offset: Offset(0.0, 4.0),
                        blurRadius: 15.0,
                      ),
                    ],
                        border: Border.all(
                          color: Colors.transparent,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(12),
                  ),
                  child: getCardInfo(i, i_add, slider_titles, countTasksByMarker[i-1])
                );
              },
            );
          }).toList(),
          height: 140.0,
          autoPlay: true,
          autoPlayCurve: Curves.elasticIn,
          autoPlayDuration: const Duration(milliseconds: 2800),
            ),
           ]
          ),

           decoration: BoxDecoration(
            gradient: new LinearGradient(
                    colors: [
                      Color.fromRGBO(162, 122, 246, 1),
                      Color.fromRGBO(114, 103, 239, 1),
                      ],

                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.0,1.0],
                    tileMode: TileMode.clamp),
           ),
        ),

// -------------------> Блок с тенью и громофоном

        Padding(
          padding: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
          child: DecoratedBox(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    boxShadow:<BoxShadow>[
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.19),
                        offset: Offset(0.0, 4.0),
                        blurRadius: 20.0,
                      ),
                    ],
                        border: Border.all(
                          color: Colors.transparent,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(15),
                  ),
                  child: 
         Container(
           padding: EdgeInsets.only(right: 16.0, left: 16.0, top: 2.0, bottom: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            Align(
                alignment: Alignment.centerLeft,
                child: new FutureBuilder<int>(// ----- ToDo Лист
              future: countTask,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
             return
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.body1,
                children: [
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 10.0, top: 2.0, bottom: 2.0),
                      child: Icon(FontAwesome.tasks, color: Color.fromRGBO(114, 103, 239, 1),size: 24),
                    ),
                  ),
                  TextSpan(text: 'Всего задач: ${snapshot.data.toString()}',
                    style: TextStyle(fontSize: 22.0,
                    fontFamily: 'Exo 2',
                    fontWeight: FontWeight.w300,)),
                ],
              ),
            );
            }),
          ),
                Padding(
                    padding: EdgeInsets.only(left: 0.0, right: 0.0, top: 2.0, bottom: 2.0),
                    child: 
                    RawMaterialButton(
                            onPressed: () {
                              getVoiceInfo();
                            },
                            child: new Icon(
                              FontAwesome.bullhorn,
                              size: 27,
                              color: Color.fromRGBO(114, 103, 239, 1),
                        ),
                        shape: new CircleBorder(),
                        elevation: 4,
                        hoverElevation: 10,
                        constraints: BoxConstraints.tight(Size(36, 36)),
                        fillColor: Colors.white,
                    ),
                ),
          ],),
          ),
        ),
        ),

        // -------------------> Листвью с задачами
        
         Expanded(
          child: Container(
            child: FutureBuilder<List<Client>>(
        future: DBProvider.db.getAllTasks(),
        builder:
         (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
          if (snapshot.hasData) 
          {
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 0.0, top: 10.0, right: 0.0, left:0.0),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Client item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: 
                  Container(
                    padding: EdgeInsets.only( top: 6.0, left: 5.0),
                    color: Colors.green[300],
                    alignment: Alignment.centerLeft,
                      child: Column(
                        children: <Widget>[
                              Icon(
                              FontAwesome.check,
                              color: Colors.white,
                            ),
                            Text("Выполнил", 
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                                fontFamily: 'Exo 2',
                                fontWeight: FontWeight.w600,),),
                            ],
                          ),
                        ),
                        secondaryBackground:
                        Container(
                          padding: EdgeInsets.only( top: 6.0, right: 5.0),
                          color: Colors.red[300],
                          alignment: Alignment.centerRight,
                            child: Column(
                        children: <Widget>[
                              Icon(
                              FontAwesome.close,
                              color: Colors.white,
                          ),
                        Text("Удалить", 
                          style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                            fontFamily: 'Exo 2',
                            fontWeight: FontWeight.w600,),),
                        ],
                      ),
                    ),
                  direction: DismissDirection.endToStart,

// -------------------> Обработчик смахивания в бок

                  onDismissed: (direction) {
                    int pr;
                    DBProvider.db.deleteClient(item.id).then((priority){
                      var pr = priority;
                      // -------------------> Обновляем стейт со значением
                      refreshCount();
                      // -------------------> Обновляем значение в локальной бд по значению id
                      counterDone(pr);
                      check().then((intenet) {
                      // -------------------> Если пользователь зарегистрирован и есть интернет Обновляем значение на сервере в бд по значению id
                      if (intenet != null && intenet && registration) {
                        print("synchromised And Pr --->" + pr.toString() + "Id user Server --->" + userIdServer.toString());
                        httpGet("https://delau.000webhostapp.com/flutter/delete.php?id="+item.id.toString()+"&priority="+(pr~/ 2).toString()+"&user_id="+userIdServer.toString());
                      }
                    });
                  });
// -------------------> Показываем снакбар о выполнении
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Color.fromRGBO(114, 103, 239, 1),
                        content: Text(
                          'Задача удалена',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),

                    );
                  },
                  child: ListTile(
                    leading: Icon(
                    (item.marker <= 5) ? i_add[item.marker] : MdiIcons.fromString('${item.icon}'),
                    color: Color.fromRGBO(114, 103, 239, 1),
                    size: 28.0,
                  ),
                    title: Text('${item.title}',
                    style: TextStyle(fontSize: 18.0, fontFamily: 'Exo 2', fontWeight: FontWeight.w300,),
                    overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: get_subtitle_of_SQLI(item),
                    trailing: Checkbox(
                      onChanged: (bool value) {
                        DBProvider.db.blockOrUnblock(item);
                        setState(() {
                          
                        });
                      },
                      value: item.done,
                    ),
                    onTap: () {
                    // _onTapItem(context, item);
                    Navigator.pushNamed(context, '/postPage/${item.id}');
                  }
                  ),
                );
              },
            );
          } 
          else 
          {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      ),
    ),

      ],
      ), 
      ),

// -------------------> Navbar

      bottomNavigationBar: CurvedNavigationBar(
        height: 50.0,
    backgroundColor: Colors.transparent,
    animationDuration: Duration(microseconds: 2500),
    items: <Widget>[
      Icon(Icons.list, size: 30, color: Colors.deepPurpleAccent,),
      Icon(FontAwesome.sticky_note_o, size: 30, color: Colors.black54,),
      Icon(Icons.add, size: 30, color: Colors.black54,),
      Icon(Icons.pie_chart_outlined, size: 30, color: Colors.black54,),
      Icon(FontAwesome.user_o, size: 30, color: Colors.black54,),
    ],
    index: 0,
    animationCurve: Curves.bounceInOut,
    onTap: (index) {
      if(index == 0){
        Navigator.pushNamed(context, '/');
      }
      if(index == 1){
        Navigator.pushNamed(context, '/notes');
      }
      if(index == 2){
        Navigator.pushNamed(context, '/second');
      }
      if(index == 3){
        Navigator.pushNamed(context, '/rating');
      }
      if(index == 4){
        Navigator.pushNamed(context, '/user');
      }
    },
  ),
          );
        }
}

  void counterDone(int pr) async{
    await DBUserProvider.dbc.updateCountDone(pr);
  }

// -------------------> Создаем звездочки по ptriority

class StarDisplay extends StatelessWidget {
  final int value;
  const StarDisplay({Key key, this.value = 0})
      : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
          color: index < value ? Colors.yellow : Colors.black12,
          size: 16.0,
        );
      }),
    );
  }
}

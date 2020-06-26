import 'package:delau/models/task.dart';

Future<List<Task>>getTestTaskData() async{
  var _selectedDay = await DateTime.now();
  return [
        Task(isChecked: true, icon:"wifi", isOpen: false, description: 'Сайт рыбатекст поможет дизайнеру, верстальщику, вебмастеру сгенерировать несколько абзацев более менее осмысленного текста рыбы' , name: 'Пойти выбросить мусор', dateTime: _selectedDay),
        Task(isChecked: false, isOpen: false, icon:"cart", description: 'Сайт рыбатекст поможет дизайнеру, верстальщику, вебмастеру сгенерировать несколько абзацев более менее осмысленного текста рыбы Сайт рыбатекст поможет дизайнеру, верстальщику, вебмастеру сгенерировать несколько абзацев более менее осмысленного текста рыбы', name:"Задачи на сайте", dateTime: _selectedDay), 
        Task(isChecked: false, isOpen: false, icon:"calendar", description: 'Сайт', name: 'Купить хлеба', dateTime: _selectedDay), 
        Task(isChecked: false, isOpen: false, icon:"circle", description: 'Сайт верстальщику, вебмастеру сгенерировать несколько абзацев более', name: 'Позвонить Марине и рассказать за жизнь', dateTime: _selectedDay),
];}
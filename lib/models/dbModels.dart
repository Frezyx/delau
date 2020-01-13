import 'dart:core';

class Note{

  int _id;
  String _title;
  String _description;
  String _date;
  String _time;
  int _priority;
  int _marker;
  int _done;

  Note(this._date, this._description, this._done,
  this._marker, this._priority, this._time, this._title);

  Note.withId(this._id, this._date, this._description, this._done,
  this._marker, this._priority, this._time, this._title);

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;
  String get time => _time;
  int get priority => _priority;
  int get marker => _marker;
  int get done => _done;

  set title(String newTitle){
    if(newTitle.length < 255){
      this.title = newTitle;
    }
  }

  set description(String newDescription){
    if(newDescription.length < 255){
      this.description = newDescription;
    }
  }

  set date(String newDate){
    if(newDate.length < 255){
      this.date = newDate;
    }
  }

  set time(String newTime){
    if(newTime.length < 255){
      this.time = newTime;
    }
  }

  set priority(int newPriority){
      this.priority = newPriority;
  }

  set marker(int newMarker){
      this.marker = newMarker;
  }

  set done(int newDone){
      this.done = newDone;
  }

  //Создаем модель в обьекте MAP

  	Map<String, dynamic> toMap() {

		var map = Map<String, dynamic>();
		if (id != null) {
			map['id'] = _id;
		}
		map['title'] = _title;
		map['description'] = _description;
		map['priority'] = _priority;
    map['marker'] = _priority;
    map['time'] = _priority;
		map['date'] = _date;
    map['done'] = _done;

		return map;
	}

  	// ПЕрекидываем обьекты из Мапы в Ноту


	Note.fromMapObject(Map<String, dynamic> map) {
		this._id = map['id'];
		this._title = map['title'];
		this._description = map['description'];
		this._priority = map['priority'];
    this._marker = map['marker'];
		this._date = map['date'];
    this._time = map['time'];
    this._done = map['done'];
	}

}
import 'package:flutter/material.dart';
import 'package:delau/pages/pageIsComing.dart';

class UpdateTask extends StatefulWidget{
  String _id;

  UpdateTask({String id}): _id = id;

  @override
  _UpdateTaskState createState() => _UpdateTaskState(_id);
}

class _UpdateTaskState extends State<UpdateTask> {
  String id;

  _UpdateTaskState(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnWork(id: id),
    );
  }
}
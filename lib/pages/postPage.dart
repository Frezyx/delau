import 'package:delau/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:delau/models/dbModels.dart';
import 'package:delau/widget/postItem.dart';

class PostPage extends StatefulWidget {
  String _id;

  PostPage({String id}): _id = id;

  @override
  _PostPageState createState() => _PostPageState(_id);
}

class _PostPageState extends State<PostPage> {
  String id;

  _PostPageState(this.id);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder<List<Task>>(
        future: DBProvider.db.getClientInList(int.parse(id)),
        builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
          if (snapshot.hasData) 
          {
            return ListViewPosts(item: snapshot.data);
          }
        },
      ),
    );
  }
}
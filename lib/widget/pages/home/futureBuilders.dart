import 'package:delau/models/marker.dart';
import 'package:delau/models/task.dart';
import 'package:delau/utils/provider/own_api/prepare/getMarkersList.dart';
import 'package:delau/utils/provider/own_api/prepare/getTasksList.dart';
import 'package:delau/widget/infoIllustratedScreens/infoscreens.dart';
import 'package:delau/widget/pages/home/homeListItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

Widget buildGridMarkers(taskListBloc) {
  return Expanded(
    child: FutureBuilder(
        future: getMarkersList(),
        builder: (BuildContext context, AsyncSnapshot<List<Marker>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return InfoScreen.getNoConnectionScreen(context);
            case ConnectionState.waiting:
              return new Center(child: new CircularProgressIndicator());
            case ConnectionState.active:
              return new Text('');
            case ConnectionState.done:
              if (snapshot.hasError) {
                return InfoScreen.getErrorScreen(context);
              } else {
                var count = snapshot.data.length;
                var data = snapshot.data;
                if (count == 0) {
                  return InfoScreen.getNoMarkerScreen(context);
                } else {
                  return AnimationLimiter(
                      child: StaggeredGridView.countBuilder(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 3,
                    itemCount: count,
                    itemBuilder: (context, i) {
                      return AnimationConfiguration.staggeredGrid(
                          position: i,
                          duration: const Duration(milliseconds: 375),
                          columnCount: 3,
                          child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                  child: buildGridMarkerItem(
                                      data, i, taskListBloc))));
                    },
                    staggeredTileBuilder: (int index) =>
                        StaggeredTile.count(1, 1),
                  ));
                }
              }
          }
        }),
  );
}

Widget buildListTasks(taskListBloc) {
  return Expanded(
      child: Container(
    height: double.infinity,
    child: FutureBuilder(
        // future: getTasks(4),
        future: taskListBloc.isMarkerOpened
            ? getTasksByMarker(taskListBloc.marker)
            : getTasksByDate(DateTime.now()),
        builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return InfoScreen.getNoConnectionScreen(context);
            case ConnectionState.waiting:
              return new Center(child: new CircularProgressIndicator());
            case ConnectionState.active:
              return new Text('');
            case ConnectionState.done:
              if (snapshot.hasError) {
                return InfoScreen.getErrorScreen(context);
              } else {
                var count = snapshot.data.length;
                var data = snapshot.data;
                if (count == 0) {
                  return InfoScreen.getNoTasksScreen(context);
                } else {
                  return AnimationLimiter(
                      child: ListView.builder(
                          itemCount: count,
                          itemBuilder: (context, i) {
                            return AnimationConfiguration.staggeredList(
                                position: i,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                        child:
                                            buildListItem(i, data, context))));
                          }));
                }
              }
          }
        }),
  ));
}

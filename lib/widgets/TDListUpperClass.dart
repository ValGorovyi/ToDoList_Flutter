import 'package:flutter/material.dart';
import 'package:todo_list_fl/widgets/groupForm/groupFormWidget.dart';
import 'package:todo_list_fl/widgets/listItem.dart';

class TDListUpperClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/list': (conrext) => TDListUpperWidget(),
        '/list/addGroup': (context) => AddGroupFormWidget(),
      },
      initialRoute: '/list',
    );
  }
}

class TDListUpperWidget extends StatelessWidget {
  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed('/list/addGroup');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('toDos Group'),
        centerTitle: true,
        backgroundColor: Colors.limeAccent,
      ),
      body: GroupsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showForm(context),
        child: Icon(Icons.add_box_rounded),
      ),
    );
  }
}

class GroupsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) => ListItem(),
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 10),
      itemCount: 30,
    );
  }
}

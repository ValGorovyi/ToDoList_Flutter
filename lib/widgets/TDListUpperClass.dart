import 'package:flutter/material.dart';
import 'package:todo_list_fl/widgets/groupForm/groupFormWidget.dart';
import 'package:todo_list_fl/widgets/groupsW/groupsModel.dart';
import 'package:todo_list_fl/widgets/listItem.dart';
import 'package:todo_list_fl/widgets/taskForm/taskFormWidget.dart';
import 'package:todo_list_fl/widgets/tasks/tasksWidget.dart';

class TDListUpperClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/list': (conrext) => TDListUpperWidget(),
        '/list/addGroup': (context) => AddGroupFormWidget(),
        '/list/tasks': (context) => TasksWidget(),
        '/list/tasks/addTask': (context) => TaskFormWidget(),
      },
      initialRoute: '/list',
    );
  }
}

class TDListUpperWidget extends StatefulWidget {
  @override
  State<TDListUpperWidget> createState() => _TDListUpperWidgetState();
}

class _TDListUpperWidgetState extends State<TDListUpperWidget> {
  final model = GroupsModel();

  @override
  Widget build(BuildContext context) {
    return GroupsInherit(model: model, child: _TDListUpperWidgetBody());
  }
}

class _TDListUpperWidgetBody extends StatelessWidget {
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
        onPressed: () => GroupsInherit.read(context)?.model.showForm(context),
        child: Icon(Icons.add_box_rounded),
      ),
    );
  }
}

class GroupsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GroupsItemsCound =
        GroupsInherit.watch(context)?.model.groups.length ?? 0;
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) =>
          ListGroupItem(index: index),
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 10),
      itemCount: GroupsItemsCound,
    );
  }
}

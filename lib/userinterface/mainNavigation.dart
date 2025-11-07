import 'package:flutter/material.dart';
import 'package:todo_list_fl/userinterface/widgets/TDListUpperClass.dart';
import 'package:todo_list_fl/userinterface/widgets/groupForm/groupFormWidget.dart';
import 'package:todo_list_fl/userinterface/widgets/taskForm/taskFormWidget.dart';
import 'package:todo_list_fl/userinterface/widgets/tasks/tasksWidget.dart';

abstract class MainNavigationNames {
  static const groupForm = '/addGroup';
  static const tasks = '/tasks';
  static const taskForm = '/tasks/addTask';
  static const groups = '/';
}

class MainNavigation {
  final initialRoute = MainNavigationNames.groups;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationNames.groups: (conrext) => TDListUpperWidget(),
    MainNavigationNames.groupForm: (context) => AddGroupFormWidget(),
    // MainNavigationNames.tasks: (context) => TasksWidget(),
    // MainNavigationNames.taskForm: (context) => TaskFormWidget(),
  };
  Route<dynamic>? onGenerateMyRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationNames.tasks:
        final groupKey = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) {
            return TasksWidget(groupKey: groupKey);
          },
        );
      case MainNavigationNames.taskForm:
        final groupKey = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) {
            return TaskFormWidget(groupKey: groupKey);
          },
        );
      default:
        const defaultWidget = Center(child: Text('Navigation error. Sorry'));
        return MaterialPageRoute(builder: (context) => defaultWidget);
    }
  }
}

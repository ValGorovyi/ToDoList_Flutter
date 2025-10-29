import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list_fl/entity/groupEntity.dart';

class TasksModel extends ChangeNotifier {
  int groupKey;
  GroupEntity? _group;
  GroupEntity? get group => _group;
  late final Future<Box<GroupEntity>> _groupBox;
  TasksModel({required this.groupKey}) {
    _setup();
  }

  void _setup() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupEntityAdapter());
    }
    _groupBox = Hive.openBox<GroupEntity>('group_entity_box');
    _loadGroup();
  }

  void _loadGroup() async {
    final box = await _groupBox;
    _group = box.get(groupKey);
    notifyListeners();
  }

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed('/list/tasks/addTask');
  }
}

class TasksInherit extends InheritedNotifier {
  TasksModel model;

  TasksInherit({required this.model, required Widget child, Key? key})
    : super(child: child, notifier: model, key: key);

  static TasksInherit? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TasksInherit>();
  }

  static TasksInherit? read(BuildContext context) {
    final w = context
        .getElementForInheritedWidgetOfExactType<TasksInherit>()
        ?.widget;
    return w is TasksInherit ? w : null;
  }
}

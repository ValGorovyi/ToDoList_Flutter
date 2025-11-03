import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_fl/entity/groupEntity.dart';
import 'package:todo_list_fl/entity/taskEntity.dart';

class TasksModel extends ChangeNotifier {
  int groupKey;
  GroupEntity? _group;
  GroupEntity? get group => _group;
  var _tasks = <TaskEntity>[];
  List<TaskEntity> get tasks => _tasks.toList();
  late final Future<Box<GroupEntity>> _groupBox;

  TasksModel({required this.groupKey}) {
    _setup();
  }

  void _readBoxTFromHive() {
    print(_group);
    _tasks = _group?.tasks ?? <TaskEntity>[];
    notifyListeners();
  }

  void deleteTask(int index) async {
    await _group?.tasks?.deleteFromHive(index);
    await _group?.save();
  }

  void _setupListenTask() async {
    final box = await _groupBox;
    _readBoxTFromHive();
    box.listenable(keys: <dynamic>[groupKey]).addListener(_readBoxTFromHive);
  }

  void _setup() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupEntityAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskEntityAdapter());
    }
    Hive.openBox<TaskEntity>('task_entity_box');
    _groupBox = Hive.openBox<GroupEntity>('group_entity_box');
    _loadGroup();
    _setupListenTask();
  }

  void _loadGroup() async {
    final box = await _groupBox;
    _group = box.get(groupKey);
    notifyListeners();
  }

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed('/list/tasks/addTask', arguments: groupKey);
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

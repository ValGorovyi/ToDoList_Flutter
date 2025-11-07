import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_fl/userinterface/entity/groupEntity.dart';
import 'package:todo_list_fl/userinterface/entity/taskEntity.dart';
import 'package:todo_list_fl/userinterface/mainNavigation.dart';

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
    /// eshe net _group
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

  void doneTogle(int groupIndex) async {
    final task = group?.tasks?[groupIndex];
    final curretDone = task?.isDone ?? false;
    task?.isDone = !curretDone;
    task?.save();
    notifyListeners();
  }

  void _setup() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupEntityAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskEntityAdapter());
    }
    _groupBox = Hive.openBox<GroupEntity>('group_entity_box');
    await Hive.openBox<TaskEntity>('task_entity_box');
    _loadGroup();
    _setupListenTask();
  }

  void _loadGroup() async {
    final box = await _groupBox;
    _group = box.get(groupKey);
    notifyListeners();
  }

  void showForm(BuildContext context) {
    Navigator.of(
      context,
    ).pushNamed(MainNavigationNames.taskForm, arguments: groupKey);
  }
}

class TasksInherit extends InheritedNotifier {
  TasksModel model;

  TasksInherit({required this.model, required super.child, super.key})
    : super(notifier: model);

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

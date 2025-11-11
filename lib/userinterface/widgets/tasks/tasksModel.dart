import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_fl/userinterface/boxManager.dart';
import 'package:todo_list_fl/userinterface/entity/taskEntity.dart';
import 'package:todo_list_fl/userinterface/mainNavigation.dart';
import 'package:todo_list_fl/userinterface/widgets/tasks/tasksWidget.dart';

class TasksModel extends ChangeNotifier {
  TasksWConfiguration configuration;
  var _tasks = <TaskEntity>[];
  List<TaskEntity> get tasks => _tasks.toList();
  late final Future<Box<TaskEntity>> _taskBox;

  TasksModel({required this.configuration}) {
    _setupStarted();
  }

  Future<void> _readBoxTFromHive() async {
    /// eshe net _group
    _tasks = (await _taskBox).values.toList();
    notifyListeners();
  }

  Future<void> deleteTask(int taskIndex) async {
    final box = await _taskBox;
    await box.deleteAt(taskIndex);
    // await _group?.tasks?.deleteFromHive(index);
    // await _group?.save();
  }

  Future<void> doneTogle(int taskIndex) async {
    final task = (await _taskBox).getAt(taskIndex);
    task?.isDone = !task.isDone;
  }

  void _setupStarted() async {
    _taskBox = BoxManager.instance.openTasksBox(configuration.groupKey);
    await _readBoxTFromHive();
    (await _taskBox).listenable().addListener(() {
      _readBoxTFromHive();
    });
  }

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed(
      MainNavigationNames.taskForm,
      arguments: configuration.groupKey,
    );
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

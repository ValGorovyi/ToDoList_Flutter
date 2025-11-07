import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list_fl/userinterface/entity/groupEntity.dart';
import 'package:todo_list_fl/userinterface/entity/taskEntity.dart';

class TaskFormModel {
  var taskText = '';
  int groupKey;
  TaskFormModel({required this.groupKey});
  void SaveTaskText(BuildContext context) async {
    if (taskText.isEmpty) return;
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupEntityAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskEntityAdapter());
    }
    final task = TaskEntity(isDone: false, name: taskText);
    final taskBox = await Hive.openBox<TaskEntity>('task_entity_box');
    await taskBox.add(task);

    final groupBox = await Hive.openBox<GroupEntity>('group_entity_box');
    final group = groupBox.get(groupKey);
    group?.addTask(taskBox, task);

    Navigator.of(context).pop();
  }
}

class TaskFormInherit extends InheritedNotifier {
  final TaskFormModel model;
  const TaskFormInherit({super.key, required super.child, required this.model});

  static TaskFormInherit? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskFormInherit>();
  }

  static TaskFormInherit? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TaskFormInherit>()
        ?.widget;
    return widget is TaskFormInherit ? widget : null;
  }

  @override
  bool updateShouldNotify(covariant InheritedNotifier<Listenable> oldWidget) {
    return false;
  }
}

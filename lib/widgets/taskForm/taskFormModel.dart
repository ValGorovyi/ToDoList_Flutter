import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list_fl/entity/groupEntity.dart';
import 'package:todo_list_fl/entity/taskEntity.dart';

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

class GroupFormInherit extends InheritedNotifier {
  final TaskFormModel model;
  GroupFormInherit({Key? key, required Widget child, required this.model})
    : super(child: child);

  static GroupFormInherit? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GroupFormInherit>();
  }

  static GroupFormInherit? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<GroupFormInherit>()
        ?.widget;
    return widget is GroupFormInherit ? widget : null;
  }
}

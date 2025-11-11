import 'package:flutter/material.dart';
import 'package:todo_list_fl/userinterface/boxManager.dart';
import 'package:todo_list_fl/userinterface/entity/taskEntity.dart';

class TaskFormModel {
  var taskText = '';
  int groupKey;
  TaskFormModel({required this.groupKey});
  void SaveTaskText(BuildContext context) async {
    if (taskText.isEmpty) return;
    final task = TaskEntity(isDone: false, name: taskText);
    final box = await BoxManager.instance.openTasksBox(groupKey);
    box.add(task);

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

import 'package:flutter/material.dart';
import 'package:todo_list_fl/userinterface/entity/groupEntity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_fl/userinterface/entity/taskEntity.dart';
import 'package:todo_list_fl/userinterface/mainNavigation.dart';

class GroupsModel extends ChangeNotifier {
  var _groups = <GroupEntity>[];
  List<GroupEntity> get groups => _groups.toList();
  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationNames.groupForm);
  }

  void showTasks(BuildContext context, int indexGroup) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupEntityAdapter());
    }
    final box = await Hive.openBox<GroupEntity>('group_entity_box');
    final groupKey = box.keyAt(indexGroup);
    Navigator.of(
      context,
    ).pushNamed(MainNavigationNames.tasks, arguments: groupKey);
  }

  void deleteGroup(int index) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupEntityAdapter());
    }
    final box = await Hive.openBox<GroupEntity>('group_entity_box');
    await box.getAt(index)?.tasks?.deleteAllFromHive();

    box.deleteAt(index);
  }

  GroupsModel() {
    _setupStarted();
  }
  void _readBoxFromHive(Box<GroupEntity> box) {
    _groups = box.values.toList();
    notifyListeners();
  }

  void _setupStarted() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupEntityAdapter());
    }
    final box = await Hive.openBox<GroupEntity>('group_entity_box');

    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskEntityAdapter());
    }
    await Hive.openBox<TaskEntity>('task_entity_box');

    _readBoxFromHive(box);
    box.listenable().addListener(() {
      _readBoxFromHive(box);
    });
  }
}

class GroupsInherit extends InheritedNotifier {
  final GroupsModel model;
  const GroupsInherit({required this.model, required super.child, super.key})
    : super(notifier: model);
  static GroupsInherit? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GroupsInherit>();
  }

  static GroupsInherit? read(BuildContext context) {
    final w = context
        .getElementForInheritedWidgetOfExactType<GroupsInherit>()
        ?.widget;
    return w is GroupsInherit ? w : null;
  }
}

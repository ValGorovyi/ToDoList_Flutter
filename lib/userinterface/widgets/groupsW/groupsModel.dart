import 'package:flutter/material.dart';
import 'package:todo_list_fl/userinterface/boxManager.dart';
import 'package:todo_list_fl/userinterface/entity/groupEntity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_fl/userinterface/mainNavigation.dart';
import 'package:todo_list_fl/userinterface/widgets/tasks/tasksWidget.dart';

class GroupsModel extends ChangeNotifier {
  late final Future<Box<GroupEntity>> _groupBox;
  var _groups = <GroupEntity>[];
  List<GroupEntity> get groups => _groups.toList();
  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationNames.groupForm);
  }

  void showTasks(BuildContext context, int indexGroup) async {
    final group = (await _groupBox).getAt(indexGroup);
    if (group != null) {
      final configuration = TasksWConfiguration(group.key as int, group.name);
      Navigator.of(
        context,
      ).pushNamed(MainNavigationNames.tasks, arguments: configuration);
    }
  }

  void deleteGroup(int index) async {
    final box = await _groupBox;
    final groupKey = (await _groupBox).keyAt(index) as int;
    final taskBoxName = BoxManager.instance.boxNameCreator(groupKey);
    Hive.deleteBoxFromDisk(taskBoxName);

    // box.deleteAt(index);
  }

  GroupsModel() {
    _setupStarted();
  }
  Future<void> _readBoxFromHive() async {
    _groups = (await _groupBox).values.toList();
    notifyListeners();
  }

  void _setupStarted() async {
    _groupBox = BoxManager.instance.openGroupBox();
    await _readBoxFromHive();
    (await _groupBox).listenable().addListener(() {
      _readBoxFromHive();
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

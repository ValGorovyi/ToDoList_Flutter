import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list_fl/userinterface/entity/groupEntity.dart';

class GroupFormModel {
  var GroupName = '';
  void SaveGroupName(BuildContext context) async {
    if (GroupName.isEmpty) return;
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupEntityAdapter());
    }
    final box = await Hive.openBox<GroupEntity>('group_entity_box');
    final group = GroupEntity(name: GroupName);
    box.add(group); //await?
    Navigator.of(context).pop();
  }
}

class GroupFormInherit extends InheritedNotifier {
  final GroupFormModel model;
  const GroupFormInherit({
    super.key,
    required super.child,
    required this.model,
  });

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

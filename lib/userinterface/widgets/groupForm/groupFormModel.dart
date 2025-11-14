import 'package:flutter/material.dart';
import 'package:todo_list_fl/userinterface/boxManager.dart';
import 'package:todo_list_fl/userinterface/entity/groupEntity.dart';

class GroupFormModel extends ChangeNotifier {
  var _groupName = '';
  String? errorText;
  set groupName(String value) {
    if (errorText != null && value.trim().isNotEmpty) {
      errorText = null;
      notifyListeners();
    }
    _groupName = value;
  }

  void SaveGroupName(BuildContext context) async {
    final groupName = _groupName.trim();
    if (groupName.isEmpty) {
      errorText = 'Input Text Error';
      notifyListeners();
      return;
    }
    // if (_groupName.isEmpty) return;
    final box = await BoxManager.instance.openGroupBox();

    final group = GroupEntity(name: _groupName);
    await box.add(group); //await?
    await BoxManager.instance.closeBox(box);
    Navigator.of(context).pop();
  }
}

class GroupFormInherit extends InheritedNotifier {
  final GroupFormModel model;
  const GroupFormInherit({super.key, required super.child, required this.model})
    : super(notifier: model);

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

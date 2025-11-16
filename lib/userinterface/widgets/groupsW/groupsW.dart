import 'package:flutter/material.dart';
import 'package:todo_list_fl/userinterface/widgets/groupsW/groupsModel.dart';
import 'package:todo_list_fl/userinterface/widgets/groupsW/listItem.dart';

class GroupsList extends StatelessWidget {
  const GroupsList({super.key});

  @override
  Widget build(BuildContext context) {
    final GroupsItemsCound =
        GroupsInherit.watch(context)?.model.groups.length ?? 0;
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) =>
          ListGroupItem(index: index),
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 10),
      itemCount: GroupsItemsCound,
    );
  }
}

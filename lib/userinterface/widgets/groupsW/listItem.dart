import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list_fl/userinterface/widgets/groupsW/groupsModel.dart';

class ListGroupItem extends StatelessWidget {
  final index;
  const ListGroupItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final model = GroupsInherit.read(context)?.model;
    final group = model?.groups[index];
    return Slidable(
      key: ValueKey(UniqueKey()),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),

        dismissible: DismissiblePane(
          key: key,
          onDismissed: () {
            model?.deleteGroup(index);
          },
        ),
        children: [
          SlidableAction(
            onPressed: (BuildContext c) {
              model?.deleteGroup(index);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),

      child: ColoredBox(
        color: Colors.white,
        child: ListTile(
          title: Text(group!.name),
          onTap: () => model?.showTasks(context, index),
        ),
      ),
    );
  }
}

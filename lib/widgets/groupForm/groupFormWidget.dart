import 'package:flutter/material.dart';
import 'package:todo_list_fl/widgets/groupForm/groupFormModel.dart';

class AddGroupFormWidget extends StatefulWidget {
  @override
  State<AddGroupFormWidget> createState() => _AddGroupFormWidgetState();
}

class _AddGroupFormWidgetState extends State<AddGroupFormWidget> {
  final _model = GroupFormModel();

  @override
  Widget build(BuildContext context) {
    return GroupFormInherit(model: _model, child: _GroupFormBodyWidget());
  }
}

class _GroupFormBodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = GroupFormInherit.read(context)?.model;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Group'),
        actions: [
          IconButton(
            onPressed: () {
              model?.SaveGroupName(context);
            },
            icon: Icon(Icons.done_all),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
          child: GroupTextW(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          model?.SaveGroupName(context);
        },
        child: Icon(Icons.done),
      ),
    );
  }
}

class GroupTextW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = GroupFormInherit.read(context)?.model;
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Input Group Name',
      ),
      autofocus: true,
      onEditingComplete: () => model?.SaveGroupName(context),
      onChanged: (value) => model?.GroupName = value,
    );
  }
}

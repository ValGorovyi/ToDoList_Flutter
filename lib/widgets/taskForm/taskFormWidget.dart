import 'package:flutter/material.dart';
import 'package:todo_list_fl/widgets/taskForm/taskFormModel.dart';

class TaskFormWidget extends StatefulWidget {
  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  TaskFormModel? _model;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_model == null) {
      final groupKey = ModalRoute.of(context)?.settings.arguments as int;
      _model = TaskFormModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TaskFormInherit(child: _TextFormBodyWidget(), model: _model!);
  }
}

class _TextFormBodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = TaskFormInherit.read(context)?.model;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task Text'),
        actions: [
          IconButton(
            onPressed: () {
              model?.SaveTaskText(context);
            },
            icon: Icon(Icons.done_all),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
          child: TaskTextW(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          model?.SaveTaskText(context);
        },
        child: Icon(Icons.done),
      ),
    );
  }
}

class TaskTextW extends StatelessWidget {
  const TaskTextW({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TaskFormInherit.read(context)?.model;
    return TextField(
      maxLines: null,
      minLines: null,
      expands: true,

      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Input Task Text',
      ),
      autofocus: true,
      onChanged: (value) {
        print('vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv');
        print(value);
        model?.taskText = value;
      },
      onEditingComplete: () => model?.SaveTaskText(context),
    );
  }
}

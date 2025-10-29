import 'package:flutter/material.dart';
import 'package:todo_list_fl/widgets/tasks/tasksModel.dart';

class TasksWidget extends StatefulWidget {
  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  TasksModel? _model;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_model == null) {
      final groupKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = TasksModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = _model;
    if (model != null) {
      return TasksInherit(child: TasksWidgetBody(), model: model);
    } else {
      return CircularProgressIndicator();
    }
  }
}

class TasksWidgetBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = TasksInherit.watch(context)?.model;
    final title = model?.group?.name ?? 'Task';
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model?.showForm(context),
        child: Icon(Icons.add_box_rounded),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
      body: TasksList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model?.showForm(context),
        child: Icon(Icons.add_box_rounded),
      ),
    );
  }
}

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tasksItemsCound =
        TasksInherit.watch(context)?.model.tasks.length ?? 0;
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) =>
          ListTasksItem(index: index),
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 10),
      itemCount: tasksItemsCound,
    );
  }
}

class ListTasksItem extends StatelessWidget {
  final index;
  ListTasksItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final model = TasksInherit.read(context)?.model;
    final task = model?.tasks[index];
    return Slidable(
      key: const ValueKey(0),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () {
            model?.deleteTask(index);
          },
        ),

        children: [
          SlidableAction(
            onPressed: (BuildContext c) {
              model?.deleteTask(index);
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
        child: ListTile(title: Text(task!.name), onTap: () {}),
      ),
    );
  }
}

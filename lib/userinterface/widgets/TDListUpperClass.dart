import 'package:flutter/material.dart';
import 'package:todo_list_fl/userinterface/mainNavigation.dart';
import 'package:todo_list_fl/userinterface/widgets/groupsW/groupsModel.dart';
import 'package:todo_list_fl/userinterface/widgets/groupsW/groupsW.dart';

class TDListUpperClass extends StatelessWidget {
  static final mainNavigation = MainNavigation();

  const TDListUpperClass({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute,
      onGenerateRoute: mainNavigation.onGenerateMyRoute,
    );
  }
}

class TDListUpperWidget extends StatefulWidget {
  const TDListUpperWidget({super.key});

  @override
  State<TDListUpperWidget> createState() => _TDListUpperWidgetState();
}

class _TDListUpperWidgetState extends State<TDListUpperWidget> {
  final _model = GroupsModel();

  @override
  Widget build(BuildContext context) {
    return GroupsInherit(model: _model, child: _TDListUpperWidgetBody());
  }

  @override
  void dispose() async {
    await _model.dispose();
    super.dispose();
  }
}

class _TDListUpperWidgetBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('toDos Group'),
        centerTitle: true,
        backgroundColor: Colors.limeAccent,
      ),
      body: GroupsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GroupsInherit.read(context)?.model.showForm(context),
        child: Icon(Icons.add_box_rounded),
      ),
    );
  }
}

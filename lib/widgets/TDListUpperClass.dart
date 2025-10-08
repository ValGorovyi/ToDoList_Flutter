import 'package:flutter/material.dart';

class TDListUpperClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/list': (conrext) => TDListUpperWidget()},
      initialRoute: '/list',
    );
  }
}

class TDListUpperWidget extends StatelessWidget {
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
        onPressed: () {},
        child: Icon(Icons.add_box_rounded),
      ),
    );
  }
}

class GroupsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) =>
          ListTile(title: Text('demo text'), onTap: () {}),
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 10),
      itemCount: 30,
    );
  }
}

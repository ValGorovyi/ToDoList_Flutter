import 'package:hive/hive.dart';
import 'package:todo_list_fl/userinterface/entity/groupEntity.dart';
import 'package:todo_list_fl/userinterface/entity/taskEntity.dart';

abstract class _boxNames {
  static const groupsBoxName = 'group_entity_box';
  static const groupsBoxId = 1;
  // static const tasksBoxName = 'task_entity_box';
  static const tasksBoxId = 2;
}

class BoxManager {
  static final BoxManager instance = BoxManager._();
  BoxManager._();

  String boxNameCreator(int groupKey) => '$_boxNames.groupBoxName_$groupKey';

  Future<Box<G>> _openBox<G>(
    int boxId,
    String boxName,
    TypeAdapter<G> adapter,
  ) async {
    if (!Hive.isAdapterRegistered(boxId)) {
      Hive.registerAdapter(adapter);
    }
    return Hive.openBox<G>(boxName);
  }

  Future<Box<GroupEntity>> openGroupBox() async {
    return _openBox(
      _boxNames.groupsBoxId,
      _boxNames.groupsBoxName,
      GroupEntityAdapter(),
    );
  }

  Future<Box<TaskEntity>> openTasksBox(int groupKey) async {
    return _openBox(
      _boxNames.tasksBoxId,
      boxNameCreator(groupKey),
      TaskEntityAdapter(),
    );
  }

  Future<void> closeBox<G>(Box box) async {
    await box.compact();
    await box.close();
  }
}

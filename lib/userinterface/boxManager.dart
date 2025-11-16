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
  final Map<String, int> _boxCount = <String, int>{};
  static final BoxManager instance = BoxManager._();
  BoxManager._();

  String boxNameCreator(int groupKey) =>
      '$_boxNames.groupboxname_$groupKey'.toLowerCase();

  Future<Box<G>> _openBox<G>(
    int boxId,
    String boxName,
    TypeAdapter<G> adapter,
  ) async {
    if (Hive.isBoxOpen(boxName)) {
      final cound = _boxCount[boxName] ?? 1;
      _boxCount[boxName] = cound + 1;
      return Hive.box(boxName);
    }
    _boxCount[boxName] = 1;
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
    if (!box.isOpen) {
      _boxCount.remove(box.name);
      return;
    }
    int cound = _boxCount[box.name] ?? 1;
    _boxCount[box.name] = cound - 1;
    if (cound > 0) return;
    _boxCount.remove(box.name);
    await box.compact();
    await box.close();
  }
}

import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_fl/entity/taskEntity.dart';
part 'groupEntity.g.dart';

@HiveType(typeId: 1)
class GroupEntity {
  @HiveField(0)
  String name;
  @HiveField(1)
  HiveList<TaskEntity>? tasks;
  GroupEntity({required this.name});

  void addTask(Box<TaskEntity> box, TaskEntity task) {
    tasks ??= HiveList(box);
    tasks?.add(task);
  }
}

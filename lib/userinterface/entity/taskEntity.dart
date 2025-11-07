import 'package:hive/hive.dart';

part 'taskEntity.g.dart';

@HiveType(typeId: 2)
class TaskEntity extends HiveObject {
  @HiveField(1)
  String name;
  @HiveField(2)
  bool isDone;
  TaskEntity({required this.isDone, required this.name});
}

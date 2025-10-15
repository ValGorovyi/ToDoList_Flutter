import 'package:hive_flutter/hive_flutter.dart';
part 'groupEntity.g.dart';

@HiveType(typeId: 1)
class GroupEntity {
  @HiveField(0)
  String name;
  GroupEntity({required this.name});
}

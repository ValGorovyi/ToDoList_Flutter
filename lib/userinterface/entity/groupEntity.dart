import 'package:hive_flutter/hive_flutter.dart';
part 'groupEntity.g.dart';

@HiveType(typeId: 1)
class GroupEntity extends HiveObject {
  // lAST USED HIVE FIELD ID (1)

  @HiveField(0)
  String name;
  GroupEntity({required this.name});
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groupEntity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroupEntityAdapter extends TypeAdapter<GroupEntity> {
  @override
  final int typeId = 1;

  @override
  GroupEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroupEntity(name: fields[0] as String);
  }

  @override
  void write(BinaryWriter writer, GroupEntity obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

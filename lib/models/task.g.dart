// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 2;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      title: fields[1] as dynamic,
      content: fields[4] as String,
      done: fields[5] as bool,
      highlightColor: fields[2] as Color?,
      creationDate: fields[0] as DateTime?,
      dueDate: fields[6] as DateTime?,
    )..tags = (fields[3] as List).cast<Tag>();
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(7)
      ..writeByte(4)
      ..write(obj.content)
      ..writeByte(5)
      ..write(obj.done)
      ..writeByte(6)
      ..write(obj.dueDate)
      ..writeByte(0)
      ..write(obj.creationDate)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.highlightColor)
      ..writeByte(3)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

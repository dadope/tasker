// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteAdapter extends TypeAdapter<Note> {
  @override
  final int typeId = 1;

  @override
  Note read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Note(
      creationDate: fields[0] as DateTime?,
      title: fields[1] as String,
      highlightColor: fields[2] as Color?,
      content: fields[4] as String,
    )..tags = (fields[3] as List).cast<Tag>();
  }

  @override
  void write(BinaryWriter writer, Note obj) {
    writer
      ..writeByte(5)
      ..writeByte(4)
      ..write(obj.content)
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
      other is NoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

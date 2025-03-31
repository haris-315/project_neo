// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_based_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoleBasedModelAdapter extends TypeAdapter<RoleBasedModel> {
  @override
  final int typeId = 1;

  @override
  RoleBasedModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoleBasedModel(
      role: fields[0] as String,
      content: fields[1] as Chat,
    );
  }

  @override
  void write(BinaryWriter writer, RoleBasedModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.role)
      ..writeByte(1)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoleBasedModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

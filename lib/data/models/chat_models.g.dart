// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GeminiResponseAdapter extends TypeAdapter<GeminiResponse> {
  @override
  final int typeId = 2;

  @override
  GeminiResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GeminiResponse(
      responseText: fields[0] as String,
      blockReason: fields[1] as String?,
      totalTokens: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, GeminiResponse obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.responseText)
      ..writeByte(1)
      ..write(obj.blockReason)
      ..writeByte(2)
      ..write(obj.totalTokens);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeminiResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserChatAdapter extends TypeAdapter<UserChat> {
  @override
  final int typeId = 3;

  @override
  UserChat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserChat(
      message: fields[0] as String,
      sendTime: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, UserChat obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.sendTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserChatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

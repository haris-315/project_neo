import 'package:hive_flutter/adapters.dart';
import 'package:project_neo/features/data/models/chat_models.dart';
part 'role_based_model.g.dart';

@HiveType(typeId: 1)
class RoleBasedModel {
  @HiveField(0)
  final String role;
  @HiveField(1)
  final Chat chat;

  RoleBasedModel({required this.role, required this.chat});

  Map<String, String> toMap() => <String, String>{
    "Role": role,
    "Text": chat.content,
  };
}

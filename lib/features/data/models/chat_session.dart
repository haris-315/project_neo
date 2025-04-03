import 'package:hive_flutter/adapters.dart';
import 'package:project_neo/features/data/models/role_based_model.dart';
part 'chat_session.g.dart';
@HiveType(typeId: 0)
class ChatSession {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final DateTime creationDate;
  @HiveField(2)
  final List<RoleBasedModel> conversations;

  ChatSession({required this.title, required this.creationDate, required this.conversations});
}

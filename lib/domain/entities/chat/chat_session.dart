import 'package:project_neo/domain/entities/chat/chat_entity.dart';

class ChatSession {
  String title;
  final DateTime createdAt;
  final String id;
  String identifier;
  List<ChatEntity> conversation;
  ChatSession({
    required this.title,
    required this.createdAt,
    required this.id,
    required this.identifier,
    required this.conversation,
  });

  factory ChatSession.empty() => ChatSession(
    title: "",
    createdAt: DateTime.now(),
    id: "",
    identifier: "",
    conversation: [],
  );
}

import 'package:project_neo/domain/entities/chat_entity.dart';

class ChatSession {
  final String title;
  final DateTime createdAt;
  final String id;
  final String identifier;
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

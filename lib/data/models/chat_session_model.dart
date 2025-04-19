import 'dart:convert';

import 'package:project_neo/data/models/chat_model.dart';
import 'package:project_neo/domain/entities/chat/chat_session.dart';

class ChatSessionModel extends ChatSession {
  ChatSessionModel({
    required super.id,
    required super.title,
    required super.createdAt,
    required super.conversation,
    required super.identifier,
  });
  factory ChatSessionModel.fromJson(Map<String, dynamic> json) {
    return ChatSessionModel(
      id: json['id'],
      identifier: json['identifier'],
      title: json['title'],
      createdAt: DateTime.parse(json['createdAt']),
      conversation:
          (json['conversation'] as List<Map<String, dynamic>>)
              .map((val) => ChatModel.fromMap(val))
              .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "identifier": identifier,
      "title": title,
      "created_at": createdAt.toIso8601String(),
      "conversation": jsonEncode(
        conversation
            .map((val) => {"prompt": val.prompt, "content": val.content})
            .toList(),
      ),
    };
  }

  List<List<Map<String, dynamic>>> contextMemory(String uname) =>
      conversation
          .map(
            (val) => [
              {
                "role": "user",
                "parts": [
                  {"text": val.prompt},
                ],
              },
              {
                "role": "model",
                "parts": [
                  {"text": val.content},
                ],
              },
            ],
          )
          .toList();
}

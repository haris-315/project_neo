import 'package:project_neo/data/models/chat_model.dart';
import 'package:project_neo/domain/entities/chat_session.dart';

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
  toJson() {
    return {
      "id": id,
      "title": title,
      "createdAt": createdAt,
      "identifier": identifier,
      "conversation":
          conversation
              .map((val) => {"prompt": val.prompt, "content": val.content})
              .toList(),
    };
  }

  List<List<Map<String, dynamic>>> contextMemory(String uname) =>
      conversation
          .map(
            (val) => [
              {
                "role": uname,
                "parts": [
                  {"text": val.prompt},
                ],
              },
              {
                "role": "Neo",
                "parts": [
                  {"text": val.content},
                ],
              },
            ],
          )
          .toList();
}

import 'package:project_neo/domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  ChatModel({required super.prompt, required super.content});
  factory ChatModel.fromJson(Map<String, dynamic> map, String prompt) {
    return ChatModel(
      prompt: prompt,
      content:
          map["candidates"]?[0]?["content"]?["parts"]?[0]?["text"] ??
          "No response.",
    );
  }
  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      prompt: map['prompt'],
      content:
          map['content']
    );
  }
  
  Map<String, dynamic> toMap() {
    return {"prompt" : prompt, "content" : content};
  }
}

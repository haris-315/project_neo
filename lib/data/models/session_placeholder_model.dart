import 'package:project_neo/domain/entities/chat/session_placeholder.dart';

class SessionPlaceholderModel extends SessionPlaceholder {
  SessionPlaceholderModel({required super.title, required super.createdAt});
  factory SessionPlaceholderModel.fromJson(Map<String, dynamic> json) {
    return SessionPlaceholderModel(
      title: json["title"],
      createdAt: DateTime.parse(json["created_at"]),
    );
  }
}

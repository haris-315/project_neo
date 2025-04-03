import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
part 'chat_models.g.dart';

abstract class Chat {
  String get content;
}

@HiveType(typeId: 2)
class GeminiResponse extends Chat {
  @HiveField(0)
  final String responseText;
  @HiveField(1)
  final String? blockReason;
  @HiveField(2)
  final int? totalTokens;

  GeminiResponse({
    required this.responseText,
    this.blockReason,
    this.totalTokens,
  });

  factory GeminiResponse.fromJson(Map<String, dynamic> json) {
    return GeminiResponse(
      responseText:
          json["candidates"]?[0]?["content"]?["parts"]?[0]?["text"] ??
          "No response.",
      blockReason: json["promptFeedback"]?["blockReason"],
      totalTokens: json["usageMetadata"]?["totalTokens"],
    );
  }

  static GeminiResponse fromRawJson(String str) =>
      GeminiResponse.fromJson(json.decode(str));
  @HiveField(3)
  @override
  // TODO: implement content
  String get content => responseText;
}

@HiveType(typeId: 3)
class UserChat extends Chat {
  @HiveField(0)
  final String message;
  @HiveField(1)
  final DateTime sendTime;

  UserChat({required this.message, required this.sendTime});
  @HiveField(2)
  @override
  // TODO: implement content
  String get content => message;
}

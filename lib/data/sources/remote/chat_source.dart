import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:project_neo/core/custom_exceptions/server_exception.dart';
import 'package:project_neo/data/models/chat_model.dart';
import 'package:project_neo/data/models/chat_session_model.dart';
import 'package:project_neo/domain/entities/chat_session.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GeminiDataSource {
  final SupabaseClient client;
  final String apiKey =
      kDebugMode
          ? dotenv.env["GEMINI_API_KEY"]!
          : String.fromEnvironment("GEMINI_API_KEY");
  final List<String> geminiModels = [
    "gemini-2.0-flash-lite",
    "gemini-2.0-flash",
    "gemini-1.5-pro",
    "gemini-1.5-flash",
  ];

  int currentModelIndex = 0;

  GeminiDataSource({required this.client});

  Future<ChatSession> getResponse(
    String prompt,
    ChatSessionModel session,
    String user,
  ) async {
    print(session.contextMemory(user).expand((innerList) => innerList));
    String apiUrl =
        "https://generativelanguage.googleapis.com/v1/models/${geminiModels[currentModelIndex]}:generateContent?key=$apiKey";
    print(prompt);
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": [
            ...session.contextMemory(user).expand((innerList) => innerList),
            {
              "role": "user",
              "parts": [
                {"text": prompt},
              ],
            },
          ],
        }),
      );
      print(response.body);
      if (response.statusCode == 429) {
        if (currentModelIndex < geminiModels.length - 1) {
          currentModelIndex++;
          return await getResponse(prompt, session, user);
        } else {
          currentModelIndex = 0;
          throw ServerException(
            exception: "Limit reached! try again in few minutes.",
          );
        }
      }
      session.conversation.add(
        ChatModel.fromJson(jsonDecode(response.body), prompt),
      );
      await client.from("sessions").upsert(session.toJson(), onConflict: "id");
      return session;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw ServerException(
        exception: "There was an error generating reponse.",
      );
    }
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:project_neo/core/custom_exceptions/server_exception.dart';
import 'package:project_neo/core/shared/constants/app_constants.dart';
import 'package:project_neo/core/utils/generate_session_title.dart';
import 'package:project_neo/data/models/chat_model.dart';
import 'package:project_neo/data/models/chat_session_model.dart';
import 'package:project_neo/data/models/session_placeholder_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ChatRemoteDataSource {
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

  ChatRemoteDataSource({required this.client});
  Future<List<SessionPlaceholderModel>> getSessionsInfo({
    required String userId,
  }) async {
    try {
      final List data = await client
          .from(AppConstants.sessionsTable)
          .select("title, created_at, identifier")
          .eq("id", userId);
      final List<SessionPlaceholderModel> info =
          data.map((e) => SessionPlaceholderModel.fromJson(e)).toList();
      return info;
    } catch (e) {
      throw ServerException(
        exception: "An error occured while fetching sessions.",
      );
    }
  }

  Future<ChatSessionModel> getSession({required String identifier}) async {
    try {
      final data = await client
          .from(AppConstants.sessionsTable)
          .select()
          .eq("identifier", identifier);

      final ChatSessionModel info = ChatSessionModel.fromJson(data.first);
      return info;
    } catch (e) {
      throw ServerException(
        exception: "An error occured while fetching session id $identifier.",
      );
    }
  }

  Future<List<SessionPlaceholderModel>> deleteSession({
    required String identifier,
    required String userId,
  }) async {
    try {
      await client
          .from(AppConstants.sessionsTable)
          .delete()
          .eq("identifier", identifier);
      final List<SessionPlaceholderModel> info = await getSessionsInfo(
        userId: userId,
      );
      // data.map((e) => SessionPlaceholderModel.fromJson(e)).toList();
      return info;
    } catch (e) {
      throw ServerException(
        exception: "An error occured while refreshing sessions.",
      );
    }
  }

  Future<ChatSessionModel> getResponse(
    String prompt,
    ChatSessionModel session,
    String user,
  ) async {
    String apiUrl =
        "https://generativelanguage.googleapis.com/v1/models/${geminiModels[currentModelIndex]}:generateContent?key=$apiKey";
    try {
      const maxContextSize = 18;
      const trimCount = 3;

      final contextMemory =
          session.contextMemory(user).expand((e) => e).toList();

      if (contextMemory.length > maxContextSize) {
        contextMemory.removeRange(0, trimCount);
      }
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": [
            {
              "role": "user",
              "parts": [
                {"text": AppConstants.devInfo},
              ],
            },
            ...contextMemory,
            {
              "role": "user",
              "parts": [
                {"text": prompt},
              ],
            },
          ],
        }),
      );
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
      if (session.identifier.isEmpty) {
        session.identifier = const Uuid().v4();
      }
      if (session.title.isEmpty) {
        session.title = generateSessionTitle(session.conversation.first.prompt);
      }
      await client
          .from("sessions")
          .upsert(session.toJson(), onConflict: "identifier");
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

import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:project_neo/features/data/models/chat_models.dart';
import 'package:project_neo/features/data/models/role_based_model.dart';

class GeminiService {
  static final String apiKey = dotenv.env["GEMINI_API_KEY"]!;
  static final List<String> geminiModels = [
    "gemini-2.0-flash-lite",
    "gemini-2.0-flash",
    "gemini-1.5-pro",
    "gemini-1.5-flash",
  ];

  static int currentModelIndex = 0;

  static Future<RoleBasedModel> getResponse(String prompt) async {
    String apiUrl =
        "https://generativelanguage.googleapis.com/v1/models/${geminiModels[currentModelIndex]}:generateContent?key=$apiKey";

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
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
        return await getResponse(prompt);
      } else {
        currentModelIndex = 0;
        return RoleBasedModel(
          role: "Neo",
          chat: GeminiResponse(
            responseText: "Limit Reached Try In Few Minutes...",
          ),
        );
      }
    }
    return RoleBasedModel(role: "Neo", chat: GeminiResponse.fromRawJson(response.body),);
  }
}

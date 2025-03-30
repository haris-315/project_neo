import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String apiKey = "AIzaSyDNngP5vYUCs30iPJW3U3PZ5LqXZWd4Vw8";
  static final List<String> geminiModels = [
    "gemini-2.0-flash-lite",
    "gemini-2.0-flash",
    "gemini-1.5-pro",
    "gemini-1.5-flash",
  ];

  static int currentModelIndex = 0;

  static Future<String> getResponse(String prompt) async {
    String apiUrl =
        "https://generativelanguage.googleapis.com/v1/models/${geminiModels[currentModelIndex]}:generateContent?key=$apiKey";

    try {
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

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        return data["candidates"]?[0]?["content"]?["parts"]?[0]?["text"] ??
            "No response generated.";
      }
      if (response.statusCode == 429) {
        if (currentModelIndex < geminiModels.length - 1) {
          currentModelIndex++; // Switch to the next model
          return await getResponse(prompt);
        } else {
          currentModelIndex = 0; // Reset after exhausting all models
          return "API rate limit reached for all models. Please try again later.";
        }
      }

      return "Error: ${response.statusCode} - ${response.body}";
    } catch (e) {
      return "An unexpected error occurred. Please try again later.";
    }
  }
}

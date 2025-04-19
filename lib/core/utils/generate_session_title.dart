String generateSessionTitle(String prompt) {
  if (prompt.trim().isEmpty) return "New Session";

  final cleaned =
      prompt
          .replaceAll(RegExp(r'[\n\r]+'), ' ')
          .replaceAll(RegExp(r'[^\w\s-]'), '')
          .trim();

  final words =
      RegExp(
        r'\b\w+\b',
      ).allMatches(cleaned).map((m) => m.group(0)!).take(5).toList();

  if (words.isEmpty) return "New Session";

  final title = words.join(' ');
  return "${title[0].toUpperCase()}${title.substring(1)}";
}

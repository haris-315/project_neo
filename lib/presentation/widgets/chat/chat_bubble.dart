import 'package:flutter/material.dart';
import 'package:project_neo/core/services/get_user.dart';
import 'package:project_neo/core/theme/theme_palette.dart';
import 'package:project_neo/presentation/widgets/md_rendrer.dart';

class MessageBubble extends StatelessWidget {
  final String content;
  final bool isNeo;

  const MessageBubble({super.key, required this.content, this.isNeo = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: isNeo ? 600 : 400),
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.eventHorizon.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: AppTheme.cosmicPurple.withValues(alpha: .3),
            child: Text(
              _characterizeName(
                context: context,
                nameToChars: isNeo ? "Neo" : getUser(context).name.trim(),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            // Critical: allows text to wrap within available space
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    isNeo ? "Neo" : getUser(context).name,
                    style: TextStyle(
                      color: isNeo ? AppTheme.stardust : AppTheme.nebulaBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                if (isNeo)
                  MarkdownViewer(
                    markdownText: content, // Use the response here
                  )
                else
                  Text(content),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _characterizeName({
    required BuildContext context,
    nameToChars = "Neo",
  }) {
    final String name = nameToChars;
    if (name.isEmpty) return "";

    final parts = name.split(RegExp(r'\s+'));
    final buffer = StringBuffer();

    for (final part in parts) {
      if (part.isNotEmpty) {
        buffer.write(part[0].toUpperCase());
      }
    }

    return buffer.toString();
  }
}

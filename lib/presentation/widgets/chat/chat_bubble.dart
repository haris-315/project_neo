import 'package:flutter/material.dart';
import 'package:project_neo/core/services/get_user.dart';
import 'package:project_neo/core/theme/theme_palette.dart';

class MessageBubble extends StatelessWidget {
  final String content;

  const MessageBubble({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 430),
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
              _characterizeName(nameToChars: getUser(context).name.trim()),
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
                    getUser(context).name,
                    style: TextStyle(
                      color: AppTheme.stardust,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(content),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _characterizeName({nameToChars = "Neo"}) {
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

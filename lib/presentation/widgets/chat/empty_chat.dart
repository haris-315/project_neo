import 'package:flutter/material.dart';
import 'package:project_neo/core/theme/theme_palette.dart';

class EmptyChat extends StatelessWidget {
  const EmptyChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.auto_awesome, size: 55, color: AppTheme.nebulaBlue),
          const SizedBox(height: 16),
          Text("How can I help you today?", 
              style: TextStyle(
                fontSize: 18,
                color: AppTheme.stardust.withValues(alpha: 0.8),
              )),
          const SizedBox(height: 8),
          Text("Ask me anything...",
              style: TextStyle(
                color: AppTheme.stardust.withValues(alpha: 0.5),
              )),
        ],
      ),
    );
  }
}
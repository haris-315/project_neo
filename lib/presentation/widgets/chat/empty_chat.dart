import 'package:flutter/material.dart';
import 'package:project_neo/core/theme/theme_palette.dart';

class EmptyChat extends StatefulWidget {
  const EmptyChat({super.key});

  @override
  State<EmptyChat> createState() => _EmptyChatState();
}

class _EmptyChatState extends State<EmptyChat>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 599),
    )..forward();
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1),
      end: Offset(0, 0),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_awesome, size: 55, color: AppTheme.nebulaBlue),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                text: "How can I help you ",
                style: TextStyle(color: AppTheme.stardust, fontSize: 18),
                children: [
                  TextSpan(
                    text: "today?",
                    style: TextStyle(color: AppTheme.nebulaBlue, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Ask me anything...",
              style: TextStyle(color: AppTheme.stardust.withValues(alpha: 0.5)),
            ),
          ],
        ),
      ),
    );
  }
}

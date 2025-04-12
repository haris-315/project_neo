// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:project_neo/core/theme/theme_palette.dart';

class NavigationText extends StatelessWidget {
  final String t1;
  final String t2;
  final VoidCallback onTap;
  const NavigationText({
    super.key,
    required this.t1,
    required this.t2,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: RichText(
          text: TextSpan(
            text: t1,
            style: TextStyle(fontWeight: FontWeight.w700),
            children: [
              TextSpan(
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppTheme.cosmicPurple,
                ),
                text: t2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

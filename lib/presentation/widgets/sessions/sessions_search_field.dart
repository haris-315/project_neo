import 'package:flutter/material.dart';
import 'package:project_neo/core/theme/theme_palette.dart';

class SessionSearchField extends StatelessWidget {
  const SessionSearchField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: controller,
          maxLines: null,
          minLines: 1,
          keyboardType: TextInputType.multiline,
          scrollPhysics: BouncingScrollPhysics(),
          cursorColor: AppTheme.nebulaBlue,
          decoration: InputDecoration(
            hintText: "Search...",
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.nebulaBlue, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.cosmicPurple),
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            suffixIcon: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                color: AppTheme.nebulaBlue,
              ),
              constraints: BoxConstraints(minWidth: 40, maxWidth: 45),
              child: Center(child: Icon(Icons.search)),
            ),
          ),
        ),
      ),
    );
  }
}

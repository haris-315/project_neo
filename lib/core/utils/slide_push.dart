import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder {
  final Widget page;
  SlidePageRoute({required this.page})
    : super(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder:
            (_, anim, __, child) => SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, -1),
                end: Offset.zero,
              ).animate(anim),
              child: FadeTransition(
                opacity: Tween<double>(begin: 0, end: 1).animate(anim),
                child: child,
              ),
            ),
      );
}

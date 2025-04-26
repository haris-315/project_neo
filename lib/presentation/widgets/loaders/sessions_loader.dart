import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' as sk;
import 'package:project_neo/core/theme/theme_palette.dart';

class SessionsLoader extends StatefulWidget {
  const SessionsLoader({super.key});

  @override
  State<SessionsLoader> createState() => _SessionsLoaderState();
}

class _SessionsLoaderState extends State<SessionsLoader> {
  @override
  Widget build(BuildContext context) {
    return sk.SpinKitPulsingGrid(color: AppTheme.nebulaBlue);
  }
}

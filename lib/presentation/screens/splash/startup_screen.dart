import 'package:flutter/material.dart';
import 'package:project_neo/core/services/session_manager.dart';
import 'package:project_neo/core/theme/theme_palette.dart';
import 'package:project_neo/core/utils/app_constants.dart';
import 'package:project_neo/core/utils/session_parser.dart';
import 'package:project_neo/core/utils/slide_push.dart';
import 'package:project_neo/init_dpndncs.dart';
import 'package:project_neo/presentation/screens/auth/signin_screen.dart';
import 'package:project_neo/presentation/screens/chat_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  getSession() async {
    // await serviceLocator<SessionManager>().clearSession(
    //   AppConstants.sessionKey,
    //   () {},
    // );
    final response = await serviceLocator<SessionManager>().retrieveSession(
      AppConstants.sessionKey,
    );
    response.fold((fail) => () {}, (session) {
      if (session == null) {
        Navigator.pushReplacement(
          context,
          SlidePageRoute(page: SignInScreen()),
        );
      } else {
        Supabase.instance.client.auth.setSession(
          SessionParser.sFromString(session)!.refreshToken!,
        );
        Navigator.pushReplacement(context, SlidePageRoute(page: ChatScreen()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.eventHorizon,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppTheme.nebulaBlue),
            SizedBox(height: 10),
            Text(
              "Validating Info...",
              style: TextStyle(
                color: AppTheme.supernova,
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

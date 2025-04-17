import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_neo/core/theme/theme_palette.dart';
import 'package:project_neo/core/utils/slide_push.dart';
import 'package:project_neo/presentation/blocs/supabase/bloc/auth_bloc.dart';
import 'package:project_neo/presentation/screens/auth/signin_screen.dart';
import 'package:project_neo/presentation/screens/chat_screen.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(GetUserInfoEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacement(
            context,
            SlidePageRoute(page: ChatScreen()),
          );
        } else if (state is AuthError) {
          print(state.message);
          Navigator.pushReplacement(
            context,
            SlidePageRoute(page: SignInScreen()),
          );
        }
      },
      builder: (context, state) {
        print(state);
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
      },
    );
  }
}

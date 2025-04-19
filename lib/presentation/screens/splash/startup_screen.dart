import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_neo/core/theme/theme_palette.dart';
import 'package:project_neo/core/utils/slide_push.dart';
import 'package:project_neo/presentation/blocs/auth/auth_bloc.dart';
import 'package:project_neo/presentation/screens/auth/signin_screen.dart';
import 'package:project_neo/presentation/screens/chat/chat_screen.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger the auth check when the widget is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(GetUserInfoEvent());
    });

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacement(
            context,
            SlidePageRoute(page: const ChatScreen()),
          );
        } else if (state is AuthError) {
          debugPrint('Auth Error: ${state.message}');
          Navigator.pushReplacement(
            context,
            SlidePageRoute(page: const SignInScreen()),
          );
        }
      },
      child: _StartupContent(),
    );
  }
}

class _StartupContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.eventHorizon,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated logo or illustration
            _buildAnimatedLogo(),
            const SizedBox(height: 40),
            // Progress indicator with text
            _buildLoadingIndicator(),
            const SizedBox(height: 20),
            // Optional subtitle
            Text(
              "Securely validating your credentials",
              style: TextStyle(
                color: AppTheme.nebulaBlue.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedLogo() {
    // You can replace this with your actual logo or an animation
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: AppTheme.nebulaBlue.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(Icons.rocket_launch, size: 80, color: AppTheme.supernova),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Column(
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.supernova),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          "Validating Session",
          style: TextStyle(
            color: AppTheme.supernova,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

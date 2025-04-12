import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_neo/core/shared/widgets/loading_indicator.dart';
import 'package:project_neo/core/theme/theme_palette.dart';
import 'package:project_neo/core/utils/display_snackbar.dart';
import 'package:project_neo/core/utils/email_validate.dart';
import 'package:project_neo/features/presentation/blocs/supabase/bloc/auth_bloc.dart';
import 'package:project_neo/features/presentation/widgets/auth/navigation_text.dart'
    show NavigationText;

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passVisible = false;
  final GlobalKey<FormState> signInFormKey = GlobalKey();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign In",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return LoadingIndicator();
            }
            return Form(
              key: signInFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: const Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppTheme.customInputField(
                    controller: emailController,

                    hintText: "Email",
                    icon: Icons.email,
                    validate: (value) {
                      if (isValidEmail(value)) {
                        return null;
                      }
                      return "Please enter a valid email.";
                    },
                  ),
                  const SizedBox(height: 15),
                  AppTheme.customInputField(
                    obscureText: !passVisible,
                    controller: passwordController,

                    hintText: "Password",
                    icon: Icons.lock,
                    toggleVisibility: () {
                      setState(() {
                        passVisible = !passVisible;
                      });
                    },
                    validate: (value) {
                      if (value.isNotEmpty || value.length > 8) {
                        return null;
                      } else {
                        return "Enter a correct password.";
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: AppTheme.customAnimatedButton(
                      text: "Sign In",
                      onPressed: () {
                        if (signInFormKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            SignIn(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  NavigationText(
                    t1: "Don't have an account? ",
                    t2: "Sign In",
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

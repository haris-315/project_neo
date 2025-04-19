import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_neo/core/shared/widgets/loading_indicator.dart';
import 'package:project_neo/core/theme/theme_palette.dart';
import 'package:project_neo/core/utils/display_snackbar.dart';
import 'package:project_neo/core/utils/email_validate.dart';
import 'package:project_neo/core/utils/pass_validate.dart';
import 'package:project_neo/core/utils/slide_push.dart';
import 'package:project_neo/presentation/blocs/auth/auth_bloc.dart';
import 'package:project_neo/presentation/screens/auth/signin_screen.dart';
import 'package:project_neo/presentation/widgets/auth/navigation_text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passVisible = false;
  final GlobalKey<FormState> signUpFormKey = GlobalKey();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign Up",
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
              key: signUpFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppTheme.customInputField(
                    controller: nameController,

                    hintText: "Name",
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 15),
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
                      if (isStrongPassword(value)) {
                        return null;
                      } else {
                        return "Please choose a strong password.";
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: AppTheme.customAnimatedButton(
                      text: "Sign Up",
                      onPressed: () {
                        if (signUpFormKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            SignUp(
                              name: nameController.text.trim(),
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
                    t1: "Already have an account! ",
                    t2: "Sign In",
                    onTap: () {
                      Navigator.push(
                        context,
                        SlidePageRoute(page: SignInScreen()),
                      );
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

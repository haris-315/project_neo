import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project_neo/core/theme/theme_palette.dart';
import 'package:project_neo/features/presentation/blocs/supabase/bloc/auth_bloc.dart';
import 'package:project_neo/features/presentation/screens/auth/signin_screen.dart';
import 'package:project_neo/features/presentation/screens/auth/signup_screen.dart';
import 'package:project_neo/features/presentation/screens/chat_screen.dart';
import 'package:project_neo/init_dpndncs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => serviceLocator<AuthBloc>())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      title: dotenv.env['SUPABASE_URL'],
      initialRoute: "/signup",
      routes: {
        '/chat': (context) => ChatScreen(),
        '/signup': (context) => SignUpScreen(),
        '/signin': (context) => SignInScreen(),
      },
    );
  }
}

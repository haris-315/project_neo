// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project_neo/core/theme/theme_palette.dart';
import 'package:project_neo/data/models/chat_models.dart';
import 'package:project_neo/data/models/chat_session.dart';
import 'package:project_neo/data/models/role_based_model.dart';
import 'package:project_neo/data/repositories/auth_repo_impl.dart';
import 'package:project_neo/data/sources/remote/auth_data_source.dart';
import 'package:project_neo/domain/usecases/auth/user_signup.dart';
import 'package:project_neo/presentation/blocs/supabase/bloc/auth_bloc.dart';
import 'package:project_neo/presentation/screens/auth/signup_screen.dart';
import 'package:project_neo/presentation/screens/chat_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  final supabase = await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  Hive.registerAdapter(ChatSessionAdapter());
  Hive.registerAdapter(RoleBasedModelAdapter());
  Hive.registerAdapter(UserChatAdapter());
  Hive.registerAdapter(GeminiResponseAdapter());
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => AuthBloc(
                userSignUp: UserSignUp(
                  repo: AuthRepositoryImpl(AuthDataSource(client: supabase.client)),
                ),
              ),
        ),
      ],
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
      // home: ChatScreen(),
      initialRoute: "signup",
      routes: {
        'chat': (context) => ChatScreen(),
        'signup': (context) => SignUpScreen(),
      },
    );
  }
}

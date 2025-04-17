import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project_neo/core/theme/theme_palette.dart';
import 'package:project_neo/presentation/blocs/chat/chat_bloc.dart';
import 'package:project_neo/presentation/blocs/supabase/bloc/auth_bloc.dart';
import 'package:project_neo/presentation/screens/chat_screen.dart';
import 'package:project_neo/init_dpndncs.dart';
import 'package:project_neo/presentation/screens/splash/startup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<ChatBloc>()),
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
      initialRoute: "/startup",
      routes: {
        '/chat': (context) => ChatScreen(),
        '/startup': (context) => StartupScreen(),
      },
    );
  }
}

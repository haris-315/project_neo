// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project_neo/data/models/chat_models.dart';
import 'package:project_neo/data/models/chat_session.dart';
import 'package:project_neo/data/models/role_based_model.dart';
import 'package:project_neo/presentation/screens/chat_screen.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await DotEnv().load();
  // final supabase = await Supabase.initialize(
  //   url: dotenv.env['SUPABASE_URL']!,
  //   anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  // );
  Hive.registerAdapter(ChatSessionAdapter());
  Hive.registerAdapter(RoleBasedModelAdapter());
  Hive.registerAdapter(UserChatAdapter());
  Hive.registerAdapter(GeminiResponseAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatbot',
      home: ChatScreen(),
    );
  }
}

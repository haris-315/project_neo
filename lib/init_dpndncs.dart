import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project_neo/core/services/session_manager.dart';
import 'package:project_neo/data/repositories/auth_repo_impl.dart';
import 'package:project_neo/data/repositories/chat_repo_impl.dart';
import 'package:project_neo/data/sources/remote/auth_data_source.dart';
import 'package:project_neo/data/sources/remote/chat_source.dart';
import 'package:project_neo/domain/repositories/auth_repo.dart';
import 'package:project_neo/domain/usecases/auth/get_user.dart';
import 'package:project_neo/domain/usecases/auth/user_signin.dart';
import 'package:project_neo/domain/usecases/auth/user_signup.dart';
import 'package:project_neo/domain/usecases/gemini/get_chat_response.dart';
import 'package:project_neo/presentation/blocs/chat/chat_bloc.dart';
import 'package:project_neo/presentation/blocs/supabase/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await dotenv.load();
  final supabase = await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  if (kDebugMode) {
    print(supabase.client.accessToken);
  }

  serviceLocator.registerLazySingleton(() => supabase.client);
  _initAuth();
}

void _initAuth() {
  serviceLocator
    // {Auth Dependencies}
    ..registerLazySingleton(() => SessionManager())
    ..registerFactory(
      () => AuthDataSource(
        client: serviceLocator(),
        sessionManager: serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepo>(() => AuthRepositoryImpl(serviceLocator()))
    ..registerFactory(() => UserSignUp(authRepo: serviceLocator()))
    ..registerFactory(() => UserSignIn(authRepo: serviceLocator()))
    ..registerFactory(() => GetUser(authRepo: serviceLocator()))
    ..registerLazySingleton(
      () => AuthBloc(
        getUserInfo: serviceLocator(),
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        sessionManager: serviceLocator(),
      ),
    )
    // {Chat Dependencies}
    ..registerFactory(() => GeminiDataSource(client: serviceLocator()))
    ..registerFactory(() => ChatRepoImpl(geminiDataSource: serviceLocator()))
    ..registerFactory(
      () => GetChatResponse(chatRepo: serviceLocator<ChatRepoImpl>()),
    )
    ..registerLazySingleton(() => ChatBloc(getChatResponse: serviceLocator()));
}

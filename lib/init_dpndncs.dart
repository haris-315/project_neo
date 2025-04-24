import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project_neo/core/services/session_manager.dart';
import 'package:project_neo/data/repositories/auth_repo_impl.dart';
import 'package:project_neo/data/repositories/chat_repo_impl.dart';
import 'package:project_neo/data/sources/remote/auth_data_source.dart';
import 'package:project_neo/data/sources/remote/chat_source.dart';
import 'package:project_neo/domain/repositories/auth_repo.dart';
import 'package:project_neo/domain/repositories/chat_repo.dart';
import 'package:project_neo/domain/usecases/auth/get_user.dart';
import 'package:project_neo/domain/usecases/auth/user_signin.dart';
import 'package:project_neo/domain/usecases/auth/user_signup.dart';
import 'package:project_neo/domain/usecases/chat/delete_session.dart';
import 'package:project_neo/domain/usecases/chat/get_chat_response.dart';
import 'package:project_neo/domain/usecases/chat/get_session.dart';
import 'package:project_neo/domain/usecases/chat/get_sessions_info.dart';
import 'package:project_neo/presentation/blocs/chat/chat_bloc.dart';
import 'package:project_neo/presentation/blocs/auth/auth_bloc.dart';
import 'package:project_neo/presentation/blocs/sessions/sessions_bloc.dart';
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
    ..registerFactory(() => ChatRemoteDataSource(client: serviceLocator()))
    ..registerFactory<ChatRepo>(
      () => ChatRepoImpl(chatRemoteDataSource: serviceLocator()),
    )
    ..registerFactory(() => GetChatResponse(chatRepo: serviceLocator()))
    ..registerLazySingleton(() => GetSessionsInfo(chatRepo: serviceLocator()))
    ..registerFactory(() => DeleteSession(chatRepo: serviceLocator()))
    ..registerLazySingleton(
      () => SessionsBloc(
        getSessionInfo: serviceLocator(),
        deleteSession: serviceLocator(),
      ),
    )
    ..registerFactory(() => GetSession(chatRepo: serviceLocator()))
    ..registerLazySingleton(
      () => ChatBloc(
        getChatResponse: serviceLocator(),
        getSession: serviceLocator(),
      ),
    );
}

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project_neo/data/models/chat_models.dart';
import 'package:project_neo/data/models/chat_session.dart';
import 'package:project_neo/data/models/role_based_model.dart';
import 'package:project_neo/data/repositories/auth_repo_impl.dart';
import 'package:project_neo/data/sources/remote/auth_data_source.dart';
import 'package:project_neo/domain/repositories/auth_repo.dart';
import 'package:project_neo/domain/usecases/auth/user_signin.dart';
import 'package:project_neo/domain/usecases/auth/user_signup.dart';
import 'package:project_neo/presentation/blocs/supabase/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  await dotenv.load();
  final supabase = await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  print(supabase.client.accessToken);
  Hive.registerAdapter(ChatSessionAdapter());
  Hive.registerAdapter(RoleBasedModelAdapter());
  Hive.registerAdapter(UserChatAdapter());
  Hive.registerAdapter(GeminiResponseAdapter());

  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator
    ..registerFactory(() => AuthDataSource(client: serviceLocator()))
    ..registerFactory<AuthRepo>(() => AuthRepositoryImpl(serviceLocator()))
    ..registerFactory(() => UserSignUp(authRepo: serviceLocator()))
    ..registerFactory(() => UserSignIn(authRepo: serviceLocator()))
    ..registerLazySingleton(
      () =>
          AuthBloc(userSignUp: serviceLocator(), userSignIn: serviceLocator()),
    );
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_neo/core/errors/failure.dart';
import 'package:project_neo/core/services/session_manager.dart';
import 'package:project_neo/core/utils/app_constants.dart';
import 'package:project_neo/core/utils/session_parser.dart';

import 'package:project_neo/data/models/chat_session.dart';
import 'package:project_neo/domain/entities/user.dart';
import 'package:project_neo/domain/usecases/auth/user_signin.dart';
import 'package:project_neo/domain/usecases/auth/user_signup.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

part 'auth_events.dart';
part 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final SessionManager _sessionManager;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required SessionManager sessionManager,
  }) : _userSignUp = userSignUp,
       _userSignIn = userSignIn,
       _sessionManager = sessionManager,
       super(AuthInitial()) {
    on<SignUp>(onSignUp);

    on<SignIn>(onSignIn);
  }

  FutureOr<void> onSignUp(SignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userSignUp(
      SignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    return response.fold(
      (fail) => emit(AuthError(message: fail.message)),
      (success) => emit(AuthSuccess(user: success)),
    );
  }

  FutureOr<void> onSignIn(SignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userSignIn(
      SignInParams(email: event.email, password: event.password),
    );
    return response.fold(
      (fail) => emit(AuthError(message: fail.message)),
      (success) => () async {
        final currentSession = sb.Supabase.instance.client.auth.currentSession;
        
          final smResponse = await _sessionManager.storeSession(
          AppConstants.sessionKey,
          SessionParser.sToString(currentSession!),
        );
        

        emit(
          AuthSuccess(
            user: success,
            handledException: smResponse,
          ),
        );
      },
    );
  }
}

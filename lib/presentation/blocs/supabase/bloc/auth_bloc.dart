// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project_neo/data/models/chat_session.dart';
import 'package:project_neo/domain/entities/user.dart';
import 'package:project_neo/domain/usecases/auth/user_signin.dart';
import 'package:project_neo/domain/usecases/auth/user_signup.dart';

part 'auth_events.dart';
part 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;

  AuthBloc({required UserSignUp userSignUp, required UserSignIn userSignIn})
    : _userSignUp = userSignUp,
      _userSignIn = userSignIn,
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
      (success) => emit(AuthSuccess(user: success)),
    );
  }
}

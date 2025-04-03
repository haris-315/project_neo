// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:project_neo/features/data/models/chat_session.dart';
import 'package:project_neo/features/domain/usecases/auth/user_signup.dart';

part 'auth_events.dart';
part 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({required UserSignUp userSignUp})
    : _userSignUp = userSignUp,
      super(AuthInitial()) {
    on<SignUp>((event, emit) async {
      final response = await _userSignUp(
        SignUpParams(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );

      return response.fold(
        (fail) => AuthError(message: fail.message),
        (success) => AuthSuccess(uid: success),
      );
    });
  }
}

part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class SignUp extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const SignUp({required this.name, required this.email, required this.password});
}

part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});
}

final class AuthSuccess extends AuthState {
  final List<ChatSession>? sessions;
  final User user;
  final Failure? handledException;

  const AuthSuccess({this.sessions, required this.user,this.handledException});
}

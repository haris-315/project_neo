part of 'sessions_bloc.dart';

sealed class SessionsState extends Equatable {
  const SessionsState();

  @override
  List<Object> get props => [];
}

final class SessionsInitial extends SessionsState {}

final class SessionsLoading extends SessionsState {}

final class SessionsError extends SessionsState {
  final String error;

  const SessionsError({required this.error});
}

final class SessionsSuccess extends SessionsState {
  final List<SessionPlaceholder> sessionsInfo;

  const SessionsSuccess({required this.sessionsInfo});
}

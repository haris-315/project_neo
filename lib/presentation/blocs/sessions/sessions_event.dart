part of 'sessions_bloc.dart';

sealed class SessionsEvent extends Equatable {
  const SessionsEvent();

  @override
  List<Object> get props => [];
}

class GetSessionsInfoEvent extends SessionsEvent {
  final String userId;

  const GetSessionsInfoEvent({required this.userId});
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sessions_bloc.dart';

sealed class SessionsEvent extends Equatable {
  const SessionsEvent();

  @override
  List<Object> get props => [];
}

class GetSessionsInfoEvent extends SessionsEvent {
  final String userId;
  final bool fetchExternal;

  const GetSessionsInfoEvent({
    required this.userId,
    this.fetchExternal = false,
  });
}

class DeleteSessionEvent extends SessionsEvent {
  final String identifier;
  final String userId;

  const DeleteSessionEvent({required this.identifier, required this.userId});
}

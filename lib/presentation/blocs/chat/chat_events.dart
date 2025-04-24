part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendMessage extends ChatEvent {
  final String prompt;
  final ChatSession session;
  final String user;

  SendMessage({
    required this.prompt,
    required this.session,
    required this.user,
  });
}

class GetSessionEvent extends ChatEvent {
  final String identifier;

  GetSessionEvent({
    required this.identifier
  });
}

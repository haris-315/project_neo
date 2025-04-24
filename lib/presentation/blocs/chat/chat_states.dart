part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {
  final bool loadingSession;

  ChatLoading({this.loadingSession = false});
}

class ChatSuccess extends ChatState {
  final ChatSession currentSession;
  ChatSuccess(this.currentSession);
}

class ChatFailure extends ChatState {
  final String error;
  ChatFailure(this.error);
}

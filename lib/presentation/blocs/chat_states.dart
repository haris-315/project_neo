part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final String userMessage;
  final String botResponse;
  ChatSuccess(this.userMessage, this.botResponse);
}

class ChatFailure extends ChatState {
  final String error;
  ChatFailure(this.error);
}

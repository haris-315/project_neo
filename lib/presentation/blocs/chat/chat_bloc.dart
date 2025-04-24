import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_neo/domain/entities/chat/chat_session.dart';
import 'package:project_neo/domain/usecases/chat/get_chat_response.dart';
import 'package:project_neo/domain/usecases/chat/get_session.dart';

part 'chat_events.dart';
part 'chat_states.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatResponse _getChatResponse;
  final GetSession _getSession;
  ChatBloc({
    required GetSession getSession,
    required GetChatResponse getChatResponse,
  }) : _getChatResponse = getChatResponse,
       _getSession = getSession,
       super(ChatInitial()) {
    on<SendMessage>(onSendMessage);
    on<GetSessionEvent>(onGetSession);
  }

  FutureOr<void> onSendMessage(event, emit) async {
    emit(ChatLoading());
    try {
      final response = await _getChatResponse(
        ChatParams(
          prompt: event.prompt,
          session: event.session,
          user: event.user,
        ),
      );
      response.fold(
        (fail) => emit(ChatFailure(fail.message)),
        (success) => emit(ChatSuccess(success)),
      );
    } catch (e) {
      emit(ChatFailure("Failed to get response"));
    }
  }

  onGetSession(GetSessionEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading(loadingSession: true));
    final res = await _getSession(event.identifier);
    res.fold(
      (fail) => emit(ChatFailure(fail.message)),
      (success) => emit(ChatSuccess(success)),
    );
  }
}

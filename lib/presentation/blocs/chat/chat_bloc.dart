import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_neo/domain/entities/chat/chat_session.dart';
import 'package:project_neo/domain/usecases/chat/get_chat_response.dart';

part 'chat_events.dart';
part 'chat_states.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatResponse _getChatResponse;
  ChatBloc({required GetChatResponse getChatResponse})
    : _getChatResponse = getChatResponse,
      super(ChatInitial()) {
    on<SendMessage>((event, emit) async {
      emit(ChatLoading());
      try {
        final response = await _getChatResponse(
          ChatParams(prompt: event.prompt, session: event.session,user: event.user),
        );
        response.fold(
          (fail) => emit(ChatFailure(fail.message)),
          (success) => emit(ChatSuccess(success)),
        );
      } catch (e) {
        emit(ChatFailure("Failed to get response"));
      }
    });
  }
}

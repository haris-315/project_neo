import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/sources/remote/gemini_service.dart';

part 'chat_events.dart';
part 'chat_states.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<SendMessage>((event, emit) async {
      emit(ChatLoading());
      try {
        final response = await GeminiService.getResponse(event.message);
        emit(ChatSuccess(event.message, response));
      } catch (e) {
        emit(ChatFailure("Failed to get response"));
      }
    });
  }
}

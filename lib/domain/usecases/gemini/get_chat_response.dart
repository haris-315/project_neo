import 'package:project_neo/core/usecase/usecase_interface.dart';
import 'package:project_neo/domain/entities/chat_session.dart';
import 'package:project_neo/domain/repositories/chat_repo.dart';

class GetChatResponse implements UsecaseInterface<ChatSession, ChatParams> {
  final ChatRepo chatRepo;

  GetChatResponse({required this.chatRepo});
  @override
  call(params) async {
    final res = await chatRepo.getResponse(
      prompt: params.prompt,
      session: params.session,
      user: params.user
    );
    return res;
  }
}

class ChatParams {
  final String prompt;
  final ChatSession session;
  final String user;

  ChatParams({required this.prompt, required this.session, required this.user});
}

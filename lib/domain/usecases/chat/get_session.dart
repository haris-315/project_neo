import 'package:fpdart/fpdart.dart';
import 'package:project_neo/core/errors/failure.dart';
import 'package:project_neo/core/usecase/usecase_interface.dart';
import 'package:project_neo/data/models/chat_session_model.dart';
import 'package:project_neo/domain/repositories/chat_repo.dart';

class GetSession
    implements UsecaseInterface<ChatSessionModel, String> {
  final ChatRepo chatRepo;

  GetSession({required this.chatRepo});
  @override
  Future<Either<Failure, ChatSessionModel>> call(String params) async {
    final res = await chatRepo.getSession(identifier: params);
    return res;
  }
}


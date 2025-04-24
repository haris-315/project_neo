import 'package:fpdart/fpdart.dart';
import 'package:project_neo/core/errors/failure.dart';
import 'package:project_neo/core/usecase/usecase_interface.dart';
import 'package:project_neo/domain/entities/chat/session_placeholder.dart';
import 'package:project_neo/domain/repositories/chat_repo.dart';

class DeleteSession
    implements UsecaseInterface<List<SessionPlaceholder>, SessionDeletionParams> {
  final ChatRepo chatRepo;

  DeleteSession({required this.chatRepo});
  @override
  Future<Either<Failure, List<SessionPlaceholder>>> call(SessionDeletionParams params) async {
    final res = await chatRepo.deleteSession(identifier: params.identifier, userId: params.userId);
    return res;
  }
}

final class SessionDeletionParams {
  final String identifier;
  final String userId;

  SessionDeletionParams({required this.identifier, required this.userId});
}

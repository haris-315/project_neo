import 'package:fpdart/fpdart.dart';
import 'package:project_neo/core/errors/failure.dart';
import 'package:project_neo/core/usecase/usecase_interface.dart';
import 'package:project_neo/domain/entities/chat/session_placeholder.dart';
import 'package:project_neo/domain/repositories/chat_repo.dart';

class GetSessionsInfo implements UsecaseInterface<List<SessionPlaceholder>, String> {
  final ChatRepo chatRepo;

  GetSessionsInfo({required this.chatRepo});
  @override
  Future<Either<Failure, List<SessionPlaceholder>>> call(String params) async {
    final res = await chatRepo.getSessionsInfo(userId: params);
    return res;
  }
}

import 'package:fpdart/fpdart.dart';
import 'package:project_neo/core/custom_exceptions/server_exception.dart';
import 'package:project_neo/core/errors/failure.dart';
import 'package:project_neo/data/models/chat_session_model.dart';
import 'package:project_neo/data/models/session_placeholder_model.dart';
import 'package:project_neo/data/sources/remote/chat_source.dart';
import 'package:project_neo/domain/entities/chat/chat_session.dart';
import 'package:project_neo/domain/repositories/chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  final ChatRemoteDataSource chatRemoteDataSource;
  ChatRepoImpl({required this.chatRemoteDataSource});
  @override
  Future<Either<Failure, ChatSession>> getResponse({
    required String prompt,
    required ChatSession session,
    required String user,
  }) async {
    try {
      final response = await chatRemoteDataSource.getResponse(
        prompt,
        ChatSessionModel(
          id: session.id,
          identifier: session.identifier,
          title: session.title,
          createdAt: session.createdAt,
          conversation: session.conversation,
        ),
        user,
      );
      return right(response);
    } on ServerException catch (e) {
      throw left(Failure(message: e.exception));
    } catch (e) {
      throw left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SessionPlaceholderModel>>> getSessionsInfo({
    required String userId,
  }) async {
    try {
      final res = await chatRemoteDataSource.getSessionsInfo(userId: userId);
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(message: e.exception));
    }
  }
}

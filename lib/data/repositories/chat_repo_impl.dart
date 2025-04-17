import 'package:fpdart/src/either.dart';
import 'package:project_neo/core/custom_exceptions/server_exception.dart';
import 'package:project_neo/core/errors/failure.dart';
import 'package:project_neo/data/models/chat_session_model.dart';
import 'package:project_neo/data/sources/remote/chat_source.dart';
import 'package:project_neo/domain/entities/chat_session.dart';
import 'package:project_neo/domain/repositories/chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  final GeminiDataSource geminiDataSource;
  ChatRepoImpl({required this.geminiDataSource});
  @override
  Future<Either<Failure, ChatSession>> getResponse({
    required String prompt,
    required ChatSession session,
    required String user,
  }) async {
    try {
      final response = await geminiDataSource.getResponse(
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
}

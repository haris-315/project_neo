import 'package:fpdart/fpdart.dart';
import 'package:project_neo/core/errors/failure.dart';
import 'package:project_neo/data/models/chat_session_model.dart';
import 'package:project_neo/domain/entities/chat/chat_session.dart';
import 'package:project_neo/domain/entities/chat/session_placeholder.dart';

abstract interface class ChatRepo {
  Future<Either<Failure, ChatSession>> getResponse({
    required String prompt,
    required ChatSession session,
    required String user,
  });
  // Future<void> signOut();

  Future<Either<Failure, List<SessionPlaceholder>>> getSessionsInfo({required String userId});
    Future<Either<Failure, ChatSessionModel>> getSession({required String identifier});

  Future<Either<Failure, List<SessionPlaceholder>>> deleteSession({required String identifier,required String userId});

}

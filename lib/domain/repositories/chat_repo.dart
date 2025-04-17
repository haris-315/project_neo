import 'package:fpdart/fpdart.dart';
import 'package:project_neo/core/errors/failure.dart';
import 'package:project_neo/domain/entities/chat_session.dart';

abstract interface class ChatRepo {
  Future<Either<Failure, ChatSession>> getResponse({
    required String prompt,
    required ChatSession session,
    required String user,
  });
  // Future<void> signOut();
}

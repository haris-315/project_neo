import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_neo/domain/entities/chat/session_placeholder.dart';
import 'package:project_neo/domain/usecases/chat/delete_session.dart';
import 'package:project_neo/domain/usecases/chat/get_sessions_info.dart';

part 'sessions_event.dart';
part 'sessions_state.dart';

class SessionsBloc extends Bloc<SessionsEvent, SessionsState> {
  final GetSessionsInfo _getSessionsInfo;
  final DeleteSession _deleteSession;
  List<SessionPlaceholder> sessionsInfo = [];
  SessionsBloc({
    required GetSessionsInfo getSessionInfo,
    required DeleteSession deleteSession,
  }) : _getSessionsInfo = getSessionInfo,
       _deleteSession = deleteSession,
       super(SessionsInitial()) {
    on<GetSessionsInfoEvent>(onGetSessionsInfo);
    on<DeleteSessionEvent>(onDeleteSession);
  }

  onGetSessionsInfo(
    GetSessionsInfoEvent event,
    Emitter<SessionsState> emit,
  ) async {
    emit(SessionsLoading());
    if (sessionsInfo.isNotEmpty) {
      emit(SessionsSuccess(sessionsInfo: sessionsInfo));
    } else {
      final res = await _getSessionsInfo(event.userId);
      res.fold((fail) => emit(SessionsError(error: fail.message)), (success) {
        sessionsInfo = success;
        emit(SessionsSuccess(sessionsInfo: success));
      });
    }
  }

  onDeleteSession(DeleteSessionEvent event, Emitter<SessionsState> emit) async {
    emit(SessionsLoading());
    final res = await _deleteSession(
      SessionDeletionParams(identifier: event.identifier, userId: event.userId),
    );
    res.fold((fail) => emit(SessionsError(error: fail.message)), (success) {
      sessionsInfo = success;
      emit(SessionsSuccess(sessionsInfo: success));
    });
  }
}

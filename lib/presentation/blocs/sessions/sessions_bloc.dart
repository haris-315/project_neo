import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_neo/domain/entities/chat/session_placeholder.dart';
import 'package:project_neo/domain/usecases/chat/get_sessions_info.dart';

part 'sessions_event.dart';
part 'sessions_state.dart';

class SessionsBloc extends Bloc<SessionsEvent, SessionsState> {
  final GetSessionsInfo _getSessionsInfo;
  SessionsBloc({required GetSessionsInfo getSessionInfo})
    : _getSessionsInfo = getSessionInfo,
      super(SessionsInitial()) {
    on<GetSessionsInfoEvent>(onGetSessionsInfo);
  }

  onGetSessionsInfo(
    GetSessionsInfoEvent event,
    Emitter<SessionsState> emit,
  ) async {
    final res = await _getSessionsInfo(event.userId);
    res.fold(
      (fail) => emit(SessionsError(error: fail.message)),
      (success) => emit(SessionsSuccess(sessionsInfo: success)),
    );
  }
}

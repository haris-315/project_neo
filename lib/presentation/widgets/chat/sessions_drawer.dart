import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_neo/core/services/get_user.dart';
import 'package:project_neo/core/theme/theme_palette.dart';
import 'package:project_neo/domain/entities/chat/session_placeholder.dart';
import 'package:project_neo/presentation/blocs/chat/chat_bloc.dart';
import 'package:project_neo/presentation/blocs/sessions/sessions_bloc.dart';

class SessionsDrawer extends StatefulWidget {
  const SessionsDrawer({super.key});

  @override
  State<SessionsDrawer> createState() => _SessionsDrawerState();
}

class _SessionsDrawerState extends State<SessionsDrawer> {
  List<SessionPlaceholder> currentSessionInfo = [];
  @override
  void initState() {
    super.initState();
    context.read<SessionsBloc>().add(
      GetSessionsInfoEvent(userId: getUser(context).id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionsBloc, SessionsState>(
      listener: (context, state) {
        if (state is SessionsSuccess) {
          currentSessionInfo = state.sessionsInfo;
        }
      },
      builder: (context, state) {
        if (state is SessionsError) {
          return Center(child: Text(state.error));
        }
        return Drawer(
          backgroundColor: AppTheme.eventHorizon,
          elevation: 12,
          shadowColor: AppTheme.nebulaBlue.withValues(alpha: .4),

          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is SessionsLoading)
                    LinearProgressIndicator(
                      color: AppTheme.nebulaBlue,
                      minHeight: 4,
                    ),
                  SizedBox(height: 80),
                  ...currentSessionInfo.map((info) {
                    final timeFormater = DateFormat('dd/MM/yy HH:mm:ss');

                    return Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: 50,
                          minHeight: 30,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            context.read<ChatBloc>().add(
                              GetSessionEvent(identifier: info.identifier),
                            );
                          },
                          child: Container(
                            decoration: AppTheme.glassmorphism,
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      info.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: AppTheme.stardust,
                                        fontSize: 15,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      timeFormater.format(info.createdAt),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white.withValues(
                                          alpha: .7,
                                        ),
                                        fontSize: 11,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    context.read<SessionsBloc>().add(
                                      DeleteSessionEvent(
                                        identifier: info.identifier,
                                        userId: getUser(context).id,
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.delete_outline),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

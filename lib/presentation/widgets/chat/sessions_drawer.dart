import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_neo/core/services/get_user.dart';
import 'package:project_neo/core/theme/theme_palette.dart';
import 'package:project_neo/presentation/blocs/sessions/sessions_bloc.dart';

class SessionsDrawer extends StatefulWidget {
  const SessionsDrawer({super.key});

  @override
  State<SessionsDrawer> createState() => _SessionsDrawerState();
}

class _SessionsDrawerState extends State<SessionsDrawer> {
  @override
  void initState() {
    super.initState();
    context.read<SessionsBloc>().add(
      GetSessionsInfoEvent(userId: getUser(context).id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionsBloc, SessionsState>(
      builder: (context, state) {
        if (state is SessionsError) {
          return Center(child: Text(state.error));
        }
        if (state is SessionsSuccess) {
          return Drawer(
            backgroundColor: AppTheme.eventHorizon,
            elevation: 12,
            shadowColor: AppTheme.nebulaBlue.withValues(alpha: .4),
            child: ListView.builder(
              itemCount: state.sessionsInfo.length,
              itemBuilder: (context, index) {
                final sessionInfo = state.sessionsInfo[index];
                final timeFormater = DateFormat('dd/MM/yy HH:mm:ss');

                return ListTile(
                  title: Text(
                    sessionInfo.title,
                    style: TextStyle(
                      color: AppTheme.nebulaBlue,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(timeFormater.format(sessionInfo.createdAt)),
                );
              },
            ),
          );
        }
        return Placeholder();
      },
    );
  }
}

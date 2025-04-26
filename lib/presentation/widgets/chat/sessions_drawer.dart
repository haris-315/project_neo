// sessions_drawer.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_neo/core/services/get_user.dart';
import 'package:project_neo/core/theme/theme_palette.dart';
import 'package:project_neo/domain/entities/chat/session_placeholder.dart';
import 'package:project_neo/presentation/blocs/chat/chat_bloc.dart';
import 'package:project_neo/presentation/blocs/sessions/sessions_bloc.dart';
import 'package:project_neo/presentation/widgets/loaders/sessions_loader.dart';
import 'package:project_neo/presentation/widgets/sessions/sessions_search_field.dart';

class SessionsDrawer extends StatefulWidget {
  final VoidCallback onNewSession;
  const SessionsDrawer({super.key, required this.onNewSession});

  @override
  State<SessionsDrawer> createState() => _SessionsDrawerState();
}

class _SessionsDrawerState extends State<SessionsDrawer> {
  List<SessionPlaceholder> currentSessionInfo = [];
  final TextEditingController controller = TextEditingController();
  String selectedId = "";

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
        return SafeArea(
          child: Drawer(
            // backgroundColor: AppTheme.deepSpace,
            elevation: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                // gradient: LinearGradient(
                //   begin: Alignment.topRight,
                //   end: Alignment.bottomLeft,
                //   colors: [
                //     AppTheme.nebulaBlue.withValues(alpha: .1),
                //     AppTheme.eventHorizon.withValues(alpha: .8),
                //   ],
                // ),
              ),
              child:
                  state is SessionsLoading && state.initialLoading
                      ? const Center(child: SessionsLoader())
                      : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SessionSearchField(controller: controller),
                            const SizedBox(height: 10),
                            _NewSessionRow(onNewSession: widget.onNewSession),
                            if (state is SessionsLoading)
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                child: SessionsLoader(),
                              ),
                            const SizedBox(height: 80),
                            ...currentSessionInfo.map(
                              (session) => _SessionTile(
                                info: session,
                                selectedId: selectedId,
                                onSelect: (String id) {
                                  setState(() {
                                    selectedId = id;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
            ),
          ),
        );
      },
    );
  }
}

class _NewSessionRow extends StatefulWidget {
  final VoidCallback onNewSession;
  const _NewSessionRow({required this.onNewSession});

  @override
  State<_NewSessionRow> createState() => _NewSessionRowState();
}

class _NewSessionRowState extends State<_NewSessionRow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _refreshAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 599),
    );
    _refreshAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<SessionsBloc>().state is SessionsLoading;
    if (isLoading) {
      _controller
        ..forward()
        ..repeat();
    } else {
      _controller.stop();
    }
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: AppTheme.customAnimatedButton(
              text: "New Session +",
              isPrimary: false,
              onPressed: widget.onNewSession,
            ),
          ),

          const SizedBox(width: 8),

          RotationTransition(
            turns: _refreshAnimation,
            child: IconButton(
              onPressed: () {
                context.read<SessionsBloc>().add(
                  GetSessionsInfoEvent(
                    userId: getUser(context).id,
                    fetchExternal: true,
                  ),
                );
              },
              icon: const Icon(Icons.refresh),
            ),
          ),
        ],
      ),
    );
  }
}

class _SessionTile extends StatelessWidget {
  final SessionPlaceholder info;
  final String selectedId;
  final Function(String id) onSelect;
  const _SessionTile({
    required this.info,
    required this.selectedId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final timeFormatter = DateFormat('dd/MM/yy HH:mm:ss');
    final isLoading = context.watch<SessionsBloc>().state is SessionsLoading;
    final bool beingDeleted = info.identifier == selectedId;
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 12, right: 8),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pop(context);
            context.read<ChatBloc>().add(
              GetSessionEvent(identifier: info.identifier),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    beingDeleted ? AppTheme.cosmicPurple : AppTheme.nebulaBlue,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.only(
              left: 12,
              right: 6,
              top: 2,
              bottom: 2,
            ),
            constraints: const BoxConstraints(maxHeight: 44, minHeight: 30),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        info.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.stardust,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        timeFormatter.format(info.createdAt),
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed:
                      isLoading
                          ? null
                          : () {
                            onSelect(info.identifier);
                            context.read<SessionsBloc>().add(
                              DeleteSessionEvent(
                                identifier: info.identifier,
                                userId: getUser(context).id,
                              ),
                            );
                          },
                  icon: Icon(
                    beingDeleted
                        ? Icons.delete_forever_outlined
                        : Icons.delete_outline,
                    color:
                        beingDeleted
                            ? AppTheme.cosmicPurple
                            : Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

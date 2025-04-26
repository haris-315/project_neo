import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_neo/core/theme/theme_palette.dart';
import 'package:project_neo/domain/entities/chat/chat_session.dart';
import 'package:project_neo/presentation/widgets/chat/chat_bubble.dart';
import 'package:project_neo/presentation/widgets/chat/empty_chat.dart';
import 'package:project_neo/presentation/widgets/chat/md_rendrer.dart';
import 'package:project_neo/presentation/widgets/chat/prompt_input.dart';
import 'package:project_neo/presentation/widgets/chat/sessions_drawer.dart';

import '../../blocs/chat/chat_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  ChatSession session = ChatSession.empty();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatSuccess) {
          session = state.currentSession;
        }
        if (state is ChatFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: AppTheme.neonPurple,
                content: Text(state.error),
                duration: Duration(seconds: 7),
              ),
            );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            forceMaterialTransparency: false,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            title: const Text(
              "Neo",
              style: TextStyle(
                color: AppTheme.nebulaBlue,
                fontFamily: "wilker",
              ),
            ),
          ),
          drawer: SessionsDrawer(
            onNewSession: () {
              setState(() {
                session = ChatSession.empty();
              });
              Navigator.pop(context);
            },
          ),
          body: Stack(
            children: [
              state is ChatLoading && state.loadingSession
                  ? Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.cosmicPurple,
                    ),
                  )
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (session.conversation.isEmpty) ...[
                        Expanded(child: EmptyChat()),
                      ] else
                        Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            padding: const EdgeInsets.all(8),
                            itemCount: session.conversation.length,
                            itemBuilder: (context, index) {
                              final message = session.conversation[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ListTile(title: Text("You: ${message.prompt}")),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 23.0,
                                      ),
                                      child: MessageBubble(
                                        content: message.prompt,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    child: MarkdownViewer(
                                      markdownText: message.content,
                                    ),
                                  ),
                                  const Divider(),
                                ],
                              );
                            },
                          ),
                        ),

                      SizedBox(height: 90),
                    ],
                  ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Material(
                  child: PromptInput(
                    controller: _controller,
                    session: session,
                    scrollController: scrollController,
                    isLoading: state is ChatLoading && !state.loadingSession,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

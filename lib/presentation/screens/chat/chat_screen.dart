import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_neo/core/theme/theme_palette.dart';
import 'package:project_neo/domain/entities/chat/chat_session.dart';
import 'package:project_neo/presentation/widgets/chat/chat_bubble.dart';
import 'package:project_neo/presentation/widgets/chat/empty_chat.dart';
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
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "N e o",
              style: TextStyle(color: AppTheme.nebulaBlue, fontFamily: ""),
            ),
          ),
          drawer: SessionsDrawer(),
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
                                    child: MessageBubble(
                                      content: message.prompt,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    child: MessageBubble(
                                      content: message.content,
                                      isNeo: true,
                                    ),
                                  ),
                                  const Divider(),
                                ],
                              );
                            },
                          ),
                        ),
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

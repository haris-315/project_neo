import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_neo/core/services/get_user.dart';
import 'package:project_neo/domain/entities/chat_session.dart';
import 'package:project_neo/presentation/widgets/md_rendrer.dart';
import '../blocs/chat/chat_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  ChatSession session = ChatSession.empty();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Neo")),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ChatSuccess) {
                  final session = state.currentSession;
                  final conversation = session.conversation;
                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: conversation.length,
                    itemBuilder: (context, index) {
                      final message = conversation[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(title: Text("You: ${message.prompt}")),
                          const ListTile(title: Text("Neo")),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: MarkdownViewer(
                              markdownText:
                                  message.content, // Use the response here
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  );
                }
                return const Center(child: Text("Start a conversation!"));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    context.read<ChatBloc>().add(
                      SendMessage(prompt: _controller.text, session: session,user: getUser(context).name),
                    );
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

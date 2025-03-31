import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_neo/presentation/widgets/md_rendrer.dart';
import '../blocs/chat_bloc.dart';

class ChatScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Chatbot")),
        body: Builder(
          builder: (context) {
            return Column(
              children: [
                BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state is ChatLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is ChatSuccess) {
                      return Column(
                        children: [
                          ListTile(title: Text("You: ${state.userMessage}")),
                          IntrinsicHeight(
                            child: MarkdownViewer(
                              markdownText: state.botResponse,
                            ),
                          ),
                        ],
                      );
                    }
                    return const Center(child: Text("Start a conversation!"));
                  },
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
                            SendMessage(_controller.text),
                          );
                          _controller.clear();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

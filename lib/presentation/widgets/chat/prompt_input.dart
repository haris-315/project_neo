import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_neo/core/services/get_user.dart';
import 'package:project_neo/core/theme/theme_palette.dart';
import 'package:project_neo/domain/entities/chat_session.dart';
import 'package:project_neo/presentation/blocs/chat/chat_bloc.dart';

class PromptInput extends StatelessWidget {
  const PromptInput({
    super.key,
    required TextEditingController controller,
    required this.session,
  }) : _controller = controller;

  final TextEditingController _controller;
  final ChatSession session;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(gradient: AppTheme.subtleGlow),
        constraints: const BoxConstraints(maxWidth: 590, maxHeight: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              maxLines: null,
              minLines: 1,
              keyboardType: TextInputType.multiline,
              scrollPhysics: BouncingScrollPhysics(),
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: OutlineInputBorder(),
                fillColor: Colors.transparent,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.mic)),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    context.read<ChatBloc>().add(
                      SendMessage(
                        prompt: _controller.text,
                        session: session,
                        user: getUser(context).name,
                      ),
                    );
                    _controller.clear();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

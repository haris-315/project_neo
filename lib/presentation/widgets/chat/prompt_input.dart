// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_neo/core/services/get_user.dart';
import 'package:project_neo/core/theme/theme_palette.dart';
import 'package:project_neo/domain/entities/chat/chat_session.dart';
import 'package:project_neo/presentation/blocs/chat/chat_bloc.dart';

class PromptInput extends StatefulWidget {
  final TextEditingController controller;
  final ChatSession session;
  final ScrollController scrollController;
  final bool isLoading;

  const PromptInput({
    super.key,
    required this.controller,
    required this.session,
    required this.scrollController,
    required this.isLoading,
  });
  @override
  State<PromptInput> createState() => _PromptInputState();
}

class _PromptInputState extends State<PromptInput> {
  FocusNode focusNode = FocusNode();
  bool isExpaned = false;

  bool isEmpty = true;
  void _handleFocus() {
    if (focusNode.hasFocus) {
      setState(() {
        isExpaned = true;
        focusNode.removeListener(_handleFocus);
      });
    } else {
      setState(() {
        isExpaned = false;
      });
    }
  }

  void _handleText() {
    if (widget.controller.text == "" || widget.controller.text.isEmpty) {
      setState(() {
        isEmpty = true;
      });
    } else {
      if (isEmpty != true) {
        return;
      }
      setState(() {
        isEmpty = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    focusNode.addListener(_handleFocus);
    widget.controller.addListener(_handleText);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.glassmorphism,
      constraints: const BoxConstraints(maxWidth: 590, maxHeight: 400),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Input(focusNode: focusNode, widget: widget, isEmpty: isEmpty),
          SizedBox(height: 4, width: 1),

          AnimatedSwitcher(
            duration: Duration(milliseconds: 340),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            transitionBuilder:
                (child, anim) => SizeTransition(sizeFactor: anim, child: child),
            child:
                !isExpaned
                    ? null
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.mic_none_outlined),
                        ),
                        widget.isLoading
                            ? CircularProgressIndicator.adaptive()
                            : SendButton(
                              scrollController: widget.scrollController,
                              isFieldEmpty: isEmpty,
                              widget: widget,
                              focusNode: focusNode,
                            ),
                      ],
                    ),
          ),
        ],
      ),
    );
  }
}

class SendButton extends StatelessWidget {
  const SendButton({
    super.key,
    required this.widget,
    required this.focusNode,
    required this.isFieldEmpty,
    required this.scrollController,
  });

  final PromptInput widget;
  final bool isFieldEmpty;
  final FocusNode focusNode;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.send),
      onPressed:
          isFieldEmpty
              ? null
              : () {
                handleSend(context, focusNode, widget, scrollController);
              },
    );
  }
}

class Input extends StatelessWidget {
  const Input({
    super.key,
    required this.focusNode,
    required this.widget,
    required this.isEmpty,
  });

  final FocusNode focusNode;
  final PromptInput widget;
  final bool isEmpty;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: widget.controller,
      maxLines: null,
      minLines: 1,
      keyboardType: TextInputType.multiline,
      scrollPhysics: BouncingScrollPhysics(),
      cursorColor: AppTheme.nebulaBlue,
      decoration: InputDecoration(
        hintText: "Type a message...",
        border: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        fillColor: Colors.transparent,
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }
}

void handleSend(
  BuildContext context,
  FocusNode focusNode,
  dynamic widget,
  ScrollController scrollController,
) {
  context.read<ChatBloc>().add(
    SendMessage(
      prompt: widget.controller.text,
      session: widget.session,
      user: getUser(context).name,
    ),
  );

  if (scrollController.hasClients) {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
  focusNode.unfocus(disposition: UnfocusDisposition.scope);
}

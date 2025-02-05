// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class AskOurAi extends StatefulWidget {
  const AskOurAi({super.key});
  @override
  State<AskOurAi> createState() => _AskOurAiState();
}

class _AskOurAiState extends State<AskOurAi> {
  late final GenerativeModel _model;
  late final ChatSession _chat;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFieldFocus = FocusNode(debugLabel: 'TextField');
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-8b',
      apiKey: 'AIzaSyCcUGyhB6jq9jGI9n0hHtUuBfjBeu7e5_U',
    );
    _chat = _model.startChat(history: []);
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeOutCirc,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        title: Row(
          children: [
            const Text("Ask AI by "),
            Shimmer.fromColors(
              baseColor: Colors.blue,
              highlightColor: Colors.red,
              period: const Duration(seconds: 5),
              child: const Text('Gemini'),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _chat.history.length,
              itemBuilder: (context, idx) {
                var content = _chat.history.toList()[idx];
                var text = content.parts
                    .whereType<TextPart>()
                    .map((e) => e.text)
                    .join('');
                return MessageWidget(
                  text: text,
                  isFromUser: content.role == 'user',
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: _textFieldFocus,
                    decoration: textFieldDecoration(context, 'Ask anything...'),
                    controller: _textController,
                    onSubmitted: _sendChatMessage,
                    maxLines: null,
                  ),
                ),
                const SizedBox(width: 8),
                _loading
                    ? LoadingAnimationWidget.flickr(
                        leftDotColor: Colors.blue,
                        rightDotColor: Colors.red,
                        size: 30,
                      )
                    : IconButton(
                        icon: const Icon(Icons.send),
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () => _sendChatMessage(_textController.text),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendChatMessage(String message) async {
    setState(() => _loading = true);
    try {
      await _chat.sendMessage(Content.text(message));
      setState(() => _loading = false);
      _scrollDown();
    } catch (e) {
      _showError(e.toString());
      setState(() => _loading = false);
    } finally {
      _textController.clear();
      _textFieldFocus.requestFocus();
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Oops!'),
          content: const Text('Something went wrong. Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }
}

class MessageWidget extends StatelessWidget {
  final String text;
  final bool isFromUser;

  const MessageWidget(
      {super.key, required this.text, required this.isFromUser});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isFromUser)
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/postalhub_logo.jpg'),
            radius: 15,
          ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 0,
              left: 0,
              right: 0,
              bottom: 15,
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isFromUser
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(15),
              ),
              child: MarkdownBody(
                selectable: true,
                data: text,
                onTapLink: (text, href, title) {
                  if (href != null) launchUrl(Uri.parse(href));
                },
              ),
            ),
          ),
        ),
        if (isFromUser)
          const CircleAvatar(
            backgroundImage: AssetImage('assets/user_icon.png'),
            radius: 15,
          ),
      ],
    );
  }
}

InputDecoration textFieldDecoration(BuildContext context, String hintText) =>
    InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );

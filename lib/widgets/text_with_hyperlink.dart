import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextWithHyperLink extends StatelessWidget {
  final String message;
  final String hyperlink;
  final VoidCallback? onHyperlinkTapped;

  const TextWithHyperLink({
    Key? key,
    required this.message,
    required this.hyperlink,
    this.onHyperlinkTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> messageParts = message.split(hyperlink);
    String beforeHyperLink = messageParts[0];
    String afterHyperLink = "";
    afterHyperLink = messageParts[1];

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: beforeHyperLink),
          TextSpan(
            style: const TextStyle(
                color: Colors.blue, decoration: TextDecoration.underline),
            text: hyperlink,
            recognizer: TapGestureRecognizer()..onTap = onHyperlinkTapped,
          ),
          TextSpan(text: afterHyperLink),
        ],
      ),
    );
  }
}

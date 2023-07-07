import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TextfieldDialog {
  final TextEditingController _controller = TextEditingController();
  bool _canceled = true;
  final BuildContext context;
  final String title;
  final String textfieldHint;

  TextfieldDialog({
    required this.context,
    required this.title,
    this.textfieldHint = "",
  });

  String get value => _controller.text;

  bool get canceled => _canceled;

  Future<void> show() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          onChanged: (value) {},
          controller: _controller,
          decoration: InputDecoration(hintText: textfieldHint),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text("common.cancel").tr(),
            onPressed: () {
              _canceled = true;
              Navigator.pop(context);
            },
          ),
          TextButton(
              child: Text(
                "common.done",
                style: DefaultTextStyle.of(context)
                    .style
                    .copyWith(color: Theme.of(context).primaryColor),
              ).tr(),
              onPressed: () {
                _canceled = false;
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}

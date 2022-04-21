import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class YesNoDialog {
  final BuildContext context;
  final String title;
  final String info;
  final Function? onYesCallback;
  final Function? onNoCallback;

  YesNoDialog({
    required this.context,
    required this.title,
    required this.info,
    this.onYesCallback,
    this.onNoCallback,
  });

  Future<void> show() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        content: Text(info, textAlign: TextAlign.center),
        actions: <Widget>[
          TextButton(
            child: const Text("common.yes").tr(),
            onPressed: () {
              onNoCallback?.call();
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text("common.no").tr(),
            onPressed: () {
              onYesCallback?.call();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

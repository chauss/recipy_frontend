import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class InfoDialog {
  final BuildContext context;
  final String title;
  final String info;

  InfoDialog({
    required this.context,
    required this.title,
    required this.info,
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
            child: Text(
              "common.ok",
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            ).tr(),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

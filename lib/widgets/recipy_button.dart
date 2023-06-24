import 'package:flutter/material.dart';
import 'package:recipy_frontend/widgets/process_indicator.dart';

class RecipyButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isProcessing;

  const RecipyButton({
    required this.title,
    this.onPressed,
    this.isProcessing = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isProcessing ? null : onPressed,
      style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          fixedSize: const Size.fromHeight(40),
          shape: const LinearBorder()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
          isProcessing
              ? const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: ProcessIndicator(color: Colors.white, size: 20),
                )
              : Container()
        ],
      ),
    );
  }
}

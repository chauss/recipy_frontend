import 'package:flutter/material.dart';

class ProcessIndicator extends StatelessWidget {
  final Color? color;
  final double size;

  const ProcessIndicator({Key? key, this.color, this.size = 40})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: SizedBox(
          height: size,
          width: size,
          child: CircularProgressIndicator(
              color: color ?? Theme.of(context).colorScheme.secondary),
        ),
      );
}

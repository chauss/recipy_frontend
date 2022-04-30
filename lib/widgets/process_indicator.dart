import 'package:flutter/material.dart';

class ProcessIndicator extends StatelessWidget {
  const ProcessIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: SizedBox(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary),
        ),
      );
}

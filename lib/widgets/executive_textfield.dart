import 'package:flutter/material.dart';

typedef AddFunction<G> = Future Function(String name);
typedef AddFunctionCalback = Function(bool result);

class ExecutiveTextfield<T> extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final AddFunction<T> addFunction;
  final AddFunctionCalback? resultCallback;
  final String? hintText;
  final bool enabled;

  ExecutiveTextfield({
    Key? key,
    required this.addFunction,
    this.resultCallback,
    this.hintText,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 20.0, bottom: 10),
              child: TextField(
                controller: controller,
                onSubmitted: (_) => safeCallAddFunction(),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  hintText: hintText,
                ),
                enabled: enabled,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: safeCallAddFunction,
          ),
        ],
      ),
    );
  }

  void safeCallAddFunction() async {
    String controllerText = controller.text;
    if (controllerText.isEmpty) return;

    var result = await addFunction(controllerText);
    resultCallback?.call(result);
  }
}

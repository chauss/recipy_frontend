import 'package:flutter/material.dart';

typedef GetAssortmentFunction<G> = List<G> Function();
typedef GetDisplayNameFunction<G> = String Function(G element);
typedef OnSelectionFunction<G> = void Function(G? element);

class RecipyDropdownWidget<T> extends StatelessWidget {
  final GetAssortmentFunction<T> getAssortment;
  final GetDisplayNameFunction<T> getDisplayName;
  final OnSelectionFunction<T> onSelection;
  final String? hint;
  final T? preselection;

  const RecipyDropdownWidget({
    Key? key,
    required this.getAssortment,
    required this.getDisplayName,
    required this.onSelection,
    this.hint,
    this.preselection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: preselection,
      hint: Text(hint ?? ""),
      icon: const Icon(Icons.arrow_drop_down_rounded),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: onSelection,
      items: getAssortment().map<DropdownMenuItem<T>>(
        (T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(getDisplayName(value)),
          );
        },
      ).toList(),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

// TODO Rename to RecipyTextField
class CustomTextField extends StatefulWidget {
  final TextEditingController _controller;
  final FocusNode _focusNode;
  final String? _hintText;
  final TextInputType? _keyboardType;
  final TextInputAction? _textInputAction;
  final Function(String)? _onChanged;
  final Function(String)? _onSubmitted;
  final Function(String)? _onFocusLost;
  final List<TextInputFormatter>? _inputFormatters;
  final bool _isMultiline;
  final int _onChangedDebounceMs;

  CustomTextField({
    Key? key,
    TextEditingController? controller,
    FocusNode? focusNode,
    String? hintText,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
    Function(String)? onFocusLost,
    List<TextInputFormatter>? inputFormatters,
    bool isMultiline = false,
    int onChangedDebounceMs = 150,
  })  : _controller = controller ?? TextEditingController(),
        _focusNode = focusNode ?? FocusNode(),
        _hintText = hintText,
        _keyboardType = keyboardType,
        _textInputAction = textInputAction,
        _onChanged = onChanged,
        _onSubmitted = onSubmitted,
        _onFocusLost = onFocusLost,
        _inputFormatters = inputFormatters,
        _isMultiline = isMultiline,
        _onChangedDebounceMs = onChangedDebounceMs,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final double _clearButtonWidth = 52;
  StreamSubscription? _keyboardDisplayedStreamSubscription;
  late bool _keyboardIsVisible;
  Timer? _onChangedDebounce;

  @override
  void initState() {
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();
    _keyboardIsVisible = keyboardVisibilityController.isVisible;

    _keyboardDisplayedStreamSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() => _keyboardIsVisible = visible);
    });
  }

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    widget._controller.selection = oldWidget._controller.selection;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    bool shouldShowClear = (widget._controller.text.isNotEmpty) &&
        widget._focusNode.hasFocus &&
        _keyboardIsVisible;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(child: _buildTextField(shouldShowClear, context)),
            shouldShowClear ? _buildClearButton() : Container(),
          ],
        ),
        _buildUnderline(),
      ],
    );
  }

  Widget _buildTextField(bool shouldShowClear, BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: 2, right: shouldShowClear ? 0 : 8, bottom: 2),
      child: Focus(
        focusNode: widget._focusNode,
        onFocusChange: (gainedFocus) {
          if (gainedFocus) {
            widget._controller.selection = TextSelection.fromPosition(
                TextPosition(offset: widget._controller.text.length));
          } else {
            widget._onFocusLost?.call(widget._controller.text);
          }
        },
        child: TextField(
          minLines: widget._isMultiline ? 2 : 1,
          maxLines: widget._isMultiline ? null : 1,
          controller: widget._controller,
          textInputAction: widget._textInputAction,
          keyboardType: widget._keyboardType,
          obscureText: widget._keyboardType == TextInputType.visiblePassword,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration.collapsed(hintText: widget._hintText),
          onChanged: (text) {
            _onChangedDebounce?.cancel();
            _onChangedDebounce = Timer(
              Duration(milliseconds: widget._onChangedDebounceMs),
              () => widget._onChanged?.call(text),
            );

            setState(() {});
          },
          onSubmitted: widget._onSubmitted,
          inputFormatters: widget._inputFormatters,
        ),
      ),
    );
  }

  Widget _buildUnderline() {
    return Flexible(
      child: Container(
        height: 2,
        width: double.infinity,
        color: widget._focusNode.hasFocus
            ? Theme.of(context).colorScheme.secondaryContainer
            : Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.4),
      ),
    );
  }

  Widget _buildClearButton() {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: SizedBox(
        width: _clearButtonWidth,
        child: const Opacity(
          opacity: 0.5,
          child: Icon(
            Icons.close,
            size: 20,
          ),
        ),
      ),
      onTap: () {
        widget._controller.clear();
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _keyboardDisplayedStreamSubscription?.cancel();
    _onChangedDebounce?.cancel();
    super.dispose();
  }
}

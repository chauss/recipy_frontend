import 'dart:async';
import 'package:flutter/material.dart';

class BurgerIcon extends StatefulWidget {
  final BurgerIconController? controller;
  final double width;

  const BurgerIcon({Key? key, this.controller, this.width = 80})
      : super(key: key);

  @override
  BurgerIconState createState() => BurgerIconState();
}

class BurgerIconState extends State<BurgerIcon> {
  final String cuteEyesBurgerAsset = 'assets/icons/burger_cute_eyes.png';
  final String smilingBurgerAsset = 'assets/icons/burger_smiling.png';
  bool showSmilingBurger = false;
  Timer? iconReset;

  @override
  void initState() {
    widget.controller?.addListener(showBurgerSmiling);
    super.initState();
  }

  void showBurgerSmiling() {
    iconReset?.cancel();
    setState(() => showSmilingBurger = true);

    iconReset = Timer(
      const Duration(milliseconds: 1000),
      () => setState(() {
        showSmilingBurger = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: showSmilingBurger ? 0 : 1,
          child: Image.asset(
            cuteEyesBurgerAsset,
            width: widget.width,
          ),
        ),
        Opacity(
          opacity: showSmilingBurger ? 1 : 0,
          child: Image.asset(
            smilingBurgerAsset,
            width: widget.width,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget.controller?.removeListener(showBurgerSmiling);
    super.dispose();
  }
}

class BurgerIconController extends ChangeNotifier {
  void showSmile() => notifyListeners();
}

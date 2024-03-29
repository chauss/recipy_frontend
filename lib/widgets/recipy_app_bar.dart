import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipy_frontend/widgets/burger_icon.dart';

class RecipyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final BurgerIconController iconController = BurgerIconController();

  RecipyAppBar({
    Key? key,
    required this.title,
    this.actions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: _getLeadingWidget(context),
      ),
      title: Text(title),
      actions: actions,
      elevation: 0,
    );
  }

  Widget _getLeadingWidget(BuildContext context) {
    if (ModalRoute.of(context)?.canPop ?? false) {
      if (kIsWeb) {
        return Container();
      }
      return const BackButton();
    } else {
      return BurgerIcon(controller: iconController);
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

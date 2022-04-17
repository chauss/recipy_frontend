import 'package:flutter/material.dart';

class RecipyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const RecipyAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: InkWell(
          child: Image.asset('assets/icons/burger-smile.png'),
          onTap: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

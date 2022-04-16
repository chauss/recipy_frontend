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
      leading: InkWell(
        child: const Image(
          image: AssetImage('assets/burger-icon.png'),
          width: 40,
        ),
        onTap: () => Scaffold.of(context).openDrawer(),
      ),
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

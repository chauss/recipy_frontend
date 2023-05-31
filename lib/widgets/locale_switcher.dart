import 'package:flutter/material.dart';
import 'package:recipy_frontend/config/locale_config.dart';
import 'package:easy_localization/easy_localization.dart';

class LocaleSwitcher extends StatelessWidget {
  const LocaleSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: supportedLocales
          .map(
            (locale) => TextButton(
              onPressed: context.locale == locale
                  ? null
                  : () => context.setLocale(locale),
              child: Text(
                locale.toString(),
                style: TextStyle(
                  color: context.locale == locale
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorLight,
                  fontSize: context.locale == locale ? 20 : 16,
                  fontWeight: context.locale == locale
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

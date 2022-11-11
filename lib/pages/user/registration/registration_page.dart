import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/widgets/custom_text_field.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/widgets/recipy_app_bar.dart';
import 'package:recipy_frontend/config/routes_config.dart';
import 'package:recipy_frontend/widgets/text_with_hyperlink.dart';
import 'registration_model.dart';
import 'package:easy_localization/easy_localization.dart';

class RegistrationPage extends ConsumerWidget {
  RegistrationPage({Key? key}) : super(key: key);

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RegistrationController controller =
        ref.read(registrationControllerProvider.notifier);

    RegistrationModel model = ref.watch(registrationControllerProvider);

    return Scaffold(
      appBar: RecipyAppBar(title: "user.registration.title".tr()),
      body: Container(
        margin: const EdgeInsets.only(left: 24, right: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: usernameController,
              focusNode: usernameFocusNode,
              hintText: "user.registration.username.textfield.hint".tr(),
              onSubmitted: (text) => onUsernameSubmitted(text, controller),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: passwordController,
              focusNode: passwordFocusNode,
              hintText: "user.registration.password.textfield.hint".tr(),
              onSubmitted: (text) => onPasswordSubmitted(text, controller),
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 20),
            TextWithHyperLink(
              message: "user.registration.already_registered.message".tr(),
              hyperlink: "user.registration.already_registered.hyperlink".tr(),
              onHyperlinkTapped: () =>
                  Beamer.of(context).beamToNamed(RecipyRoute.login),
            )
          ],
        ),
      ),
    );
  }

  void onUsernameSubmitted(String username, RegistrationController controller) {
    String password = passwordController.text;
    if (username != "" && password != "") {
      controller.register(username, password);
    } else {
      passwordFocusNode.requestFocus();
    }
  }

  void onPasswordSubmitted(String password, RegistrationController controller) {
    String username = usernameController.text;
    if (username != "" && password != "") {
      controller.register(username, password);
    } else {
      usernameFocusNode.requestFocus();
    }
  }
}

abstract class RegistrationController extends StateNotifier<RegistrationModel> {
  RegistrationController(RegistrationModel state) : super(state);

  void register(String username, String password);
}

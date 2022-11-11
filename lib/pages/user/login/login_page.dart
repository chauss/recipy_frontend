import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/widgets/custom_text_field.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/widgets/recipy_app_bar.dart';
import 'package:recipy_frontend/config/routes_config.dart';
import 'package:recipy_frontend/widgets/text_with_hyperlink.dart';
import 'login_model.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LoginController controller = ref.read(loginControllerProvider.notifier);

    LoginModel model = ref.watch(loginControllerProvider);

    return Scaffold(
      appBar: RecipyAppBar(title: "user.login.title".tr()),
      body: Container(
        margin: const EdgeInsets.only(left: 24, right: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: usernameController,
              focusNode: usernameFocusNode,
              hintText: "user.login.username.textfield.hint".tr(),
              onSubmitted: (text) => onUsernameSubmitted(text, controller),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: passwordController,
              focusNode: passwordFocusNode,
              hintText: "user.login.password.textfield.hint".tr(),
              onSubmitted: (text) => onPasswordSubmitted(text, controller),
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 20),
            TextWithHyperLink(
              message: "user.login.not_registered.message".tr(),
              hyperlink: "user.login.not_registered.hyperlink".tr(),
              onHyperlinkTapped: () =>
                  Beamer.of(context).beamToNamed(RecipyRoute.registration),
            )
          ],
        ),
      ),
    );
  }

  void onUsernameSubmitted(String username, LoginController controller) {
    String password = passwordController.text;
    if (username != "" && password != "") {
      controller.login(username, password);
    } else {
      passwordFocusNode.requestFocus();
    }
  }

  void onPasswordSubmitted(String password, LoginController controller) {
    String username = usernameController.text;
    if (username != "" && password != "") {
      controller.login(username, password);
    } else {
      usernameFocusNode.requestFocus();
    }
  }
}

abstract class LoginController extends StateNotifier<LoginModel> {
  LoginController(LoginModel state) : super(state);

  void login(String username, String password);
}

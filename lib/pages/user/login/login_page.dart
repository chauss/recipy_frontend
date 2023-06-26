import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/widgets/recipy_button.dart';
import 'package:recipy_frontend/widgets/recipy_text_field.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/widgets/info_dialog.dart';
import 'package:recipy_frontend/widgets/recipy_app_bar.dart';
import 'package:recipy_frontend/config/routes_config.dart';
import 'package:recipy_frontend/widgets/text_with_hyperlink.dart';
import 'login_model.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LoginController controller = ref.read(loginControllerProvider.notifier);

    LoginModel model = ref.watch(loginControllerProvider);

    react(model, controller, context);

    return Scaffold(
      appBar: RecipyAppBar(title: "user.login.title".tr()),
      body: buildBody(controller, model, context),
    );
  }

  void react(
      LoginModel model, LoginController controller, BuildContext context) {
    if (model.errorCode != null) {
      var dialog = InfoDialog(
        context: context,
        title: "common.error".tr(),
        info: "user.error.${model.errorCode}".tr(),
      );
      SchedulerBinding.instance.addPostFrameCallback((_) {
        dialog.show().then((_) => controller.dismissError());
      });
    } else if (model.successfullyLoggedIn) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        context.beamToNamed(RecipyRoute.userMyRecipes);
      });
    }
  }

  Widget buildBody(
      LoginController controller, LoginModel model, BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/icons/burger_smiling.png',
              width: 96,
              height: 96,
            ),
            const SizedBox(height: 80),
            RecipyTextField(
              controller: emailController,
              focusNode: emailFocusNode,
              hintText: "user.login.email.textfield.hint".tr(),
              onSubmitted: (text) => onEmailSubmitted(text, controller, model),
            ),
            const SizedBox(height: 16),
            RecipyTextField(
              controller: passwordController,
              focusNode: passwordFocusNode,
              hintText: "user.login.password.textfield.hint".tr(),
              onSubmitted: (text) =>
                  onPasswordSubmitted(text, controller, model),
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 24),
            RecipyButton(
              title: "user.login.login".tr(),
              isProcessing: model.loginInProgress,
              onPressed: () => controller.login(
                emailController.text,
                passwordController.text,
              ),
            ),
            const SizedBox(height: 80),
            TextWithHyperLink(
              message: "user.login.not_registered.message".tr(),
              hyperlink: "user.login.not_registered.hyperlink".tr(),
              onHyperlinkTapped: () =>
                  Beamer.of(context).beamToNamed(RecipyRoute.registration),
            ),
          ],
        ),
      ),
    );
  }

  void onEmailSubmitted(
    String email,
    LoginController controller,
    LoginModel model,
  ) {
    if (model.loginInProgress) {
      return;
    }
    String password = passwordController.text;
    if (email != "" && password != "") {
      controller.login(email, password);
    } else {
      passwordFocusNode.requestFocus();
    }
  }

  void onPasswordSubmitted(
    String password,
    LoginController controller,
    LoginModel model,
  ) {
    if (model.loginInProgress) {
      return;
    }
    String email = emailController.text;
    if (email != "" && password != "") {
      controller.login(email, password);
    } else {
      emailFocusNode.requestFocus();
    }
  }
}

abstract class LoginController extends StateNotifier<LoginModel> {
  LoginController(LoginModel state) : super(state);

  Future<void> login(String email, String password);
  void dismissError();
}

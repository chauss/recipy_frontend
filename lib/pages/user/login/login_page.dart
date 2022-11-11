import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/widgets/custom_text_field.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/widgets/info_dialog.dart';
import 'package:recipy_frontend/widgets/process_indicator.dart';
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

    return Scaffold(
      appBar: RecipyAppBar(title: "user.login.title".tr()),
      body: buildBody(controller, model, context),
    );
  }

  Widget buildBody(
      LoginController controller, LoginModel model, BuildContext context) {
    if (model.errorCode != null) {
      var dialog = InfoDialog(
        context: context,
        title: "common.error".tr(),
        info: "user.error.${model.errorCode}".tr(),
      );
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        dialog.show().then((_) => controller.dismissError());
      });
    } else if (model.successfullyLoggedIn) {
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        Beamer.of(context).beamToNamed(RecipyRoute.recipes);
      });
    }

    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            controller: emailController,
            focusNode: emailFocusNode,
            hintText: "user.login.email.textfield.hint".tr(),
            onSubmitted: (text) => onEmailSubmitted(text, controller, model),
          ),
          const SizedBox(height: 10),
          CustomTextField(
            controller: passwordController,
            focusNode: passwordFocusNode,
            hintText: "user.login.password.textfield.hint".tr(),
            onSubmitted: (text) => onPasswordSubmitted(text, controller, model),
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 20),
          TextWithHyperLink(
            message: "user.login.not_registered.message".tr(),
            hyperlink: "user.login.not_registered.hyperlink".tr(),
            onHyperlinkTapped: () =>
                Beamer.of(context).beamToNamed(RecipyRoute.registration),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: model.loginInProgress
                ? null
                : () => controller.login(
                      emailController.text,
                      passwordController.text,
                    ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "user.login.login".tr(),
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: Colors.white,
                      ),
                ),
                model.loginInProgress
                    ? const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: ProcessIndicator(color: Colors.white, size: 20),
                      )
                    : Container()
              ],
            ),
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor),
          )
        ],
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

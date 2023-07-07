import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/widgets/recipy_button.dart';
import 'package:recipy_frontend/widgets/recipy_text_field.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/widgets/dialogs/info_dialog.dart';
import 'package:recipy_frontend/widgets/recipy_app_bar.dart';
import 'package:recipy_frontend/config/routes_config.dart';
import 'package:recipy_frontend/widgets/text_with_hyperlink.dart';
import 'registration_model.dart';
import 'package:easy_localization/easy_localization.dart';

class RegistrationPage extends ConsumerWidget {
  RegistrationPage({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode displayNameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RegistrationController controller =
        ref.read(registrationControllerProvider.notifier);

    RegistrationModel model = ref.watch(registrationControllerProvider);

    react(model, controller, context);

    return Scaffold(
      appBar: RecipyAppBar(title: "user.registration.title".tr()),
      body: buildBody(controller, model, context),
    );
  }

  void react(RegistrationModel model, RegistrationController controller,
      BuildContext context) {
    if (model.errorCode != null) {
      var dialog = InfoDialog(
        context: context,
        title: "common.error".tr(),
        info: "user.error.${model.errorCode}".tr(),
      );
      SchedulerBinding.instance.addPostFrameCallback((_) {
        dialog.show().then((_) => controller.dismissError());
      });
    } else if (model.successfullyRegistered) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Beamer.of(context).beamToNamed(RecipyRoute.userMyRecipes);
      });
    }
  }

  Widget buildBody(
    RegistrationController controller,
    RegistrationModel model,
    BuildContext context,
  ) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RecipyTextField(
              controller: displayNameController,
              focusNode: displayNameFocusNode,
              hintText: "user.registration.display_name.textfield.hint".tr(),
              onSubmitted: (text) =>
                  onDisplayNameSubmitted(text, controller, model),
            ),
            const SizedBox(height: 16),
            RecipyTextField(
              controller: emailController,
              focusNode: emailFocusNode,
              hintText: "user.registration.email.textfield.hint".tr(),
              onSubmitted: (text) => onEmailSubmitted(text, controller, model),
            ),
            const SizedBox(height: 16),
            RecipyTextField(
              controller: passwordController,
              focusNode: passwordFocusNode,
              hintText: "user.registration.password.textfield.hint".tr(),
              onSubmitted: (text) =>
                  onPasswordSubmitted(text, controller, model),
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 24),
            RecipyButton(
              title: "user.registration.register".tr(),
              isProcessing: model.registrationInProgress,
              onPressed: () => controller.register(
                emailController.text,
                passwordController.text,
                displayNameController.text,
              ),
            ),
            const SizedBox(height: 80),
            TextWithHyperLink(
              message: "user.registration.already_registered.message".tr(),
              hyperlink: "user.registration.already_registered.hyperlink".tr(),
              onHyperlinkTapped: () =>
                  Beamer.of(context).beamToNamed(RecipyRoute.login),
            ),
          ],
        ),
      ),
    );
  }

  void onEmailSubmitted(
    String email,
    RegistrationController controller,
    RegistrationModel model,
  ) {
    if (model.registrationInProgress) {
      return;
    }
    String password = passwordController.text;
    String displayName = displayNameController.text;
    if (displayName == "") {
      displayNameFocusNode.requestFocus();
    } else if (password == "") {
      passwordFocusNode.requestFocus();
    } else {
      controller.register(email, password, displayName);
    }
  }

  void onPasswordSubmitted(
    String password,
    RegistrationController controller,
    RegistrationModel model,
  ) {
    if (model.registrationInProgress) {
      return;
    }
    String email = emailController.text;
    String displayName = displayNameController.text;
    if (displayName == "") {
      displayNameFocusNode.requestFocus();
    } else if (email == "") {
      emailFocusNode.requestFocus();
    } else {
      controller.register(email, password, displayName);
    }
  }

  void onDisplayNameSubmitted(
    String displayName,
    RegistrationController controller,
    RegistrationModel model,
  ) {
    if (model.registrationInProgress) {
      return;
    }
    String email = emailController.text;
    String password = passwordController.text;
    if (email == "") {
      emailFocusNode.requestFocus();
    } else if (password == "") {
      passwordFocusNode.requestFocus();
    } else {
      controller.register(email, password, displayName);
    }
  }
}

abstract class RegistrationController extends StateNotifier<RegistrationModel> {
  RegistrationController(RegistrationModel state) : super(state);

  Future<void> register(String email, String password, String displayName);
  void dismissError();
}

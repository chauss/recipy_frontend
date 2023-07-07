import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/config/routes_config.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/widgets/dialogs/info_dialog.dart';
import 'package:recipy_frontend/widgets/process_indicator.dart';
import 'package:recipy_frontend/widgets/recipe_overview_widget.dart';
import 'package:recipy_frontend/widgets/recipy_app_bar.dart';
import 'my_recipes_model.dart';
import 'package:easy_localization/easy_localization.dart';

class MyRecipesPage extends ConsumerWidget {
  const MyRecipesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MyRecipesController controller =
        ref.read(myRecipesControllerProvider.notifier);
    MyRecipesModel model = ref.watch(myRecipesControllerProvider);

    react(model, controller, context);

    return Scaffold(
      appBar: RecipyAppBar(
        title: "user.my_recipes.title".tr(),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.beamToNamed(RecipyRoute.userProfile),
          )
        ],
      ),
      body: buildBody(context, model, controller),
    );
  }

  void react(MyRecipesModel model, MyRecipesController controller,
      BuildContext context) {
    if (model.errorCode != null) {
      var dialog = InfoDialog(
        context: context,
        title: "common.error".tr(),
        info: "error_codes.${model.errorCode}".tr(),
      );
      SchedulerBinding.instance.addPostFrameCallback((_) {
        dialog.show().then((_) => controller.dismissError());
      });
    }
  }

  Widget buildBody(
    BuildContext context,
    MyRecipesModel model,
    MyRecipesController controller,
  ) {
    if (model.isLoading) {
      return const ProcessIndicator();
    }

    Widget recipesWidget;
    if (model.recipeOverviews.isEmpty) {
      recipesWidget = Center(
        child: SizedBox(
          width: 240,
          child: const Text(
            "user.my_recipes.no_recipes_yet",
            textAlign: TextAlign.center,
          ).tr(),
        ),
      );
    } else {
      recipesWidget = GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: model.recipeOverviews
            .map(
              (recipeOverview) => RecipeOverviewWidget(
                recipeOverview: recipeOverview,
                onClick: () => context.beamToNamed(
                    RecipyRoute.recipeDetailsRouteForId(
                        context, recipeOverview.id)),
              ),
            )
            .toList(),
      );
    }

    return RefreshIndicator(
        onRefresh: controller.refetchRecipes,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: recipesWidget,
        ));
  }
}

abstract class MyRecipesController extends StateNotifier<MyRecipesModel> {
  MyRecipesController(MyRecipesModel state) : super(state);

  Future<void> refetchRecipes();
  void dismissError();
}

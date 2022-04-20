import 'package:recipy_frontend/pages/recipe_detail/parts/edit_ingredient_usage_widget.dart';
import 'package:recipy_frontend/pages/recipe_detail/parts/editable_ingredient_usage.dart';

class DeleteIngredientUsageRequest {
  final EditableIngredientUsage ingredientUsage;

  DeleteIngredientUsageRequest({required this.ingredientUsage});
}

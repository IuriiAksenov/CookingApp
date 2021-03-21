import './recipe_preview.dart';
import 'package:app/models/types/recipe_group_type.dart';

class RecipePreviewsGroup {
  final RecipeGroupType recipeGroupType;
  final List<RecipePreview> recipes;

  const RecipePreviewsGroup({this.recipeGroupType, this.recipes});

  static RecipePreviewsGroup fromJson(Map json) {
    return RecipePreviewsGroup(
      recipeGroupType: RecipeGroupType.fromId(json['recipeGroupType']),
      recipes: [
        ...json['recipes']
            .map((value) => RecipePreview.fromJson(value))
            .toList()
      ],
    );
  }
}

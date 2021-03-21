import 'package:app/models/types/custom_type.dart';

class RecipeGroupType extends CustomType {
  RecipeGroupType(int id, String name) : super(id, name);

  static RecipeGroupType get none => RecipeGroupType(0, 'Any recipe kind');
  static RecipeGroupType get breakfast => RecipeGroupType(1, 'Breakfast');
  static RecipeGroupType get salads => RecipeGroupType(2, 'Salads');
  static RecipeGroupType get forBigFamily =>
      RecipeGroupType(3, 'For big family');

  factory RecipeGroupType.fromId(int id) {
    switch (id) {
      case 1:
        return breakfast;
      case 2:
        return salads;
      case 3:
        return forBigFamily;
      default:
        return none;
    }
  }
}

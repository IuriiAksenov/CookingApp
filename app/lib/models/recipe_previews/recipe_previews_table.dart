import './recipe_previews_group.dart';

class RecipePreviewsTable {
  final RecipePreviewsGroup highPopular;
  final RecipePreviewsGroup middlePopular;
  final RecipePreviewsGroup lowPopular;
  final int totalAmount;

  RecipePreviewsTable({
    this.highPopular,
    this.middlePopular,
    this.lowPopular,
    this.totalAmount,
  });

  static RecipePreviewsTable fromJson(Map<String, dynamic> json) {
    return RecipePreviewsTable(
      highPopular: RecipePreviewsGroup.fromJson(json['highPopular']),
      middlePopular: RecipePreviewsGroup.fromJson(json['middlePopular']),
      lowPopular: RecipePreviewsGroup.fromJson(json['lowPopular']),
      totalAmount: json['totalAmount'],
    );
  }
}

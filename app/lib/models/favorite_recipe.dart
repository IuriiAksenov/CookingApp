import '../repositories/db_base_model.dart';

class FavoriteRecipe extends DbBaseModel {
  static String table = 'favorite';

  final int id;
  FavoriteRecipe({this.id});

  factory FavoriteRecipe.fromJson(Map<String, dynamic> json) {
    return FavoriteRecipe(
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id,
    };
    return map;
  }
}

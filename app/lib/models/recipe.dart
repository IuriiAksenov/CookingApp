import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final String duration;
  final int servingsCount;
  final List<String> ingredients;
  final List<String> tablewares;

  const Recipe({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.imageUrl,
    @required this.duration,
    @required this.servingsCount,
    @required this.ingredients,
    @required this.tablewares,
  })  : assert(id != null),
        assert(name != null),
        assert(description != null),
        assert(imageUrl != null),
        assert(duration != null),
        assert(servingsCount != null),
        assert(ingredients != null),
        assert(tablewares != null);

  @override
  List<Object> get props => [
        id,
        name,
        description,
        imageUrl,
        duration,
        servingsCount,
        ingredients,
        tablewares
      ];

  static Recipe fromJson(Map json) {
    return Recipe(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      duration: json['duration'],
      servingsCount: json['servingsCount'],
      ingredients: [...json['ingredients']],
      tablewares: [...json['tablewares']],
    );
  }

  @override
  String toString() => 'Recipe { id: $id, name: $name }';
}

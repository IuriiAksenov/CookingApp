import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class RecipePreview extends Equatable {
  final dynamic id;
  final String name;
  final String description;
  final String imageUrl;
  final String duration;
  final int servingsCount;

  const RecipePreview(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.imageUrl,
      @required this.duration,
      @required this.servingsCount})
      : assert(id != null),
        assert(name != null),
        assert(description != null),
        assert(imageUrl != null),
        assert(duration != null),
        assert(servingsCount != null);

  @override
  List<Object> get props => [
        id,
        name,
        description,
        imageUrl,
        duration,
        servingsCount,
      ];

  static RecipePreview fromJson(Map json) {
    return RecipePreview(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      duration: json['duration'],
      servingsCount: json['servingsCount'],
    );
  }

  @override
  String toString() => 'Recipe preview { id: $id, name: $name }';
}

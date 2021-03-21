import 'dart:convert';

List<RecipeStage> recipeStageFromJson(String str) => List<RecipeStage>.from(
    json.decode(str).map((x) => RecipeStage.fromJson(x)));

String recipeStageToJson(List<RecipeStage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecipeStage {
  RecipeStage({
    this.name,
    this.parts,
    this.stageType,
  });

  String name;
  List<Part> parts;
  int stageType;

  factory RecipeStage.fromJson(Map<String, dynamic> json) => RecipeStage(
        name: json["name"],
        parts: List<Part>.from(json["parts"].map((x) => Part.fromJson(x))),
        stageType: json["stageType"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "parts": List<dynamic>.from(parts.map((x) => x.toJson())),
        "stageType": stageType,
      };
}

class Part {
  Part({
    this.stagePartType,
    this.text,
    this.url,
  });

  int stagePartType;
  String text;
  String url;

  factory Part.fromJson(Map<String, dynamic> json) => Part(
        stagePartType: json["stagePartType"],
        text: json["text"] == null ? null : json["text"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "stagePartType": stagePartType,
        "text": text == null ? null : text,
        "url": url == null ? null : url,
      };
}

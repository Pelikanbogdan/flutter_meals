import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal.g.dart';

@JsonSerializable()
class Meal {
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  factory Meal.fromSnapshot(DocumentSnapshot snapshot) => Meal(
        id: snapshot['id'] as String,
        categories: (snapshot['categories'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
        title: snapshot['title'] as String,
        imageUrl: snapshot['imageUrl'] as String,
        ingredients: (snapshot['ingredients'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
        steps: (snapshot['steps'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
        duration: snapshot['duration'] as int,
        complexity: $enumDecode(_$ComplexityEnumMap, snapshot['complexity']),
        affordability:
            $enumDecode(_$AffordabilityEnumMap, snapshot['affordability']),
        isGlutenFree: snapshot['isGlutenFree'] as bool,
        isLactoseFree: snapshot['isLactoseFree'] as bool,
        isVegan: snapshot['isVegan'] as bool,
        isVegetarian: snapshot['isVegetarian'] as bool,
      );

  Map<String, dynamic> toJson() => _$MealToJson(this);

  const Meal(
      {required this.id,
      required this.categories,
      required this.title,
      required this.imageUrl,
      required this.ingredients,
      required this.steps,
      required this.duration,
      required this.complexity,
      required this.affordability,
      required this.isGlutenFree,
      required this.isLactoseFree,
      required this.isVegan,
      required this.isVegetarian});
}

enum Complexity {
  simple,
  medium,
  hard,
}

enum Affordability {
  affordable,
  pricey,
  luxurious,
}

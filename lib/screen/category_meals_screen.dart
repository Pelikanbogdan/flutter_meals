import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_meals/helper/firebase_helper.dart';
import 'package:flutter_meals/models/meal.dart';
import 'package:flutter_meals/widget/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  const CategoryMealsScreen({Key? key}) : super(key: key);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  final firebaseHelper = FirebaseHelper();
  Map<String, dynamic> toFirebase = {};
  CollectionReference meals = FirebaseFirestore.instance.collection('meals');

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'] ?? '';
    final categoryId = routeArgs['id'];
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('meals').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LinearProgressIndicator();
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(categoryTitle),
            ),
            body: ListView.builder(
              itemBuilder: (ctx, index) {
                DocumentSnapshot docSnap = snapshot.data!.docs[index];
                final meal = Meal.fromSnapshot(docSnap);
                if (meal.categories.contains(categoryId)) {
                  return MealItem(
                    meal: meal,
                    id: meal.id,
                    title: meal.title,
                    imageUrl: meal.imageUrl,
                    duration: meal.duration,
                    affordability: meal.affordability,
                    complexity: meal.complexity,
                  );
                } else {
                  return const SizedBox();
                }
              },
              itemCount: snapshot.data!.docs.length,
            ),
          );
        });
  }
}

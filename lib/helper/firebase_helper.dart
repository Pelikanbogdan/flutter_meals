import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_meals/data/dummy_data.dart';

class FirebaseHelper {
  Map<String, dynamic> _toFirebase = {};
  final CollectionReference _meals =
      FirebaseFirestore.instance.collection('meals');

  fillCollection() {
    for (var meal in dummyMeals) {
      _toFirebase = meal.toJson();
      _meals.add(_toFirebase);
    }
  }
}

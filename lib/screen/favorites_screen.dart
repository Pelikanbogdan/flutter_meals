import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/service/preferences_service.dart';
import '../models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final _preferencesService = PreferencesService();

  FavoritesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _preferencesService.getMealIds(),
      builder: (context, data) {
        if (!data.hasData) {
          return const CircularProgressIndicator();
        }
        final listOfId = data.data as List<String>;
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('meals').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            List<Meal> meals =
                snapshot.data!.docs.map((e) => Meal.fromSnapshot(e)).toList();
            List<Meal> filteredMeals = [];
            for (String id in listOfId) {
              for (Meal meal in meals) {
                if (meal.id == id) {
                  filteredMeals.add(meal);
                }
              }
            }
            return ListView.builder(
              itemCount: filteredMeals.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredMeals[index].title),
                  subtitle: Image.network(filteredMeals[index].imageUrl),
                );
              },
              padding: const EdgeInsets.all(20),
            );
          },
        );
      },
    );
  }
} 


// class _FavoritesScreenState extends State<FavoritesScreen> {
//   final _preferencesService = PreferencesService();
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: _preferencesService.getMealIds(),
//         builder: (context, data) {
//           if (!data.hasData) {
//             return const CircularProgressIndicator();
//           }
//           // final comparableSnap = data.data as List<String?>;
//           return StreamBuilder<QuerySnapshot>(
//             stream: FirebaseFirestore.instance.collection('meals').snapshots(),
//             builder: (context, snapshot) {
//               return ListView.builder(
//                 itemCount: snapshot.data!.docs.length,
//                 itemBuilder: (context, index) {
//                   DocumentSnapshot docSnap = snapshot.data!.docs[index];
//                   final favoriteMeal = Meal.fromSnapshot(docSnap);
//                   return ListTile(
//                     title: Text(favoriteMeal.title),
//                     subtitle: Image.network(favoriteMeal.imageUrl),
//                   );
//                 },
//                 padding: const EdgeInsets.all(20),
//               );
//             },
//           );
//         });
//   }
// }

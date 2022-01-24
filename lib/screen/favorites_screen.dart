import 'package:flutter/material.dart';
import 'package:flutter_meals/service/preferences_service.dart';
import '../models/meal.dart';

class FavoritesScreen extends StatefulWidget {
  static List<Meal> favoriteMeals = [];

  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final _preferencesService = PreferencesService();
  List<String> listOfIds = [];
  void loadId() async {
    final id = await _preferencesService.getMealIds();
    setState(() {
      listOfIds = id!;
    });
  }

  @override
  void initState() {
    loadId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _preferencesService.getMealIds(),
      builder: (context, snapshot) {
        return Center(
          child: Text('first element: ' +
              listOfIds.first +
              ' ' +
              'elements count:' +
              listOfIds.length.toString()),
        );
      },
    );
  }
}

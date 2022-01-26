import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_meals/provider/auth_provider.dart';
import 'package:flutter_meals/screen/categories_screen.dart';
import 'package:flutter_meals/screen/category_meals_screen.dart';
import 'package:flutter_meals/screen/wrapper_screen.dart';
import 'package:flutter_meals/screen/meal_detail_screen.dart';
import 'package:flutter_meals/screen/auth_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Meals',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthScreen(),
          // '/': (context) => const WrapperScreen(),
          AuthScreen.routeName: (context) => const AuthScreen(),
          CategoriesScreen.routeName: (context) => const CategoriesScreen(),
          CategoryMealsScreen.routeName: (context) =>
              const CategoryMealsScreen(),
          MealDetailScreen.routeName: (context) => MealDetailScreen(),
        },
      ),
    );
  }
}

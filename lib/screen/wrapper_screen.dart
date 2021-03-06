import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/screen/auth_screen.dart';
import 'package:flutter_meals/screen/tabs_screen.dart';

class WrapperScreen extends StatelessWidget {
  const WrapperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return const TabsScreen();
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something Went Wrong!Whoops'));
            } else {
              return const AuthScreen();
            }
          }),
    );
  }
}

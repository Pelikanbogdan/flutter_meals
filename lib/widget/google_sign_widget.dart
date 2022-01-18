import 'package:flutter/material.dart';
import 'package:flutter_meals/provider/google_sign_in_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class GoogleSignUpWidget extends StatelessWidget {
  const GoogleSignUpWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(
            'assets/images/logo.png',
            scale: 1.8,
          ),
          const Spacer(),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Hello there,\nWelcome Back',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Login to your account to continue',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/signup');
            },
            child: const Text('Sign in via Email'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              final provider = Provider.of<GoogleSignInProvider>(
                context,
                listen: false,
              );
              provider.googleLogin();
            },
            icon: const FaIcon(
              FontAwesomeIcons.google,
              color: Colors.white,
            ),
            label: const Text('Sign up with Google'),
          ),
          const SizedBox(height: 40),
          RichText(
            text: const TextSpan(
              text: 'Already have an account? ',
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                    text: 'Log in',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black))
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

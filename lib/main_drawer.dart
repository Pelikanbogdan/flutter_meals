import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/provider/auth_provider.dart';
import 'package:flutter_meals/screen/auth_screen.dart';
import 'package:flutter_meals/service/preferences_service.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('YES'),
            onPressed: () {
              final preference = PreferencesService();
              preference.deleteAllMeal();
              final provider =
                  Provider.of<AuthProvider>(context, listen: false);
              provider.googleLogout();
              Navigator.of(ctx).popAndPushNamed(AuthScreen.routeName);
            },
          ),
          TextButton(
            child: const Text('NO'),
            onPressed: () {
              final provider =
                  Provider.of<AuthProvider>(context, listen: false);
              provider.googleLogout();
              Navigator.of(ctx).popAndPushNamed(AuthScreen.routeName);
            },
          ),
        ],
      ),
    );
  }

  Widget buildListTile(String title, IconData icon) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.bottomLeft,
            color: Theme.of(context).colorScheme.secondary,
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: (20),
                      backgroundImage: NetworkImage(user?.photoURL ??
                          'https://www.pikpng.com/pngl/m/404-4040531_computer-icons-user-avatar-icon-design-login-user.png'),
                    ),
                  ),
                  Text(
                    user?.email ?? 'Anonymous',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          buildListTile(
            'Meals',
            Icons.restaurant,
          ),
          buildListTile(
            'Filters',
            Icons.settings,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextButton(
              onPressed: () {
                _showDialog('Whould you like to clear favorites?');
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}

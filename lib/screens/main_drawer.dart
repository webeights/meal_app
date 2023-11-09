import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.switchScreens});

  final void Function(String) switchScreens;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.primary),
            child: const Row(
              children: [
                Icon(
                  Icons.fastfood_rounded,
                  size: 50,
                  color: Colors.white,
                ),
                SizedBox(width: 15),
                Text(
                  'Cooking Up!',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () => switchScreens('meals'),
            leading: Icon(
              Icons.restaurant_rounded,
              size: 40,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('Meals'),
          ),
          ListTile(
            onTap: () => switchScreens('filters'),
            leading: Icon(
              Icons.settings,
              size: 40,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('Filters'),
          ),
        ],
      ),
    );
  }
}

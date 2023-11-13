import 'package:flutter/material.dart';
import 'package:meal_app/providers/favorites_provider.dart';
import 'package:meal_app/providers/filters_provider.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/filters.dart';
import 'package:meal_app/screens/main_drawer.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  var currentIndex = 0;

  void switchTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void infoMessage(String text) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text(text),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  void switchScreens(String text) {
    Navigator.of(context).pop();
    if (text == 'filters') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMeals = ref.watch(favoritesNotifierProvider);
    final availableMeal = ref.watch(filteredMealsNotifierProvider);

    String title = 'Categories';

    Widget activeScreen = CategoriesScreen(
      availableMeals: availableMeal,
    );

    if (currentIndex == 1) {
      activeScreen = MealScreen(
        meal: favoriteMeals,
      );
      title = 'Favorites';
    }

    return Scaffold(
      drawer: MainDrawer(
        switchScreens: switchScreens,
      ),
      appBar: AppBar(
        title: Text(title),
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: switchTab,
        currentIndex: currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

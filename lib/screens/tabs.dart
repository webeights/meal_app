import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/filters.dart';
import 'package:meal_app/screens/main_drawer.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  var currentIndex = 0;
  final List<Meal> favoriteMeal = [];
  Map<Filters, bool> filteredMeal = kInitialFilters;

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

  void toggleFavorites(Meal meal) {
    var isExisting = favoriteMeal.contains(meal);

    if (!isExisting) {
      setState(() {
        favoriteMeal.add(meal);
        infoMessage('Meal added to favorites');
      });
    }

    if (isExisting) {
      setState(() {
        favoriteMeal.remove(meal);
        infoMessage('Meal removed to favorites');
      });
    }
  }

  void switchScreens(String text) async {
    Navigator.of(context).pop();
    if (text == 'filters') {
      var result = await Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
          builder: (context) => FiltersScreen(
            currentActiveFilters: filteredMeal,
          ),
        ),
      );
      setState(() {
        filteredMeal = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealNotifierProvider);
    var availableMeals = meals.where((meal) {
      if (filteredMeal[Filters.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (filteredMeal[Filters.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (filteredMeal[Filters.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (filteredMeal[Filters.vegan]! && !meal.isVegan) {
        return false;
      }

      return true;
    }).toList();

    String title = 'Categories';

    Widget activeScreen = CategoriesScreen(
      toggleFavorites: toggleFavorites,
      availableMeals: availableMeals,
    );

    if (currentIndex == 1) {
      activeScreen = MealScreen(
        toggleFavorites: toggleFavorites,
        meal: favoriteMeal,
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
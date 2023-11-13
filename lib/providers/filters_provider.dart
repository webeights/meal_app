import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/providers/meal_provider.dart';

enum Filters {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filters, bool>> {
  FiltersNotifier()
      : super({
          Filters.glutenFree: false,
          Filters.lactoseFree: false,
          Filters.vegetarian: false,
          Filters.vegan: false,
        });

  void setFilters(Map<Filters, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filters filters, bool activeFilter) {
    state = {...state, filters: activeFilter};
  }
}

final filtersNotifierProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filters, bool>>(
        (ref) => FiltersNotifier());

final filteredMealsNotifierProvider = Provider((ref) {
  final meals = ref.watch(mealNotifierProvider);
  final filteredMeals = ref.watch(filtersNotifierProvider);
  return meals.where((meal) {
    if (filteredMeals[Filters.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (filteredMeals[Filters.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (filteredMeals[Filters.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (filteredMeals[Filters.vegan]! && !meal.isVegan) {
      return false;
    }

    return true;
  }).toList();
});

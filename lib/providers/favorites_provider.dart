import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/models/meal.dart';

class FavoritesNotifier extends StateNotifier<List<Meal>> {
  FavoritesNotifier() : super([]);

  void addToFavorites(Meal meal) {
    var isExisting = state.contains(meal);

    if (isExisting) {
      state = state.where((m) => m.id != meal.id).toList();
      print(isExisting);
    } else {
      print(isExisting);
      state = [...state, meal];
    }
  }
}

final favoritesNotifierProvider =
    StateNotifierProvider<FavoritesNotifier, List<Meal>>(
        (ref) => FavoritesNotifier());

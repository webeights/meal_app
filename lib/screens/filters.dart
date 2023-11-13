import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(filtersNotifierProvider);
    final selectFilter = ref.read(filtersNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text('Gluten Free'),
            subtitle: const Text('Show Gluten Free Meals Only'),
            value: filter[Filters.glutenFree]!,
            onChanged: (value) => selectFilter.setFilter(
              Filters.glutenFree,
              value,
            ),
          ),
          SwitchListTile(
            title: const Text('Lactose Free'),
            subtitle: const Text('Show Lactose Free Meals Only'),
            value: filter[Filters.lactoseFree]!,
            onChanged: (value) => selectFilter.setFilter(
              Filters.lactoseFree,
              value,
            ),
          ),
          SwitchListTile(
            title: const Text('Vegetarian'),
            subtitle: const Text('Show Vegetarian Meals Only'),
            value: filter[Filters.vegetarian]!,
            onChanged: (value) => selectFilter.setFilter(
              Filters.vegetarian,
              value,
            ),
          ),
          SwitchListTile(
            title: const Text('Vegan'),
            subtitle: const Text('Show Vegan Meals Only'),
            value: filter[Filters.vegan]!,
            onChanged: (value) => selectFilter.setFilter(
              Filters.vegan,
              value,
            ),
          ),
        ],
      ),
    );
  }
}

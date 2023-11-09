import 'package:flutter/material.dart';

enum Filters {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentActiveFilters});

  final Map<Filters, bool> currentActiveFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var isGlutenFree = false;
  var isLactoseFree = false;
  var isVegetarian = false;
  var isVegan = false;

  @override
  void initState() {
    isGlutenFree = widget.currentActiveFilters[Filters.glutenFree]!;
    isLactoseFree = widget.currentActiveFilters[Filters.lactoseFree]!;
    isVegetarian = widget.currentActiveFilters[Filters.vegetarian]!;
    isVegan = widget.currentActiveFilters[Filters.vegan]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filters.glutenFree: isGlutenFree,
            Filters.lactoseFree: isLactoseFree,
            Filters.vegetarian: isVegetarian,
            Filters.vegan: isVegan
          });
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Gluten Free'),
              subtitle: const Text('Show Gluten Free Meals Only'),
              value: isGlutenFree,
              onChanged: (value) {
                setState(() {
                  isGlutenFree = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Lactose Free'),
              subtitle: const Text('Show Lactose Free Meals Only'),
              value: isLactoseFree,
              onChanged: (value) {
                setState(() {
                  isLactoseFree = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Vegetarian'),
              subtitle: const Text('Show Vegetarian Meals Only'),
              value: isVegetarian,
              onChanged: (value) {
                setState(() {
                  isVegetarian = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Vegan'),
              subtitle: const Text('Show Vegan Meals Only'),
              value: isVegan,
              onChanged: (value) {
                setState(() {
                  isVegan = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

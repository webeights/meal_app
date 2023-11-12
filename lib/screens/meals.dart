import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meal_detail.dart';
import 'package:meal_app/widgets/meal_item.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({
    super.key,
    this.title,
    required this.meal,
  });

  final String? title;
  final List<Meal> meal;

  void showMealDetail(BuildContext context, Meal meals) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealDetailScreen(
          meal: meals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = meal.isEmpty
        ? const Center(
            child: Text(
              'Add some of your favorite meals!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        : ListView(
            children: meal
                .map((meal) => MealItem(
                      meal: meal,
                      showMealDetail: () => showMealDetail(context, meal),
                    ))
                .toList(),
          );

    if (title == null) {
      return mainContent;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: mainContent,
    );
  }
}

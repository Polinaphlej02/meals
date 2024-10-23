import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details_screen.dart';
import 'package:meals/widgets/meal_item.dart';


class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.title, required this.meals, required this.onToggleFavoriteMeal});

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavoriteMeal;
  
  void _selectedMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => MealDetailsScreen(meal: meal, onToggleFavoriteMeal: onToggleFavoriteMeal,)));
    }

  @override
  Widget build(BuildContext context) {

    Widget content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          return MealItem(meal: meals[index], onSelectedMeal: (meal) {
            _selectedMeal(context, meals[index]);
          });
        });

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Nothing here", style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondaryContainer),),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Try selecting a different category",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondaryContainer),
            ),
          ],
        ),
      );
    }
    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}

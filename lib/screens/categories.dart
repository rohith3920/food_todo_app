import 'package:flutter/material.dart';

import 'package:flutter_food/data/dummy_data.dart';
import 'package:flutter_food/models/category.dart';
import 'package:flutter_food/models/meal.dart';
import 'package:flutter_food/screens/meals.dart';
import 'package:flutter_food/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.onToggleFavourite,
    required this.availableMeal,
  });
  final void Function(Meal meal) onToggleFavourite;
  final List<Meal> availableMeal;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealScreen(
          title: category.title,
          meals: filteredMeals,
          onToggleFavourite: onToggleFavourite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(24),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final Category in availableCategories)
          CategoryGridView(
            category: Category,
            onselectCategory: () {
              _selectCategory(context, Category);
            },
          )
      ],
    );
  }
}

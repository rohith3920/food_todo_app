import 'package:flutter/material.dart';
// import 'package:flutter_food/data/dummy_data.dart';
// import 'package:flutter_food/providers/meals_provider.dart';
// import 'package:flutter_food/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_food/screens/categories.dart';
import 'package:flutter_food/screens/filters_screen.dart';
import 'package:flutter_food/screens/meals.dart';
import 'package:flutter_food/widgets/main_drawer.dart';
import 'package:flutter_food/providers/facourite_provider.dart';
import 'package:flutter_food/providers/filter_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactosFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FilterScreen(),
        ),
      );

      // print(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeal: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favouriteMealsProvider);
      activePage = MealScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Your Favourities';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites'),
        ],
      ),
    );
  }
}

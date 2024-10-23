import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoritesMeals = [];

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavoritesStatus(meal) {
    final isExisting = _favoritesMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoritesMeals.remove(meal);
      }); 
      _showInfoMessage("Meal is not longer a favorite.");
    } else {
      setState(() {
         _favoritesMeals.add(meal);
      });
      _showInfoMessage("Meal is a favorite now");
    }
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) {
    if (identifier == "filters") {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(onToggleFavoriteMeal: _toggleMealFavoritesStatus,);
      var activeScreenTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(meals: _favoritesMeals, onToggleFavoriteMeal: _toggleMealFavoritesStatus,);
      activeScreenTitle = "Your favorites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeScreenTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen,),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favorites",
            )
        ],
        ),
    );
  }
}
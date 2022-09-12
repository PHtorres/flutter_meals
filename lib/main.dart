import 'package:flutter/material.dart';
import 'dummy_data.dart';
import 'models/filter.dart';
import 'models/meal.dart';
import 'screens/filters_screen.dart';
import 'screens/bottom_tabs_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Filter _filter = Filter(
      glutenFree: false, lactoseFree: false, vegan: false, vegetarian: false);

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Filter filter) {
    print(filter.glutenFree);
    print(filter.lactoseFree);
    print(filter.vegetarian);
    print(filter.vegan);
    setState(() {
      _filter = filter;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (!meal.isGlutenFree && _filter.glutenFree) return false;
        if (!meal.isLactoseFree && _filter.lactoseFree) return false;
        if (!meal.isVegetarian && _filter.vegetarian) return false;
        if (!meal.isVegan && _filter.vegan) return false;
        return true;
      }).toList();
    });
  }

  void _toggleFavoriteMeal(String mealId) {
    final existingMealIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingMealIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingMealIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodySmall: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              titleLarge: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Roboto-Condensed',
                  fontWeight: FontWeight.bold))),
      initialRoute: BottomTabsScreen.routeName,
      routes: {
        BottomTabsScreen.routeName: (_) => BottomTabsScreen(_favoriteMeals),
        CategoriesScreen.routeName: (_) => CategoriesScreen(),
        CategoryMealsScreen.routeName: (_) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (_) =>
            MealDetailScreen(_toggleFavoriteMeal, _isMealFavorite),
        FiltersScreen.routeName: (_) => FiltersScreen(_filter, _setFilters)
      },
    );
  }
}

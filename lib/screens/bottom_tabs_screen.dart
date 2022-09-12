import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import './categories_screen.dart';
import './favorites_screen.dart';

class Screen {
  Widget widget;
  String title;

  Screen(this.widget, this.title);
}

class BottomTabsScreen extends StatefulWidget {
  static const routeName = 'bottom-tabs';
  final List<Meal> favoriteMeals;

  BottomTabsScreen(this.favoriteMeals);

  @override
  State<BottomTabsScreen> createState() => _BottomTabsScreenState();
}

class _BottomTabsScreenState extends State<BottomTabsScreen> {
  List<Screen> _screens;
  int _selectedScreenIndex = 0;

  @override
  void initState() {
    _screens = [
      Screen(CategoriesScreen(), 'Categories'),
      Screen(FavoritesScreen(widget.favoriteMeals), 'Favorites')
    ];
    super.initState();
  }

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_screens[_selectedScreenIndex].title)),
      drawer: MainDrawer(),
      body: _screens[_selectedScreenIndex].widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        //backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedScreenIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              label: 'Categories'),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.star),
              label: 'Favorites'),
        ],
      ),
    );
  }
}

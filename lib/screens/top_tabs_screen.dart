import 'package:flutter/material.dart';
import './categories_screen.dart';
import './favorites_screen.dart';

class TopTabsScreen extends StatefulWidget {
  static const routeName = 'top-tabs';
  const TopTabsScreen({Key key}) : super(key: key);

  @override
  State<TopTabsScreen> createState() => _TopTabsScreenState();
}

class _TopTabsScreenState extends State<TopTabsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Meals'),
            bottom: TabBar(tabs: [
              Tab(
                icon: Icon(Icons.category),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favorites',
              )
            ]),
          ),
          body: TabBarView(children: [CategoriesScreen(), FavoritesScreen([])]),
        ));
  }
}

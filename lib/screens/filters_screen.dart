import 'package:flutter/material.dart';
import '../models/filter.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = 'filters';
  final Function saveFilters;
  final Filter filter;

  FiltersScreen(this.filter, this.saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegan = false;
  var _vegetarian = false;

  @override
  void initState() {
    _glutenFree = widget.filter.glutenFree;
    _lactoseFree = widget.filter.lactoseFree;
    _vegan = widget.filter.vegan;
    _vegetarian = widget.filter.vegetarian;
    super.initState();
  }

  Widget _buildFilterItem(
      String title, bool value, String subtitle, Function onValueChange) {
    return SwitchListTile(
        title: Text(title),
        value: value,
        subtitle: Text(subtitle),
        onChanged: onValueChange);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your filters'),
        actions: [
          IconButton(
              onPressed: () {
                widget.saveFilters(Filter(
                    glutenFree: _glutenFree,
                    lactoseFree: _lactoseFree,
                    vegan: _vegan,
                    vegetarian: _vegetarian));
              },
              icon: Icon(Icons.save))
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selections.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildFilterItem(
                  'Gluten-free', _glutenFree, 'Only includes gluten-free meals',
                  (newValue) {
                setState(() {
                  _glutenFree = newValue;
                });
              }),
              _buildFilterItem('Lactose-free', _lactoseFree,
                  'Only includes lactose-free meals', (newValue) {
                setState(() {
                  _lactoseFree = newValue;
                });
              }),
              _buildFilterItem(
                  'Vegetarian', _vegetarian, 'Only includes vegetarian meals',
                  (newValue) {
                setState(() {
                  _vegetarian = newValue;
                });
              }),
              _buildFilterItem('Vegan', _vegan, 'Only includes vegan meals',
                  (newValue) {
                setState(() {
                  _vegan = newValue;
                });
              })
            ],
          ))
        ],
      ),
    );
  }
}

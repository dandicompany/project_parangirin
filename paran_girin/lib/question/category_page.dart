import 'package:flutter/material.dart';
import 'package:paran_girin/layout/base_appbar.dart';

class CategoryPage extends StatefulWidget {

  final String categoryTitle;

  const CategoryPage({Key key, this.categoryTitle}) : super(key: key);
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: BaseAppBar(title : categoryTitle),
      
    );
  }
}
import 'package:flutter/material.dart';
import 'package:paran_girin/layout/base_appbar.dart';
import 'package:paran_girin/question/question_card.dart';

class CategoryPage extends StatefulWidget {

  final String categoryTitle;

  const CategoryPage({Key key, this.categoryTitle}) : super(key: key);
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title : widget.categoryTitle),
      body: ListView.separated(
        controller: scrollController,
        itemCount: 10,
        itemBuilder: (BuildContext context, int idx) {
          return QuestionCard(
            qTitle: "파란 기린과의 첫 만남",
            qDescription: "파란 기린과 인사를 나누어 보아요!",
            isDone: true,
          );
        },
        separatorBuilder: (BuildContext context, int i) {
          return Divider(
            height: 1
          );
        },
      )
    );
  }
}



import 'package:flutter/material.dart';
import 'package:paran_girin/layout/base_appbar.dart';
import 'package:paran_girin/question/qestion_post.dart';
import 'package:paran_girin/question/question_card.dart';

class QuestionPage extends StatefulWidget {
  final String categoryTitle;

  const QuestionPage({Key key, this.categoryTitle}) : super(key: key);
  
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
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
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => QuestionPost(
                    categoryTitle: "자연탐구",
                    image: "assets/images/category_nature.png",
                    qTitle: "땅 속의 두더지",
                    question: "두더지는 왜 땅 속을 좋아할까?",
                    storyText: "파란기린을 태어날 때부터 파란색 피부를 가진 특별한 기린이에요. 용기가 넘치고 마음이 따뜻한 파란기린과 인사해보세요!",
                    guide: "파란기린을 태어날 때부터 파란색 피부를 가진 특별한 기린이에요. 용기가 넘치고 마음이 따뜻한 파란기린과 인사해보세요!",
                  )
                )
              );
            },
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
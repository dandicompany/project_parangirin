import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paran_girin/layout/base_appbar.dart';
import 'package:paran_girin/question/qestion_post.dart';
import 'package:paran_girin/question/question_card.dart';
import 'package:provider/provider.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:paran_girin/models/schema.dart';

class QuestionPage extends StatefulWidget {
  final String categoryTitle;

  const QuestionPage({Key key, this.categoryTitle}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState(this.categoryTitle);
}

class _QuestionPageState extends State<QuestionPage> {
  ScrollController scrollController = ScrollController();
  FirebaseProvider fp;
  String category;
  _QuestionPageState(this.category);
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    return Scaffold(
        appBar: BaseAppBar(title: widget.categoryTitle),
        body: StreamBuilder(
            stream: fp
                .getFirestore()
                .collection('questions')
                .where('category', isEqualTo: this.category)
                .snapshots(),
            builder: (context, snapshot) {
              logger.d(snapshot);
              if (snapshot.connectionState == ConnectionState.active) {
                QuerySnapshot qSnapshot = snapshot.data;
                List<QueryDocumentSnapshot> docs = qSnapshot.docs;
                return ListView.separated(
                  controller: scrollController,
                  itemCount: docs.length,
                  itemBuilder: (BuildContext context, int idx) {
                    Question question = Question.fromJson(docs[idx].data());
                    return QuestionCard(
                      qTitle: question.title ?? "제목없음",
                      qDescription: question.question ?? "질문없음",
                      isDone: fp
                          .getUserInfo()
                          .currentChild
                          .answers
                          .containsKey(question.qid),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => QuestionPost(
                                categoryTitle: question.category ?? "카테고리없음",
                                image: "assets/images/category_nature.png",
                                qTitle: question.title ?? "제목없음",
                                question: question.question ?? "질문없음",
                                storyText: question.story ?? "스토리없음",
                                guide: question.guide ?? "가이드없음",
                                qid: question.qid.toString())));
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int i) {
                    return Divider(height: 1);
                  },
                );
              } else {
                return SizedBox.shrink();
              }
            }));
    // body: ListView.separated(
    //   controller: scrollController,
    //   itemCount: 10,
    //   itemBuilder: (BuildContext context, int idx) {
    //     return QuestionCard(
    //       qTitle: "파란 기린과의 첫 만남",
    //       qDescription: "파란 기린과 인사를 나누어 보아요!",
    //       isDone: true,
    //       onTap: () {
    //         Navigator.of(context).push(MaterialPageRoute(
    //             builder: (context) => QuestionPost(
    //                   categoryTitle: "자연탐구",
    //                   image: "assets/images/category_nature.png",
    //                   qTitle: "땅 속의 두더지",
    //                   question: "두더지는 왜 땅 속을 좋아할까?",
    //                   storyText:
    //                       "파란기린을 태어날 때부터 파란색 피부를 가진 특별한 기린이에요. 용기가 넘치고 마음이 따뜻한 파란기린과 인사해보세요!",
    //                   guide:
    //                       "파란기린을 태어날 때부터 파란색 피부를 가진 특별한 기린이에요. 용기가 넘치고 마음이 따뜻한 파란기린과 인사해보세요!",
    //                 )));
    //       },
    //     );
    //   },
    //   separatorBuilder: (BuildContext context, int i) {
    //     return Divider(height: 1);
    //   },
    // ));
  }
}

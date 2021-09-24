import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:paran_girin/question/category_card.dart';
import 'package:paran_girin/question/question_page.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paran_girin/question/qestion_post.dart';
import 'package:paran_girin/question/question_card.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:paran_girin/models/schema.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Function constructOnTap(context, String category) {
    return () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => QuestionPage(categoryTitle: category)));
    };
  }

  bool searched = false;
  bool available = true;
  String query;
  TextEditingController textCon = TextEditingController();
  FirebaseProvider fp;
  ScrollController scrollController = ScrollController();

  Widget _searchQuestions() {
    // logger.d(textCon.text.split(" ").join().split("#"));
    String key = query;
    logger.d(query);
    List<Question> results = List<Question>();
    fp.getStaticInfo().questions.values.forEach((element) {
      if (element.containsKeyWord(key)) {
        results.add(element);
      }
    });
    int today =  DateTime.parse(
        DateFormat("yyyyMMdd").format(DateTime.now())).millisecondsSinceEpoch;
    
    for (var ans in fp.getStaticInfo().answers.values){
      if(DateTime.parse(
        DateFormat("yyyyMMdd").format(DateTime.fromMillisecondsSinceEpoch(ans.date))).millisecondsSinceEpoch == today){
        available = false;
      }
    }
    return ListView.separated(
      controller: scrollController,
      itemCount: results.length,
      itemBuilder: (BuildContext context, int idx) {
        Question question = results[idx];
        return QuestionCard(
          qTitle: question.title ?? "제목없음",
          qDescription: question.question ?? "질문없음",
          questionDone:
              fp.getUserInfo().currentChild.answers.containsKey(question.qid),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => QuestionPost(
                      tag: question.tag ?? "태그 없음",
                      categoryTitle: question.category ?? "카테고리없음",
                      image: "assets/images/category_nature.png",
                      qTitle: question.title ?? "제목없음",
                      question: question.question ?? "질문없음",
                      storyText: question.story ?? "스토리없음",
                      guide: question.guide ?? "가이드없음",
                      available: available,
                    )));
          },
        );
      },
      separatorBuilder: (BuildContext context, int i) {
        return Divider(height: 1);
      },
    );
  }

  // Widget _searchQuestions() {
  //   // logger.d(textCon.text.split(" ").join().split("#"));
  //   logger.d(textCon.text.replaceAll(" ", ""));
  //   return StreamBuilder(
  //       stream: fp
  //           .getFirestore()
  //           .collection('questions')
  //           .where('tag',
  //               arrayContainsAny: textCon.text.split(" ").join().split("#"))
  //           .snapshots(),
  //       builder: (context, snapshot) {
  //         logger.d(snapshot);
  //         if (snapshot.connectionState == ConnectionState.active) {
  //           QuerySnapshot qSnapshot = snapshot.data;
  //           List<QueryDocumentSnapshot> docs = qSnapshot.docs;
  //           return ListView.separated(
  //             controller: scrollController,
  //             itemCount: docs.length,
  //             itemBuilder: (BuildContext context, int idx) {
  //               Question question = Question.fromJson(docs[idx].data());
  //               return QuestionCard(
  //                 qTitle: question.title ?? "제목없음",
  //                 qDescription: question.question ?? "질문없음",
  //                 isDone: fp
  //                     .getUserInfo()
  //                     .currentChild
  //                     .answers
  //                     .containsKey(question.qid),
  //                 onTap: () {
  //                   Navigator.of(context).push(MaterialPageRoute(
  //                       builder: (context) => QuestionPost(
  //                             categoryTitle: question.category ?? "카테고리없음",
  //                             image: "assets/images/category_nature.png",
  //                             qTitle: question.title ?? "제목없음",
  //                             question: question.question ?? "질문없음",
  //                             storyText: question.story ?? "스토리없음",
  //                             guide: question.guide ?? "가이드없음",
  //                           )));
  //                 },
  //               );
  //             },
  //             separatorBuilder: (BuildContext context, int i) {
  //               return Divider(height: 1);
  //             },
  //           );
  //         } else {
  //           return SizedBox.shrink();
  //         }
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          color: AppTheme.colors.background,
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(55),
            // left: ScreenUtil().setWidth(16),
            // right: ScreenUtil().setWidth(16),
          ),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(5.0)),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(16),
                        right: ScreenUtil().setWidth(16)),
                    child: TextField(
                      // onSubmitted: (_) => _searchPosts(),
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        setState(() {
                          query = value;
                          searched = (query.length > 0);
                        });
                      },
                      controller: textCon,
                      decoration: InputDecoration(
                        prefixIcon: GestureDetector(
                          onTap: () {},
                          child:
                              Icon(Icons.search, color: AppTheme.colors.base2),
                        ),
                        hintText: "질문을 검색해보세요 :)",
                        hintStyle: TextStyle(fontSize: ScreenUtil().setSp(16)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Color.fromRGBO(235, 235, 235, 1),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                      ),
                    ),
                  )),
              SizedBox(height: ScreenUtil().setHeight(5)),
              searched
                  ? SizedBox(height: 800, child: _searchQuestions())
                  : Column(children: [
                      CategoryCard(
                        onTap: constructOnTap(context, "사회관계"),
                        title: "사회관계",
                        hashtag: "#나 #가족 #또래 #지역사회 #우리나라 \n#세계 #사회적가치",
                        color: Color.fromRGBO(237, 245, 255, 1),
                        icon: "assets/icons/society.svg",
                        iconColor: AppTheme.colors.primary2,
                      ),
                      SizedBox(height: ScreenUtil().setHeight(12)),
                      CategoryCard(
                          onTap: constructOnTap(context, "자연탐구"),
                          title: "자연탐구",
                          hashtag: "#호기심 #수학적탐구 #과학적탐구",
                          color: Color.fromRGBO(127, 177, 65, 0.1),
                          icon: "assets/icons/nature.svg",
                          iconColor: Color.fromRGBO(127, 177, 65, 1),
                          iconWidth: 55,
                          iconHeight: 55),
                      SizedBox(height: ScreenUtil().setHeight(12)),
                      CategoryCard(
                          onTap: constructOnTap(context, "예술"),
                          title: "예술",
                          hashtag: "#예술감상 #예술표현 #심미적탐색",
                          color: Color.fromRGBO(245, 75, 139, 0.1),
                          icon: "assets/icons/art.svg",
                          iconColor: Color.fromRGBO(245, 75, 139, 1)),
                      SizedBox(height: ScreenUtil().setHeight(12)),
                      CategoryCard(
                          onTap: constructOnTap(context, "신체"),
                          title: "신체",
                          hashtag: "#감각기관 #운동하기 #건강한 생활 \n#안전한 생활치",
                          color: Color.fromRGBO(250, 184, 95, 0.1),
                          icon: "assets/icons/body.svg",
                          iconColor: Color.fromRGBO(250, 184, 95, 1)),
                      SizedBox(height: ScreenUtil().setHeight(12)),
                      CategoryCard(
                          onTap: constructOnTap(context, "의사소통"),
                          title: "의사소통",
                          hashtag: "#말하기 #쓰기 #건강한 생활 #안전한 생활",
                          color: Color.fromRGBO(110, 97, 213, 0.1),
                          icon: "assets/icons/communication.svg",
                          iconColor: Color.fromRGBO(110, 97, 213, 1),
                          iconWidth: 42,
                          iconHeight: 42),
                    ])
            ],
          )),
    );
  }
}

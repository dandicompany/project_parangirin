import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/Video/videoTest.dart';
import 'package:paran_girin/layout/default_icon_button.dart';
import 'package:paran_girin/myPageDetail/privacy_policy.dart';
import 'package:paran_girin/onboarding/privacyPolicy.dart';
import 'package:paran_girin/question/question_post.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:paran_girin/models/schema.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class HomeAvatarBig extends StatefulWidget {
  State<StatefulWidget> createState() => _HomeAvatarBigState();
}

class _HomeAvatarBigState extends State<HomeAvatarBig> {
  FirebaseProvider fp;
  bool todayDone;

  void refresh() {
    if (todayDone) {
      setState(() {});
    }
  }

  void initState() {
    todayDone = false;
    Timer.periodic(Duration(seconds: 1), (Timer t) => refresh());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    DateTime now = DateTime.now();
    int nextLv = 0;
    while (true){
      if (fp.getUserInfo().currentChild.answers.containsKey(nextLv.toString())){
        nextLv += 1;
      } else {
        break;
      }
    }
    nextLv = min(nextLv,fp.getStaticInfo().questions.length -  1);

    String todayQid = (nextLv% fp.getStaticInfo().questions.length).toString();
    logger.d("-----------------------&&&SOS 이곳은 HomeAvatarBig &&&---------------------------");
    logger.d(todayQid);
    todayDone = fp.getUserInfo().currentChild.answers.containsKey(todayQid);

    int today =  DateTime.parse(
        DateFormat("yyyyMMdd").format(DateTime.now())).millisecondsSinceEpoch;
    
    if (!todayDone){
      for (var ans in fp.getStaticInfo().answers.values){
        if(DateTime.parse(
          DateFormat("yyyyMMdd").format(DateTime.fromMillisecondsSinceEpoch(ans.date))).millisecondsSinceEpoch == today){
          todayDone = true;
        }
      }
    }

    Question question = fp.getStaticInfo().questions[todayQid];
    logger.d(question.category);
    DateTime tomorrow = DateTime.parse(
        DateFormat("yyyyMMdd").format(now.add(Duration(days: 1))));
    Duration remainingTime = tomorrow.difference(now);

    int textMaxNum = 20;

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(
          alignment: Alignment(0.0, 0.85),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              child: Container(
                width: double.infinity,
                // height: ScreenUtil().setHeight(728),
                height: ScreenUtil().setHeight(812),
                child: Image.asset("assets/background/lv5.jpg",
                // child: Image.asset("assets/avatars/default_background.png",
                    fit: BoxFit.cover),
                // child: Lottie.asset("assets/avatars/default_background.png"),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(16.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: double.infinity,
                          // height: ScreenUtil().setHeight(74)
                          height: ScreenUtil().setHeight(50)),
                      Navigator.of(context).canPop()
                          ? IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: AppTheme.colors.base1,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              iconSize: ScreenUtil().radius(20),
                            )
                          : null,
                      Text(
                        todayDone ? "오늘의 질문에 이미 답변을 하셨네요" : "오늘의 질문",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(16),
                            color: AppTheme.colors.base2,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(15)),
                      // Expanded(
                      //  child: Text(
                        Text(
                          todayDone
                            ? "내일은 어떤 질문이\n기다리고 있을까요?"
                            : (question.question.length > textMaxNum 
                              ? '${question.question.substring(0, textMaxNum)}...' 
                              : question.question
                            ),
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            // color: todayDone ? AppTheme.colors.base2:AppTheme.colors.base1,
                            color: AppTheme.colors.base1,
                            fontWeight: FontWeight.w300
                          ),
                          // maxLines: 2,
                          // softWrap: true,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      // ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: ScreenUtil().setHeight(595),
                  child: Image.asset(
                    'assets/avatars/nod.gif',
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ],
            ),
            // 버튼에 겹쳐져서 안보임
            // GestureDetector(
            //   onTap: () {},
            //   child: Text(
            //     "새로운 질문을 추천해주세요!",
            //     style: TextStyle(
            //       // fontFamily: 'Noto Sans KR',
            //       fontSize: ScreenUtil().setSp(12),
            //       color: AppTheme.colors.base2
            //     ),
            //   )
            // ),
            todayDone
                ? ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(27)),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                      color: Colors.white,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: new TextSpan(
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(16),
                                color: AppTheme.colors.base1),
                            children: <TextSpan>[
                              new TextSpan(text: '새로운 질문이 생성되기까지\n'),
                              new TextSpan(
                                  text: remainingTime.inHours.toString(),
                                  style: new TextStyle(
                                      fontSize: ScreenUtil().setSp(20))),
                              new TextSpan(text: '시간 '),
                              new TextSpan(
                                  text: (remainingTime.inMinutes % 60).toString(),
                                  style: new TextStyle(
                                      fontSize: ScreenUtil().setSp(20))),
                              new TextSpan(text: '분 '),
                              new TextSpan(
                                  text: (remainingTime.inSeconds % 60).toString(),
                                  style: new TextStyle(
                                      fontSize: ScreenUtil().setSp(20))),
                              new TextSpan(text: '초 남았어요')
                            ]),
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(16.0)),
                    child: DefaultIconButton(
                        text: "추천 질문으로 대화하기",
                        icon: "assets/icons/camera.svg",
                        isInvert: true,
                        press: () async {
                          await fp.getFAnalytics().logEvent(name: 'button_click', parameters: <String, String>{'button': 'home/todayQuestion'});
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => Initialization(todayQid)));
                          Navigator.pushReplacement<void, void>(
                            context,MaterialPageRoute<void>(
                              //builder: (BuildContext context) => Initialization(today_qid)));
                              builder: (BuildContext context) => QuestionPost(
                                  tag: question.tag ?? "태그 없음",
                                  categoryTitle: question.category ?? "카테고리 없음",
                                  image: "assets/images/category_nature.png",
                                  qTitle: question.title ?? "제목 없음",
                                  question: question.question ?? "질문 없음",
                                  storyText: question.story ?? "스토리 없음",
                                  guide: question.guide ?? "가이드 없음",
                                  qid: question.qid.toString(),
                                  available: true,)));
                              //builder: (BuildContext context) => PrivacyPolicy2()));
                              // tag: question.tag ?? "태그 없음", --> hobin
                              //    categoryTitle: question.category ?? "카테고리 없음",
                              //    image: "assets/images/category_nature.png",
                              //    qTitle: question.title ?? "제목 없음",
                              //    question: question.question ?? "질문 없음",
                              //    storyText: question.story ?? "스토리 없음",
                              //    guide: question.guide ?? "가이드 없음",
                              //    qid: question.qid.toString())));
                              // // builder: (BuildContext context) => PrivacyPolicy2()));
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paran_girin/Video/videoTest.dart';
import 'package:paran_girin/layout/base_appbar.dart';
import 'package:paran_girin/layout/default_button.dart';
import 'package:paran_girin/layout/default_icon_button.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:provider/provider.dart';

class QuestionPost extends StatefulWidget {
  final String categoryTitle;
  final String image;
  final String qTitle;
  final String question;
  final String storyText;
  final String guide;
  final String qid;

  const QuestionPost(
      {Key key,
      this.categoryTitle,
      this.image,
      this.qTitle,
      this.question,
      this.storyText,
      this.guide,
      this.qid})
      : super(key: key);

  @override
  _QuestionPostState createState() => _QuestionPostState();
}

class _QuestionPostState extends State<QuestionPost> {
  ScrollController scrollController = ScrollController();
  FirebaseProvider fp;
  bool _storyVisible = false;
  bool _guideVisible = false;
  List<String> tags = [];

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    DateTime now = DateTime.now();
    String today_qid =
        (now.day % fp.getStaticInfo().questions.length).toString();
    bool todayDone = fp.getUserInfo().currentChild.answers.containsKey(today_qid);
    tags = "#말하기#의사소통#단어".split("#");
    logger.d(tags.length, tags);

    return Scaffold(
        appBar: BaseAppBar(title: widget.categoryTitle),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(100)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                // if (tags.length != 0){
                // tags.forEach( (x) => print(x));

                // }
              ],),
              Image.asset(
                  // widget.image,
                  _setImage(),
                  fit: BoxFit.cover),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.qTitle,
                      style: TextStyle(
                          color: AppTheme.colors.base1,
                          fontWeight: FontWeight.w300,
                          fontSize: ScreenUtil().setSp(14)),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(3)),
                    Text(
                      widget.question,
                      style: TextStyle(
                          color: AppTheme.colors.base1,
                          fontWeight: FontWeight.w300,
                          fontSize: ScreenUtil().setSp(21),
                          height: 1.4),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(33)),

                    // story drop down
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _storyVisible = !_storyVisible;
                        });
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            _storyVisible
                                ? "assets/icons/arrow-up.svg"
                                : "assets/icons/arrow-down.svg",
                            width: ScreenUtil().setWidth(24),
                            height: ScreenUtil().setHeight(24),
                          ),
                          Text(
                            " 스토리",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(18),
                                color: AppTheme.colors.primary2),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: AppTheme.colors.primary4,
                      thickness: 1,
                    ),
                    SizedBox(height: ScreenUtil().setHeight(6)),
                    Visibility(
                      visible: _storyVisible,
                      child: Text(
                        widget.storyText + "\n\n",
                        style: TextStyle(
                            color: AppTheme.colors.base1,
                            fontSize: ScreenUtil().setSp(14),
                            height: 1.6),
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    // guide drop down
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _guideVisible = !_guideVisible;
                        });
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            _guideVisible
                                ? "assets/icons/arrow-up.svg"
                                : "assets/icons/arrow-down.svg",
                            width: ScreenUtil().setWidth(24),
                            height: ScreenUtil().setHeight(24),
                          ),
                          Text(
                            " 부모님 가이드",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(18),
                                color: AppTheme.colors.primary2),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: AppTheme.colors.primary4,
                      thickness: 1,
                    ),
                    SizedBox(height: ScreenUtil().setHeight(6)),
                    Visibility(
                      visible: _guideVisible,
                      child: Text(
                        widget.guide + "\n\n",
                        style: TextStyle(
                            color: AppTheme.colors.base1,
                            fontSize: ScreenUtil().setSp(14),
                            height: 1.6),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(34)),

              // camera button
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
                child: todayDone 
                  ? DefaultIconButton(
                    text: "파란 기린과 대화하기 ",
                    isInvert: false,
                    press: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Initialization(widget.qid)));
                    })
                  : DefaultButton(
                    text: "이미 대답한 질문이에요",
                    color: AppTheme.colors.base3,
                    press: (){
                    }
                    // color: const Color.fromRGBO(163, 163, 163, 1),
                  )
              )
            ],
          ),
        ));
  }

  String _setImage() {
    switch (widget.categoryTitle) {
      case '사회관계':
        return 'assets/images/category_society.png';
      case '자연탐구':
        return 'assets/images/category_nature.png';
      case '예술':
        return 'assets/images/category_art.png';
      case '신체':
        return 'assets/images/category_body.png';
      case '의사소통':
        return 'assets/images/category_communication.png';
      default:
        return 'assets/images/category_society.png';
    }
  }
}

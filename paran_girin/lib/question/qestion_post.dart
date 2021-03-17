import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paran_girin/Video/videoTest.dart';
import 'package:paran_girin/layout/base_appbar.dart';
import 'package:paran_girin/layout/default_icon_botton.dart';
import 'package:paran_girin/theme/app_theme.dart';

class QuestionPost extends StatefulWidget {
  final String categoryTitle;
  final String image;
  final String qTitle;
  final String question;
  final String storyText;
  final String guide;

  const QuestionPost({Key key, this.categoryTitle, this.image, this.qTitle, this.question, this.storyText, this.guide}) : super(key: key);

  @override
  _QuestionPostState createState() => _QuestionPostState();
}

class _QuestionPostState extends State<QuestionPost> {
  ScrollController scrollController = ScrollController();
  bool _storyVisible = false;
  bool _guideVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title : widget.categoryTitle),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: ScreenUtil().setHeight(100)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              widget.image,
              fit: BoxFit.cover
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(22)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.qTitle,
                    style: TextStyle(
                      color: AppTheme.colors.base1,
                      fontWeight: FontWeight.w300,
                      fontSize: ScreenUtil().setSp(14)
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(3)),
                  Text(
                    widget.question,
                    style: TextStyle(
                      color: AppTheme.colors.base1,
                      fontWeight: FontWeight.w300,
                      fontSize: ScreenUtil().setSp(21)
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(33)),

            // story drop down
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        _storyVisible = !_storyVisible;
                      });
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          _storyVisible ? "assets/icons/arrow-up.svg" : "assets/icons/arrow-down.svg",
                          width: ScreenUtil().setWidth(24),
                          height: ScreenUtil().setHeight(24),
                        ),
                        Text(
                          " 스토리",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(18),
                            color: AppTheme.colors.primary2
                          ),
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
                      widget.storyText,
                      style: TextStyle(
                        color: AppTheme.colors.base1,
                        fontSize: ScreenUtil().setSp(14)
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
            // guide drop down
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        _guideVisible = !_guideVisible;
                      });
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          _guideVisible ? "assets/icons/arrow-up.svg" : "assets/icons/arrow-down.svg",
                          width: ScreenUtil().setWidth(24),
                          height: ScreenUtil().setHeight(24),
                        ),
                        Text(
                          " 부모님 가이드",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(18),
                            color: AppTheme.colors.primary2
                          ),
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
                      widget.guide,
                      style: TextStyle(
                        color: AppTheme.colors.base1,
                        fontSize: ScreenUtil().setSp(14)
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(34)),

          // camera button
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(16)
              ),
              child: DefaultIconButton(
                text: "파란 기린과 대화하기 ",
                isInvert: false,
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Initialization()));
                }
              ),
            )
          ],
        ),
      )
    );
  }
}
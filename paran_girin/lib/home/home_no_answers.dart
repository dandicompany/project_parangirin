import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/layout/base_appbar.dart';
import 'package:paran_girin/theme/app_theme.dart';

class HomeNoAnswers extends StatefulWidget {
  @override
  _HomeNoAnswersState createState() => _HomeNoAnswersState();
}

class _HomeNoAnswersState extends State<HomeNoAnswers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: "우리 아이 뽐내기",),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: ScreenUtil().setHeight(212)
          ),
          Container(
            width: ScreenUtil().setWidth(132),
            height: ScreenUtil().setHeight(132),
            child: Image.asset(
              "assets/images/embarassed_sweat 1.png",
              fit: BoxFit.cover
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: ScreenUtil().setHeight(34)
          ),    
          Text(
            "아직 생성된 대화가 없어요\n파란기린과 첫 번째 대화를 시작해보세요.",
            style: TextStyle(
              color: AppTheme.colors.base2,
              fontSize: ScreenUtil().setSp(16),
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ]
      ),
    );
  }
}
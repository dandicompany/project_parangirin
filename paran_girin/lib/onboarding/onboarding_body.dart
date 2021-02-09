import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/Video/videoTest.dart';
import 'package:paran_girin/layout/default_botton.dart';
import 'package:paran_girin/login/login_page.dart';
import 'package:paran_girin/onboarding/onboard_content.dart';
import 'package:paran_girin/theme/app_theme.dart';

class OnboardingBody extends StatefulWidget {
  @override
  _OnboardingBodyState createState() => _OnboardingBodyState();
}

class _OnboardingBodyState extends State<OnboardingBody> {
  int currentPage = 0;
  List<Map<String, String>> onboardText= [
    {
      "text1": "아이와의 대화!",
      "text2": "\n어떻게 하고 있나요?",
    },
    {
      "text1": "매일 새롭게",
      "text2": "\n업로드 되는 파란기린의 질문",
    },
    {
      "text1": "우리 아이의 성장 기록",
      "text2": "\n촬영하고 저장하고 공유하세요",
    },
    {
      "text1": "아주 쉬워요!",
      "text2": "\n이제 파란기린과 여행을 떠나봐요",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(100), 
          left: ScreenUtil().setWidth(16),
          right: ScreenUtil().setWidth(16),),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                }, 
                itemCount: onboardText.length,
                itemBuilder: (context, index) => OnboardContent(
                  text1: onboardText[index]["text1"],
                  text2: onboardText[index]["text2"],
                  image: "assets/images/onboard_$index.png",
                ),
              )
            ),
            Expanded(
              flex: 5,
              child: Column(
                children: <Widget>[
                  Spacer(flex: 1,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardText.length, (index) => buildDot(index: index)
                    ),
                  ),
                  Spacer(flex: 1,),
                  DefaultButton(
                    text: "바로 시작하기",
                    press: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        // builder: (context) => Initialization()));
                        builder: (context) => Initialization()));
                    },
                    //LoginPage()
                  ),
                  Spacer(flex: 1,),
                  //LoginPage()
                ],
            ),
          )
        ],
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 8),
      height: ScreenUtil().setHeight(8),
      width: ScreenUtil().setWidth(8),
      decoration: BoxDecoration(
        color: currentPage == index ? AppTheme.colors.primary2 : AppTheme.colors.primary4,
        borderRadius: BorderRadius.circular(3)),
    );
  }
  
}



  
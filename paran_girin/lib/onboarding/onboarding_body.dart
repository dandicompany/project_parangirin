import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/layout/default_button.dart';
import 'package:paran_girin/onboarding/onboard_content.dart';
import 'package:paran_girin/onboarding/privacyPolicy.dart';
import 'package:paran_girin/theme/app_theme.dart';

import '../login/auth_page.dart';

// void permission() async {
//   Map<Permission, PermissionStatus> permissions =
//       await [Permission.camera].request();
//   print('per1 : $permissions');
// }

class OnboardingBody extends StatefulWidget {
  @override
  _OnboardingBodyState createState() => _OnboardingBodyState();
}

class _OnboardingBodyState extends State<OnboardingBody> {
  int currentPage = 0;
  List<Map<String, String>> onboardText = [
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
    // permission();
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil().setHeight(100),
        // left: ScreenUtil().setWidth(16),
        // right: ScreenUtil().setWidth(16),
      ),
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
                  image: "assets/onboarding/onboard_$index.gif",
                ),
              )),
          Expanded(
            flex: 5,
            child: Column(
              children: <Widget>[
                Spacer(
                  flex: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      onboardText.length, (index) => buildDot(index: index)),
                ),
                Spacer(
                  flex: 1,
                ),
                (currentPage == 3)
                  ? DefaultButton(
                    text: "바로 시작하기",
                    press: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          // builder: (context) => Initialization()));
                          // builder: (context) => textToSpeech()));
                          builder: (context) => PrivacyPolicy2()));
                          //builder: (context) => AuthPage())); --> hobin
                    }
                  )
                  : GestureDetector(
                      onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PrivacyPolicy2()));
                    },
                      child: Text(
                        "건너뛰기",
                        style: TextStyle(
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(14),
                          decoration: TextDecoration.underline,
                          color: AppTheme.colors.base2,
                        ),
                      )
                  ),
                Spacer(
                  flex: 1,
                ),
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
          color: currentPage == index
              ? AppTheme.colors.primary2
              : AppTheme.colors.primary4,
          borderRadius: BorderRadius.circular(3)),
    );
  }
}

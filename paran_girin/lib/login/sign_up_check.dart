import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/layout/default_botton.dart';
import 'package:paran_girin/login/baby_info.dart';
import 'package:paran_girin/login/login_body.dart';
import 'package:paran_girin/login/login_page.dart';

class SignUpCheck extends StatefulWidget {
  @override
  _SignUpCheckState createState() => _SignUpCheckState();
}

class _SignUpCheckState extends State<SignUpCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Body(),
      body: Column(
        children: [
          LoginBody(
            title: "환영합니다!",
            description: " ",
            actionText: " ",
            loginInfo: "확인을 위해\n한 번 더 비밀번호를 입력해주세요",
            isEmail: false,
            textPress: () {
              Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginPage()));
            }
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
            child: DefaultButton(
              text: "다음",
              press: () {
                Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BabyInfo()));
              },
            ),
          )
        ],
      ),
    );
  }
}
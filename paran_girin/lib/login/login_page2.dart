import 'package:flutter/material.dart';
import 'package:paran_girin/login/baby_info.dart';
import 'package:paran_girin/login/login_body.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LoginPage2 extends StatefulWidget {
  const LoginPage2({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPage2State createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  @override
  Widget build(BuildContext context) {
  //  printScreenInformation();
  return Scaffold(
      // body: Body(),
      body: LoginBody(
        title: "샐리, 참 오랜만이에요!",
        description: "혹시 비밀번호를 잊으셨나요? 비밀번호 찾기",
        loginInfo: "이어서 비밀번호를 입력하고\n로그인을 완료하세요",
        isEmail: false,
      ),
    );
  }
}
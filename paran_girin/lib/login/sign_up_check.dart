import 'package:flutter/material.dart';
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
      body: LoginBody(
        title: "환영합니다!",
        description: "앗, 이미 등록되어 있는 회원이신가요? ",
        actionText: "이전으로 돌아가기",
        loginInfo: "확인을 위해\n한 번 더 비밀번호를 입력해주세요",
        isEmail: false,
        textPress: () {
          Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginPage()));
        },
        buttonPress: () {
          Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BabyInfo()));
        },
      ),
    );
  }
}
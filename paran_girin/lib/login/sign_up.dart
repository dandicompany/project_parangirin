import 'package:flutter/material.dart';
import 'package:paran_girin/login/login_body.dart';
import 'package:paran_girin/login/login_page.dart';
import 'package:paran_girin/login/sign_up_check.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
  //  printScreenInformation();
  return Scaffold(
      // body: Body(),
      body: LoginBody(
        title: "환영합니다!",
        description: "앗, 이미 등록되어 있는 회원이신가요? ",
        actionText: "이전으로 돌아가기",
        loginInfo: "가입을 위해 6자리 이상의\n새로운 비밀번호를 입력해 주세요",
        isEmail: false,
        textPress: () {
          Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginPage()));
        },
        buttonPress: () {
          Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SignUpCheck()));
        },
      ),
    );
  }
}
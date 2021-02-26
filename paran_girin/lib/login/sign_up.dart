import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/layout/default_botton.dart';
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
      body: Column(
        children: [
          LoginBody(
            title: "환영합니다!",
            description: " ",
            actionText: " ",
            loginInfo: "가입을 위해\n새로운 비밀번호를 입력해 주세요",
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
                        builder: (context) => SignUpCheck()));
              },
            ),
          )
        ],
      ),
    );
  }
}
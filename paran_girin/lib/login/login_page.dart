import 'package:flutter/material.dart';
import 'package:paran_girin/layout/default_botton.dart';
import 'package:paran_girin/login/email_check.dart';
import 'package:paran_girin/login/login_body.dart';
import 'package:paran_girin/login/login_page2.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: Column(
        children: [
          LoginBody(
            title: "파란기린은\n당신을 환영해요!",
            description: "",
            actionText: "",
            loginInfo: "로그인 혹은 회원가입을 위해\n이메일을 입력해 주세요",
            isEmail: true,
            textPress: () {},
          ),
          _loginSNSText(),
          SizedBox(height: ScreenUtil().setHeight(15)),
          Container(
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget> [ 
                _facebookButton(),
                _googleButton(),
              ]
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(60)),
          Container(
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
            child: DefaultButton(
              text: "다음",
              // for New user
              // press: () {
              //   Navigator.of(context).push(MaterialPageRoute(
              //           builder: (context) => EmailCheck()));
              // },

              // for existing user (if account is already existent)

              press: () {
                Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginPage2()));
              },
            ),
          )
        ],
      ),
    );
  }
}

Widget _loginSNSText() {
  return Container(
    alignment: Alignment.topLeft,
    height: ScreenUtil().setHeight(20),
    padding: EdgeInsets.only(
      left: ScreenUtil().setWidth(16),
      right: ScreenUtil().setWidth(16),
    ),
    child: Container(
      width: ScreenUtil().setWidth(180),
      child: 
        Align(
          alignment: Alignment.bottomRight,
          child: Text('혹은 SNS 계정으로 함께 해요',
            style: TextStyle(
            // fontFamily: 'Noto Sans KR',
            fontWeight: FontWeight.w500,
            fontSize: ScreenUtil().setSp(14)),
          ),
        ),
    ),
  );
}

Widget _facebookButton() {
  return Ink(
    decoration: ShapeDecoration(
      color: Colors.white,
      shape: CircleBorder(),
      ),
      child: IconButton(
        icon: Icon(Icons.ac_unit),
        iconSize: 40.0,  // * screenUtil 씌워줘야함
        onPressed: (){},
      )
  
  );
}

Widget _googleButton() {
  return Ink(
    decoration: ShapeDecoration(
      color: AppTheme.colors.base3,
      shape: CircleBorder(),
      ),
      child: IconButton(
        icon: Icon(Icons.access_alarm),
        iconSize: 40.0,  // * screenUtil 씌워줘야함
        onPressed: (){},
      )
  
  );
}


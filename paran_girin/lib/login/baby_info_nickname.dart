import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/layout/default_button.dart';
import 'package:paran_girin/login/baby_info_birth.dart';
import 'package:paran_girin/theme/app_theme.dart';

class BabyInfoNickname extends StatefulWidget {
  final String name;
  BabyInfoNickname(this.name);
  @override
  _BabyInfoNicknameState createState() => _BabyInfoNicknameState(this.name);
}

class _BabyInfoNicknameState extends State<BabyInfoNickname> {
  String name;
  TextEditingController _nickCon = TextEditingController();
  _BabyInfoNicknameState(this.name);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: ScreenUtil().setWidth(96),
            left: ScreenUtil().setWidth(16),
            right: ScreenUtil().setWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "아이의 이름은 김기린이에요",
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(16.0),
                  fontWeight: FontWeight.w300,
                  color: AppTheme.colors.base2),
            ),
            SizedBox(
                width: double.infinity, height: ScreenUtil().setHeight(86)),
            Text(
              "아이의 별명을 알려주세요",
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(18.0),
                  fontWeight: FontWeight.w400,
                  color: AppTheme.colors.base1),
            ),
            SizedBox(height: ScreenUtil().setHeight(6)),
            Text(
              "파란기린은 아이를 별명으로 부르며 대화할거에요",
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(14.0),
                  fontWeight: FontWeight.w400,
                  color: AppTheme.colors.base2),
            ),
            SizedBox(height: ScreenUtil().setHeight(32)),
            TextField(
              controller: _nickCon,
              decoration: InputDecoration(
                  hintText: "꿈돌이",
                  hintStyle: TextStyle(fontSize: ScreenUtil().setSp(18))),
              keyboardType: TextInputType.name,
              // obscureText: true, // for password
            ),
            SizedBox(height: ScreenUtil().setHeight(50)),
            DefaultButton(
              text: "다음",
              press: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => BabyInfoBirth(name, _nickCon.text)));
              },
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/layout/default_botton.dart';
import 'package:paran_girin/login/baby_info_confirm.dart';
import 'package:paran_girin/theme/app_theme.dart';

class BabyInfoBirth extends StatefulWidget {
  @override
  _BabyInfoBirthState createState() => _BabyInfoBirthState();
}

class _BabyInfoBirthState extends State<BabyInfoBirth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: ScreenUtil().setWidth(92),
          left: ScreenUtil().setWidth(16),
          right: ScreenUtil().setWidth(16)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "아이의 이름은 김기린이에요\n파란기린은 아이를 꿈돌이라고 부를게요",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(16.0),
                fontWeight: FontWeight.w300,
                color: AppTheme.colors.base2
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(86)),
            Text(
              "아이의 생년월일을 알려주세요",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(18.0),
                fontWeight: FontWeight.w400,
                color: AppTheme.colors.base1
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(6)),
            Text(
              "아이의 연령에 맞는 이야기를 준비해둘게요",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(14.0),
                fontWeight: FontWeight.w400,
                color: AppTheme.colors.base2
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(39)),
            TextField(
              decoration: InputDecoration(
                hintText: "꿈돌이", 
                hintStyle: TextStyle(
                  fontSize: ScreenUtil().setSp(18)
                )
              ),
              keyboardType: TextInputType.name,
            // obscureText: true, // for password
            ),
            SizedBox(height: ScreenUtil().setHeight(50)),
            DefaultButton(
              text: "가입 완료하기",
              press: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BabyInfoConfirm()));
              },
            )
          ],
        ),
      ),
    );
  }
}
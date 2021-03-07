import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/layout/default_botton.dart';
import 'package:paran_girin/login/baby_info_name.dart';
import 'package:paran_girin/login/baby_info_profile.dart';
import 'package:paran_girin/theme/app_theme.dart';

class BabyInfoConfirm extends StatefulWidget {
  @override
  _BabyInfoConfirmState createState() => _BabyInfoConfirmState();
}

class _BabyInfoConfirmState extends State<BabyInfoConfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: ScreenUtil().setWidth(64),
          left: ScreenUtil().setWidth(16),
          right: ScreenUtil().setWidth(16)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "추가하고 싶은 자녀가 있나요? ",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                    color: AppTheme.colors.base2
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BabyInfoName()));
                  },
                  child: Text(
                    "자녀 추가하기",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: ScreenUtil().setSp(14),
                      color: AppTheme.colors.primary2
                    ),
                  )
                )
              ],
            ),
            SizedBox(height: ScreenUtil().setHeight(101)),
            Text(
              "아이의 이름은 김기린이에요\n\n파란기린은 아이를 꿈돌이라고 부를게요\n\n꿈돌이는 1998년 8월 3일에 태어났어요",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(16.0),
                fontWeight: FontWeight.w300,
                color: AppTheme.colors.base1
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(96)),
            DefaultButton(
              text: "가입 완료하기",
              press: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BabyInfoProfile()));
              },
            )
          ],
        ),
      ),
    );
  }
}
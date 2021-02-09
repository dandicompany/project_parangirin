import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:paran_girin/theme/app_theme.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 150),
      child: Container(
        width: double.infinity,
        color: AppTheme.colors.background,
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                HomeAvatar(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "생각 뽐내기",
                        style: TextStyle(
                          color: AppTheme.colors.base1,
                          fontWeight: FontWeight.w700,
                          fontSize: ScreenUtil().setSp(18)
                        ),
                      ),
                      Text(
                        "2021년 2월 둘째 주",
                        style: TextStyle(
                          color: AppTheme.colors.base2,
                          fontSize: ScreenUtil().setSp(12)
                        ),
                      )
                    ],
                  ),
                )
                
              ],
            ),
          ]
        )
      ),
    );
  }
}

class HomeAvatar extends StatelessWidget {
  const HomeAvatar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: ScreenUtil().setHeight(488),
          child: Image.asset("assets/avatars/default_background.png"),
          // child: Lottie.asset("assets/avatars/default_background.png"),
        ),
        Container(
          width: ScreenUtil().setWidth(396),
          height: ScreenUtil().setHeight(396),
          child: Lottie.asset('assets/avatars/lurking-cat.json'),
        ),
      ],
    );
  }
}
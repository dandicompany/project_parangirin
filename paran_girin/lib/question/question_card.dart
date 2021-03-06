import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paran_girin/theme/app_theme.dart';

class QuestionCard extends StatelessWidget {
  final VoidCallback onTap;
  final String qTitle;
  final String qDescription;
  final bool isDone;

  const QuestionCard({Key key, this.onTap, this.qTitle, this.qDescription, this.isDone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(82),
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(16),
        vertical: ScreenUtil().setHeight(19),
      ),
      child: InkWell(
      // child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // SvgPicture.asset(
            //   isDone ? "assets/icons/check-circle.svg" : "assets/icons/circle.svg",
            //   width: ScreenUtil().setWidth(24),
            //   height: ScreenUtil().setHeight(24),
            // ),
            Image.asset(
                isDone ? "assets/icons/check-circle.png" : "assets/icons/circle.png",
                width: ScreenUtil().setWidth(24),
                height: ScreenUtil().setHeight(24),
                fit: BoxFit.cover
              ),
            Container(
              width: ScreenUtil().setWidth(280),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    qTitle,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(18),
                      color: AppTheme.colors.base1
                    ),
                  ),
                  Text(
                    qDescription,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(12),
                      color: AppTheme.colors.base3
                    ),
                  )
                ],
              ),
            ),
            SvgPicture.asset(
              "assets/icons/arrow-right.svg",
              width: ScreenUtil().setWidth(6),
              height: ScreenUtil().setHeight(12),
            ),
          ],
        )
      ),
    );
  }
}
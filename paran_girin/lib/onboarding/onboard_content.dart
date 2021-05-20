import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/theme/app_theme.dart';


class OnboardContent extends StatelessWidget {
  const OnboardContent({
    Key key, 
    this.text1, 
    this.text2, 
    this.image, 
  }) : super(key: key);
  final String text1, text2, image;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(16),
              right: ScreenUtil().setWidth(16),
            ),
            child: RichText(
            text: new TextSpan(
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: ScreenUtil().setSp(24)
              ),
              children: <TextSpan>[
                new TextSpan(text: text1,
                  style: new TextStyle(color: AppTheme.colors.primary2,)),
                new TextSpan(text: text2,
                  style: new TextStyle(color: AppTheme.colors.base2,))
              ],
            )
        ),
          ),
        Spacer(flex: 1,),
        Image.asset(
          image,
          height: ScreenUtil().setHeight(363),
          width: ScreenUtil().setWidth(363),
          fit: BoxFit.fitWidth,
          alignment: Alignment(0.0, -0.4),
        )
      ],
    );
  }
}
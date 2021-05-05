import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/theme/app_theme.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key, 
    this.text, 
    this.isInvert = false,
    this.color = const Color.fromRGBO(67, 153, 255, 1), // same as AppTheme.colors.primary2
    // this.color = AppTheme.colors.primary2,
    this.press,
  }) : super(key: key);
  final String text;
  final bool isInvert;
  final Function press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    Color main;
    if (color == const Color.fromRGBO(67, 153, 255, 1))
      main = AppTheme.colors.primary2;
    else
      main = this.color;
      
    return SizedBox(
      width: ScreenUtil().setWidth(343),
      height: ScreenUtil().setHeight(54),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: isInvert? Colors.white: main,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.w500,
            color: isInvert? main : Colors.white
          ),
        ),
      ),
    );
  }
}
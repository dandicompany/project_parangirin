import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/theme/app_theme.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key, 
    this.text, 
    this.isInvert = false,
    this.press,
  }) : super(key: key);
  final String text;
  final bool isInvert;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtil().setWidth(343),
      height: ScreenUtil().setHeight(54),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: isInvert? Colors.white: AppTheme.colors.primary2,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.w500,
            color: isInvert? AppTheme.colors.primary2 : Colors.white
          ),
        ),
      ),
    );
  }
}
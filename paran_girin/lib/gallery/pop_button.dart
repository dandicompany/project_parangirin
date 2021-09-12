
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:paran_girin/theme/app_theme.dart';

class PopButton extends StatelessWidget{
  final String title;
  final BorderRadius borderRadius;
  final VoidCallback onTap; 
  Color textColor = AppTheme.colors.base1; 
  double opacity;
   
  PopButton({
    this.title, 
    this.borderRadius,
    this.onTap,
    this.textColor,
    this.opacity
  });

  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: onTap, 
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          width: ScreenUtil().setWidth(360),
          height: ScreenUtil().setHeight(55),
          alignment: Alignment.center,
          color: Color.fromRGBO(255, 255, 255, opacity),
          child: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: ScreenUtil().setSp(18),
              fontWeight: FontWeight.w400
            ),
          )
        ),
      )
    );
  }
}
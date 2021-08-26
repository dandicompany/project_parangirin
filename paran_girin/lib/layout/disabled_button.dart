import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/theme/app_theme.dart';

class DisabledButton extends StatelessWidget {
  const DisabledButton({
    Key key, 
    this.text, 
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    Color color = AppTheme.colors.base2;
      
    return SizedBox(
      width: ScreenUtil().setWidth(343),
      height: ScreenUtil().setHeight(54),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Container(
          color: color,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(18),
                fontWeight: FontWeight.w500,
                color: Colors.white
              ),
            ),
          ),
        ),
      ),
    );
  }
}
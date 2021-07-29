import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paran_girin/theme/app_theme.dart';

class DefaultIconButton extends StatelessWidget {
  const DefaultIconButton({
    Key key, 
    this.text, 
    this.icon = "assets/icons/camera.svg",
    this.isInvert = false,
    this.press,
  }) : super(key: key);
  final String text, icon;
  final bool isInvert;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtil().setWidth(343),
      height: ScreenUtil().setHeight(54),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          primary: isInvert? Colors.white: AppTheme.colors.primary2,
          shadowColor: Color.fromRGBO(0, 0, 0, 0.15)
        ),
        onPressed: press,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(50.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                icon,
                color: isInvert? AppTheme.colors.primary2 : Colors.white,
                width: ScreenUtil().setWidth(24),
                height: ScreenUtil().setHeight(24),
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(18),
                  fontWeight: FontWeight.w500,
                  color: isInvert? AppTheme.colors.primary2 : Colors.white
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paran_girin/theme/app_theme.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtil().setWidth(120),
      height: ScreenUtil().setHeight(120),
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/thumbnail_baby.png"),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: SizedBox(
              width: ScreenUtil().setWidth(28),
              height: ScreenUtil().setHeight(28),
              child: FlatButton(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(
                    color: AppTheme.colors.base1,
                  )
                ),
                color: Colors.white,
                onPressed: () {}, 
                child: SvgPicture.asset(
                  "assets/icons/camera.svg",
                  color: AppTheme.colors.base1,)
              ),
            ),
          )
        ],
      )
    );
  }
}
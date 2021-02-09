import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key, 
    this.text, 
    this.press,
  }) : super(key: key);

  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(23)),
      color: Colors.white,
      height: ScreenUtil().setHeight(48),
      onPressed: press,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(14)),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: ScreenUtil().radius(12),
          )
        ],
      )
    );
  }
}
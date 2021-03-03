import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/theme/app_theme.dart';


class CustomElevation extends StatelessWidget {
  final Widget child;
  final String text1;
  final String text2;

  CustomElevation({@required this.child, @required this.text1, @required this.text2}) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(164),
      height: ScreenUtil().setHeight(71),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.2), width: 0.5),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.04),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [

              SizedBox(width: ScreenUtil().setWidth(4)),
              Text(text1, style: TextStyle(fontSize: 24, color: Colors.black,fontFamily: 'Noto Sans KR' ),),
              SizedBox(width: ScreenUtil().setWidth(17)),
              Text(text2, style: TextStyle(fontSize: 12, color: Colors.black,fontFamily: 'Noto Sans KR' ),),
            ]
          ),
          this.child,
        ]
      ),
    );
  }
}
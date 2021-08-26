import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
              mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: ScreenUtil().setHeight(3)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: ScreenUtil().setWidth(12),),
                  Text(text1, style: TextStyle(fontSize: 18, color: Colors.black,fontFamily: 'Noto Sans KR' ),),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(15),),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: ScreenUtil().setWidth(12)),
                  Text(text2, style: TextStyle(fontSize: 12, color: Colors.black,fontFamily: 'Noto Sans KR' ),),
                ],
              ),
            ]
          ),
          this.child,
        ]
      ),
    );
  }
}
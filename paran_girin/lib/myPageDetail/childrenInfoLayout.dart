import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class childrenInfoLayout extends StatelessWidget {
  const childrenInfoLayout({
    Key key,
    this.image,
    this.text,
    this.text2,
    this.press,
  }) : super(key: key);

  final String image;
  final String text;
  final String text2;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(23)),
        color: Colors.white,
        height: ScreenUtil().setHeight(64),
        onPressed: press,
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(image,height: 47, width: 41,),
            SizedBox(width: ScreenUtil().setWidth(16)),
            Container(
              width: 102,
              height: 22,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(text, style: TextStyle(fontSize: ScreenUtil().setSp(18), fontFamily: 'Noto Sans KR',),),
                  Text(text2,style: TextStyle(fontSize: ScreenUtil().setSp(12),fontFamily: 'Noto Sans KR',),),
                ],
              )
            ),

          ],
        ),
    );
  }
}

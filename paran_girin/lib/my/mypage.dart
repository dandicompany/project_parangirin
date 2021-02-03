import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(488),
          left: ScreenUtil().setWidth(16),
          right: ScreenUtil().setWidth(16),
        ),
        child: Column(
          children: [
            Text('myPage'),
            // _buildProfile(context),
            // SizedBox(height: ScreenUtil().setHeight(41)),
            // _buildAccountInfo(context)
          ],
        ),
      ),
    );
  }
}
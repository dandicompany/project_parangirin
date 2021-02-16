import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      // Container(
      //   padding: EdgeInsets.only(
      //     top: ScreenUtil().setHeight(488),
      //     left: ScreenUtil().setWidth(16),
      //     right: ScreenUtil().setWidth(16),
      //   child: 
        Column(
          children: [
            Container(
              width: double.infinity,
              height: ScreenUtil().setHeight(750),
              color: Colors.red,
            ),
            Container(
              width: double.infinity,
              height: ScreenUtil().setHeight(62),
              color: Colors.red,
            ),
            
            // Text('QuestionPage'),
            // _buildProfile(context),
            // SizedBox(height: ScreenUtil().setHeight(41)),
            // _buildAccountInfo(context)
          ],
        ),
    //  ),
    );
  }
}
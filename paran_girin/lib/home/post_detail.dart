import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:paran_girin/theme/app_theme.dart';

class PostDetail extends StatefulWidget {
  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: ScreenUtil().setHeight(331),
            color: Colors.black,
          ),
          SizedBox(height: ScreenUtil().setHeight(28)),
          Text(
            "세상에 없던 새로운 대답, 계란",
            // title,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(24),
            )
          ),
          SizedBox(height: ScreenUtil().setHeight(36)),
          Text(
            "타임캡슐에 담고 싶은 나의 물건은?",
            // question,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(16),
              fontWeight: FontWeight.w500,
              color: AppTheme.colors.primary2
            ),
          )
        ],
      ),
    );
  }
}
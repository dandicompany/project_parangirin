import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/layout/base_appbar.dart';
import 'package:paran_girin/layout/default_botton.dart';
import 'package:paran_girin/my/profile_menu.dart';
import 'package:paran_girin/myPageDetail/childrenInfoLayout.dart';
import 'package:paran_girin/myPageDetail/childrenInfoLayout2.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:paran_girin/login/baby_info_name.dart';

final String chosen = "(으)로 접속중";
final String notchosen = "(으)로 접속하기";

class childrenInfo extends StatefulWidget {
  @override
  _ChildInfoState createState() => _ChildInfoState();
}

class _ChildInfoState extends State<childrenInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(150)),
        child: Container(
          width: double.infinity,
          color: AppTheme.colors.background,
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(0),
            left: ScreenUtil().setWidth(16),
            right: ScreenUtil().setWidth(16),
          ),
          child: Column(
            children: [
              BaseAppBar(
                title: "자녀 관리",
              ),
              SizedBox(height: ScreenUtil().setHeight(30)),
              childrenInfoLayout(
                image: "assets/images/onboard_1.png",
                text: "샐리",
                text2: chosen,
                press: () {},
              ),
              SizedBox(height: ScreenUtil().setHeight(8)),
              childrenInfoLayout2(
                image: "assets/images/onboard_1.png",
                text: "유진",
                text2: notchosen,
                press: () {},
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        //elevation: 4.0,
        //shape: _CustomBorder(),
        //icon: const Icon(Icons.add),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        label: Text(
          '                        자녀 추가하기                        ',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: ScreenUtil().setSp(16),
          ),
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BabyInfoName()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/my/profile_menu.dart';
import 'package:paran_girin/my/profile_pic.dart';
import 'package:paran_girin/myPageDetail/Notice.dart';
import 'package:paran_girin/myPageDetail/about_parangirin.dart';
import 'package:paran_girin/myPageDetail/childrenInfo.dart';
import 'package:paran_girin/myPageDetail/privacy_policy.dart';
import 'package:paran_girin/myPageDetail/send_comments.dart';
import 'package:paran_girin/myPageDetail/terms_conditions.dart';
import 'package:paran_girin/theme/app_theme.dart';
import 'package:paran_girin/login/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:paran_girin/myPageDetail/pushAlarm.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  FirebaseProvider fp;
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(150)),
        child: Container(
          width: double.infinity,
          color: AppTheme.colors.background,
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(60),
            left: ScreenUtil().setWidth(16),
            right: ScreenUtil().setWidth(16),
          ),
          child: Column(
            children: [
              Text(
                "프로필",
                style: TextStyle(
                    color: AppTheme.colors.base1,
                    fontSize: ScreenUtil().setSp(16)),
              ),
              SizedBox(height: ScreenUtil().setHeight(30)),
              ProfilePic(),
              SizedBox(height: ScreenUtil().setHeight(16)),
              Text(
                "샐리",
                style: TextStyle(fontSize: ScreenUtil().setSp(18)),
              ),
              SizedBox(height: ScreenUtil().setHeight(41)),
              ProfileMenu(
                  text: "자녀 관리",
                  press: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChildrenInfo()));
                  }),
              ProfileMenu(
                  text: "알림 설정",
                  press: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => pushAlarm()));
                  }),
              SizedBox(height: ScreenUtil().setHeight(16)),
              ProfileMenu(
                  text: "공지 사항",
                  press: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Notice()));
                  }),
              ProfileMenu(
                  text: "의견 보내기",
                  press: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SendComments()));
                  }),
              ProfileMenu(
                text: "파란 기린 소개", 
                press: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AboutParanGirin()));
                  }),
              SizedBox(height: ScreenUtil().setHeight(16)),
              ProfileMenu(
                  text: "이용약관",
                  press: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TermsConditions()));
                  }),
              ProfileMenu(
                  text: "개인 정보 처리 방침", 
                  press: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PrivacyPolicy()));
                  }),
              ProfileMenu(text: "도움말", press: () {}),
              ProfileMenu(
                  text: "로그아웃",
                  press: () {
                    fp.signOut();
                    Navigator.of(context).pop();
                  }),
              SizedBox(height: ScreenUtil().setHeight(16)),
              // version information
              Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(23)),
                  color: Colors.white,
                  width: double.infinity,
                  height: ScreenUtil().setHeight(48),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "버전 정보",
                          style: TextStyle(fontSize: ScreenUtil().setSp(14)),
                        ),
                        RichText(
                          text: new TextSpan(
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(14)),
                              children: <TextSpan>[
                                new TextSpan(
                                    text: '현재 최신 버전입니다 ',
                                    style: new TextStyle(
                                        color: AppTheme.colors.base3)),
                                new TextSpan(
                                    text: '1.0.0',
                                    style: new TextStyle(
                                        color: AppTheme.colors.primary2)),
                              ]),
                        ),
                      ]))
              //
            ],
          ),
        ),
      ),
    );
  }
}

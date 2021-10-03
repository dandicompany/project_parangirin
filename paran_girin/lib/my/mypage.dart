import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/my/profile_menu.dart';
import 'package:paran_girin/my/profile_pic.dart';
import 'package:paran_girin/myPageDetail/Notice.dart';
import 'package:paran_girin/myPageDetail/about_parangirin.dart';
import 'package:paran_girin/myPageDetail/childrenInfo.dart';
import 'package:paran_girin/myPageDetail/faq.dart';
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
                fp.getUserInfo().currentChild.nickName, //hobin
                style: TextStyle(fontSize: ScreenUtil().setSp(18)),
              ),
              SizedBox(height: ScreenUtil().setHeight(41)),
              ProfileMenu(
                  text: "자녀 관리",
                  press: () async {
                    // sample firebase logging
                    // fp.logScreenViewString('마이페이지', '자녀관리');
                    // FirebaseAnalyticsObserver()._sendScreenView();
                    // await fp.getFAnalytics().logEvent(name: 'Click', parameters: <String, String>{'button': '자녀관리'});
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChildrenInfo(),
                        settings: RouteSettings(name: 'my/childrenInfo'),
                      ));
                  }),
              // ProfileMenu(
              //     text: "알림 설정",
              //     press: () {
              //       Navigator.of(context).push(
              //           MaterialPageRoute(builder: (context) => PushAlarm()));
              //     }),
              // SizedBox(height: ScreenUtil().setHeight(16)),
              ProfileMenu(
                  text: "공지사항",
                  press: () {

                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Notice(),
                          settings: RouteSettings(name: 'my/notice'),
                        ));
                  }),
              ProfileMenu(
                  text: "의견 보내기",
                  press: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SendComments(),
                      settings: RouteSettings(name: 'my/sendComments'),
                    ));
                  }),
              ProfileMenu(
                  text: "파란기린 소개",
                  press: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AboutParanGirin(),
                      settings: RouteSettings(name: 'my/aboutParanGirin'),
                    ));
                  }),
              SizedBox(height: ScreenUtil().setHeight(16)),
              ProfileMenu(
                  text: "이용약관",
                  press: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TermsConditions(),
                      settings: RouteSettings(name: 'my/termsConditions'),
                    ));
                  }),
              ProfileMenu(
                  text: "개인정보 처리방침",
                  press: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PrivacyPolicy(),
                      settings: RouteSettings(name: 'my/privacyPolicy'),
                    ));
                  }),
              ProfileMenu(
                  text: "FAQ",
                  press: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FAQ(),
                          settings: RouteSettings(name: 'my/faq'),
                        ));
                  }),
              ProfileMenu(
                  text: "로그아웃",
                  press: () async {
                    await fp.getFAnalytics().logEvent(name: 'button_click', parameters: <String, String>{'button': 'my/logout'});
                    fp.resetStaticInfoOnNextLoad();
                    fp.signOut();
                    // Navigator.of(context).pop();
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
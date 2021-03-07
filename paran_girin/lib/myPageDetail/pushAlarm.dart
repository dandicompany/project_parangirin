import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paran_girin/layout/base_appbar.dart';
import 'package:paran_girin/my/profile_menu.dart';
import 'package:paran_girin/myPageDetail/childrenInfoLayout.dart';
import 'package:paran_girin/theme/app_theme.dart';

class pushAlarm extends StatefulWidget {
  @override
  _pushAlarmState createState() => _pushAlarmState();
}

class _pushAlarmState extends State<pushAlarm> {
  bool isSwitched = true;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: BaseAppBar(
          title: "알림 설정",
        ),
        body: Container(
          padding: EdgeInsets.only(bottom: 150),
          child: Column(
            children: [
              SizedBox(height: ScreenUtil().setHeight(32)),
              FlatButton(
                  height: ScreenUtil().setHeight(69),
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(23)),
                  onPressed: () {},
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Image.asset('image/pic1.jpg'),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "푸시 알림",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Noto Sans KR',
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "알림이 오지 않는 경우 설정-알림-파란기린에서",
                                style: TextStyle(
                                  color: AppTheme.colors.base3,
                                  fontSize: 12,
                                  fontFamily: 'Noto Sans KR',
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "설정을 변경해주세요",
                                style: TextStyle(
                                  color: AppTheme.colors.base3,
                                  fontSize: 12,
                                  fontFamily: 'Noto Sans KR',
                                ),
                                textAlign: TextAlign.left,
                              )
                            ]),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: ScreenUtil().radius(12),
                        )
                      ],
                    ),
                  )),
              SizedBox(height: ScreenUtil().setHeight(16)),
              FlatButton(
                  height: ScreenUtil().setHeight(48),
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(23)),
                  onPressed: () {},
                  child: Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "이벤트 및 혜택 알림",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },
                        activeTrackColor: AppTheme.colors.primary2,
                        activeColor: Colors.white,
                      ),
                    ],
                  )))
            ],
          ),
        ));
  }
}
